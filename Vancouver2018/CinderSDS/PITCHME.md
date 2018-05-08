@title[Introduction]

# Cinder
## It's not just for breakfast anymore

---

@title[What is Cinder]

## What is Cinder

---

@title[What Cinder is Not]

## What Cinder is not

---

@title[Full Deployment]

### Cinder as part of an OpenStack cloud

![full cloud](Vancouver2018/CinderSDS/assets/allservices.png)

---

@title[Standalone Deployment]

### Cinder standalone for storage management

![stand alone](Vancouver2018/CinderSDS/assets/standalone.png)

---

@title[OpenStack Usage]

## Typical OpenStack Usage

- Point and click management via Horizon
- Interactive command line with OpenStackClient
- Programmatic access using REST API or SDK
  - OpenStackSDK (Shade)
  - Gophercloud
  - etc...
- Integration with config management

---

@title[OpenStack Usage - Horizon]

![horizon](Vancouver2018/CinderSDS/assets/horizon.gif)

---

@title[OpenStack Usage - CLI]

![cli](Vancouver2018/CinderSDS/assets/terminal.gif)

---?code=Vancouver2018/CinderSDS/assets/powershell.ps1&lang=powershell
@title[Windows PowerShell Example]

<span style="font-size:0.5em">Full source:<br/>
  <a
  href="https://github.com/stmcginnis/presentations/blob/master/Vancouver2018/CinderSDS/assets/powershell.ps1">
  https://github.com/stmcginnis/presentations/blob/master/Vancouver2018/CinderSDS/assets/powershell.ps1</a>
</span>

---
@title[Windows PowerShell - Scenario]

## Scenario

#### Production Database remains untouched
#### Need to run local tests against real data
#### Create volume from snapshot of data

---
@title[Windows PowerShell - Authentication]

```powershell
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
```

@[1](Using Invoke-WebReqeuest to make REST call)
@[3-4](Provide authentication information)
@[5](Using password auth)
@[6-11](Pass in credentials)
@[14-18](Provide the desired scope for the auth token)
@[22](POST against the auth token URI)

---
@title[Windows PowerShell - Authentication]

```powershell
$os_token = $result.Headers['X-Subject-Token']
$headers.Add('X-Auth-Token', $os_token)
```

---
@title[Windows PowerShell - REST Calls]

```powershell
$result = Invoke-RestMethod -Headers $headers \
    -Uri "http://192.168.1.230:8776/v3/$project_id/volumes"

foreach($vol in $result.volumes) {
        # Process volumes
    }
}
```

@[1-2](Invoke-RestMethod to simplify calls)
@[4](Easy access to JSON results)

---
@title[Windows PowerShell - Performing Actions]

```powershell
$result = Invoke-RestMethod -Headers $headers -Method Post -Body @"
{
  "volume": {
    "snapshot_id": "$($snapshot.id)"
  }
}
"@ -Uri "http://192.168.1.230:8776/v3/$project_id/volumes"
```

@[3-5](Provide JSON body for requested action)

---
@title[Windows PowerShell - Attachment]

```powershell
-Uri "http://192.168.1.230:8776/v3/$project_id/attachments"

$attachment = $result.attachment

$connection_info = $attachment.connection_info
```

@[1](Attachment API can be used...)
@[5](...to get iSCSI connection info)

---
@title[Windows PowerShell - Connect]

```powershell
foreach($target in $connection_info.target_portals) {
    $tgt_ip, $tgt_port = $target.split(':')
    $portals += New-IscsiTargetPortal -TargetPortalAddress $tgt_ip \
        -TargetPortalPortNumber $tgt_port
}
```

@[3-4](Connection can be made to storage)

---
@title[Windows PowerShell - Access Data]

```powershell
$volume = Get-Volume -FileSystemLabel "SQLData"
$mdf = "$($volume.DriveLetter)\Data\MyDB.mdf"
$ldf = "$($volume.DriveLetter)\Data\MyDB.ldf"

Invoke-Sqlcmd @"
USE [master]
CREATE DATABASE [MyDB] ON (FILENAME = '$mdf'), (FILENAME = '$ldf') FOR ATTACH
"@ -QueryTimeout 3600 -ServerInstance 'Local-Instance'
```

@[1](Local volume can then be used...)
@[5-8](...to mount and access the data)

---
@title[OpenStackSDK]

## OpenStackSDK

#### shade
#### os-client-config
#### python-openstacksdk

---
@title[OpenStackSDK - clouds.yaml]

#### clouds.yaml is cool!

```yaml
clouds:
 test-lab:
   region_name: test_lab
   auth:
     username: 'autovonbot'
     password: password1
     project_name: 'IT'
     auth_url: 'http://192.168.1.230/identity/'
```

```python
connection = openstack.connect(cloud='test-lab')
```

---
@title[OpenStackSDK - Scenario]

## Scenario

#### OS gold image system disk
#### Clone gold image
#### Boot from SAN

---
@title[OpenStackSDK - Create from volume]

```python
connection = openstack.connect(cloud='test-lab')

volume = connection.create_volume(
    10, name='New Boot Vol', image=image_id, wait=True)
```

@[1](Create our connection)
@[3-4](Create a new volume from Glance image)

---
@title['Auto Extend Scenario']

## Automatic Volume Extension

#### Local script schedule to run periodically
#### Check for volume space consumption
#### If low, automatically extend volume

---
@title['Auto Extend Script']

```bash
. ~/os_creds.rc

stats=`df -H /SanVol | tail -1`

size=`echo $stats | awk '{print $2}' | sed -e "s/G//"`
used=`echo $stats | awk '{print $5}' | sed -e "s/\%//"`

if [ $used -gt 90 ]; then
    # Need to extend the volume
    openstack volume extend MyDataVol $(($size + 10))

    # Resize the local volume
    diskutil cs resizeStack d3eaf95e-e2e0-4410-9c96-6f093f91407a 200
fi
```

@[1](Source the credentials so we don't have to include them in script)
@[3-6](Parse out volume space information)
@[8](Check if we have gone past 90% consumption)
@[9-10](Use CLI to extend the volume)

