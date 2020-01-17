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
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Tabs",
    bundles = [":Bundle"],
    deps = [
        "//components/AnimationTiming",
        "//components/Elevation",
        "//components/Ink",
        "//components/Palettes",
        "//components/Ripple",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Typography",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

filegroup(
    name = "BundleFiles",
    srcs = glob([
        "src/MaterialTabs.bundle/**",
    ]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":Tabs",
        "//components/schemes/Typography",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":Tabs",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_extension_objc_library(
    name = "TabBarView",
    deps = [
        "//components/AnimationTiming",
        "//components/Ripple",
        "//components/private/Math",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

filegroup(
    name = "TabsExamplesAssets",
    srcs = glob(["examples/resources/TabBarDemoAssets.xcassets/**"]),
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    data = [":TabsExamplesAssets"],
    deps = [
        ":TabBarView",
        ":Tabs",
        ":Theming",
        ":TypographyThemer",
        "//components/ActionSheet",
        "//components/ActionSheet:Theming",
        "//components/AppBar",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Collections",
        "//components/Palettes",
        "//components/Slider",
        "//components/private/Icons/icons/ic_settings",
        "//components/private/Math",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":TabBarView",
        ":Tabs",
        ":Theming",
        "//components/AppBar",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Palettes",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_objc_library(
    name = "privateTabBarView",
    hdrs = native.glob(["src/TabBarView/private/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/Theming/*.m",
        "tests/unit/TabBarView/*.m",
    ]),
    deps = [
        ":TabBarView",
        ":Tabs",
        ":Theming",
        ":TypographyThemer",
        ":private",
        ":privateTabBarView",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
        "@material_internationalization_ios//:MDFInternationalization",
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
    extra_srcs = native.glob(["tests/snapshot/*/*.m"]),
    deps = [
        ":TabBarView",
        ":Tabs",
        ":Theming",
        ":privateTabBarView",
        "//components/AppBar",
        "//components/HeaderStackView",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
