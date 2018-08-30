@title[Introduction]

# OpenStack Release Team
## What we do, and why we're not actually just here to annoy you

---
@title[What is the Release Team]

## Responsibilities

@ul

- Release schedule planning and coordination
- Assist teams producing deliverables
- Communicate to users of deliverables
- Maintaining release automation

@ulend

---
@title[What Release Team is Not]

## Not Responsible for

@ul

- Feature scheduling
- Feature tracking
- Prioritization of work

@ulend

---
@title[Release Models]

## Release Models

- cycle-with-milestones
- cycle-with-intermediary
- cycle-trailing
- independent

---
@title[Cycle with Milestones]

## Cycle with Milestones

One main deliverable per release cycle.

- Nova
- Cinder
- Keystone
- Glance

---
@title[Cycle with Intermediary]

## Cycle with Intermediary

Updates throughout development cycle or low volume of change

- python-$PROJECTclient
- $PROJECT-tempest-plugin
- Swift
- oslo.log

---
@title[Cycle Trailing]

## Cycle Trailing

Projects that need output from other deliverables

- Ansible
- TripleO
- Puppet
- Kolla

---
@title[Independent]

## Independent

Not tied to specific release cycle

- Bandit
- Doc8
- OpenStackDocsTheme

---
@title[Release Schedule]

### Release Scheduling

![schedule](Denver2018/ReleaseTeam/assets/schedule.png)

---
@title[Release Schedule]

### Milestones and Deadlines

- Checkpoints to assess progress and test release tooling
- Library freezes to minimize late-cycle surprises
- RC deadlines to finalize deliverables and help downstream

---
@title[Milestones]

### Regular milestone intervals

@ul

- Helps team direct focus to keep schedule on track
- Ensures regular intervals for release tooling and updates


@ulend

---
@title[Lib Freezes]

### Library Freezes

Both non-client and client library freezes

@ul

- Service and clients consume non-client libs
- Other projects consume client libs
- Requirements freeze to avoid last minute fire drilles

@ulend

---
@title[RC Deadlines]

### RC Deadlines

@ul

- Branch point for final stabilization
- Allows downstream to start testing and packaging
- Gives deployment projects a small chance to get things ready

@ulend

---
@title[Coordinated Release]

## Coordinated Release

- Final official release for the development cycle
- Coordinate with marketing for PR and announcements
- Provide a set of deliverables expected to work together

---
@title[Release Inclusion]

### Release Inclusion

@ul

- No more than two missed milestones
- Membership Freeze
- Forced releases

@ulend

---
@title[References]

### References

<span style="font-size:0.6em">
[https://releases.openstack.org/#references](https://releases.openstack.org/#references)
<br/>
[http://git.openstack.org/cgit/openstack/releases](http://git.openstack.org/cgit/openstack/releases)
<br/>
</span>

---
@title[Thanks]

### Thank You

<hr/>

@fa[twitter] @SeanTMcGinnis
