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
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "//:material_components_ios.bzl",
    "mdc_extension_objc_library",
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "NavigationBar",
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        "//components/ButtonBar",
        "//components/Typography",
        "//components/private/Math",
        "@material_internationalization_ios//:MDFInternationalization",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":NavigationBar",
        "//components/schemes/Color",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":NavigationBar",
        "//components/schemes/Typography",
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
    visibility = ["//visibility:private"],
    deps = [
        ":ColorThemer",
        ":NavigationBar",
        ":TypographyThemer",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = native.glob(["tests/unit/*.swift"]),
    copts = [
        "-swift-version",
        "3",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":ColorThemer",
        ":NavigationBar",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)
