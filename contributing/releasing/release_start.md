MDC follows the ["git flow"](http://nvie.com/posts/a-successful-git-branching-model/) style of 
development, where the default branch is called `develop`. `stable` (instead of the traditional
`master`) is reserved for releases. The `develop` branch is periodically copied to a release candidate,
tested, and then merged into `stable`, which serves as the stable "vetted" branch.

## A note on the role of the release engineer

Each release is driven by a single **release engineer**, who is also a Googler. The release engineer
is expected to do the following, in order of priority:

- Do not break Google.
- Cut a release early in the working calendar week.
- Land a release at least once every calendar week.
- (Optional) Share something new with the team while you're waiting for tests to pass.

If something is stopping the release engineer from achieving any of the above goals, the culprit
code should be removed immediately from the release.

Importantly: **do not** block the cutting of the weekly release on a PR or a piece of functionality
you'd like to land. If your PR hasn't landed by the time the release is cut, it's not making it into
that week's release. If your PR is important, cut a hotfix release in addition to the
typical weekly release.

If you are not able to cut a release Wednesday morning, cut it Tuesday evening before you leave the
office.

Please post regular updates about the status of the release to the team's chat room. This helps inform the
team of the status of the release, and also encourages team problem solving in the event that something is
stuck. At minimum, the following inflection points should be noted:

- The release is being initiated.
- Internal testing of the release has begun.
- Internal testing of the release has ended.
- The release has been submitted internally.
- The release has been published to CocoaPods.

For Googlers, also read [go/mdc-release-engineering](http://go/mdc-release-engineering) for additional details.

## Before you start

### First time setup

Install [brew](https://brew.sh/), [sourcekitten](https://github.com/jpsim/SourceKitten), and [git-lfs](https://git-lfs.github.com/):

    brew install sourcekitten
    brew install git-lfs

Please follow [using git-lfs instructions](https://github.com/material-components/material-components-ios/blob/2b6da5f10438081e5a7b2211e27336c6846433e5/contributing/tools.md#using-git-lfs) if you have already cloned the repository.

Verify that xcode-select is pointing to an Xcode installation directory:

    xcode-select -p
    
    # Example output:
    # /Applications/Xcode.app/Contents/Developer

If not, select the Xcode you have installed. For example:

    sudo xcode-select --switch /Applications/Xcode.app

### Create a clean clone

Make sure you are working from a direct clone of the main Git repository.  The scripts involved 
assume that the remote "origin" is the actual repository and not your fork.  Since most contributors 
will be working day-to-day with a fork, consider creating a separate clone just for releases.

    git clone git@github.com:material-components/material-components-ios.git mdc-ios-release
    cd mdc-ios-release

### Configure the merge strategy for `.gitattributes`

We have two different versions of `.gitattributes` in the `develop` and
`stable` branches. To avoid conflicts (or accidental merges) between the two
branches, we define a custom merge strategy just for that file.  After cloning
the repository, be sure to run this command:

    git config merge.gitattributes.driver true

## Cutting and testing the release

Our entire release process is encoded into the `release` script in the scripts/ directory.
Read the [tool's readme](../scripts/README-release.md) to learn more about the tool.

### Cut a release branch

Run the following command to cut a release:

    scripts/release cut

Note: if for some reason `cut` fails, first ensure that nobody else is in the middle of cutting a release by visiting the repo and verifying that a release-candidate does not already exist because aborting the release will delete the remote release candidate. If that isn't the case, then please run `scripts/release abort` and try again.

You will now have a local `release-candidate` branch, a new section in CHANGELOG.md titled
"release-candidate", and the `release-candidate` branch will have been pushed to GitHub.

#### Hotfixing

If you need to cut a hotfix release, run the following command instead:

    scripts/release cut --hotfix

A hotfix release is like a regular release, but its scope is limited specifically to the fix. Hotfix
release candidates start from origin/stable rather than origin/develop. 

If the hotfix is to fix a regression or a problematic commit in a recent release, the ideal
path forward is to revert that commit using the `git revert <commit-hash>` command and opening a PR with that change to the develop branch.
After that PR is merged, you should cherry-pick the revert commit into the `release-candidate` branch: `git cherry-pick <commit-hash>`.

Other than the steps above regarding hotfixing, the entire release process stays the same.

#### Create a Pull Request for the Release Branch

If you have not clicked [the release candidate pull request comparison
link](https://github.com/material-components/material-components-ios/compare/stable...release-candidate)
provided in the script do so now.

At this point you should also create the initial Release Candidate pull request using the URL
that the `cut` script generated.

Name the Pull Request title "{WIP} Release Candidate." until you are able to provide the version as the title.

Add the group `material-components/release-blocking-clients` to the pull request's reviewers. This is the mechanism by which
release-blocking clients are notified of a new release.

**Do not use GitHub's big green button to merge the approved pull request.** Release are an
exception to our normal squash-and-merge procedure.

#### Verify CocoaPods podspec and trunk access

Send our local podspec through the CocoaPods linter:

    pod lib lint MaterialComponents.podspec --skip-tests --allow-warnings

CocoaPods publishes a directory of publicly available pods through its **trunk** service.
Note: Ensure that you can [push the podspec](#publish-to-cocoapods) later by checking for `MaterialComponents` in your list of available `Pods` when you:

    pod trunk me

If this fails or MaterialComponents is not listed [register an account and session](https://guides.cocoapods.org/making/getting-setup-with-trunk.html).