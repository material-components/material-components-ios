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
    "mdc_public_objc_library",
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
    "mdc_unit_test_swift_library",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "ActivityIndicator",
    bundles = [":Bundle"],
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/Palettes",
        "//components/private/Application",
        "@material_internationalization_ios//:MDFInternationalization",
        "@motion_animator_objc//:MotionAnimator",
        "@motion_interchange_objc//:MotionInterchange",
    ],
)

filegroup(
    name = "BundleFiles",
    srcs = glob([
        "src/MaterialActivityIndicator.bundle/**",
    ]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)

mdc_unit_test_swift_library(
    name = "unit_test_swift_sources",
    deps = [
        ":ActivityIndicator",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    deps = [
        ":ActivityIndicator",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":ActivityIndicator",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Collections",
        "//components/Typography",
    ],
)

mdc_examples_swift_library(
    name = "SwiftExamples",
    deps = [
        ":ActivityIndicator",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    deps = [
        ":ActivityIndicator",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [
        ":snapshot_test_lib",
    ],
)
