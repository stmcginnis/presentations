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

###### [https://github.com/stmcginnis/presentations/blob/master/Vancouver2018/CinderSDS/assets/powershell.ps1](https://github.com/stmcginnis/presentations/blob/master/Vancouver2018/CinderSDS/assets/powershell.ps1)

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

@[1] Using Invoke-WebReqeuest to make REST call
@[3-4] Provide authentication information
@[5] Using password auth
@[6-11] Pass in credentials
@[14-18] Provide the desired scope for the auth token
@[22] POST against the auth token URI

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

@[1-2] Invoke-RestMethod to simplify calls
@[4] Easy access to JSON results

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

@[3-5] Power JSON body for requested action
