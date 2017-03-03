# Hotfixing

Hotfixes are changes made to the stable branch or a previous release in order to resolve a critical
bug that may have been detected post-release. Hotfixes are essentially [releases](releasing.md) that
happen off-schedule.

We only support the latest tagged release on `origin/stable`.

TODO: Discuss how many releases back we actively support.
https://github.com/material-components/material-components-ios/issues/294

### Create a hotfix branch

Run the following command to cut a release:

    scripts/release/cut --hotfix

A hotfix branch is like a release branch, but its scope is limited specifically to the fix. In other
words, the hotfix branch must start from `origin/stable`.


### Follow the releasing process

Start at [Test the release branch](releasing.md#test-the-release-branch) and cut the hotfix release
as though it were a normal release.
