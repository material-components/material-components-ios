# Copyright 2017-present The Material Components for iOS Authors. All
# Rights Reserved.
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
    name = "Buttons",
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
    ],
    deps = [
        "//components/Elevation",
        "//components/Ink",
        "//components/Ripple",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/ShapeLibrary",
        "//components/Shapes",
        "//components/Typography",
        "//components/private/Math",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":Buttons",
        ":ColorThemer",
        ":ShapeThemer",
        "//components/ShadowElevations",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":Buttons",
        "//components/schemes/Color",
    ],
)

mdc_extension_objc_library(
    name = "TitleColorAccessibilityMutator",
    deps = [
        ":Buttons",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

mdc_extension_objc_library(
    name = "ShapeThemer",
    deps = [
        ":Buttons",
        "//components/schemes/Shape",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":Buttons",
        "//components/schemes/Typography",
    ],
)

mdc_extension_objc_library(
    name = "ButtonThemer",
    deps = [
        ":Buttons",
        ":ColorThemer",
        ":ShapeThemer",
        ":TypographyThemer",
    ],
)

mdc_objc_library(
    name = "private",
    testonly = 1,
    hdrs = native.glob(["src/private/*.h"]),
    visibility = [":test_targets"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":Buttons",
        ":Theming",
        "//components/ShapeLibrary",
        "//components/Shapes",
        "//components/Typography",
        "//components/private/Math",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Shape",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":Buttons",
        ":Theming",
        "//components/Typography",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Shape",
        "//components/schemes/Typography",
    ],
)

package_group(
    name = "test_targets",
    packages = [
        "//components/Buttons/...",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/supplemental/*.m",
        "tests/unit/supplemental/*.h",
    ]),
    xibs = native.glob(["tests/unit/resources/*.xib"]),
    deps = [
        ":ButtonThemer",
        ":Buttons",
        ":ColorThemer",
        ":ShapeThemer",
        ":TitleColorAccessibilityMutator",
        ":TypographyThemer",
        ":private",
        "//components/Palettes",
        "//components/Typography",
    ],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    extra_srcs = native.glob([
        "tests/unit/Theming/*.swift",
    ]),
    deps = [
        ":Buttons",
        ":ColorThemer",
        ":Theming",
        ":TypographyThemer",
        ":private",
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
    deps = [
        ":Buttons",
        ":Theming",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
