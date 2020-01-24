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
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")

licenses(["notice"])  # Apache 2.0

mdc_objc_library(
    name = "BottomNavigation",
    srcs =
        native.glob(
            [
                "src/*.m",
                "src/private/*.h",
                "src/private/*.m",
            ],
            exclude = [
                "src/MDCBottomNavigationBarController.m",
                "src/MDCBottomNavigationBarController.h",
                "src/MaterialBottomNavigationBeta.h",
            ],
        ),
    hdrs =
        native.glob(
            ["src/*.h"],
            exclude = [
                "src/MDCBottomNavigationBarController.h",
                "src/MaterialBottomNavigationBeta.h",
            ],
        ),
    bundles = [":Bundle"],
    enable_modules = 1,
    includes = ["src"],
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//components/Elevation",
        "//components/Ink",
        "//components/Palettes",
        "//components/Ripple",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Typography",
        "//components/private/Math",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

# Should only be used by test targets or :BottomNavigationBeta until
# that can be rolled-up into the main target.
mdc_objc_library(
    name = "privateHeaders",
    hdrs = native.glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_objc_library(
    name = "BottomNavigationBeta",
    srcs = ["src/MDCBottomNavigationBarController.m"],
    hdrs = [
        "src/MDCBottomNavigationBarController.h",
        "src/MaterialBottomNavigationBeta.h",
    ],
    enable_modules = 1,
    includes = ["src"],
    sdk_frameworks = ["CoreGraphics"],
    visibility = ["//:__subpackages__"],
    deps = [
        ":BottomNavigation",
        ":privateHeaders",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":BottomNavigation",
        "//components/ShadowElevations",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

filegroup(
    name = "BundleFiles",
    srcs = glob([
        "src/MaterialBottomNavigation.bundle/**",
    ]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    includes = ["examples/supplemental"],
    deps = [
        ":BottomNavigation",
        ":Theming",
        "//components/Palettes",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":BottomNavigation",
        ":BottomNavigationBeta",
        ":ObjcExamples",
        ":Theming",
        "//components/AppBar",
        "//components/Buttons",
        "//components/Palettes",
        "//components/schemes/Container",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = native.glob(
        [
            "tests/unit/*.m",
            "tests/unit/*.h",
            "tests/unit/Theming/*.m",
        ],
        exclude =  [
            "tests/unit/MDCBottomNavigationBarControllerTests.m",
            "tests/unit/MDCBottomNavigationBarControllerDelegateTests.m",
        ],
    ),
    sdk_frameworks = [
        "CoreGraphics",
        "XCTest",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":BottomNavigation",
        ":Theming",
        ":privateHeaders",
        "//components/Typography",
    ],
)

mdc_objc_library(
    name = "unit_test_beta_sources",
    testonly = 1,
    srcs = [
        "tests/unit/MDCBottomNavigationBarControllerTests.m",
        "tests/unit/MDCBottomNavigationBarControllerDelegateTests.m",
    ],
    sdk_frameworks = [
        "CoreGraphics",
        "XCTest",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":BottomNavigationBeta",
    ],
)

ios_unit_test(
    name = "unit_tests_beta",
    flaky = 1,
    minimum_os_version = "9.0",
    test_host = "//components/private/Snapshot/TestHost",
    deps = [":unit_test_beta_sources"],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    deps = [
        ":BottomNavigation",
        ":BottomNavigationBeta",
        ":Theming",
        ":privateHeaders",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
