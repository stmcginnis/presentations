@title[Introduction]

## OpenStack Release Team Onboarding
#### The Who, What, Why, Where, and How for Release Management

---
@title[Release Team Mission]

> Coordinating the release of OpenStack deliverables, by
> defining the overall development cycle, release models,
> publication processes, versioning rules and tools, then
> enabling project teams to produce their own releases.

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
@title[Coordinated Release]

## Coordinated Release

- Final official release for the development cycle
- Coordinate with marketing for PR and announcements
- Provide a set of deliverables expected to work together

---
@title[Owned Assets - releases.openstack.org]

#### Published Release Site

![releases.openstack.org](Berlin2018/ReleaseTeam/assets/releases_site.png)

---
@title[Owned Assets - Release Artifacts]

#### Release Artifacts

![release artifacts](Berlin2018/ReleaseTeam/assets/release_artifacts.png)

---
@title[Owned Assets - Release Schedule]

#### Release Schedule Planning

![stein release schedule](Berlin2018/ReleaseTeam/assets/release_schedule.png)

---
@title[Releases Repo]

http://git.openstack.org/cgit/openstack/releases/

<div class="column">
<div class="pre">@css[folder](./)
├── @css[folder](deliverables)
├── @css[folder](doc)
├── @css[folder](openstack_releases)
├── @css[folder](templates)
├── @css[folder](tools)
├── bindep.txt
├── CONTRIBUTING.rst
├── LICENSE
├── README.rst
├── requirements.txt
├── setup.cfg
├── setup.py
├── test-requirements.txt
├── tox.ini
├── watched_queries.yml
└── yamllint.yml
</div>
</div>

---
@title[Deliverables]
@transition[none]

@snap[north]
deliverables
@snapend

<div class="column1">
<div class="pre">@css[folder](./deliverables/)
├── @css[folder](austin)
├── @css[folder](bexar)
├── @css[folder](cactus)
├── @css[folder](diablo)
├── @css[folder](essex)
├── @css[folder](folsom)
├── @css[folder](grizzly)
├── @css[folder](havana)
├── @css[folder](icehouse)
├── @css[folder](_independent)
├── @css[folder](juno)
├── @css[folder](kilo)
├── @css[folder](liberty)
├── @css[folder](mitaka)
├── @css[folder](newton)
├── @css[folder](ocata)
├── @css[folder](pike)
├── @css[folder](queens)
├── @css[folder](rocky)
├── @css[folder](stein)
└── series_status.yaml
</div>
</div>

<div class="column2">
@ul
- Deliverables for each release
- YAML files with tag and branch info
- Updated by teams to request release
@ulend
</div>

---
@title[Doc Source]
@transition[none]

@snap[north]
doc/source
@snapend

<div class="column1">
<div class="pre">@css[folder](./doc/source/)
├── @css[folder](austin)
├── @css[folder](bexar)
├── @css[folder](...)
├── @css[folder](_extra)
├── @css[folder](_exts)
├── @css[folder](reference)
├── @css[folder](releases)
├── @css[folder](static)
├── @css[folder](teams)
├── @css[folder](_themes)
├── conf.py
├── independent.rst
└── index.rst
</div>
</div>

<div class="column2">
@ul
- Static and placeholder pages per cycle
- Schedule yaml files
- Reference documentation for release tools and process
- Sphinx extensions for generating content
@ulend
</div>

---
@title[Source Code]
@transition[none]

@snap[north]
openstack_releases
@snapend

<div class="column1">
<div class="pre">@css[folder](./openstack_releases/)
├── @css[folder](cmds)
├── @css[folder](tests)
├── defaults.py
├── deliverable.py
├── gitutils.py
├── governance.py
├── ...
├── sphinxext.py
├── versionutils.py
├── wiki.py
├── xstaticutils.py
└── yamlutils.py
</div>
</div>

<div class="column2">
@ul
- Source code for automation and tooling
- Convenient commands under `cmd` folder
- Unit tests under `tests` folder
- Common library functionality in root
@ulend
</div>

---
@title[Source Code]
@transition[none]

@snap[north]
tools
@snapend

