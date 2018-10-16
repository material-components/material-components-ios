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
     "mdc_objc_library",
     "mdc_unit_test_suite")

load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")
licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "NavigationDrawer",
    sdk_frameworks = [
        "Foundation",
        "UIKit",
    ],
    deps = [
        "//components/ShadowLayer",
        "//components/private/UIMetrics",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = native.glob(["tests/unit/*.m"]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [
         ":NavigationDrawer",
    ],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
    deps = [
        ":unit_test_sources",
    ]
)
