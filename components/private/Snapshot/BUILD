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
    "mdc_extension_objc_library",
    "mdc_objc_library",
    "mdc_swift_library",
    "mdc_public_objc_library",
)

licenses(["notice"])  # Apache 2.0

mdc_objc_library(
    name = "SnapshotSourceDummies",
    srcs = native.glob([
        "src/SourceDummies/*.h",
        "src/SourceDummies/*.m",
    ]),
)

mdc_swift_library(
    name = "SnapshotSwiftLib",
    srcs = glob(["src/*.swift"]),
    copts = [
        "-swift-version",
        "4.2",
    ],
)

mdc_extension_objc_library(
    name = "SnapshotUtilities",
    testonly = 1,
    visibility = ["//visibility:public"],
)

mdc_extension_objc_library(
    name = "SnapshotTestCase",
    testonly = 1,
    visibility = ["//visibility:private"],
    deps = [
        "@ios_snapshot_test_case//:SnapshotTestCase",
    ],
)

mdc_public_objc_library(
    name = "Snapshot",
    testonly = 1,
    deps = [
        ":SnapshotSourceDummies",
        ":SnapshotSwiftLib",
        ":SnapshotTestCase",
        ":SnapshotUtilities",
    ],
)
