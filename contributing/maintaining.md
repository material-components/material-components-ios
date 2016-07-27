# Maintaining

These instructions describe how we accept changes into the material-components-ios (MDC) repository.
This doc is for core contributors. If you are looking for more casual contribution see the
[contributing page](https://github.com/google/material-components-ios/blob/develop/contributing/README.md).

## Pull Request Flow

This assumes that there is a GitHub pull request in flight.

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
* Commandeer the diff in the web UI.
* Run `arc patch` the diff to your local machine.
* Run `arc diff` the diff to run the linter and unit tests.
* Get the diff approved by another core team member like you would any other diff.
* Run `arc land` the diff as you would any other diff.
  * Note: this will preserve the original author of the pull request by using the last commit.
