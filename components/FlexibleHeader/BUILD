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
    "mdc_extension_objc_library",
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_swift_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
    "mdc_unit_test_swift_library",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "FlexibleHeader",
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/Elevation",
        "//components/ShadowElevations",
        "//components/private/Application",
        "//components/private/Math",
        "//components/private/UIMetrics",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":FlexibleHeader",
        "//components/schemes/Color",
    ],
)

mdc_objc_library(
    name = "private",
    testonly = 1,
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = [":test_targets"],
)

package_group(
    name = "test_targets",
    packages = [
        "//components/FlexibleHeader/...",
    ],
)

mdc_extension_objc_library(
    name = "CanAlwaysExpandToMaximumHeight",
    deps = [
        ":FlexibleHeader",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":CanAlwaysExpandToMaximumHeight",
        ":ColorThemer",
        ":FlexibleHeader",
        "//components/Buttons",
        "//components/PageControl",
        "//components/Palettes",
    ],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    deps = [
        ":CanAlwaysExpandToMaximumHeight",
        ":ColorThemer",
        ":FlexibleHeader",
        "//components/ShadowLayer",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/supplemental/*.m",
        "tests/unit/supplemental/*.h",
    ]),
    deps = [
        ":CanAlwaysExpandToMaximumHeight",
        ":ColorThemer",
        ":FlexibleHeader",
        ":private",
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
        ":FlexibleHeader",
        "//components/ShadowLayer",
    ],
)

mdc_snapshot_swift_library(
    name = "snapshot_test_lib_swift",
    deps = [
        ":FlexibleHeader",
        "//components/ShadowLayer",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
        ":snapshot_test_lib_swift",
    ],
)
