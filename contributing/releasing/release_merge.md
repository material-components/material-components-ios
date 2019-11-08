## Merge the release candidate branch

Once the release-candidate has **passed all "Required" GitHub presubmit tests** and **all internal presubmit tests**, you may merge the release into the
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

You can now sync to the desired stable release. [go/mdc-releasing#re-run-the-import-script-against-githubstable](http://go/mdc-releasing#re-run-the-import-script-against-githubstable). 