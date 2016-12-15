# Versions and releases

MDC's version numbers strictly follow [semantic versioning](http://semver.org/):
`MAJOR.minor.patch`. In short, if the current version is `1.1.1`, then:

* A major release has a version number of `2.0.0`.
* A minor release has a version number of `1.2.0`.
* A patch release has a version number of `1.1.2`.

> These are *engineering* version numbers, intended for communicating to our engineering clients
> what type of follow-up work a upgrading to a release might entail. Since every breaking change
> bumps the major version number, we'll quickly run up to "large" major versions. That's ok.

Major releases can contain breaking changes to clients, while minor and patch releases cannot.

## What are breaking changes?

- API deletions or modifications.
- Visible changes to user interface components.

## What are non-breaking changes?

- API additions.
- Behavioral changes.

## How can a release be a patch release?

Either:

- There are *no changes to component sources* (changes to documentation—README.md or
header docs—do not count), or
- Component changes *only include bug fixes with no apparent behavioral changes*.

