# Releasing

These instructions describe how to cut a new release.

MDC follows the ["git flow"](http://nvie.com/posts/a-successful-git-branching-model/) style of
development, where the default branch is called `develop`. `stable` (instead of the traditional
`master`) is reserved for releases. The `develop` branch is periodically copied to a release branch,
tested, and then merged into `stable`, which serves as the stable "vetted" branch.

## Before you start

### Check for issues that might affect the release process

Occasionally there are temporary issues with the release process, check the [`Blocking Release`
label](https://github.com/material-components/material-components-ios/labels/is%3ABlocking%20next%20release) for
any open issues that might affect the release.

## Cutting and testing the release

Our entire release process is encoded into the `release` script in the scripts/ directory.
Read the [tool's readme](../scripts/README-release.md) to learn more about the tool.

### Cut a release branch and notify clients

Run the following command to cut a release:

    scripts/release cut

You will now have a local `release-candidate` branch, a new section in CHANGELOG.md titled
"release-candidate", and the `release-candidate` branch will have been pushed to GitHub.

The `scripts/release cut` script will output the body of an email you should now send to the
[discussion list](https://groups.google.com/forum/#!forum/material-components-ios-discuss) so
clients can test the release.

At this point you should also create the initial Release Candidate pull request using the URL
that the `cut` script generated.

**Do not use GitHub's big green button to merge the approved pull request.** Release are an
exception to our normal squash-and-merge procedure. 

### Resolve any failures

Push `release-candidate` to GitHub with `git push origin release-candidate` as you make changes.
This allows other people and machines to track the progress of the release.

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

To figure out the release number you will need to examine the release's changes.

You have several tools available for deciding if a release is major, minor, or a patch.

### Review the API diff

CHANGELOG.md automatically includes the latest set of public API changes as part of the `cut` command.
Inspect the API changes to get a quick sense of whether there might be an API-breaking change.

1. If any part of a public API is deleted or changed, then this release is a *major* release.
1. If any public API's nullability annotations have changed then this release is a *major* release.
1. Otherwise, if any public APIs added, then this release is a *minor* release.
1. Otherwise, this release *might* still be a bug fix release.

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

Before pushing these changes to GitHub it's a good idea to run a final sanity check:

    git checkout develop
    scripts/release test
    
    git checkout stable
    scripts/release test

## Publish the official release

> Have all release-blocking clients given the go-ahead? **Do not create the official release
> until all release-blocking clients are ready**. Otherwise you might publish a release that
> isn't actually stable.

You can now publish the release to GitHub:

    scripts/release publish <version>

## Publish to Cocoapods

    git checkout stable
    pod trunk push MaterialComponents.podspec

## Reply to the original release email message

Post a reply to your message on [Material Components for iOS
Discuss](https://groups.google.com/forum/#!forum/material-components-ios-discuss) indicating that
you are done.

## Coordinate with release-blocking clients to finish work

Any work that was started by the [Release-blocking clients](#release-blocking-clients)
(dragon) step above may need to be finalized.
