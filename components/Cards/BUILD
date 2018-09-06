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

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite")
load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Cards",
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/Ink",
        "//components/ShadowLayer",
        "//components/private/Math",
        "//components/private/Icons/icons/ic_check_circle",
        "//components/private/ShapeLibrary",
        "//components/private/Shapes",
    ],
)

mdc_objc_library(
    name = "CardThemer",
    srcs = native.glob(["src/CardThemer/*.m"]),
    hdrs = native.glob(["src/CardThemer/*.h"]),
    includes = ["src/CardThemer"],
    deps = [
        ":Cards",
        ":ColorThemer",
        ":ShapeThemer",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "ColorThemer",
    srcs = native.glob(["src/ColorThemer/*.m"]),
    hdrs = native.glob(["src/ColorThemer/*.h"]),
    includes = ["src/ColorThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    deps = [
        ":Cards",
        "//components/schemes/Color",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "ShapeThemer",
    srcs = native.glob(["src/ShapeThemer/*.m"]),
    hdrs = native.glob(["src/ShapeThemer/*.h"]),
    includes = ["src/ShapeThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    deps = [
        ":Cards",
        "//components/schemes/Shape",
    ],
    visibility = ["//visibility:public"],
)

swift_library(
    name = "unit_test_swift_sources",
    srcs = glob(["tests/unit/*.swift"]),
    deps = [
        ":Cards",
        ":ColorThemer",
    ],
    visibility = ["//visibility:private"],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = native.glob([
        "tests/unit/*.m",
        "tests/unit/*.h",
    ]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [
        ":Cards",
        "//components/private/Icons/icons/ic_info",
    ],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
    deps = [
      ":unit_test_sources",
      ":unit_test_swift_sources"
    ],
)

