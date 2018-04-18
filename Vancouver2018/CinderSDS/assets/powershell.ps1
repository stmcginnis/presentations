$creds = Get-Credential

$project_id = "a0af589c11ed43539166d0dcb6e2a56d"
$headers = @{"Content-Type" = "application/json"}

$result = Invoke-WebRequest -Headers $headers -Method Post -Body @"
{
  "auth": {
    "identity": {
      "methods": ["password"],
        "password": {
          "user": {
            "name": "$($creds.UserName)",
            "domain": {"id": "default"},
            "password": "$($creds.GetNetworkCredential().password)"
          }
        }
      },
      "scope": {
        "project": {
          "domain": {"name": "Default"},
          "name": "admin"
      }
    }
  }
}
"@ -Uri http://192.168.1.230:5000/v3/auth/tokens

$os_token = $result.Headers['X-Subject-Token']
$headers.Add('X-Auth-Token', $os_token)

$src_vol = $null
$result = Invoke-RestMethod -Headers $headers -Uri "http://192.168.1.230:8776/v3/$project_id/volumes"
foreach($vol in $result.volumes) {
    if ($vol.name -eq "Demo-Vol") {
        $src_vol = $vol.id
        break
    }
}

$result = Invoke-RestMethod -Headers $headers -Method Post -Body @"
{
  "snapshot": {
    "name": "demo-snap",
    "description": "Demo snapshot for testing",
    "volume_id": "$src_vol",
    "force": "True"
  }
}
"@ -Uri "http://192.168.1.230:8776/v3/$project_id/snapshots"

$snapshot = $result.snapshot

$result = Invoke-RestMethod -Headers $headers -Method Post -Body @"
{
  "volume": {
    "snapshot_id": "$($snapshot.id)"
  }
}
"@ -Uri "http://192.168.1.230:8776/v3/$project_id/volumes"

$volume = $result.volume

$my_ip = Get-NetIPAddress | Where { $_.InterfaceAlias -eq "Ethernet" -and $_.AddressFamily -eq "IPv4" }

$headers.Add("OpenStack-API-Version", "volume 3.43")
$result = Invoke-RestMethod -Headers $headers -Method Post -Body @"
{
  "attachment": {
    "instance_uuid": "$([guid]::NewGuid())",
    "connector": {
      "initiator": "$((Get-InitiatorPort).NodeAddress)",
      "ip": "$($my_ip.IPAddress)",
      "platform": "x86_64",
      "host": "$env:computername",
      "os_type": "windows",
      "multipath": "true"
    },
    "volume_uuid": "$($volume.id)"
  }
}
"@ -Uri "http://192.168.1.230:8776/v3/$project_id/attachments"

$attachment = $result.attachment
$portals = @()
$connections = @()

$connection_info = $attachment.connection_info
foreach($target in $connection_info.target_portals) {
    $tgt_ip, $tgt_port = $target.split(':')
    $portals += New-IscsiTargetPortal -TargetPortalAddress $tgt_ip -TargetPortalPortNumber $tgt_port
}

foreach($target in $connection_info.target_iqns) {
    $connections += Get-IscsiTarget -NodeAddress $target |
        Connect-IscsiTarget -AuthenticationType ONEWAYCHAP `
            -ChapSecret $connection_info.auth_password `
            -ChapUsername $connection_info.auth_username
}

foreach ($connection in $connections) {
    $disk = Get-Disk -iSCSISession $connection
    Set-Disk -Number $disk.Number -IsOffline $False
    Set-Disk -Number $disk.Number -IsReadonly $False
}

$volume = Get-Volume -FileSystemLabel "SQLData"
$mdf = "$($volume.DriveLetter)\Data\MyDB.mdf"
$ldf = "$($volume.DriveLetter)\Data\MyDB.ldf"
Invoke-Sqlcmd @"
USE [master]
CREATE DATABASE [MyDB] ON (FILENAME = '$mdf'), (FILENAME = '$ldf') FOR ATTACH
"@ -QueryTimeout 3600 -ServerInstance 'Local-Instance'

# Clean up when done after detaching DB
foreach ($connection in $connections) {
    $disk = Get-Disk -iSCSIConnection $connection
    Set-Disk -Number $disk.ID -IsOffline $True
}

foreach($target in $connection_info.target_iqns) {
    Get-IscsiTarget -NodeAddress $target | Disconnect-IscsiTarget -Confirm:$false
}

foreach($target in $connection_info.target_portals) {
    $tgt_ip, $tgt_port = $target.split(':')
    Remove-IscsiTargetPortal -TargetPortalAddress $tgt_ip -Confirm:$false
}

$result = Invoke-RestMethod -Headers $headers -Method Delete `
    -Uri "http://192.168.1.230:8776/v3/$project_id/attachments/$($attachment.id)"

$result = Invoke-RestMethod -Headers $headers -Method Delete `
    -Uri "http://192.168.1.230:8776/v3/$project_id/volumes/$($volume.id)"

$result = Invoke-RestMethod -Headers $headers -Method Delete `
    -Uri "http://192.168.1.230:8776/v3/$project_id/snapshots/$($snapshot.id)"

$headers.Add('X-Subject-Token', $os_token)
$result = Invoke-WebRequest -Headers $headers -Method Delete `
    -Uri http://192.168.1.230:5000/v3/auth/tokens

