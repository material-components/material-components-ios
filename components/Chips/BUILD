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

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite")

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
        "//components/TextFields:private",
        "//components/Typography",
        "//components/private/Math",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_objc_library(
    name = "ChipThemer",
    srcs = native.glob(["src/ChipThemer/*.m"]),
    hdrs = native.glob(["src/ChipThemer/*.h"]),
    includes = ["src/ChipThemer"],
    deps = [
        ":Chips",
        ":ColorThemer",
        ":ShapeThemer",
        ":TypographyThemer",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "privateHeaders",
    hdrs = glob(["src/*.h"]),
    visibility = ["//visibility:private"],
    deps = [":Chips"],
)

mdc_objc_library(
    name = "FontThemer",
    srcs = native.glob(["src/FontThemer/*.m"]),
    hdrs = native.glob(["src/FontThemer/*.h"]),
    includes = ["src/FontThemer"],
    visibility = ["//visibility:public"],
    deps = [
        ":Chips",
        "//components/Themes",
    ],
)

mdc_objc_library(
    name = "ColorThemer",
    srcs = native.glob(["src/ColorThemer/*.m"]),
    hdrs = native.glob(["src/ColorThemer/*.h"]),
    includes = ["src/ColorThemer"],
    visibility = ["//visibility:public"],
    deps = [
        ":Chips",
        "//components/schemes/Color",
    ],
)

mdc_objc_library(
    name = "ShapeThemer",
    srcs = native.glob(["src/ShapeThemer/*.m"]),
    hdrs = native.glob(["src/ShapeThemer/*.h"]),
    includes = ["src/ShapeThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    deps = [
        ":Chips",
        "//components/schemes/Shape",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "TypographyThemer",
    srcs = native.glob(["src/TypographyThemer/*.m"]),
    hdrs = native.glob(["src/TypographyThemer/*.h"]),
    includes = ["src/TypographyThemer"],
    visibility = ["//visibility:public"],
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
    deps = [
        ":Chips",
        ":ChipThemer",
        ":ColorThemer",
        ":FontThemer",
        ":ShapeThemer",
        ":TypographyThemer",
        ":private",
        ":privateHeaders",
        "//components/TextFields:private",
        "//components/private/ShapeLibrary",
    ],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
    deps = [
      ":unit_test_sources",
    ],
)
