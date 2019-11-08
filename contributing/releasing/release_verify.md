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