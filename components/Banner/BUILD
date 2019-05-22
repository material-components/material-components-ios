# Copyright 2019-present The Material Components for iOS Authors. All Rights Reserved.
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
    "mdc_snapshot_objc_library",
    "mdc_snapshot_test",
)

licenses(["notice"])  # Apache 2.0

mdc_objc_library(
    name = "Banner",
    sdk_frameworks = ["UIKit"],
    visibility = [
    ],
    srcs = native.glob(["src/*.m"]),
    hdrs = native.glob(["src/*.h"]),
    includes = ["src"],
    deps = [
        "//components/Buttons",
        "//components/Typography",
    ],
)

mdc_examples_objc_library(
    name = "ObjcExamples",
    deps = [
        ":Banner",
        "//components/schemes/Color",
    ],
)

mdc_snapshot_objc_library(
    name = "snapshot_test_lib",
    deps = [
        ":Banner",
        "//components/Buttons",
    ],
)

mdc_snapshot_test(
    name = "snapshot_tests",
    deps = [":snapshot_test_lib"],
)
