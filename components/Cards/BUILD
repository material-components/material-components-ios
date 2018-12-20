# Copyright 2018-present The Material Components for iOS Authors. All Rights Reserved.
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
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Cards",
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/Ink",
        "//components/ShadowLayer",
        "//components/private/Icons/icons/ic_check_circle",
        "//components/private/Math",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
    ],
)

mdc_objc_library(
    name = "Theming",
    srcs = native.glob(["src/Theming/*.m"]),
    hdrs = native.glob(["src/Theming/*.h"]),
    includes = ["src/Theming"],
    visibility = ["//visibility:public"],
    deps = [
        ":Cards",
        ":ColorThemer",
        ":ShapeThemer",
        "//components/schemes/Container",
    ],
)

mdc_objc_library(
    name = "CardThemer",
    srcs = native.glob(["src/CardThemer/*.m"]),
    hdrs = native.glob(["src/CardThemer/*.h"]),
    includes = ["src/CardThemer"],
    visibility = ["//visibility:public"],
    deps = [
        ":Cards",
        ":ColorThemer",
        ":ShapeThemer",
    ],
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
        ":Cards",
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
    visibility = ["//visibility:public"],
    deps = [
        ":Cards",
        "//components/schemes/Shape",
    ],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = glob(["tests/unit/*.swift"]),
    copts = [
        "-swift-version",
        "3",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":Cards",
        ":ColorThemer",
        ":ShapeThemer",
        ":Theming",
    ],
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
        ":Cards",
        "//components/private/Icons/icons/ic_info",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)
