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
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "//:material_components_ios.bzl",
    "mdc_examples_objc_library",
    "mdc_examples_swift_library",
    "mdc_extension_objc_library",
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "BottomSheet",
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/private/KeyboardWatcher",
        "//components/private/Math",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
    ],
)

mdc_objc_library(
    name = "privateHeaders",
    hdrs = glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
    deps = [":BottomSheet"],
)

mdc_extension_objc_library(
    name = "ShapeThemer",
    deps = [
        ":BottomSheet",
        "//components/schemes/Shape",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = glob(["tests/unit/*.m"]),
    hdrs = glob(["tests/unit/*.h"]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":BottomSheet",
        ":privateHeaders",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":BottomSheet",
        ":Theming",
        ":ShapeThemer",
        "//components/Buttons",
        "//components/AppBar",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/private/Application",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
        "//components/schemes/Color",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":BottomSheet",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
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
        ":BottomSheet",
        ":ShapeThemer",
    ],
)
