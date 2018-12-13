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
load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "BottomSheet",
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/private/KeyboardWatcher",
        "//components/private/Math",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
    ],
)

mdc_objc_library(
    name = "privateHeaders",
    hdrs = glob(["src/private/*.h"]),
    visibility = ["//visibility:private"],
    deps = [":BottomSheet"],
)

mdc_objc_library(
    name = "ShapeThemer",
    srcs = native.glob(["src/ShapeThemer/*.m"]),
    hdrs = native.glob(["src/ShapeThemer/*.h"]),
    includes = ["src/ShapeThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":BottomSheet",
        "//components/schemes/Shape",
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
        ":BottomSheet",
        ":privateHeaders",
    ],
)

mdc_unit_test_suite(
    deps = [
        ":unit_test_sources",
        ":unit_test_swift_sources",
    ],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = glob(["tests/unit/*.swift"]),
    copts = [
        "-swift-version",
        "3",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":BottomSheet",
        ":ShapeThemer",
    ],
)
