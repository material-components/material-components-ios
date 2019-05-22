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

load("//:material_components_ios.bzl", "mdc_public_objc_library")

licenses(["notice"])  # Apache 2.0

mdc_public_objc_library(
    name = "ic_chevron_right",
    bundles = [":Bundle"],
    sdk_frameworks = ["UIKit"],
    deps = ["//components/private/Icons"],
)

filegroup(
    name = "BundleFiles",
    srcs = glob(["src/MaterialIcons_ic_chevron_right.bundle/**"]),
)

objc_bundle(
    name = "Bundle",
    bundle_imports = [":BundleFiles"],
)
