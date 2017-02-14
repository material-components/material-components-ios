# Releasing

These instructions describe how to cut a new release.

MDC follows the ["git flow"](http://nvie.com/posts/a-successful-git-branching-model/) style of
development, where the default branch is called `develop`. `stable` (instead of the traditional
`master`) is reserved for releases. The `develop` branch is periodically copied to a release branch,
tested, and then merged into `stable`, which serves as the stable "vetted" branch.

## Before you start

### Check for issues that might affect the release process

Occasionally there are temporary issues with the release process, check the [`release`
tag](https://github.com/material-components/material-components-ios/labels/where%3ARelease) for
anything that might be affecting the release.

### Check the release milestone

We use weekly release milestones to track important issues that need to land in a given release.
These issues may come from client teams that are shipping to the App Store on a given date.

Look in the [Tasks for Next Release
milestone](https://github.com/material-components/material-components-ios/milestone/10) for issues
that must be resolved before or during release. If there are open issues you must identify why the
issues are still open and either close them if resolved or determine whether it's acceptable to move
the issue to a subsequent release.

## Cutting and testing the release

### Reset your state

Releasing is important enough that we want to start with a clean slate:

    scripts/clean_all

### Cut a release branch and notify clients

Run the following command to cut a release:

    scripts/release/cut
    git add CHANGELOG.md
    git commit -m "Cut release candidate."

You will now have a local `release-candidate` branch and a new section in CHANGELOG.md titled
"release-candidate".

The `scripts/release/cut` script will output the body of an email you should now send so clients can
test the release.

### Test the release branch

    scripts/prep_all
    scripts/build_all
    scripts/test_all

Identify why any failures occurred and resolve them before continuing.

> Push `release-candidate` to GitHub with `git push origin release-candidate` as you make changes.
> This allows other people and machines to track the progress of the release.

#### Making changes

You or clients may find problems with the release that need fixing before continuing. You have two
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

You will now begin adding release notes to
[CHANGELOG.md](https://github.com/material-components/material-components-ios/blob/stable/CHANGELOG.md)
in the "release-candidate" section. **You will not know the version number yet**, to figure it out
you will need to examine the release's changes.

You have several tools available for deciding if a release is major, minor, or a patch.

### Generating the API diff

> Our API diff tooling should not be trusted at the moment. :( Please inspect changes to component
> headers manually with `scripts/release/diff components/*/src/*.h` and generate the API diff by
> hand.

Generate the API diff by running the following:

    scripts/release/api_diff

- Append the command's output to CHANGELOG.md's "release-candidate" section.
- Delete any component sections that state "No public API changes detected."

Commit the changes to the release branch.

    git add CHANGELOG.md
    git commit -m "Added API diff to CHANGELOG.md."
    git push origin release-candidate

1. If any part of a public API is deleted or changed, then this release is a *major* release.
1. If any public API's nullability annotations have changed then this release is a *major* release.
1. Otherwise, if any public APIs added, then this release is a *minor* release.
1. Otherwise, this release *might* still be a bug fix release.

### Generate the change logs

Run the following command to generate a list of changes organized by component:

    scripts/release/changes

Paste the results into CHANGELOG.md's "release-candidate" section after the "API diffs" section.

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
> `--use_diff_tool` to `scripts/release/diff` below.

Generate a list of component public header changes:

    scripts/release/changed_public_headers

Show changes to component headers:

    scripts/release/diff components/*/src/*.h

Show all changes to components:

    scripts/release/diff components/*/src/

#### Diff everything

Show all changes that are part of this release:

    scripts/release/diff

#### Lint the podspec

    pod spec lint MaterialComponents.podspec

Note: Ensure that you can [push the podspec](#publish-to-cocoapods) later by checking for `MaterialComponents` in your `Pods` when you:

    pod trunk me


### Classify the release type

You should now be able to identify the release type and its new version number. Bump the release
(change the version number everywhere):

    scripts/release/bump <major.minor.patch>

Add the version number to the change log in the "release-candidate" section:

    $EDITOR CHANGELOG.md

Commit the results to your branch:

    git commit -am "Bumped version number to $(pod ipc spec MaterialComponents.podspec | grep '"version"' | cut -d'"' -f4)."
    git push origin release-candidate

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

## Send the release out for review

Send the release-candidate branch out for review by opening [a pull request from `release-candidate`
to
`stable`](https://github.com/material-components/material-components-ios/compare/stable...release-candidate).

Get a reviewer to approve the change.

**Do not use GitHub's big green button to merge the approved pull request.** Release are an
exception to our normal squash-and-merge procedure. 

## Merge the release candidate branch

Once the release-candidate has passed all tests by clients, you may merge the release into the
`develop` and `stable` branches.

    # Did you listen to the dragon?
    #
    # Do not run this until all release-blocking clients have given the go-ahead.
    # Ensure that you've checked off every item in the commit message's checklist.
    #
    scripts/release/merge

Once you've resolved any merge conflicts your local `develop` and `stable` branches will both
include the latest changes from `release-candidate`.

Before pushing these changes to GitHub it's a good idea to run a final sanity check:

    git checkout stable
    scripts/test_all

    git checkout develop
    scripts/test_all

You can now push both branches to GitHub:

    git push origin stable develop

and delete the release branch:

    git branch -d release-candidate
    git push origin :release-candidate

## Publish the official release

1. Have all release-blocking clients given the go-ahead? **Do not create the official release until
   all release-blocking clients are ready**. Otherwise you might publish a release that isn't
   actually stable.
1. Visit our
   [GitHub list of releases](https://github.com/material-components/material-components-ios/releases), click on
   "Draft a new release".
1. Tag the release "vX.Y.Z".
1. Select the stable branch.
1. Title the release "Release X.Y.Z".
1. In the body of the release notes, paste the text from [CHANGELOG.md](https://github.com/material-components/material-components-ios/blob/stable/CHANGELOG.md) for this release.
1. Publish the release.

## Publish to Cocoapods

    pod trunk push MaterialComponents.podspec

## Reply to the original release email message

Post a reply to your message on [Material Components for iOS
Discuss](https://groups.google.com/forum/#!forum/material-components-ios-discuss) indicating that
you are done.

## Coordinate with release-blocking clients to finish work

Any work that was started by the [Release-blocking clients](#release-blocking-clients)
(dragon) step above may need to be finalized.