<div class="column1">
<div class="pre">@css[folder](./tools/)
├── @css[file](aclissues.py)
├── @css[file](aclmanager.py)
├── @css[file](add_release_note_links.sh)
├── @css[file](announce.sh)
├── @css[file](build_reenqueue_commands.sh)
├── @css[file](build_tag_history.sh)
├── @css[file](clone_repo.sh)
├── @css[file](discover_branch_points.py)
├── functions
├── @css[file](import_branch_points.sh)
├── @css[file](inactive_project_report.sh)
├── @css[file](list_changes_unreleased_delive...)
├── @css[file](list_library_unreleased_change...)
├── @css[file](list_stable_unreleased_changes.sh)
├── @css[file](list_unreleased_and_open_chang...)
├── @css[file](list_unreleased_changes.sh)
├── @css[file](list_weeks.py)
├── @css[file](mkteampage.sh)
├── @css[file](new_release.sh)
├── @css[file](run_yamllint.sh)
├── @css[file](series_diff_start.sh)
├── @css[file](tag_history_from_git.py)
├── @css[file](tox-log-command.sh)
└── @css[file](verify_branches_and_late_relea...)
</div>
</div>

<div class="column2">
@ul
- Tools for various release management tasks
- Useful examples of calling some of the cmds
@ulend
</div>

---
@title[Ways to Participate]

#### Ways To Get Involved

@ul
- Review release requests
- Triage release failures / Fix automation
- Find more to automate!
- Find more to document!
@ulend

---
@title[Cycle Tracking]

### Release Cycle Tracking

![Release Process](Berlin2018/ReleaseTeam/assets/release_process.png)

---
@title[Cycle Tracking]

### Release Cycle Tracking

![Release Process](Berlin2018/ReleaseTeam/assets/release_tracking.png)

---
@title[Release Process Overview]

1. Team submits review updating *$deliverable.yaml* file
  * New release tag
  * New branch creation
2. Release team reviews request
  * Check that validation jobs pass
  * Check semver rules are followed
3. Zuul jobs perform tagging, upload to pypi, publish tarballs

@size[0.5em](https://releases.openstack.org/reference/using.html)

---
@title[Deliverable File]

#### Release Request

```yaml
launchpad: spam
team: 'Flying Circus'
type: library
release-model: cycle-with-intermediary
repository-settings:
  openstack/spam:
    tarball-base: openstack-spam
releases:
  - projects:
      - hash: 3da9679d9b12e2808ce9d073117e93d40ce05da3
        repo: openstack/spam
    version: 1.1.0
branches:
  - location: 1.1.0
    name: stable/rocky
```

@[1-2](Team information)
@[3-4](Release model and deliverable type)
@[5-7](Settings and flags for the repo)
@[8-12](Releases to tag on the repo)
@[13-15](Branches to create off of tag or sha)

---
@title[Review Dashboard]

### Review Dashboard

![Review dashboard](Berlin2018/ReleaseTeam/assets/review_dashboard.png)

---
@title[Check Jobs]

### Check Queue Jobs

@ul
- openstack-tox-validate
- releases-tox-list-changes
- build-openstack-sphinx-docs
@ulend

---
@title[Gate Jobs]

### Gate Jobs

@ul
- openstack-tox-validate
- build-openstack-sphinx-docs
@ulend

---
@title[Post Jobs]

### Post Jobs

@ul
- Tag triggers post jobs
- Docs are published to docs.openstack.org
- Project-specific release/publish jobs run
- Release notes published
@ulend

@size[0.5em](http://git.openstack.org/cgit/openstack-infra/project-config/tree/playbooks/publish)

---
@title[Reviewing Changes]

### Reviewing Changes

@ul
- Make sure openstack-tox-validate job passes
- Check releases-tox-list-changes output
  - Check for PTL/Liaison and make sure to have their ack
  - Check for stable policy (stable releases)
  - Review commits included
  - Make sure requested version appropriate for commits
  - Check release model
@ulend

---
@title[References]

### References

<span style="font-size:0.6em">
[http://git.openstack.org/cgit/openstack/releases](http://git.openstack.org/cgit/openstack/releases)
<br/>
[https://releases.openstack.org/reference/process.html](https://releases.openstack.org/reference/process.html)
<br/>
[http://tiny.cc/a1mkwy](http://tiny.cc/a1mkwy)
<br/>
[https://etherpad.openstack.org/p/stein-relmgt-tracking](https://etherpad.openstack.org/p/stein-relmgt-tracking)
<br/>
[http://git.openstack.org/cgit/openstack-infra/project-config/tree/playbooks/publish](http://git.openstack.org/cgit/openstack-infra/project-config/tree/playbooks/publish)
</span>

---
@title[Thanks]

### Thank You

<hr/>

@fa[twitter] @SeanTMcGinnis
