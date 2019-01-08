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
    name = "ActionSheet",
    sdk_frameworks = ["UIKit"],
    deps = [
        "//components/BottomSheet",
        "//components/Ink",
        "//components/Typography",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":ActionSheet",
        ":ColorThemer",
        ":TypographyThemer",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "ActionSheetThemer",
    deps = [
        ":ActionSheet",
        ":ColorThemer",
        ":TypographyThemer",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":ActionSheet",
        "//components/schemes/Typography",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":ActionSheet",
        "//components/schemes/Color",
    ],
)

mdc_objc_library(
    name = "privateHeaders",
    testonly = 1,
    hdrs = native.glob(["src/private/*.h"]),
    deps = [":ActionSheet"],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
)

mdc_objc_library(
    name = "ObjcExamples",
    srcs = glob([
        "examples/*.m",
        "examples/*.h",
        "examples/supplemental/*.m",
        "examples/supplemental/*.h",
    ]),
    deps = [
        ":ActionSheet",
        ":Theming",
        "//components/Buttons:ButtonThemer",
        "//components/schemes/Color",
        "//components/schemes/Typography",
    ],
)

swift_library(
    name = "SwiftExamples",
    srcs = glob([
        "examples/*.swift",
        "examples/supplemental/*.swift",
    ]),
    deps = [
        ":ActionSheet",
        ":Theming",
    ],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = glob(["tests/unit/*.swift"]),
    copts = [
        "-swift-version",
        "3",
    ],
    deps = [
        ":ActionSheet",
        ":ColorThemer",
        ":private",
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
        "CoreImage",
        "XCTest",
    ],
    deps = [
        ":ActionSheet",
        ":ActionSheetThemer",
        ":ColorThemer",
        ":Theming",
        ":TypographyThemer",
        ":privateHeaders",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)
