# Scripts

Scripts for maintaining Material Components for iOS—none of these scripts are required to use MDC or
for casual contributors.

The important scripts are:

* `prep_all`: prepare the Material Components catalog, tests, and demos apps for building.
* `build_all`: build the Material Components catalog and each of our demo apps.
* `test_all`: build and test the Material Components unit and interation tests.
* `clean_all`: remove artifacts from the `prep_all`, `build_all`, and `test_all` scripts.
* `check_components`: run component checks for documentation, examples, etc.
* `install_contributor_tools`: install local contributor tools to speed up the development cycle. 

## Languages

Material Components follows Google's language standards for scripting. The following lanaguages can
be used for scripts:

* [Bash](https://google.github.io/styleguide/shell.xml)
* [Python 2.7](https://google.github.io/styleguide/pyguide.html)

Either language can be used for a particular purpose, but larger or more complex scripts should be
written in (or converted to) Python. Bash scripts get unwieldy quickly and advanced Bash scripting
knowledge is currently less common than advanced Python scripting knowledge.

The intent is that the scripts will run on relatively current OS X machines with (only) Xcode installed.

