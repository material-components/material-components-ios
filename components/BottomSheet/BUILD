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
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
    "mdc_unit_test_swift_library",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "BottomSheet",
    sdk_frameworks = [
        "QuartzCore",
        "WebKit",
    ],
    deps = [
        "//components/Elevation",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/ShapeLibrary",
        "//components/Shapes",
        "//components/private/KeyboardWatcher",
        "//components/private/Math",
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

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":BottomSheet",
        ":ShapeThemer",
        "//components/AppBar",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/Buttons",
        "//components/ShapeLibrary",
        "//components/Shapes",
        "//components/private/Application",
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

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    deps = [
        ":BottomSheet",
        ":privateHeaders",
    ],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    deps = [
        ":BottomSheet",
        ":ShapeThemer",
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
        ":BottomSheet",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
