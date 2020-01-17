# Bazel and Kokoro support for MDC iOS

[Bazel](https://bazel.build/) is Google's open source build infrastructure. Kokoro is Google's
continuous integration infrastructure, presently visible
[only to Googlers](http://kokoro.corp.google.com/job/MaterialComponents_iOS/job/macos_external/).

Kokoro, like Travis CI, will run continuous integration on the latest commits to develop as
well as presubmit checks on pull requests. The entry-point for the kokoro continuous integration
script is the `.kokoro` script in the root of the repo.

## Running kokoro presubmits locally

First, ensure that you have [installed bazel 0.20](https://docs.bazel.build/versions/master/install-os-x.html#install-with-installer-mac-os-x) using [the binary installer from the Release page](https://github.com/bazelbuild/bazel/releases/tag/0.20.0) (not Homebrew)
and at least one version of Xcode.

Run the following command from the root of your MDC-iOS repo to run the presubmits:

```
./.kokoro
```

The presubmit script will build and run unit tests against every version of Xcode installed on your
local machine. The results of the unit tests will be reported to the console.

## Module import statements

When bazel generates modules for use in Swift, module names follow the convention of
`path_to_component_component`. For example, ActivityIndicator would need to be imported like so in a
swift file:

```swift
import components_ActivityIndicator_ActivityIndicator
```

However, because we primarily support CocoaPods for public use, we write our import statements like
so in the committed code:

```swift
import MaterialComponents.MaterialActivityIndicator
```

The `.kokoro` script has a pre/post phase where it will translate between the CocoaPods-supported
import statements and the bazel-supported import statements.

> Note that the kokoro script can only translate import statements that specify the component name.
> Import statements like the following will need to be updated to use the more specific
> `MaterialComponents.Material<component>` pattern:
>
>     import MaterialComponents

## BUILD files

In order for a component to be included in the kokoro presubmits it must have a `BUILD` file. This
file must be located in the root of the component's folder:

```
components/
  ActivityIndicator/
    BUILD
```

### Minimal BUILD template

For a component written in Objective-C with only Objective-C tests and no resources or dependencies.

```
load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "ComponentName",
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = glob(["tests/unit/*.m"]),
    hdrs = glob(["tests/unit/*.h"]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [":ComponentName"],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
  name = "unit_tests",
    deps = [
      ":unit_test_sources",
    ],
)
```

### Adding dependencies

Dependencies are added as paths relative to the root of the MDC iOS repo:

```
mdc_public_objc_library(
    name = "ComponentName",
    deps = ["//components/Palettes"],
)

```

### Adding a Bundle

If your component depends on non-source resources, you can add a bundle target to your component
with the following additions:

```
load("//tools/build_defs/apple:resources.bzl", "apple_bundle_import")

mdc_public_objc_library(
    name = "ComponentName",
    data = [":Bundle"],
)

apple_bundle_import(
    name = "Bundle",
    bundle_imports = glob([
        "src/ComponentName.bundle/**",
    ]),
)
```

### Exposing private APIs to unit tests

You can export private APIs such that they are only visible to unit test targets using `filegroup`
rules:

```
mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    deps = [":Ink"],
    includes = ["src/private"],
    visibility = [":test_targets"],
)

package_group(
    name = "test_targets",
    packages = [
        "//components/ComponentName/...",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = glob(["tests/unit/*.m"]),
    hdrs = glob(["tests/unit/*.h"]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [
        ":ComponentName",
        ":private"
    ],
    visibility = ["//visibility:private"],
)
```

### Adding Swift unit tests

```
mdc_swift_library(
    name = "unit_test_swift_sources",
    srcs = glob(["tests/unit/*.swift"]),
    deps = [":ComponentName"],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
  name = "unit_tests",
    deps = [
      ":unit_test_sources",
      ":unit_test_swift_sources"
    ],
)
```
