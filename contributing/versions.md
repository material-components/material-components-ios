# Versions and releases

MDC's version numbers strictly follow [semantic versioning v2.0.0](https://semver.org/spec/v2.0.0.html):
`MAJOR.minor.patch`. In short, if the current version is `1.1.1`, then:

* A major release has a version number of `2.0.0`.
* A minor release has a version number of `1.2.0`.
* A patch release has a version number of `1.1.2`.

> These are *engineering* version numbers, intended for communicating to our engineering clients
> what type of follow-up work a upgrading to a release might entail. Since every breaking change
> bumps the major version number, we'll quickly run up to "large" major versions. That's ok.

Major releases can contain breaking changes to clients, while minor and patch releases cannot.

## How do we determine which numbers need to change?

We follow the guidelines defined by the [semver v2.0.0](https://semver.org/spec/v2.0.0.html#semantic-versioning-specification-semver) specification.

Our public API includes the following:

- APIs that are present in non-private headers. A private header is one that is contained within a sub-directory named `private/` within a `src/` directory.

We define "backwards incompatible changes" to include the following:

- Any change that will result in a build breakage from the previous release.

## What is the source of truth for MDC's version number?

The [VERSION](https://github.com/material-components/material-components-ios/blob/develop/VERSION)
file contains the current version as a simple string (and nothing else). Our `scripts/release/bump`
script updates that number and copies it into all the locations that it needs to end up, e.g.
CocoaPods podspecs, etc. You can use the `scripts/print_version` script to print out the version
number of the library.

