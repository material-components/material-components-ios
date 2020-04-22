"""Bazel macros for building MDC component libraries."""

load("@bazel_ios_warnings//:strict_warnings_objc_library.bzl", "strict_warnings_objc_library")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test", "ios_unit_test_suite")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

IOS_MINIMUM_OS = "9.0"
SNAPSHOT_IOS_MINIMUM_OS = "10.0"
SWIFT_VERSION = "4.2"

DEFAULT_IOS_RUNNER_TARGETS = [
    "//components/testing/runners:IPAD_PRO_12_9_IN_9_3",
    "//components/testing/runners:IPHONE_7_PLUS_IN_10_3",
]

KOKORO_ENVIRONMENT_IOS_RUNNER_TARGET = "//components/testing/runners:IPHONE_X_IN_11_0"
AUTOBOT_ENVIRONMENT_IOS_RUNNER_TARGET = "//components/testing/runners:IPHONE_8_IN_13_0"

SNAPSHOT_IOS_RUNNER_TARGET = "//components/testing/runners:IPHONE_7_IN_11_2"

def mdc_objc_library(
    name,
    copts = [],
    **kwargs):
  """Declare an Objective-C library with strict_warnings_objc_library."""
  strict_warnings_objc_library(
      name = name,
      copts = copts,
      **kwargs)

def mdc_swift_library(name, **kwargs):
  """Declare a Swift library that supports CocoaPods-style imports."""
  _mdc_cocoapods_compatible_swift_library(
      name = name,
      **kwargs)

def mdc_public_objc_library(
    name,
    deps = [],
    extra_srcs = [],
    sdk_frameworks = [],
    visibility = ["//visibility:public"],
    **kwargs):
  """Declare a public MDC component as a Objective-C library according to MDC's conventions.

  The conventions for an MDC component are:
  - The public implementation lives inside of src.
  - The private implementation lives inside of src/private.

  The default visibility of "//visibility:public" can be overridden, for
  example, "//some/package:__subpackages__".

  Args:
    name: The name of the library.
    deps: The dependencies of the library.
    extra_srcs: Extra sources to add to the standard ones.
    sdk_frameworks: The SDK frameworks needed, e.g. "CoreGraphics".
    visibility: The visibility of the package.
    **kwargs: Any arguments accepted by _mdc_objc_library().
  """
  mdc_objc_library(
      name = name,
      deps = deps,
      sdk_frameworks = sdk_frameworks,
      visibility = visibility,
      srcs = native.glob(["src/*.m", "src/private/*.h", "src/private/*.m"]) + extra_srcs,
      hdrs = native.glob(["src/*.h"]),
      includes = ["src"],
      enable_modules = 1,
      **kwargs)

def mdc_extension_objc_library(
    name,
    deps = [],
    sdk_frameworks = [],
    visibility = ["//visibility:public"],
    **kwargs):
  """Declare a public MDC component extension as an Objective-C library according to MDC's 
     conventions.

  The conventions for an MDC component extension are:
  - The public implementation lives in `src/$name/`.
  - The private implementation lives in `src/$name/private`.

  The default visibility can be overridden.

  Args:
    name: The name of the extension. It must match the folder it resides in.
    deps: The dependencies of the extension.
    sdk_frameworks: Extra SDK frameworks (e.g., CoreGraphics) required by the extension.
    visibility: The visibility of the extension.
    **kwarrgs: Any arguments accepted by _mdc_objc_library().
  """
  mdc_objc_library(
      name = name,
      deps = deps,
      sdk_frameworks = sdk_frameworks,
      visibility = visibility,
      srcs = native.glob([
          "src/" + name + "/*.m",
          "src/" + name + "/private/*.m",
          "src/" + name + "/private/*.h",
      ]),
      hdrs = native.glob(["src/" + name + "/*.h"]),
      includes = ["src/" + name],
      enable_modules = 1,
      **kwargs)

