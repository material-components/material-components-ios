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
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "List",
    sdk_frameworks = [
        "CoreGraphics",
        "UIKit",
    ],
    deps = [
        "//components/Ink",
        "//components/ShadowLayer",
        "//components/ShadowElevations",
        "//components/Typography",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_objc_library(
    name = "TypographyThemer",
    srcs = native.glob(["src/TypographyThemer/*.m"]),
    hdrs = native.glob(["src/TypographyThemer/*.h"]),
    includes = ["src/TypographyThemer"],
    sdk_frameworks = ["UIKit"],
    deps = [
        ":List",
        "//components/schemes/Typography",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "ColorThemer",
    srcs = native.glob(["src/ColorThemer/*.m"]),
    hdrs = native.glob(["src/ColorThemer/*.h"]),
    includes = ["src/ColorThemer"],
    sdk_frameworks = ["UIKit"],
    deps = [
        ":List",
        "//components/schemes/Color",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "ListThemer",
    srcs = native.glob(["src/ListThemer/*.m"]),
    hdrs = native.glob(["src/ListThemer/*.h"]),
    includes = ["src/ListThemer"],
    sdk_frameworks = ["UIKit"],
    deps = [
        ":List",
        ":TypographyThemer",
        ":ColorThemer",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    srcs = native.glob([
        "tests/unit/*.m",
    ]),
    sdk_frameworks = [
        "UIKit",
        "XCTest",
    ],
    deps = [
         ":List",
         ":ListThemer",
         ":ColorThemer",
         ":TypographyThemer",
    ],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
    deps = [
        ":unit_test_sources",
    ]
)
