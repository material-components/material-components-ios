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

load("//:material_components_ios.bzl",
     "mdc_public_objc_library",
     "mdc_objc_library",
     "mdc_unit_test_suite")
load("@build_bazel_rules_apple//apple:swift.bzl", "swift_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Dialogs",
    bundles = [":Bundle"],
    sdk_frameworks = [
        "QuartzCore",
        "UIKit",
    ],
    deps = [
        "//components/Buttons",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Typography",
        "//components/private/KeyboardWatcher",
        "@material_internationalization_ios//:MDFInternationalization",
        "@motion_animator_objc//:MotionAnimator",
        "@motion_transitioning_objc//:MotionTransitioning",
    ],
)

filegroup(
    name = "BundleFiles",
    srcs = glob([
        "src/MaterialDialogs.bundle/**",
    ]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)

mdc_objc_library(
    name = "DialogThemer",
    srcs = native.glob(["src/DialogThemer/*.m"]),
    hdrs = native.glob(["src/DialogThemer/*.h"]),
    includes = ["src/DialogThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    deps = [
        ":Dialogs",
        "//components/Themes",
        "//components/Buttons:ButtonThemer",
        ":ColorThemer",
        ":TypographyThemer",
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
        ":Dialogs",
        "//components/Themes",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "TypographyThemer",
    srcs = native.glob(["src/TypographyThemer/*.m"]),
    hdrs = native.glob(["src/TypographyThemer/*.h"]),
    includes = ["src/TypographyThemer"],
    sdk_frameworks = [
        "UIKit",
    ],
    deps = [
        ":Dialogs",
        "//components/schemes/Typography",
    ],
    visibility = ["//visibility:public"],
)

mdc_objc_library(
    name = "private",
    hdrs = native.glob(["src/private/*.h"]),
    includes = ["src/private"],
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
        ":Dialogs",
        ":DialogThemer",
        ":ColorThemer",
        ":TypographyThemer",
        ":private",
    ],
    visibility = ["//visibility:private"],
)

mdc_unit_test_suite(
    deps = [
      ":unit_test_sources",
    ],
)
