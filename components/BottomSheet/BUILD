# Copyright 2017-present The Material Components for iOS Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite",
     "DEFAULT_IOS_RUNNER_TARGETS")
load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test_suite")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "BottomSheet",
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
      "//components/private/KeyboardWatcher",
      "//components/private/Math",
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
    deps = [":BottomSheet"],
    visibility = ["//visibility:private"],
)

mdc_objc_library(
    name = "app_tests_lib",
    testonly = 1,
    srcs = glob(["tests/app/*.m"]),
    hdrs = glob(["tests/app/*.h"]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [":BottomSheet"],
    visibility = ["//visibility:private"],
)

# These are separate from the regular unit test suite because we want to specify
# test_host so we can exercise tests which depend on UIKit functionality like
# UIViewController presentation logic.
ios_unit_test_suite(
    name = "app_tests",
    deps = [":app_tests_lib"],
    minimum_os_version = "8.0",
    size = "medium",
    test_host = "@build_bazel_rules_apple//apple/testing/default_host/ios",
    runners = DEFAULT_IOS_RUNNER_TARGETS,
)

mdc_unit_test_suite(
    deps = [
      ":unit_test_sources",
    ],
)
