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
    "mdc_objc_library",
    "mdc_public_objc_library",
    "mdc_unit_test_suite",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Ripple",
    sdk_frameworks = [
        "CoreGraphics",
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/private/Math",
    ],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
    visibility = ["//visibility:private"],
    deps = [":Ripple"],
)

mdc_objc_library(
    name = "ObjcExamples",
    srcs = glob([
        "examples/*.h",
        "examples/*.m",
        "examples/supplemental/*.h",
        "examples/supplemental/*.m",
    ]),
    visibility = ["//visibility:private"],
    deps = [
        ":Ripple",
    ],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = glob(["tests/unit/*.m"]),
    hdrs = glob(["tests/unit/*.h"]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":ColorThemer",
        ":Ripple",
        ":private",
    ],
)

mdc_unit_test_suite(
    deps = [
        ":unit_test_sources",
    ],
)
