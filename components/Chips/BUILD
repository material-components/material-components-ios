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
    "mdc_public_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
    "mdc_unit_test_swift_library",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Chips",
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/Elevation",
        "//components/Ink",
        "//components/Ripple",
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
        "//components/Typography",
        "//components/schemes/Container",
    ],
)

mdc_objc_library(
    name = "privateHeaders",
    testonly = 1,
    hdrs = glob(["src/*.h"]),
    visibility = ["//visibility:private"],
    deps = [":Chips"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":Chips",
        ":Theming",
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

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    extra_srcs = glob([
        "tests/unit/Theming/*.swift",
    ]),
    deps = [
        ":Chips",
        ":Theming",
        "//components/schemes/Color",
        "//components/schemes/Shape",
        "//components/schemes/Typography",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    deps = [
        ":Chips",
        ":privateHeaders",
        "//components/ShapeLibrary",
        "//components/TextFields:private",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
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
