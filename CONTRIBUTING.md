Want to contribute? Great! First, read this page (including the small print at the end).

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

| &darr; Component \ Task &rarr; | [API review](#api-review) | [Minimize dependencies](#minimize-dependencies) | [Nullability](#nullability-annotations) |
|:------------- |:-------------:|:-------------:|:-------------:|
| SomeComponent  |  |  |  |

## API review

API reviews work like typical code reviews with the added constraint of only reviewing the
component's **public APIs**.

To initiate an API review, send a pull request that only includes the public APIs you wish to
review.

TODO(featherless): Flesh this out with some concrete examples of existing API reviews.

## Minimize dependencies

We generally recommend zero dependencies as a goal, but reasonable exceptions can be made.

Avoid creating shared "Core" or "Utility" libraries. These wildcard libraries inevitably acquire
dust and reduce the modularity of anything built atop of them.

If your component does depend on such utilities, consider duplicating small functions within your
component.

## Nullability annotations

Nullability annotations improve our API compatibility in Swift.

1. **required** Add nullability annotations to every header of your component.

> Note: Material components **explicitly** annotate all public APIs rather than use
`NS_ASSUME_NONNULL_BEGIN`. This is an intentional deviation from Apple’s practice of using the
`ASSUME` macros.

The general annotation for id pointers is `nonnull`, `nullable` and `null_resetable`. They should be
used in method parameters, return values and property annotations.

`nonnull` - This pointer cannot be nil. This is commonly used for required method parameters or
properties and return values that are guaranteed to exist.

Consider the required URLString parameter in:

    - (instancetype)[NSURL initWithString:(nonnull NSString *)URLString];

`nullable` - This pointer may or may not be equal to nil.  This is commonly used for optional method
parameters, properties that are optional or as return values for a method that may not succeed.

Consider an NSDictionary returning nil when asked for a key:value pair that is doesn’t contain:

    - (nullable id)[NSDictionary objectForKey:key];

`null_resettable` - Used on properties that will always return a non-nil value, but you can reset
the property to its default by setting it to nil.

Consider UISwitch’s tintColor property:

    @property(null_resettable, nonatomic, strong) UIColor *tintColor;

`null_unspecified` - Indicates that you cannot make any guarantees to the state of this pointer. You
probably shouldn’t be using this annotation.

For plain C pointers, `__nullable` or `__nonnull` can be used.  To avoid conflicts with third-party
libraries, Xcode 7 also introduced replacement  keywords `_Nullable` and `_Nonnull`.

Once you add the first nullability annotation to any API in a file, Xcode will emit warnings for all
other APIs in that file that must also be annotated.

TODO(featherless): Add other steps.
