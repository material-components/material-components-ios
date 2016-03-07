Want to contribute? Great! First, read this page (including the small print at the end).

## Pull requests

Pull requests can be hard to review if they try to tackle too many things
at once. Phabricator's "[Writing Reviewable Code](https://secure.phabricator.com/book/phabflavor/article/writing_reviewable_code/)"
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
the one above, the [Software Grant and Corporate Contributor License Agreement](https://cla.developers.google.com/about/google-corporate).
