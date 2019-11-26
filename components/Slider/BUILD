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
    "mdc_extension_objc_library",
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Slider",
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        "//components/Elevation",
        "//components/Palettes",
        "//components/private/Math",
        "//components/private/ThumbTrack",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":Slider",
        "//components/schemes/Color",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":ColorThemer",
        ":Slider",
        "//components/Collections",
        "//components/Palettes",
        "//components/private/Math",
        "//components/schemes/Color",
        "//components/schemes/Typography",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    deps = [
        ":ColorThemer",
        ":Slider",
        ":private",
        "//components/private/ThumbTrack",
    ],
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
        ":Slider",
        ":private",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
    ],
)
