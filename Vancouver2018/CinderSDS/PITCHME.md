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

---

@title[OpenStack Usage - Horizon]

![horizon](Vancouver2018/CinderSDS/assets/horizon.gif)

---

@title[OpenStack Usage - CLI]

![cli](Vancouver2018/CinderSDS/assets/terminal.gif)

---?code=Vancouver2018/CinderSDS/assets/powershell.ps1&lang=powershell
@title[Windows PowerShell Example]

@[1](Get username and password)
@[6-27](Authenticate with Keystone)
@[29-30](Set auth token in headers)
@[33-39](Get list of volumes and find our volume)
@[41-50](Create a snapshot of our production volume)
@[54-59](Create a new volume from the snapshot)
@[66](Set header for specific microversion)
@[67-82](Create an attachment for the volume)
@[88-92](Log in to iSCSI portals)
@[94-99](Log in to targets)
@[101-105](Initialize disk)
@[107](Find our volume)
@[108-113](Attach to database files on volume)
@[115-119](Offline volume after we are done)
@[121-123](Disconnect from targets)
@[125-128](Disconnect from portal)
@[130-137](Detach and clean up)
@[139-141](Log out)
