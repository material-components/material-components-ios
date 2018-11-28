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

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite")
load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Buttons",
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/Ink",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Typography",
        "//components/private/Math",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

mdc_objc_library(
    name = "Theming",
    srcs = native.glob(["src/Theming/*.m"]),
    hdrs = native.glob(["src/Theming/*.h"]),
    includes = ["src/Theming"],
    deps = [
        ":Buttons",
        ":ColorThemer",
        ":ShapeThemer",
        ":TypographyThemer",
        "//components/ShadowElevations",
        "//components/schemes/Container",
    ],
    visibility = ["//visibility:public"],
)


mdc_objc_library(
    name = "ColorThemer",
    srcs = native.glob(["src/ColorThemer/*.m"]),
    hdrs = native.glob(["src/ColorThemer/*.h"]),
    includes = ["src/ColorThemer"],
    deps = [
        ":Buttons",
        "//components/schemes/Color",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "TitleColorAccessibilityMutator",
    srcs = native.glob(["src/TitleColorAccessibilityMutator/*.m"]),
    hdrs = native.glob(["src/TitleColorAccessibilityMutator/*.h"]),
    includes = ["src/TitleColorAccessibilityMutator"],
    deps = [
        ":Buttons",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "ShapeThemer",
    srcs = native.glob(["src/ShapeThemer/*.m"]),
    hdrs = native.glob(["src/ShapeThemer/*.h"]),
    includes = ["src/ShapeThemer"],
    deps = [
        ":Buttons",
        "//components/schemes/Shape",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "TypographyThemer",
    srcs = native.glob(["src/TypographyThemer/*.m"]),
    hdrs = native.glob(["src/TypographyThemer/*.h"]),
    includes = ["src/TypographyThemer"],
    deps = [
        ":Buttons",
        "//components/schemes/Typography",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "ButtonThemer",
    srcs = native.glob(["src/ButtonThemer/*.m"]),
    hdrs = native.glob(["src/ButtonThemer/*.h"]),
    includes = ["src/ButtonThemer"],
    deps = [
        ":Buttons",
        ":ColorThemer",
        ":ShapeThemer",
        ":TypographyThemer",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = [":test_targets"],
)

package_group(
    name = "test_targets",
    packages = [
        "//components/Buttons/...",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = glob([
        "tests/unit/*.m",
        "tests/unit/*.h",
        "tests/unit/supplemental/*.m",
        "tests/unit/supplemental/*.h",
    ]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [
        ":Buttons",
        ":ButtonThemer",
        ":ColorThemer",
        ":private",
        ":ShapeThemer",
        ":TitleColorAccessibilityMutator",
        ":TypographyThemer",
        "//components/Palettes",
    ],
    visibility = ["//visibility:private"],
    xibs = native.glob(["tests/unit/resources/*.xib"]),
)

mdc_unit_test_suite(
    deps = [
      ":unit_test_sources",
    ],
)
