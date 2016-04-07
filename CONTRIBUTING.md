Want to contribute? Great! First, read this page (including the [small print](#the-small-print)).

## Pull requests

Pull requests can be hard to review if they try to tackle too many things
at once. Phabricator's
"[Writing Reviewable Code](https://secure.phabricator.com/book/phabflavor/article/writing_reviewable_code/)"
provides a set of guidelines that help increase the likelihood of your
pull request getting merged.

In short (slightly modified from the original article):

- A pull request should be as small as possible, but no smaller.
- The smallest a pull request can be is a single cohesive idea: don't
  make pull requests so small that they are meaningless on their own.
- Turn large pull requests into small pull requests by dividing large
  problems into smaller problems and solving the small problems one at
  a time.
- Write sensible pull request descriptions.

Our additions:

- A pull request should affect as few components as possible.
- Pull requests must include a modification to the CHANGELOG.md summarizing the
  change.

### Conventions

This repository follows a file layout convention that ensures consistency and
predictability across all of our components. The convention for a given
component is as follows:

    components/ComponentName/
      README.md
      docs/                 <- In-depth technical documentation.
        TechnicalDoc1.md    <- Docs are written in Markdown.
        assets/             <- All documentation assets live here.
          image.png         <- Pngs, movs, gifs, etc...
      examples/             <- Examples added here show up in the [Catalog](catalog/README.md).
        Example.swift       <- Examples can be Swift,
        Example.m           <-                        or Objective-C
      src/                  <- All component source lives here
        MaterialComponent.h <- Every component must have an umbrella header
        MDCObject.h         <- Component source must be written in Objective-C.
        MDCObject.m
      tests/                <- All tests here will show up in the [Catalog](catalog/README.md).
        unit/               <- All unit tests must go here.
          SomeAPITest.swift <- Unit tests can be Swift,
          AnotherTest.m     <-                          or Objective-C.

Note that all directories are **lower-cased** except the component's root
directory.

### Before you contribute

Before we can use your code, you must sign the
[Google Individual Contributor License Agreement](https://developers.google.com/open-source/cla/individual?csw=1)
(CLA), which you can do online. The CLA is necessary mainly because you own the
copyright to your changes, even after your contribution becomes part of our
codebase, so we need your permission to use and distribute your code. We also
need to be sure of various other things—for instance that you'll tell us if you
know that your code infringes on other people's patents. You don't have to sign
the CLA until after you've submitted your code for review and a member has
approved it, but you must do it before we can put your code into our codebase.
Before you start working on a larger contribution, you should get in touch with
us first through the issue tracker with your idea so that we can help out and
possibly guide you. Coordinating up front makes it much easier to avoid
frustration later on.

### Code reviews

All submissions, including submissions by project members, require review. We
allow pull requests to be filed, but we perform code reviews on codereview.cc.

### The small print

Contributions made by corporations are covered by a different agreement than
the one above, the
[Software Grant and Corporate Contributor License Agreement](https://cla.developers.google.com/about/google-corporate).

# Component checklist

This checklist describes the process by which Material components are built.

## API review

API reviews work like typical code reviews with the added constraint of only reviewing the
component's **public APIs**.

To initiate an API review, send a pull request that only includes the public APIs you wish to
review.

TODO(featherless): Flesh this out with some concrete examples of existing API reviews.

## Minimize dependencies

The work: avoid non-essential dependencies.

The why: the team has had many discussions on this topic. Generally speaking, we use the following
considerations as a basis for minimizing dependencies:

- dependencies increase cost of maintenance and cost of usage for a component, and
- dependency-less components are much easier to drop in and, most importantly, to remove from a
  project.

[Reach out to the team directly](community/#questions) for advice or questions on this matter.

Recommendations:

- Aim for zero non-platform dependencies.
- Reasonable exceptions can be made, but must be justified.
- Do not create "Core" or "Utility" libraries.

## Nullability annotations

The work: add nullability annotations to every header of your component.

The why: nullability annotations improve Swift usage of a component's APIs.
[Learn more](https://developer.apple.com/swift/blog/?id=25)

Recommendations:

We **explicitly** annotate all public APIs rather than use `NS_ASSUME_NONNULL_BEGIN`. This is an
intentional deviation from Apple’s practice of using the `ASSUME` macros.

While Xcode 7 also introduced `_Nullable` and `_Nonnull`, we require the `__nullable` and
`__nonnull` versions in order to maintain Xcode 6 support.

Further reading:

- http://nshipster.com/swift-1.2/#nullability-annotations
