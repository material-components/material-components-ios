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
        "//components/TextFields",
        "//components/Typography",
        "//components/private/Math",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
        "@material_internationalization_ios//:MDFInternationalization",
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
        "//components/TextFields:private",
        "//components/private/ShapeLibrary",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)
