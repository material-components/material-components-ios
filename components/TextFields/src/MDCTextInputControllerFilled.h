// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MDCTextInputControllerBase.h"

API_DEPRECATED_BEGIN(
    "🕘 Schedule time to migrate. "
    "Use branded UITextField or UITextView instead: go/material-ios-text-fields/gm2-migration. "
    "This is go/material-ios-migrations#not-scriptable 🕘",
    ios(12, 12))

/**
 Material Design compliant filled background text field from 2017.

 NOTE: All 'automagic' logic is inherited from MDCTextInputControllerBase.

 The background is filled, the corners are rounded, there's no border, there is an underline, and
 the placeholder is centered vertically in the filled area.

 Defaults:

 Active Color - Blue A700

 Border Fill Color - Black, 6% opacity
 Border Stroke Color - Clear

 Disabled Color = [UIColor lightGrayColor]

 Error Color - Red A400

 Floating Placeholder Color Active - Blue A700
 Floating Placeholder Color Normal - Black, 54% opacity

 Inline Placeholder Color - Black, 54% opacity

 Leading Underline Label Text Color - Black, 54% opacity

 Normal Color - Black, 54% opacity

 Rounded Corners - All

 Trailing Underline Label Text Color - Black, 54% opacity

 Underline Height Active - 2p
 Underline Height Normal - 1p

 Underline View Mode - While editing

 Note: The [Design guidance](https://material.io/components/text-fields/#anatomy) changed and treats
 placeholder as distinct from `label text`. The placeholder-related properties of this class most
 closely align with the "label text" as described in the guidance.
 */
@interface MDCTextInputControllerFilled : MDCTextInputControllerBase

@end

API_DEPRECATED_END
