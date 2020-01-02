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

load("//:material_components_ios.bzl", "mdc_objc_library", "mdc_swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")

licenses(["notice"])  # Apache 2.0

IOS_MINIMUM_OS = "9.0"

ios_application(
    name = "MDCCatalog",
    app_icons = glob(["MDCCatalog/Assets.xcassets/AppIcon.appiconset/**"]),
    bundle_id = "com.google.mdc-catalog",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["MDCCatalog/Info.plist"],
    launch_storyboard = "MDCCatalog/Base.lproj/LaunchScreen.storyboard",
    minimum_os_version = IOS_MINIMUM_OS,
    deps = [
        ":MDCCatalogLib",
        ":MDCCatalogObjcLib",
    ],
)

ios_application(
    name = "MDCDragons",
    app_icons = glob(["MDCCatalog/Assets.xcassets/AppIconInverse.appiconset/**"]),
    bundle_id = "com.google.MDCDragons",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["MDCDragons/Info.plist"],
    launch_storyboard = "MDCCatalog/Base.lproj/LaunchScreen.storyboard",
    minimum_os_version = IOS_MINIMUM_OS,
    deps = [
        ":MDCDragonsLib",
    ],
)

mdc_objc_library(
    name = "MDCCatalogObjcLib",
    srcs = native.glob(["MDCCatalog/*.h"]),
    visibility = ["//visibility:private"],
)

mdc_swift_library(
    name = "MDCCatalogLib",
    srcs = native.glob(["MDCCatalog/*.swift"]),
    copts = [
        "-swift-version",
        "4.2",
    ],
    resources = ["MDCDragons/HeaderView.xib"],
    deps = [
        ":MaterialCatalog",
        "//components/AppBar",
        "//components/AppBar:ColorThemer",
        "//components/AppBar:TypographyThemer",
        "//components/BottomSheet",
        "//components/Buttons",
        "//components/Buttons:ButtonThemer",
        "//components/Buttons:Theming",
        "//components/Collections",
        "//components/Dialogs",
        "//components/FlexibleHeader",
        "//components/FlexibleHeader:ColorThemer",
        "//components/Ink",
        "//components/LibraryInfo",
        "//components/OverlayWindow",
        "//components/Palettes",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Themes",
        "//components/Typography",
        "//components/private/Icons",
        "//components/private/Icons/icons/ic_arrow_back",
        "//components/private/Icons/icons/ic_check",
        "//components/private/Icons/icons/ic_color_lens",
        "//components/private/Icons/icons/ic_help_outline",
        "//components/private/Icons/icons/ic_more_horiz",
        "//components/private/Icons/icons/ic_settings",
        "//components/schemes/Color",
        "//components/schemes/Container",
        "//components/schemes/Typography",
        "@catalog_by_convention//:CatalogByConvention",
        "@material_internationalization_ios//:MDFInternationalization",
        "@material_text_accessibility_ios//:MDFTextAccessibility",
    ],
)

mdc_objc_library(
    name = "MaterialCatalog",
    srcs = native.glob(["MaterialCatalog/*.m"]),
    hdrs = native.glob(["MaterialCatalog/*.h"]),
    module_name = "MaterialCatalog",
    deps = [
        "//components/Themes",
    ],
)

mdc_swift_library(
    name = "MDCDragonsLib",
    srcs = native.glob(["MDCDragons/*.swift"]),
    copts = [
        "-swift-version",
        "4.2",
    ],
    data = glob(["MDCCatalog/Assets.xcassets/*.imageset/**"]),
    resources = ["MDCDragons/HeaderView.xib"],
    deps = [
        "//components/AppBar",
        "//components/FlexibleHeader",
        "//components/LibraryInfo",
        "//components/ShadowElevations",
        "//components/ShadowLayer",
        "//components/Themes",
        "//components/Typography",
        "//components/private/Icons/icons/ic_arrow_back",
        "//components/private/Icons/icons/ic_chevron_right",
        "//components/private/KeyboardWatcher",
        "@catalog_by_convention//:CatalogByConvention",
    ],
)

mdc_objc_library(
    name = "MDCActionExtension",
    srcs = native.glob(["MDCActionExtension/*.m"]),
    hdrs = native.glob(["MDCActionExtension/*.h"]),
    deps = ["@catalog_by_convention//:CatalogByConvention"],
)
