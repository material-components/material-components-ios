"""Bazel macros for building MDC component libraries."""

load("@bazel_ios_warnings//:strict_warnings_objc_library.bzl", "strict_warnings_objc_library")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

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

ios_test_runner(
  name = "IPHONE_5_IN_8_1",
  device_type = "iPhone 5",
  os_version = "8.1",
)
ios_test_runner(
  name = "IPAD_PRO_12_9_IN_9_3",
  device_type = "iPad Pro (12.9-inch)",
  os_version = "9.3",
)
ios_test_runner(
  name = "IPHONE_7_PLUS_IN_10_3",
  device_type = "iPhone 7 Plus",
  os_version = "10.3",
)
ios_test_runner(
  name = "DYNAMIC_RUNNER",
  device_type = select({ ":older_xcode": "iPad 2", "//conditions:default": "iPhone X" }),
  os_version = select({ ":older_xcode": "8.4", "//conditions:default": "11.0" }), 
)

native.config_setting(
    name = "older_xcode",
    values = {"xcode_version": "8.3.3"},
)

RUNNERS = [":IPHONE_5_IN_8_1", ":IPAD_PRO_12_9_IN_9_3", ":IPHONE_7_PLUS_IN_10_3", ":DYNAMIC_RUNNER"]