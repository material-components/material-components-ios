# Coding conventions

Since we all want to spend more time coding and less time fiddling with whitespace, Material
Components for iOS uses coding conventions and styles to encourage consistency. Code with a
consistent coding style is easier (and less error-prone!) to review, maintain, and understand.

In general, we try to use established conventions instead of spending engineering time on developing
new ones; please be patient if MDC's coding style isn't the same as your preferred coding style. :)

## Be consistent

If you're not sure what to do in any particular situation, the cardinal rule is to **be
consistent**. For example, take a look at the surrounding code and do whatever it's doing, or look
for similar classes elsewhere in the code base.

## General conventions

### Minimize dependencies

Avoid non-essential dependencies between components.

A goal of MDC is to allow each component to be used independently of the others, as much as
reasonably possible.

- Dependencies increase cost of maintenance and cost of usage for a component, and
- Dependency-less components are much easier to add and remove from a project.
- In particular, "Core"- or "Utility"-type components often become a dumping ground and artificially
  increase interdependencies between components.

Recommendations:

- Aim for zero non-platform dependencies.
- Create small, targeted components.
- Watch out for the tendency for components to grow in scope or become overly vague and
  "utility"-like.

## Objective-C

Objective-C must be used for the implementation of components and can be used for unit tests, UI
tests, and demonstration apps.

### Style

Material Components for iOS follows [Google's Objective-C style
guide](https://google.github.io/styleguide/objcguide.xml) for Objective-C code. Note that the
Objective-C style guide uses the [Google C++ style
guide](https://google.github.io/styleguide/cppguide.html) as its "superclass", meaning that rules
from the C++ style guide are in effect unless the Objective-C style guide indicates otherwise.

#### clang-format

We use [clang-format](http://clang.llvm.org/docs/ClangFormat.html) to automatically format our
Objective-C code. If you're going to be contributing more than a few one-offs, we suggest
[installing clang-format](clang-format.md) to take care of the formatting for you. We recommend
running clang format on your changes before sending a pull request because it will facilitate
readability by everyone working on the project.

### Nullability annotations

Add [nullability annotations](https://developer.apple.com/swift/blog/?id=25) to your public APIs to
improve Objective-C and Swift interoperations.

* Use `_Nullable` and `_Nonnull`, not `__nullable` and `__nonnull`, since the latter are for Xcode
  6.3, which we do not support.
* Explicitly annotate all public APIs instead of using `NS_ASSUME_NONNULL_BEGIN` and
  `NS_ASSUME_NONNULL_END`.

### Macros

Avoid macros.

* Most uses of macros can be replaced with `static inline` C functions.
* Macros are appropriate when dealing with system-level macros like
  `__IPHONE_OS_VERSION_MIN_REQUIRED`.

### A note about subclassing a UIView

Assume you've created MDCFooSpinner which subclasses UIView.

* Implement both initWithFrame: and initWithCoder:.
* If both init methods are setting up the same state, each should call a common method.
* To avoid collisions and problems subclasses, this common method should be named
  commonMDCFooSpinnerInit.

## Swift

Swift cannot be used for the implementation of components, but is encouraged for unit tests, UI
tests, and demonstration apps.

Given the rapid change in the Swift language and coding styles, we don't enforce any particular
style of Swift except to follow the cardinal rule: *be consistent*.
