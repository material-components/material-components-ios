# Copyright 2019-present The Material Components for iOS Authors. All
# Rights Reserved.
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
    "mdc_public_objc_library",
    "mdc_unit_test_objc_library",
    "mdc_unit_test_suite",
)

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "Elevation",
    sdk_frameworks = [
        "CoreGraphics",
    ],
    deps = [
        "//components/private/Color",
        "//components/private/Math",
    ],
)

mdc_unit_test_objc_library(
    name = "unit_test_sources",
    testonly = 1,
    sdk_frameworks = [
        "UIKit",
        "CoreGraphics",
    ],
    visibility = ["//visibility:private"],
    deps = [
        ":Elevation",
        "//components/private/Color",
    ],
)

mdc_unit_test_suite(
    name = "unit_tests",
    deps = [
        ":unit_test_sources",
    ],
)
