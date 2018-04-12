@title[Introduction]

# OpenSDS Contribution
#### Workflow and tips and tricks

<hr/>
@fa[globe] www.opensds.io <br/>
@fa[twitter] @opensds_io

---

@title[Overview]

### Project Overview

![architecture](Copenhagen2018/Contribution/assets/opensds-overview.png)

### Common Interface
### Policy-Based Control
### Wide Storage Support
### Enterprise Class

---

@title[Project Repos]

## Project Repos

![repos](Copenhagen2018/Contribution/assets/repos.png)

@fa[github] https://github.com/opensds

---

@title[Governance Structure]

### OpenSDS Governance Structure

![governance](Copenhagen2018/Contribution/assets/governance.jpg)

<dl>
  <dt>TSC</dt>
  <dd>Technical Steering Committee</dd>

  <dt>EUAC</dt>
  <dd>End User Advisory Committee</dd>
</dl>

---

@title[Communication]

## Community Communication

@fa[slack] OpenSDS Slack Channel <br/>
[https://opensds.slack.com/](https://opensds.slack.com/) <br/>
@fa[envelope] Mailing Lists <br/>
[https://lists.opensds.io/](https://lists.opensds.io/mailman/listinfo) <br/>
@fa[github] GitHub Issues <br/>
[https://github.com/opensds/opensds/issues](https://github.com/opensds/opensds/issues)

---

@title[Meetings]

## OpenSDS Meetings

Technical meetings weekly

- Tuesdays, 12pm Eastern US time
- Thursdays, 8pm Eastern US time

<span style="font-size:0.6em; color:gray">Meetings held using Zoom for audio
and video.</span>
<br/>
<span style="font-size:0.6em">See https://github.com/opensds/opensds/blob/master/COMMUNITY.md for more
details.</span>

---

@title[Proposing new features]

## New Features

Design specification submitted as a pull request to opensds/design-specs repo.
<br/>
Pull request used to discuss design decision and clarify plan.
<br/>
<br/>
@fa[github]
[https://github.com/opensds/design-specs](https://github.com/opensds/design-specs)

---

@title[Fixing bugs]

## Fixing Bugs

Open bugs are tracked using the GitHub issue tracker.
<br/>
Assign issue to yourself if no one is working on it.
<br/>
![assign_issue](Copenhagen2018/Contribution/assets/assign_issue.png)

---

@title[Testing]

## Early Release Testing

Manual testing is very much appreciated!
<br/>
Development releases are available from the [opensds/opensds Releases
tab](https://github.com/opensds/opensds/releases).

---

@title[GitHub Usage]

## GitHub Workflow

- Fork repo
- Clone your fork and create a branch
- Make changes to code
- Push changes to your forked repo
- Open pull request from your forked branch to the OpenSDS **development**
  branch

---

@title[GitHub Usage]

## GitHub Workflow Example

```
$ git clone https://github.com/stmcginnis/opensds.git
$ cd opensds
$ git checkout -b my_cool_new_feature

# Make changes to code

$ git add .
$ git commit
$ git push origin my_cool_new_feature
```

@[1]
@[2]
@[3]
@[4-6]
@[7]
@[8]
@[9]

---

@title[GitHub Workflow]

![new PR](Copenhagen2018/Contribution/assets/new_pr.png)

---

@title[GitHub Workflow]

![Pull request branches](Copenhagen2018/Contribution/assets/new_pr_branches.png)

---

@title[GitHub Workflow]

![Pull request description](Copenhagen2018/Contribution/assets/new_pr_desc.png)

---

@title[GitHub Workflow]

### Updating changes

```
$ git add .
$ git commit
$ git push origin my_cool_new_feature

# Or...

$ git push --force origin my_cool_new_feature
```

@[1]
@[2]
@[3]
@[7]

---

@title[GitHub Workflow - Hub]

#### Workflow using [hub](https://hub.github.com/)

```
$ git clone opensds/opensds
$ cd opensds
$ git checkout -b my_cool_new_feature

# Make changes to code

$ git add .
$ git commit
$ git fork
$ git push USER_NAME my_cool_new_feature
$ git pull-request
```

@[1]
@[2]
@[3]
@[4-6]
@[7]
@[8]
@[9]
@[10]
@[11]

---

@title[Release Cycle]

![Release cycle](Copenhagen2018/Contribution/assets/roadmap.png)
