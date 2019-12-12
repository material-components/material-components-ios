# Copyright 2018-present The Material Components for iOS Authors. All
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

load(
    "//:material_components_ios.bzl",
    "mdc_examples_objc_library",
    "mdc_public_objc_library",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Shape",
    deps = [
        "//components/ShapeLibrary",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        "//components/AppBar",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/BottomSheet",
        "//components/BottomSheet:ShapeThemer",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Buttons:ShapeThemer",
        "//components/Buttons:Theming",
        "//components/Cards",
        "//components/Cards:ShapeThemer",
        "//components/Cards:Theming",
        "//components/Chips",
        "//components/Chips:Theming",
        "//components/ShapeLibrary",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Shape",
        "//components/schemes/Typography",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        ":Shape",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)
