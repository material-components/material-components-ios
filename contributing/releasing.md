# Releasing

The MDC-iOS release process takes places whenever a significant body of work
needs to be made generally available, but typically once a week.  The release
process follows a set of general steps:

1.  A `release-candidate` branch is created and a Pull Request is created.
2.  The CHANGELOG and library version number are updated.
3.  The release is copied into Google for internal testing.
4.  Any unexpected breakages or problems are fixed immediately or reverted.
5.  The release is published to GitHub and CocoaPods.

If you have any questions about the release process in general, [please open an
Issue for the project
maintainers](https://github.com/material-components/material-components-ios/issues/new/choose).
