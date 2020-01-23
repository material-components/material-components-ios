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
    name = "ActionSheet",
    sdk_frameworks = ["UIKit"],
    deps = [
        "//components/BottomSheet",
        "//components/Elevation",
        "//components/Ink",
        "//components/Ripple",
        "//components/ShadowElevations",
        "//components/Typography",
        "//components/private/Math",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":ActionSheet",
        "//components/Elevation",
        "//components/ShadowElevations",
        "//components/private/Color",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "ActionSheetThemer",
    deps = [
        ":ActionSheet",
        ":ColorThemer",
        ":TypographyThemer",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":ActionSheet",
        "//components/schemes/Typography",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":ActionSheet",
        "//components/schemes/Color",
    ],
)

mdc_objc_library(
    name = "privateHeaders",
    testonly = 1,
    hdrs = native.glob(["src/private/*.h"]),
    deps = [":ActionSheet"],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":ActionSheet",
        ":Theming",
        "//components/Buttons",
        "//components/Buttons:Theming",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":ActionSheet",
        ":Theming",
        "//components/AppBar",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    extra_srcs = glob(["tests/unit/ColorThemer/*.swift"]),
    deps = [
        ":ActionSheet",
        ":ColorThemer",
        ":privateHeaders",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    hdrs = glob(["tests/unit/*.h"]),
    extra_srcs = glob([
        "tests/unit/ActionSheetThemer/*.m",
        "tests/unit/Theming/*.m",
    ]),
    sdk_frameworks = [
        "CoreImage",
    ],
    deps = [
        ":ActionSheet",
        ":ActionSheetThemer",
        ":ColorThemer",
        ":Theming",
        ":TypographyThemer",
        ":privateHeaders",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    # TODO (https://github.com/material-components/material-components-ios/issues/8249): Re-enable autobot environment.
    use_autobot_environment_runner = False,
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    deps = [
        ":ActionSheet",
        ":privateHeaders",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
    ],
)
