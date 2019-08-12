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
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = [":test_targets"],
)

package_group(
    name = "test_targets",
    packages = [
        "//components/Chips/...",
        "//components/TextFields/...",
    ],
)

mdc_public_objc_library(
    name = "TextFields",
    sdk_frameworks = [
        "QuartzCore",
    ],
    deps = [
        "//components/AnimationTiming",
        "//components/Palettes",
        "//components/Typography",
        "//components/private/Math",
    ],
)

mdc_extension_objc_library(
    name = "ContainedInputView",
    deps = [
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_extension_objc_library(
    name = "Theming",
    deps = [
        ":ColorThemer",
        ":TextFields",
        ":TypographyThemer",
        "//components/schemes/Container",
    ],
)

mdc_extension_objc_library(
    name = "ColorThemer",
    deps = [
        ":TextFields",
        "//components/Themes",
    ],
)

mdc_extension_objc_library(
    name = "FontThemer",
    deps = [
        ":TextFields",
        "//components/Themes",
    ],
)

mdc_extension_objc_library(
    name = "TypographyThemer",
    deps = [
        ":TextFields",
        "//components/schemes/Typography",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":ColorThemer",
        ":ContainedInputView",
        ":TextFields",
        ":TypographyThemer",
        "//components/schemes/Container",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":ColorThemer",
        ":TextFields",
        ":TypographyThemer",
        "//components/AppBar",
    ],
)

mdc_objc_library(
    name = "ExperimentalExampleSource",
    srcs = glob(["examples/experimental/supplemental/*.m"]),
    hdrs = glob(["examples/experimental/supplemental/*.h"]),
    deps = [
        "//components/Buttons",
        "//components/Buttons:Theming",
        "//components/Chips",
        "//components/private/Math",
        "//components/schemes/Color",
    ],
)

swift_library(
    name = "SwiftExperimentalExamples",
    srcs = glob(["examples/experimental/*.swift"]),
    copts = [
        "-swift-version",
        "4.2",
    ],
    deps = [":ExperimentalExampleSource"],
)

mdc_objc_library(
    name = "ExperimentalExamples",
    srcs = glob(["examples/experimental/*.m"]),
    hdrs = glob(["examples/experimental/*.h"]),
    deps = [
        ":ExperimentalExampleSource",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/Buttons:ButtonThemer",
        "//components/Chips",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    extra_srcs = glob([
        "tests/unit/ContainedInputView/*.m",
    ]),
    deps = [
        ":ColorThemer",
        ":ContainedInputView",
        ":FontThemer",
        ":TextFields",
        ":TypographyThemer",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    asset_catalogs = [
        "tests/snapshot/resources/TextFieldsSnapshotTests.xcassets/ic_done.imageset",
        "tests/snapshot/resources/TextFieldsSnapshotTests.xcassets/ic_search.imageset",
    ],
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        ":ColorThemer",
        ":ContainedInputView",
        ":FontThemer",
        ":TextFields",
        ":TypographyThemer",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    # Tests have sometimes taken more than 5 minutes to launch the simulator
    # and execute
    timeout = "long",
    deps = ["snapshot_test_lib"],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    extra_srcs = glob([
        "tests/unit/Theming/*.swift",
    ]),
    deps = [
        ":ColorThemer",
        ":TextFields",
        ":Theming",
        "//components/Palettes",
        "//components/private/Math",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)
