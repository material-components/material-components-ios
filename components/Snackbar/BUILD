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
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Snackbar",
    bundles = [":Bundle"],
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/AnimationTiming",
        "//components/Buttons",
        "//components/OverlayWindow",
        "//components/Typography",
        "//components/private/Application",
        "//components/private/KeyboardWatcher",
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

mdc_objc_library(
    name = "ColorThemer",
    srcs = native.glob(["src/ColorThemer/*.m"]),
    hdrs = native.glob(["src/ColorThemer/*.h"]),
    includes = ["src/ColorThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Snackbar",
        "//components/schemes/Color",
    ],
)

mdc_objc_library(
    name = "FontThemer",
    srcs = native.glob(["src/FontThemer/*.m"]),
    hdrs = native.glob(["src/FontThemer/*.h"]),
    includes = ["src/FontThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":Snackbar",
        "//components/Themes",
    ],
)

mdc_objc_library(
    name = "TypographyThemer",
    srcs = native.glob(["src/TypographyThemer/*.m"]),
    hdrs = native.glob(["src/TypographyThemer/*.h"]),
    includes = ["src/TypographyThemer"],
    visibility = ["//visibility:public"],
    deps = [
        ":Snackbar",
        "//components/schemes/Typography",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = ["//visibility:private"],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = glob(["tests/unit/*.swift"]),
    visibility = ["//visibility:private"],
    deps = [
        ":ColorThemer",
        ":Snackbar",
        ":TypographyThemer",
        ":private",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = native.glob([
        "tests/unit/*.m",
        "tests/unit/*.h",
        "tests/unit/supplemental/*.m",
        "tests/unit/supplemental/*.h",
    ]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":ColorThemer",
        ":FontThemer",
        ":Snackbar",
        ":private",
    ],
)

mdc_unit_test_suite(
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)
