> **Command line driven CI frontend and development task automation tool**

> At its core tox povides a convenient way to run arbitrary commands in
> isolated environments to serve as a single entry point for build, test and
> release activities.

Note:

Here is the description of tox from the project itself.

If you've used make, ant, maven, or other build management systems, it is very
similar to that. Tox is a native python tool though, and is ideally suited for
automating python projects tasks.

---

### Installation

Multiple ways to install tox:

```bash
pip install tox
```

```bash
sudo apt install python3-tox
```

<small>Also available with Homebrew and other unofficial packages.</small>

Note:

Tox can be installed in multiple ways. If you already have a Python environment
set up, the easiest is probably to use pip to install it, though you can also
use system packages. There are some homebrew packages to install tox, but make
sure you are installing the correct tox. There is also a chat app named tox
that is the first result when searching for the homebrew package.

---

### Basic Usage - Configuration

Tox is configured using a tox.ini file at the root of the project.

```ini
[tox]
envlist = py27,py37

[testenv]
deps = pytest
commands = pytest
```

Note:

Tox settings are controlled through a tox.ini file at the root of the project.
Using this tox.ini file, you can set what things to run when tox is called,
what commands are used, and may config options that control its behavior.

---

### Basic Usage - Execution

```bash
# Execute all targets in envlist
tox
```

```bash
# Only run specified targets
tox -e py37
```

```bash
# Target does not need to be in envlist
tox -e py36
```

Note:

Running tox by itself will execute any environments you have listed in the
default envlist. You can also execute a single target by using the -e argument
with the environment name you would like.

Tox does include a set of default environments that don't need to be specified,
so you can also tell it to run targets that are not in the envlist. The envlist
it just an easy way to define a set of default environments to use if none are
specified.

---

### Virtual Environments

Virtual environment created for each target run.

```console
.tox
 |-- py27
 `-- py37
```

<br>
<br>
<small>More virtual environment information available on the virtualenv package page:</small>

[https://pypi.org/project/virtualenv/](https://pypi.org/project/virtualenv/)

Note:

Tox takes advantage of virtual environemnts to install and run tests. By
default, only packages isolated to the virtual environment will be used, so
this provides you with good isolation for running tests, making sure that
something else installed on your test machine is being used and then making it
difficult to track down why things fail once you deploy to another machine.

---

### Initialization Steps

* Virtual environment created <!-- .element: class="fragment" -->
* Dependencies installed into venv <!-- .element: class="fragment" -->
* Command(s) run from within virtual environment <!-- .element: class="fragment" -->

Note:

When you run tox for the first time, for each environment, it goes through some
basic high level steps. If the target environment is not present, it will first
create it just like running the virtualenv command yourself. It will then
install any dependencies that are defined in your environment definition in
tox.ini. Finally, it will run whatever commands you have defined using that
virtual environment for isolation.

---

### Defining Dependencies

```ini
deps = pytest
```

```ini
deps =
    -chttp://build-server/tested/upper-constraints.txt
    -r{toxinidir}/requirements.txt
    -r{toxinidir}/test-requirements.txt
```

<small>Local project is always installed into venv.</small>

Note:

You can either explicitly state a list of packages that much be installed into
the virtual environment, or you can use standard pip dependency management.

In the bottom example, I am using the common convention of installing all
requirements needed to run the project from a requirements.txt file at the root
of the project repo. Not the variable substitution used to make sure it does
this relative to where the tox.ini file is. This makes sure no matter where I
run this, it looks in the right place.

I also have a separate test-requirements.txt file. It's good practice to
separate out the packages that are only needed for testing from your main
project requirements so production deployments can only install the packages
that are actully needed for deployment.

Another good practice for larger projects is to use contraints. Using the -c
argument, let's say I have testing in place to validate certain releases of my
dependencies. If I know my project works well with version 1.0 of a package,
but I want to protect against a 2.0 release being published that changes things
and breaks my build, I can set an upper constraint to make sure whatever pip
installs is < 2.0. This helps protect against external changes breaking your
code and can save a lot of time tracking down failures in larger projects.

And as you can see, this arguments for these settings doesn't have to be a
local file. I can point this at a published web site so I can centrally track
my requirements across all of my projects to ensure things like
coinstallability.

---

### Running Installed Code

```console
./project/cmd/mycli.py
```

In setup.cfg:
```ini
[entry_points]
project.cmd =
    MyCLI = project.cmd.mycli.MyCLI
```

Note:

Let's say my project includes a CLI. I don't want to have to actually fully
install my project onto my system just to try out my CLI.

---

### Running Installed Code


```bash
tox -e venv -- MyCLI
```

```bash
.tox/py27/bin/MyCLI
```

Note:

Since the project gets instlled into the virtual environment of whatever target
I choose, I can use a double dash to pass the command I want to run from there.

I can use one of the tox default environments of just a default venv, passing
in to run MyCLI. Or, since Python makes it easy to run directly out of a
virtual environment with loading the correct env, I can use the full path into
my virtual environment to call MyCLI.

---

### More Basic Settings

```ini
[tox]
skip_missing_interpreters = true
envlist = py36,py37,pypy3,pep8
skipsdist = true
```

---

### More Basic Settings

```ini
[testenv]
basepython = python3
usedevelop = true

deps =
   pytest
   coverage
commands =
   find . -type f -name "*.pyc" -delete
   coverage run -m pytest {posargs}
   coverage report -m

whitelist_externals =
   find

passenv =
    PROJECT_SETTING
```

---

### Defining Other Commands


```ini
[testenv:pep8]
commands =
   flake8 {posargs} .
   {toxinidir}/tools/check_exec.py {toxinidir}/project
```

```ini
[flake8]
ignore = W504
exclude = .git,.venv,.tox,*egg
```

---

### More Target Settings

```ini
[testenv:legacytool]
basepython = python2.7
deps = six
commands =
   {toxinidir}/tools/old_legacy_tool.py
```

---

### More Target Settings

```ini
[testenv:sometool]
envdir = {toxworkdir}/venv
commands =
   {toxinidir}/tools/sometool.py
```

---

### Command Examples

```console
tox -e py37,docs
```

```bash
tox -re py37
```

---

## References

Official Documentation

[https://tox.readthedocs.io/en/latest/install.html](https://tox.readthedocs.io/en/latest/install.html)

Project Source Code

[https://github.com/tox-dev/tox](https://github.com/tox-dev/tox)

---

### Presentation Source

[www.ivehearditbothways.com/presentations/](www.ivehearditbothways.com/presentations/PyMNtos/ToxRox/index.html)

[Slide
Source](https://github.com/stmcginnis/presentations/tree/master/PyMNtos/ToxRox)
