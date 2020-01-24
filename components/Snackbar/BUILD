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
    name = "Snackbar",
    bundles = [":Bundle"],
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
    ],
    deps = [
        "//components/AnimationTiming",
        "//components/Buttons",
        "//components/Elevation",
        "//components/OverlayWindow",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Typography",
        "//components/private/Application",
        "//components/private/KeyboardWatcher",
        "//components/private/Math",
        "//components/private/Overlay",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

filegroup(
    name = "BundleFiles",
    srcs = glob([
        "src/MaterialSnackbar.bundle/**",
    ]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)

mdc_extension_objc_library(
    name = "FontThemer",
    deps = [
        ":Snackbar",
        "//components/Themes",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":Snackbar",
        "//components/schemes/Typography",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":Snackbar",
        ":TypographyThemer",
        "//components/Buttons",
        "//components/Collections",
        "//components/Palettes",
        "//components/Typography",
        "//components/private/Overlay",
        "//components/schemes/Color",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":Snackbar",
        "//components/Buttons",
        "//components/Buttons:Theming",
        "//components/schemes/Container",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    deps = [
        ":Snackbar",
        ":TypographyThemer",
        ":private",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/supplemental/*.m",
        "tests/unit/supplemental/*.h",
    ]),
    deps = [
        ":FontThemer",
        ":Snackbar",
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
        ":Snackbar",
        ":private",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
    ],
)
