# Maintaining

These instructions describe how we accept changes into the material-components-ios (MDC) repository.
This doc is for core contributors. If you are looking for more casual contribution see the
[contributing page](https://github.com/googlmaterial-components-ios/blob/develop/contributing/README.md).

## Install contributor tools

Run the `./scripts/install_contributor_tools` to ensure you have the same version of third party
tools like clang-format, proselint, jazzy, arc.

## Arc commands

We use Phabricator as our code review tool. As a core contributor you will be using `arc` commands
to post your code up to [codereview.cc/differential](http://codereview.cc/differential/) where it
will be reviewed by at least one other core team member before it gets committed into our develop
branch.
The [arc user guide](https://secure.phabricator.com/book/phabricator/article/arcanist_diff) is a
good reference. We have changed our default `arc diff` range to `origin/develop..HEAD` since develop
is our active branch. `arc --help` lists all arc commands.

### Typical life of a diff

#### Do the work

```
arc feature awesomeChange     # Will create a git branch named awesomeChange
touch awesomeFile.m           # Make some changes
git commit -am "[Awesome] Need to make this awesome" # Commit those changes
```

#### Send it off for review:

```
git checkout awesomeChange    # To get back on your branch if you were somewhere else
arc diff                      # Will upload a diff off develop and mark it ready for review
```

The `arc diff` command will present you with an opportunity to edit the diff's subject, summary,
reviewers and more but that can be edited later in the web UI.

#### If someone `Requests Changes`:

```
git checkout awesomeChange    # To get back on your branch if you were somewhere else
touch awesomeFile.h           # Make the change requested.
git commit -am "Made that change you wanted."
arc diff                      # Will update the diff to the new state and mark it ready for review.
```

Keep repeating this until you the reviewer marks the diff `Accept Revision`


#### Once we get a approval

```
git checkout awesomeChange    # To get back on your branch if you were somewhere else
arc land                      # Will squash the commits, use the diff's title and summary and rebase
                              # onto develop.
```

The `arc land` will automatically push the changes up to develop and delete your feature branch.
Phabricator is also watching for changes to the repository and will mark diffs closed once you land
them.

If you are unsure of what will happen use `arc which` for information or `arc land --hold` to do a
dry run (everything but push). Use `arc land --help` to see the reference doc.

## Pull Request Flow

This assumes that there is a GitHub pull request in flight and you are trying to get shepherd it
into the repository.

### Run github-to-phabricator script

Get the github-to-phabricator script and from the root of the project run
```
node mirror_prs.js
```
You know it worked if [codereview.cc](http://codereview.cc) has a new diff with a github-bot author
and the pull request has a comment pointing at that diff.

#### Error: unlikely able to merge

If you get an `Unlikely able to merge` it means their branch is behind google:develop and needs to
be synced for the script to work.

##### You can sync it for them
If you do so they will lose credit for the change because you will be the last person to make a
commit before our github-to-phabricator script runs.

To sync their branch for them follow these steps:

* Add their fork to [your remotes](https://help.github.com/articles/pushing-to-a-remote/#remotes-and-forks)
  * Note: The pull request page has `<THEIR_REMOTE_URL>` inside the `command line instructions`
  link.
```
git remote add contributorsHandleFork git@github.com:contributorsHandle/material-components-ios.git
git fetch contributorsHandleFork
```
* Follow **Step 1** on the GitHub pull request web page to get their changes.
  This would look something like:
```
git checkout -b contributorsHandle-patch-1 develop
git pull git@github.com:contributorsHandle/material-components-ios.git patch-1
```
* Push the changes back to their branch on their
[fork](https://help.github.com/articles/pushing-to-a-remote/) of the repository.
```
git push contributorsHandleFork patch-1
```

At this point you should try to rerun the github-to-phabricator script.

### Commandeer revision from the github-bot

We assuming that you have a gitub-bot authored diff that came from a pull request on GitHub. If this
is not the case see above for triggering the [github-to-phabricator](#run-github-to-phabricator-script)
script.

You should:
* Take the `Commandeer Revision` action on the diff in the web UI.
* Run `arc patch` the diff to your local machine.
* Run `arc diff` the diff to run the linter and unit tests.
* Get the diff approved by another core team member like you would any other diff.
* Run `arc land` the diff as you would any other diff.
  * Note: this will preserve the original author of the pull request by using the last commit.
