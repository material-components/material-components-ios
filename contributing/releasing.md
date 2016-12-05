# Releasing

These instructions describe how to cut a new release of the material-components-ios (MDC)
repository.

MDC follows the ["git flow"](http://nvie.com/posts/a-successful-git-branching-model/) style of
development, where the default branch is called `develop`. `master` is reserved for releases. The
`develop` branch is periodically copied to a release branch, tested, and then merged into `master`,
which serves as the stable "vetted" branch.

## Issues affecting the release process

Occasionally there are temporary issues with the release process, check the
["release" tag](https://github.com/material-components/material-components-ios/labels/where%3ARelease)
for anything that might be affecting the release.

## Cutting the release

### Check the release milestone

We use weekly release milestones to track important issues that need to land in a given release.
These issues may come from client teams that are shipping to the App Store on a given date.

Open the [Milestones](https://github.com/material-components/material-components-ios/milestones) page and verify
that there are no open issues in this release's milestone. If there are open issues you must
identify why the issues are still open and either close them if resolved or determine whether it's
acceptable to move the issue to a subsequent release.

### Cut a release branch

After the announced time has passed, cut the release branch.

Run the following command to cut a release:

    scripts/release/cut
    git add CHANGELOG.md
    git commit -m "Cut release candidate."

You will now have a local `release-candidate` branch and a new section in CHANGELOG.md titled
"release-candidate".

### Send the release cut email

`scripts/release/cut` will output the body of an email you should now send.

### Create a release-candidate diff

Create a diff but mark it as `--plan-changes` so it does not go into peoples needs review inboxes.

    arc diff origin/master --nolint --plan-changes  --excuse release --message-file scripts/release/release_checklist.txt

Do NOT `arc land` this diff, its purpose is to have someone sanity check the release.

### Test the release branch

To test the branch locally you can run:

    arc unit --everything

Verify that the unit tests do not fail.

Build and run the catalog and demo applications:

    scripts/build_all_pod_projects

Identify why any failures occurred and resolve them before continuing.

### Push the release branch early and often

Push `release-candidate` to GitHub as you make necessary changes. This allows other people and
machines to track the progress of the release.

    git push origin release-candidate

#### How to address release feedback

Clients subscribed to the mailing list can now begin testing the release candidate branch. Address
concerns by making relevant changes to the `release-candidate` branch using the standard `arc diff`
flow and cherry-picking the resulting change into origin/develop.

    # Create a fix on the release branch
    arc feature <fix-name> release-candidate
    arc diff release-candidate
    arc land --onto release-candidate
    git push origin release-candidate

    # Any changes made above will be merged back into develop at the end of the releasing process
    # but if you need them in develop immediately, you can cherry-pick
    git checkout develop
    git rebase origin/develop
    git cherry-pick -x <SHA from release-candidate>
    git push origin develop

### Draft the release notes

You will now begin adding release notes to CHANGELOG.md in the "release-candidate" section.

**You will not know the version number yet**. To identify the version number you will examine the
release's **changes**.

> MDC's version numbers strictly follow [semantic versioning](http://semver.org/):
> `MAJOR.minor.patch`. In short, if the current version is `1.1.1`, then:
>
> * A major release is: `2.0.0`.
> * A minor release is: `1.2.0`.
> * A patch release is: `1.1.2`.
>
> These are *engineering* version numbers, intended for communicating to our engineering clients
> what type of follow-up work a upgrading to a release might entail. Since every breaking change
> bumps the major version number, we'll quickly run up to "large" major versions. That's ok.
>
> A release is initially assumed to be a patch release. The release classification escalates as
> changes are identified as non-breaking (minor release) or breaking (major release).
>
> **What are breaking changes?**
>
> - API deletions.
> - Visible changes to user interface components.
>
> **What are non-breaking changes?**
>
> - API additions or modifications.
> - Behavioral changes.
>
> **How can a release be a patch release?**
>
> Either there are **no changes to component source** (changes to component documentation —
> README.md or header docs — do not count), or component modifications **only include bug fixes
> with no apparent behavioral changes**.

Armed with an understanding of what we're looking for in a release classification, we'll now walk
through the available tools for informing our decision on the type of release we're cutting.

#### Generate the API diff

Generate the API diff by running the following:

    scripts/release/api_diff

- Append the command's output to CHANGELOG.md's "release-candidate" section.
- Delete any component sections that state "No public API changes detected."

Commit the changes to the release branch.

    git add CHANGELOG.md
    git commit -m "Added API diff to CHANGELOG.md."
    git push origin release-candidate

> **Release classification tips**
>
> If any public API is marked `[deleted]` then this release is now a **major release**.
>
> If any public API's nullability annotations have changed then this release is now a **major
> release**.
>
> Otherwise, if any public APIs are listed in the diff then this release is now a **minor release**.
>
> Otherwise, this release *might* still be a bug fix release.

#### Generate the change logs

Run the following command to generate a list of changes organized by component:

    scripts/release/changes

Paste the results into CHANGELOG.md's "release-candidate" section after the "API diffs" section.

#### Verify API changes

While we do primarily lean on the api_diff tool to call out API diffs, it does have known bugs.
Notably:

- [Doesn't take into consideration categories](https://github.com/mattstevens/objc-diff/issues/8)

For each API change, open the source at the latest checkout and verify that the API change does, in
fact, reflect the change that occurred.

Adjust the API diffs in CHANGELOG.md based on your visual inspection of the code. Keep an eye out
for APIs that are marked "deleted" by the generated API diff but are, in fact, deprecated.

Commit the final results to your branch.

    git add CHANGELOG.md
    git commit -m "Hand-modified CHANGELOG.md API diff."
    git push origin release-candidate

#### Identify visual changes

We do not presently have an automated way to identify visual changes between releases. See
[GitHub issue #290](https://github.com/material-components/material-components-ios/issues/290) for a discussion
on the topic.

#### Inspect the diff

##### Diff just the components/*/src

The final sanity check is to visually inspect the diff. In general we only care about changes to the
component source.
Note that scripts/release/diff takes a `--use_diff_tool` option to use your configured GUI
`git difftool`.

To filter the diff to only component changes, run:

    scripts/release/diff components/*/src/

##### Public header file changes

To generate a list of component **public header file** changes, run:

    scripts/release/changed_public_headers

##### Diff everything

To see all changes that are part of this release, run:

    scripts/release/diff

### Classify the release type

Based on the information at your disposal you should now be able to identify the release type.
Use the `next` script to generate the next version number:

    scripts/release/next {major|minor|patch}

Bump the release by running `bump` with the release's version number:

    scripts/release/bump <version number>

Also rename CHANGELOG.md's "release-candidate" section with the name of this release.

    $EDITOR CHANGELOG.md

Commit the results to your branch.

    git commit -am "Bumped version number to $(pod ipc spec MaterialComponents.podspec | grep '"version"' | cut -d'"' -f4)."
    git push origin release-candidate

## Release-blocking clients

Before you can merge the release branch into either develop or master you **must** get the release
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

Send the release-candidate branch out for review:

    git fetch
    git checkout release-candidate
    arc diff origin/master --nolint --plan-changes  --excuse release --message-file scripts/release/release_checklist.txt

Get a reviewer to approve the change.

## Merge the release candidate branch

Once the release-candidate has passed all tests by clients, you may merge the release into the
`develop` and `master` branches.

    # Did you listen to the dragon?
    #
    # Do not run this until all release-blocking clients have given the go-ahead.
    # Ensure that you've checked off every item in the commit message's checklist.
    #
    scripts/release/merge

Once you've resolved any merge conflicts your local `develop` and `master` branches will both
include the latest changes from `release-candidate`.

Before pushing these changes to GitHub it's a good idea to run a final sanity check:

    git checkout master
    arc unit --everything

    git checkout develop
    arc unit --everything

You can now push both branches to GitHub:

    git push origin master develop

and delete the release branch:

    git branch -d release-candidate
    git push origin :release-candidate

### Create the official release

1. Have all release-blocking clients given the go-ahead? **Do not create the official release until
   all release-blocking clients are ready**. Otherwise you might publish a release that isn't
   actually stable.
1. Visit our
   [GitHub list of releases](https://github.com/material-components/material-components-ios/releases), click on
   "Draft a new release".
1. Tag the release "vX.Y.Z".
1. Select the master branch.
1. Title the release "Release X.Y.Z".
1. In the body of the release notes, paste the text from [CHANGELOG.md](https://github.com/material-components/material-components-ios/blob/master/CHANGELOG.md) for this release.
1. Publish the release.

### Regenerate the site

You can preview your changes by serving a local version of the material component document site. Please refer to [Site Content Update](./site_content_update.md#build-and-preview-locally).

However, you need to be one of the material component core members in order to deploy the site for the moment. If you are able to run deploy the site, please refer to [Site Content Update](./site_content_update.md#deploy-to-production). Don't worry, we will incorporate the changes to the site for every weekly cut release as well.

### Fix clients

#### Reply to the original release email message

Post a reply to you message on [Material Components for iOS Discuss]
(https://groups.google.com/forum/#!forum/material-components-ios-discuss) indicating that you are
done.

#### Finish any internal work

Any work that was started by the [Release-blocking clients](#release-blocking-clients)
(dragon) step above may need to be finalized.
