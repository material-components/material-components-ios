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
    "mdc_examples_objc_library",
    "mdc_examples_swift_library",
    "mdc_extension_objc_library",
    "mdc_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_public_objc_library",
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Chips",
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/Ink",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/ShapeLibrary",
        "//components/Shapes",
        "//components/TextFields",
        "//components/Typography",
        "//components/private/Math",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":Chips",
        ":ColorThemer",
        ":ShapeThemer",
        ":TypographyThemer",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "ChipThemer",
    deps = [
        ":Chips",
        ":ColorThemer",
        ":ShapeThemer",
        ":TypographyThemer",
    ],
)

mdc_objc_library(
    name = "privateHeaders",
    hdrs = glob(["src/*.h"]),
    visibility = ["//visibility:private"],
    deps = [":Chips"],
)

mdc_extension_objc_library(
    name = "FontThemer",
    deps = [
        ":Chips",
        "//components/Themes",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":Chips",
        "//components/schemes/Color",
    ],
)

mdc_extension_objc_library(
    name = "ShapeThemer",
    deps = [
        ":Chips",
        "//components/schemes/Shape",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":Chips",
        "//components/schemes/Typography",
    ],
)

mdc_objc_library(
    name = "private",
    testonly = 1,
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = ["//visibility:private"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":Chips",
        ":ShapeThemer",
        ":Theming",
        ":TypographyThemer",
        "//components/ShapeLibrary",
        "//components/Shapes",
        "//components/Slider",
        "//components/Slider:ColorThemer",
        "//components/TextFields",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Shape",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":Chips",
        ":Theming",
        "//components/TextFields",
        "//components/schemes/Container",
    ],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = glob([
        "tests/unit/*.swift",
        "tests/unit/Theming/*.swift",
    ]),
    copts = [
        "-swift-version",
        "3",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":Chips",
        ":Theming",
        "//components/schemes/Color",
        "//components/schemes/Shape",
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
        ":ChipThemer",
        ":Chips",
        ":ColorThemer",
        ":FontThemer",
        ":ShapeThemer",
        ":TypographyThemer",
        ":private",
        ":privateHeaders",
        "//components/ShapeLibrary",
        "//components/TextFields:private",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    asset_catalogs = [
        "tests/snapshot/resources/ChipsSnapshotTests.xcassets/ic_cancel.imageset",
        "tests/snapshot/resources/ChipsSnapshotTests.xcassets/ic_mask.imageset",
    ],
    deps = [
        ":Chips",
        ":Theming",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