def mdc_examples_objc_library(
    name,
    deps = [],
    sdk_frameworks = [],
    visibility = ["//visibility:public"],
    **kwargs):
  """Declare an MDC component examples target as an Objective-C library according to MDC's
     conventions.

  The conventions for MDC component examples are:
  - The source lives in `examples/` and `examples/supplemental/`.

  The default visibility can be overridden.

  Args:
    name: The name of the examples target.
    deps: The examples dependencies.
    sdk_frameworks: Extra SDK frameworks (e.g., CoreGraphics) required by the examples.
    visibility: The visibility of the examples.
    **kwarrgs: Any arguments accepted by _mdc_objc_library().
  """
  mdc_objc_library(
      name = name,
      deps = deps,
      sdk_frameworks = sdk_frameworks,
      visibility = visibility,
      srcs = native.glob([
          "examples/*.m",
          "examples/*.h",
          "examples/supplemental/*.m",
          "examples/supplemental/*.h",
      ]),
      enable_modules = 1,
      **kwargs)

def mdc_examples_swift_library(
    name,
    deps = [],
    visibility = ["//visibility:public"],
    **kwargs):
  """Declare an MDC component examples target as a Swift library according to MDC's
     conventions.

  The conventions for MDC component examples are:
  - The source lives in `examples/` and `examples/supplemental/`.

  The default visibility can be overridden.

  Args:
    name: The name of the examples target.
    deps: The examples dependencies.
    visibility: The visibility of the examples.
    **kwarrgs: Any arguments accepted by _mdc_objc_library().
  """
  _mdc_cocoapods_compatible_swift_library(
      name = name,
      deps = deps,
      visibility = visibility,
      copts = [
          "-swift-version",
          "4.2",
      ],
      srcs = native.glob([
          "examples/*.swift",
          "examples/supplemental/*.swift",
      ]),
      **kwargs)

def mdc_unit_test_objc_library(
    name,
    extra_srcs = [],
    deps = [],
    sdk_frameworks = [],
    visibility = ["//visibility:private"],
    testonly = 1,
    **kwargs):
    """Declare an mdc_objc_library for unit test sources."""
    mdc_objc_library(
        name = name,
        srcs = native.glob([
            "tests/unit/*.m",
            "tests/unit/*.h",
        ]) + extra_srcs,
        deps = deps,
        sdk_frameworks = ["XCTest"] + sdk_frameworks,
        visibility = visibility,
        testonly = testonly,
        **kwargs)

def mdc_unit_test_swift_library(
    name,
    extra_srcs = [],
    deps = [],
    visibility = ["//visibility:private"],
    testonly = 1,
    **kwargs):
    """Declare a swift_library for unit test sources."""
    _mdc_cocoapods_compatible_swift_library(
        name = name,
        srcs = native.glob(["tests/unit/*.swift"]) + extra_srcs,
        deps = deps,
        visibility = visibility,
        testonly = testonly,
        copts = [
            "-swift-version",
            SWIFT_VERSION,
        ],
        **kwargs)

def mdc_snapshot_objc_library(
    name,
    extra_srcs = [],
    deps = [],
    sdk_frameworks = [],
    visibility = ["//visibility:private"],
    testonly = 1,
    **kwargs):
  """Declare an mdc_objc_library for snapshot test source."""
  mdc_objc_library(
      name = name,
      srcs = native.glob([
          "tests/snapshot/*.m",
          "tests/snapshot/*.h",
          "tests/snapshot/supplemental/*.m",
          "tests/snapshot/supplemental/*.h",
      ]) + extra_srcs,
      deps = ["//components/private/Snapshot"] + deps,
      sdk_frameworks = ["XCTest", "CoreGraphics"] + sdk_frameworks,
      visibility = visibility,
      testonly = testonly,
      **kwargs)

def mdc_snapshot_swift_library(
    name,
    extra_srcs = [],
    deps = [],
    visibility = ["//visibility:private"],
    testonly = 1,
    **kwargs):
  """Declare a swift_library for snapshot test source."""
  _mdc_cocoapods_compatible_swift_library(
      name = name,
      srcs = native.glob(["tests/snapshot/*.swift"]) + extra_srcs,
      deps = ["//components/private/Snapshot"] + deps,
      visibility = visibility,
      testonly = testonly,
      copts = [
          "-swift-version",
          SWIFT_VERSION,
      ],
      **kwargs)

