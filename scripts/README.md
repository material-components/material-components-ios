# Scripts

Scripts for maintaining Material Components for iOS—none of these scripts are required to use MDC or
for casual contributors.

The important scripts are:

* `prep_all`: prepare the Material Components catalog, tests, and demos apps for building.
* `build_all`: build the Material Components catalog and each of our demo apps.
* `test_all`: build and test the Material Components unit and integration tests.
* `clean_all`: remove artifacts from the `prep_all`, `build_all`, and `test_all` scripts.
* `check_components`: run component checks for documentation, examples, etc.
* `install_contributor_tools`: install local contributor tools to speed up the development cycle. 

## Languages

Material Components follows Google's language standards for scripting. The following languages can
be used for scripts:

* [Bash](https://google.github.io/styleguide/shell.xml)
* [Python 2.7](https://google.github.io/styleguide/pyguide.html)

Either language can be used for a particular purpose, but larger or more complex scripts should be
written in (or converted to) Python. Bash scripts get unwieldy quickly and advanced Bash scripting
knowledge is currently less common than advanced Python scripting knowledge.

The intent is that the scripts will run on relatively current OS X machines with (only) Xcode installed.

## iOS Codelabs Build Tests

iOS codelabs build tests ensure that the Objective C and Swift versions of Codelab 104 Complete
and Codelab 111 Complete can be built. If a release fails the codelabs build tests, follow these steps:
1. If the release changes a component that the codelabs use, submit a PR to the codelabs repo
with the appropriate changes for the adjusted component. Address each codelab and language
that is affected by the change (it may be helpful to run ./build_codelabs -a to determine which
codelabs are affected).
2. Merge the PR into the codelabs repo, and then rerun the codelabs build tests.
3. Continue with the release process.
