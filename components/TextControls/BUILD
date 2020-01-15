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
)

licenses(["notice"])

mdc_extension_objc_library(
    name = "Shared",
)

mdc_extension_objc_library(
    name = "BaseTextFields",
    deps = [
        "//components/private/TextControlsPrivate:Shared",
        "//components/private/TextControlsPrivate:BaseStyle",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_objc_library(
    name = "BaseTextFieldsPrivate",
    hdrs = native.glob(["src/BaseTextFields/private/*.h"]),
    includes = ["src/BaseTextFields/private"],
    visibility = [":test_targets"],
)

mdc_extension_objc_library(
    name = "FilledTextFields",
    deps = [
        ":BaseTextFields",
        "//components/private/TextControlsPrivate:FilledStyle",
    ],
)

mdc_extension_objc_library(
    name = "FilledTextFieldsTheming",
    deps = [
        ":FilledTextFields",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "OutlinedTextFields",
    deps = [
        ":BaseTextFields",
        "//components/private/TextControlsPrivate:OutlinedStyle",
    ],
)

mdc_extension_objc_library(
    name = "OutlinedTextFieldsTheming",
    deps = [
        ":OutlinedTextFields",
        "//components/schemes/Container",
    ],
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
        "//components/TextControls/...",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":BaseTextFields",
        ":FilledTextFields",
        ":FilledTextFieldsTheming",
        ":OutlinedTextFields",
        ":OutlinedTextFieldsTheming",
        "//components/Buttons",
        "//components/Buttons:Theming",
        "//components/schemes/Container",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":BaseTextFields",
        ":FilledTextFields",
        ":FilledTextFieldsTheming",
        ":OutlinedTextFields",
        ":OutlinedTextFieldsTheming",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/*/*.m",
    ]),
    deps = [
        ":BaseTextFields",
        ":FilledTextFields",
        ":FilledTextFieldsTheming",
        ":OutlinedTextFields",
        ":OutlinedTextFieldsTheming",
        ":BaseTextFieldsPrivate",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        ":Shared",
        ":BaseTextFields",
        ":FilledTextFields",
        ":FilledTextFieldsTheming",
        ":OutlinedTextFields",
        ":OutlinedTextFieldsTheming",
        "//components/private/TextControlsPrivate:Shared",
        "//components/private/TextControlsPrivate:OutlinedStyle",
        "//components/private/TextControlsPrivate:FilledStyle",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    timeout = "long",
    deps = ["snapshot_test_lib"],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)
