# Copyright 2018-present The Material Components for iOS Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test_suite")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Cards",
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/Ink",
        "//components/ShadowLayer",
        "//components/private/Math",
        "//components/private/Icons/icons/ic_check_circle",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = native.glob([
        "tests/unit/*.m",
        "tests/unit/*.h",
    ]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [
        ":Cards",
        "//components/private/Icons/icons/ic_info",
    ],
    visibility = ["//visibility:private"],
)

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

config_setting(
    name = "older_xcode",
    values = {"define": "xcode_version_arg=8.3.3"},
)

ios_unit_test_suite(
    name = "unit_tests",
    deps = [
      ":unit_test_sources",
    ],
    minimum_os_version = "8.0",
    runners = [":IPHONE_5_IN_8_1", ":IPAD_PRO_12_9_IN_9_3", ":IPHONE_7_PLUS_IN_10_3", ":DYNAMIC_RUNNER"],
    visibility = ["//visibility:private"],
)

