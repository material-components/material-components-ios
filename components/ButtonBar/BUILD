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
    name = "ButtonBar",
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/Buttons",
        "//components/private/Application",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":ButtonBar",
        "//components/Palettes",
        "//components/private/Icons/icons/ic_check_circle",
        "//components/private/Icons/icons/ic_info",
        "//components/schemes/Container",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":ButtonBar",
        "//components/schemes/Container",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    deps = [
        ":ButtonBar",
        ":private",
    ],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    deps = [
        ":ButtonBar",
        "//components/Typography",
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
        ":ButtonBar",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
