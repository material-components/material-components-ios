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
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "ShadowLayer",
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/ShadowElevations",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":ShadowLayer",
        "//components/AnimationTiming",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Slider",
        "//components/ShadowElevations",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":ShadowLayer",
        "//components/ShadowElevations",
        "//components/private/Shapes",
        "//components/private/ShapeLibrary",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = glob([
        "tests/unit/*.m",
        "tests/unit/*.h",
    ]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    visibility = ["//visibility:private"],
    deps = [":ShadowLayer"],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)
