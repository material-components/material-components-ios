These commands facilitate the cutting of releases. They represent an overall
process which can be summarized as:

- cut
- test
- bump
- merge
- publish

At each phase the release engineer is expected to run the relevant tests.

This process assumes that you are using a `develop`/`stable` branch model
similar to the "git flow" model:
http://nvie.com/posts/a-successful-git-branching-model/

In this model, all development occurs in the `develop` branch. `stable` houses
stable versions of the code. Each commit in stable often has an associated
version tag.

## Cut the release

When a stable release is ready to be cut, a `release-candidate` branch is `cut`
from the latest `origin/develop` commit.

    release cut

## Test the release

The `release-candidate` branch is automatically pushed to the remote and continuous
integration should begin running. You can run local tests by running:

    release test

## Update CHANGELOG.md

Update the CHANGELOG.md with information that you would like to call out as important from the generated `release notes`.

Things to include:

- API changes
- New features
- Bug fixes
- Call out contributions from casual contributors

When you cut the release your CHANGELOG will already be initialized with the component
changes.

## Bump version numbers

Bump the version number throughout the repository.

    release bump <new version> [<old version>]

## Merge the release

Once the release is tested, it is ready to be merged. By this point you should
know the version number of the release. We recommend following strict semver:
http://semver.org/

    release merge <version>

## Publish the release

At this point `stable` and `develop` are ready to publish. Now is a good time to
perform any final sanity checks.

    release publish <version>

And you're done!

## Publish the podspec

At this point you have published your release to Github, and the last step is to push the new version to CocoaPods!

    release podspec

And the release is now public in CocoaPods!

## Release process commands

Usage: `release cut [--hotfix]`

    Cut a release from `origin/develop`.

    Options:
      --hotfix  Cuts the release candidate from `origin/stable`.

Usage: `release bump <new version> [<old version>]`

    Updates all references to <old version> with <new version> in the repository.
    If not provided, <old version> is inferred from the latest git tag.

    Will NOT modify files that match any of the regular expressions contained in
    the versionignore file that lives beside the `release` command.

    Prerequirements:
    - Ran `release cut`.

Usage: `release merge <version>`

    Merges the current release-candidate into `stable`.

    <version> is the intended version number of the release. This must match the
    latest version number in CHANGELOG.md.

    Prerequirements:
    - Ran `release cut`.

Usage: `release publish <version>`

    Publishes the current release to GitHub.

    Prerequirements:
    - On the `stable` branch.
    - Ran `release merge <version>`.

Usage: `release abort`

    Aborts an active release.

    `This operation is destructive and requires confirmation.`

## Release information commands

The following commands will compare from origin/stable...release-candidate, if a
release candidate exists. Otherwise they will compare from origin/stable...HEAD.

Usage: `release apidiff`

    Generates an API diff since the last stable release.

Usage: `release authors`

    Generates the list of authors who have contributed since the last
    stable release.

Usage: `release components`

    Generates the list of components that have changed since the last
    stable release.

Usage: `release diff`

    Generates a diff of changes since the last stable release.

Usage: `release files`

    Generates a list of files that have changed since the last stable release.

Usage: `release headers`

    Generates a list of headers that have changed since the last stable release.

Usage: `release log`

    Generates a changelog since the last stable release.

Usage: `release notes`

    Generates CHANGELOG.md component notes since the last stable release.

Usage: `release source`

    Generates a list of component source files that have changed since the last
    stable release.
