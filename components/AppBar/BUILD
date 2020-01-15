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
    name = "AppBar",
    bundles = [":Bundle"],
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/FlexibleHeader",
        "//components/HeaderStackView",
        "//components/NavigationBar",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Typography",
        "//components/private/Application",
        "//components/private/Icons/icons/ic_arrow_back",
        "//components/private/UIMetrics",
        "@material_internationalization_ios//:MDFInternationalization",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

filegroup(
    name = "BundleFiles",
    srcs = glob([
        "src/MaterialAppBar.bundle/**",
    ]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":AppBar",
        "//components/FlexibleHeader:ColorThemer",
        "//components/NavigationBar:ColorThemer",
        "//components/Themes",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":AppBar",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":AppBar",
        "//components/NavigationBar:TypographyThemer",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = ["//visibility:private"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":AppBar",
        ":ColorThemer",
        ":Theming",
        ":TypographyThemer",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Buttons:Theming",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":AppBar",
        ":Theming",
        "//components/FlexibleHeader:CanAlwaysExpandToMaximumHeight",
        "//components/Tabs",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/Theming/*.m",
    ]),
    deps = [
        ":AppBar",
        ":Theming",
    ],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    deps = [
        ":AppBar",
        ":ColorThemer",
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
    extra_srcs = native.glob(["tests/snapshot/Theming/*.m"]),
    deps = [
        ":AppBar",
        ":Theming",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
    ],
)