def mdc_snapshot_test(
    name,
    deps = [],
    minimum_os_version = SNAPSHOT_IOS_MINIMUM_OS,
    visibility = ["//visibility:private"],
    size = "medium",
    tags = ["exclusive"],
    **kwargs):
  """Declare an MDC ios_unit_test for snapshot tests."""
  ios_unit_test(
      name = name,
      deps = deps,
      minimum_os_version = minimum_os_version,
      runner = SNAPSHOT_IOS_RUNNER_TARGET,
      tags = tags,
      test_host = "//components/private/Snapshot/TestHost",
      visibility = visibility,
      # TODO(https://github.com/material-components/material-components-ios/issues/6335)
      flaky = 1,
      size = size,
      **kwargs)

def mdc_ci_config_setting():
    """Config setting for mdc continuous integration, e.g. --define ci_mode=kokoro"""
    native.config_setting(
        name = "kokoro",
        values = {"define": "ci_mode=kokoro"},
    )
    native.config_setting(
        name = "autobot",
        values = {"define": "ci_mode=autobot"},
    )

def mdc_unit_test_suite(
    name,
    deps = [],
    minimum_os_version = IOS_MINIMUM_OS,
    visibility = ["//visibility:private"],
    size = "medium",
    use_autobot_environment_runner = True,
    **kwargs):
    """Declare a MDC unit_test_suite and a unit_test_environment using the ios_runners matrix.

    Args:
        name: The name of the target.
        deps: The dependencies of the target.
        minimum_os_version: The minimum iOS version supported by the target.
        visibility: The visibility of the package.
        size: The size of the test.
        use_autobot_environment_runner: Indicates whether autobot (a testing machine) environment runner should be used.
        **kwargs: Any arguments accepted by ios_unit_test().
    """
    mdc_ci_config_setting()
    runners = list(DEFAULT_IOS_RUNNER_TARGETS)
    if use_autobot_environment_runner:
        ios_unit_test(
            name = name + '_environment',
            deps = deps,
            minimum_os_version = minimum_os_version,
            runner = select({
                ":kokoro": KOKORO_ENVIRONMENT_IOS_RUNNER_TARGET,
                ":autobot": AUTOBOT_ENVIRONMENT_IOS_RUNNER_TARGET,
                "//conditions:default": KOKORO_ENVIRONMENT_IOS_RUNNER_TARGET,
            }),
            visibility = visibility,
            size = size,
            **kwargs)
    else:
        runners.append(KOKORO_ENVIRONMENT_IOS_RUNNER_TARGET)
    ios_unit_test_suite(
        name = name,
        deps = deps,
        minimum_os_version = minimum_os_version,
        runners = runners,
        visibility = visibility,
        size = size,
        **kwargs
    )

# The bazel target for the tool we use to rewrite import statements.
BAZEL_IMPORT_REWRITER = "//scripts/bazel_import_rewriter"

def _mdc_cocoapods_compatible_swift_library(
    name,
    srcs,
    **kwargs):
    """Internal Swift library rule for CocoaPods compatibility.

    Rewrites the provided source files to use Bazel-style imports.

    This rule is a drop-in replacement for swift_library.

    Args:
      name: The name of the target.
      srcs: The source Swift files for this library.
      **kwarrgs: Any arguments to be passed to swift_library.
    """
    cocoapods_compatible_srcs_target_name = name + "_cocoapods_compatible_srcs"

    # First, map all of the srcs to their outs.
    bazel_import_srcs = []
    for src in srcs:
        bazel_import_srcs.append(src.replace(".swift", ".bazel_imports.swift"))

    # Then, create an intermediary rule that transforms all of the srcs files.
    # Note that we provide the srcs and outs as a concatenated list of args.
    # E.g. if srcs is ['src1.swift', 'src2.swift'],
    # then outs is ['src1.bazel_imports.swift', 'src2.bazel_imports.swift']
    # and the command invocation is:
    #
    #     $cmd src1.swift src2.swift src1.bazel_imports.swift src2.bazel_imports.swift
    #
    native.genrule(
        name = cocoapods_compatible_srcs_target_name,
        srcs = srcs,
        outs = bazel_import_srcs,
        cmd = "$(location %s) $(SRCS) $(OUTS)" % BAZEL_IMPORT_REWRITER,
        tools = [BAZEL_IMPORT_REWRITER],
    )

    # And finally, define our swift_library with the `srcs` swapped for our generated srcs.
    swift_library(
        name = name,
        srcs = [":" + cocoapods_compatible_srcs_target_name],
        **kwargs)
