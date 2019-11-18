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
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
)
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])

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

mdc_public_objc_library(
    name = "TextControls",
    sdk_frameworks = [
        "QuartzCore",
    ],
    deps = [
        "//components/AnimationTiming",
        "@material_internationalization_ios//:MDFInternationalization",
        "//components/private/Math",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":TextControls",
        "//components/schemes/Container",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":TextControls",
        ":Theming",
        "//components/Buttons",
        "//components/schemes/Container",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/Theming/*.m",
    ]),
    deps = [
        ":TextControls",
        ":Theming",
        ":private",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        ":Theming",
        ":TextControls",
        ":private",
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
