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
    "mdc_public_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "ShadowLayer",
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
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
        "//components/ShadowElevations",
        "//components/Slider",
        "//components/private/Math",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":ShadowLayer",
        "//components/ShadowElevations",
        "//components/ShapeLibrary",
        "//components/Shapes",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    deps = [":ShadowLayer"],
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
        ":ShadowLayer",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
    ],
)
