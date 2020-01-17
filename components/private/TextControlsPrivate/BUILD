# Copyright 2020-present The Material Components for iOS Authors. All Rights Reserved.
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
)

licenses(["notice"])  # Apache 2.0

package_group(
    name = "TextControlsPrivatePackageGroup",
    packages = [
        "//components/private/TextControlsPrivate/...",
    ],
)

mdc_extension_objc_library(
    name = "Shared",
    sdk_frameworks = [
        "QuartzCore",
    ],
    visibility = [
        "//components/TextControls:TextControlsPackageGroup",
    ],
    deps = [
        "//components/AnimationTiming",
        "//components/TextControls:Enums",
        "//components/private/Math",
        "@material_internationalization_ios//:MDFInternationalization",
    ],
)

mdc_extension_objc_library(
    name = "BaseStyle",
    sdk_frameworks = [
        "QuartzCore",
    ],
    visibility = [
        "//components/TextControls:TextControlsPackageGroup",
    ],
    deps = [
        ":Shared",
        "//components/AnimationTiming",
        "//components/private/Math",
    ],
)

mdc_extension_objc_library(
    name = "FilledStyle",
    sdk_frameworks = [
        "QuartzCore",
    ],
    visibility = [
        "//components/TextControls:TextControlsPackageGroup",
    ],
    deps = [
        ":Shared",
        "//components/AnimationTiming",
        "//components/private/Math",
    ],
)

mdc_extension_objc_library(
    name = "OutlinedStyle",
    sdk_frameworks = [
        "QuartzCore",
    ],
    visibility = [
        "//components/TextControls:TextControlsPackageGroup",
    ],
    deps = [
        ":Shared",
        "//components/AnimationTiming",
        "//components/private/Math",
    ],
)
