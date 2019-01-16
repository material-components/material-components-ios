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
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("//:material_components_ios.bzl", "mdc_objc_library")

licenses(["notice"])  # Apache 2.0

mdc_objc_library(
    name = "test_host_lib",
    srcs = native.glob([
        "src/*.m",
    ]),
    hdrs = native.glob([
        "src/*.h",
    ]),
    enable_modules = 1,
)

ios_application(
    name = "TestHost",
    testonly = 1,
    bundle_id = "io.material.ios.snapshot",
    families = ["iphone"],
    infoplists = ["TestHost-Info.plist"],
    minimum_os_version = "10.0.0",
    visibility = ["//components:__subpackages__"],
    deps = [":test_host_lib"],
)
