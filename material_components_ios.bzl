"""Bazel macros for building MDC component libraries."""

load("@bazel_ios_warnings//:strict_warnings_objc_library.bzl", "strict_warnings_objc_library")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")
load("@build_bazel_rules_apple//apple:ios.bzl", 
    "ios_application",
    "ios_unit_test",
    "ios_unit_test_suite"
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

IOS_MINIMUM_OS = "8.0"
SNAPSHOT_IOS_MINIMUM_OS = "10.0"

DEFAULT_IOS_RUNNER_TARGETS = [
    "//components/testing/runners:IPHONE_5_IN_8_1",
    "//components/testing/runners:IPAD_PRO_12_9_IN_9_3",
    "//components/testing/runners:IPHONE_7_PLUS_IN_10_3",
    "//components/testing/runners:IPHONE_X_IN_11_0",
]

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
  swift_library(
      name = name,
      deps = deps,
      visibility = visibility,
      copts = [
          "-swift-version",
          "3",
      ],
      srcs = native.glob([
          "examples/*.swift",
          "examples/supplemental/*.swift",
      ]),
      **kwargs)

def mdc_snapshot_test(
    name,
    deps = [],
    minimum_os_version = SNAPSHOT_IOS_MINIMUM_OS,
    visibility = ["//visibility:private"],
    size = "medium",
    **kwargs):
  
  test = "%sTest" % name
  app = "%sApp" % name

  """Declare an MDC ios_unit_test for snapshot tests."""
  ios_unit_test(
      name = test,
      deps = deps,
      minimum_os_version = minimum_os_version,
      runner = SNAPSHOT_IOS_RUNNER_TARGET,
      test_host = ":%s" % app,
      visibility = visibility,
      env = {
          "FB_REFERENCE_IMAGE_DIR":"snapshot_test_goldens/goldens",
      },
      size = size,
      **kwargs)
  ios_application(
      name = app,
      infoplists = ["//components/private/Snapshot/TestHost:TestHost-Info.plist"],
      families = ["iphone"],
      bundle_id = "io.material.ios.snapshot",
      testonly = 1,
      deps = [
          "//components/private/Snapshot/TestHost",
      ],
      minimum_os_version = minimum_os_version)

def mdc_unit_test_suite(
    name,
    deps = [],
    minimum_os_version = IOS_MINIMUM_OS,
    visibility = ["//visibility:private"],
    size = "medium",
    **kwargs):
  """Declare a MDC unit_test_suite using the ios_runners matrix."""
  ios_unit_test_suite(
    name = name,
    deps = deps,
    minimum_os_version = minimum_os_version,
    runners = DEFAULT_IOS_RUNNER_TARGETS,
    visibility = visibility,
    size = size,
    **kwargs
  )
