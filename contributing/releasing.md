# Releasing

These instructions describe how to cut a new release.

MDC follows the ["git flow"](http://nvie.com/posts/a-successful-git-branching-model/) style of 
development, where the default branch is called `develop`. `stable` (instead of the traditional
`master`) is reserved for releases. The `develop` branch is periodically copied to a release candidate,
tested, and then merged into `stable`, which serves as the stable "vetted" branch.

## A note on the role of the release engineer

Each release is driven by a single **release engineer**, who is also a Googler. The release engineer
is expected to do the following, in order of priority:

- Do not break Google.
- Cut a release by first thing Wednesday morning, NYC time, without exception.
- Land a release at least once a week.

If something is stopping the release engineer from achieving any of the above goals, the culprit
code should be removed immediately from the release.

Importantly: **do not** block the cutting of the weekly release on a PR or a piece of functionality
you'd like to land. If your PR hasn't landed by the time the release is cut, it's not making it into
that week's release. If your PR is important, cut a [hotfix release](hotfixing.md) in addition to the
typical weekly release.

If you are not able to cut a release Wednesday morning, cut it Tuesday evening before you leave the
office.

## Before you start

### Create a clean clone

Make sure you are working from a direct clone of the main Git repository.  The scripts involved 
assume that the remote "origin" is the actual repository and not your fork.  Since most contributors 
will be working day-to-day with a fork, consider creating a separate clone just for releases.

    git clone git@github.com:material-components/material-components-ios.git mdc-ios-release
    cd mdc-ios-release

## Cutting and testing the release

Our entire release process is encoded into the `release` script in the scripts/ directory.
Read the [tool's readme](../scripts/README-release.md) to learn more about the tool.

### Cut a release branch and notify clients

Run the following command to cut a release:

    scripts/release cut

If you need to cut a hotfix release, run the following command instead:

    scripts/release cut --hotfix

A hotfix release is like a regular release, but its scope is limited specifically to the fix. Hotfix
release candidates start from origin/stable rather than origin/develop, but otherwise the entire
process is the same.

Note: if for some reason `cut` fails, first ensure that nobody else is in the middle of cutting a release by visiting the repo and verifying that a release-candidate does not already exist because aborting the release will delete the remote release candidate. If that isn't the case, then please run `scripts/release abort` and try again.

You will now have a local `release-candidate` branch, a new section in CHANGELOG.md titled
"release-candidate", and the `release-candidate` branch will have been pushed to GitHub.

At this point you should also create the initial Release Candidate pull request using the URL
that the `cut` script generated.

Name the Pull Request title "[WIP] Release Candidate." until you are able to provide the version as the title.

**Do not use GitHub's big green button to merge the approved pull request.** Release are an
exception to our normal squash-and-merge procedure.

### Start internal testing

You can now start the internal release testing process documented at [go/mdc-releasing](http://go/mdc-releasing).

### Resolve any failures

Push `release-candidate` to GitHub with `git push origin release-candidate` as you make changes.
This allows other people and machines to track the progress of the release.

#### Make any necessary changes

You, or clients, may find problems with the release that need fixing before continuing. You have two
options for making those changes:

1.  If the change does not touch library code and is trivial, then you can make the change directly
on the release candidate branch.
1.  If the change touches library code, is non-trivial, or you just want a second opinion, create a
pull request *targeting `release-candidate`* and get it reviewed.

Note that in both cases, changes made to the release candidate branch will be merged back into
`develop` at the end of the release.

## Determining the new version and drafting the release notes

The two most important bits of metadata about a release is the *new version number* and the *release
notes*. While we have tooling to help, your job is to make sure these are correct. If you're not
familiar with [MDC's version number policy](versions.md), please review it now.

To figure out the release number you will need to examine the release's changes.

You have several tools available for deciding if a release is major, minor, or a patch.

### Review the API diff

CHANGELOG.md automatically includes the latest set of public API changes as part of the `cut` command.
Inspect the API changes to get a quick sense of whether there might be an API-breaking change.

1. If any part of a public API is deleted or changed, then this release is a *major* release.
1. If any public API's nullability annotations have changed then this release is a *major* release.
1. Otherwise, if any public APIs added, then this release is a *minor* release.
1. Otherwise, this release *might* still be a bug fix release.

### New Features / Top Level Description 

In the "New Features" sub-category generated by the API diff tool, please provide more detail as to what is new in the release, also providing examples on how to use the added public API properties/methods. For instance if you have added the method `setShadowWidth:` to `MDCCard` an example usage would be:
```swift
let card = MDCCard()
card.setShadowWidth(10)
```

In the top level description please provide a sentence explaining the overall release. Something along the lines of:
"This minor/major/patch release includes X and Y along with some Z."

### Verify API changes

While we do primarily lean on the api_diff tool to call out API diffs, it isn't perfect.  For each
API change, open the source at the latest checkout and verify that the API change does, in fact,
reflect the change that occurred.

Adjust the API diffs in CHANGELOG.md based on your visual inspection of the code.

Commit the final results to your branch.

    git add CHANGELOG.md
    git commit -m "Hand-modified CHANGELOG.md API diff."
    git push origin release-candidate

### Identify visual changes

We do not presently have an automated way to identify visual changes between releases. See [GitHub
issue #290](https://github.com/material-components/material-components-ios/issues/290) for a
discussion on the topic.

### Sanity check: inspect the changes

#### Diff just the components

The final sanity check is to visually inspect the diff.

> If you have configured Git with a GUI diff tool (`git difftool`), then you can add
> `--use_diff_tool` to `scripts/release diff` below.

Generate a list of component public header changes:

    scripts/release headers

Show changes to component headers:

    scripts/release diff components/*/src/*.h

Show all changes to components:

    scripts/release diff components/*/src/

#### Diff everything

Show all changes that are part of this release:

    scripts/release diff

### Classify the release type

You should now be able to identify the release type and its new version number. Bump the release
(change the version number everywhere):

    scripts/release bump <major.minor.patch>

Commit the results to your branch:

    git commit -am "Bumped version number to $(scripts/print_version)."
    git push origin release-candidate

#### Verify CocoaPods podspec and trunk access

Send our local podspec through the CocoaPods linter:

    pod lib lint MaterialComponents.podspec

CocoaPods publishes a directory of publicly available pods through its **trunk** service.
Note: Ensure that you can [push the podspec](#publish-to-cocoapods) later by checking for `MaterialComponents` in your list of available `Pods` when you:

    pod trunk me

If this fails or MaterialComponents is not listed [register an account and session](https://guides.cocoapods.org/making/getting-setup-with-trunk.html).

## Testing with release-blocking clients

Before you can merge the release branch into either develop or stable you **must** get the release
go-ahead from the following clients:

- Google: must verify that the release branch passes all internal tests. If you are a Googler, see
  the internal "mirroring" document for further instructions. Notably you **must not continue** this
  releasing process until the internal synchronization CL has been tested.

---

               |\___/|
              (,\  /,)\
              /     /  \       DRAGON SAYS HALT:
             (@_^_@)/   \      READ THE ABOVE SECTION BEFORE CONTINUING.
              W//W_/     \     DO NOT MERGE OR CUT ANY RELEASES UNTIL
            (//) |        \    YOU'VE DONE SO.
          (/ /) _|_ /   )  \
        (// /) '/,_ _ _/  (~^-.
      (( // )) ,-{        _    `.
     (( /// ))  '/\      /       \
     (( ///))     `.   {       }  \
      ((/ ))    .----~-.\   \-'    ~-__
               ///.----..>   \ \_      ~--____
                ///-._ _  _ _}    ~--------------

---

## Merge the release candidate branch

Once the release-candidate has passed all tests by clients, you may merge the release into the
`develop` and `stable` branches using the `release` script.

**Do not use GitHub's big green button to merge the approved pull request.** Release are an
exception to our normal squash-and-merge procedure. 

    # Did you listen to the dragon?
    #
    # Do not run this until all release-blocking clients have given the go-ahead.
    # Ensure that you've checked off every item in the commit message's checklist.
    #
    scripts/release merge <version>

Once you've resolved any merge conflicts your local `develop` and `stable` branches will both
include the latest changes from `release-candidate`.

You must merge to **both** develop and stable. This is the mechanism by which we ensure that
stable matches develop.

## Push the branches to GitHub

You can now push the merged release candidate to GitHub so that you can complete the final
synchronization within Google.

    git push origin stable develop

You can now sync to the desired stable release. [go/mdc-releasing#re-run-the-import-script-against-githubstable](http://go/mdc-releasing#re-run-the-import-script-against-githubstable). Once you've submitted
the internal CL, continue below to tag and publish the release.

## Publish the official release

> Have all release-blocking clients given the go-ahead? **Do not create the official release
> until all release-blocking clients are ready**. Otherwise you might publish a release that
> isn't actually stable.

You can now publish the release to GitHub:

    scripts/release publish <version>

## Publish to Cocoapods

    git checkout stable
    pod trunk push MaterialComponents.podspec

## Coordinate with release-blocking clients to finish work

Any work that was started by the [Release-blocking clients](#release-blocking-clients)
(dragon) step above may need to be finalized.
