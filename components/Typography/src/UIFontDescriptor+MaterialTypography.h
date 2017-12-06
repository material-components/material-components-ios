/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 http://www.apache.org/licenses/LICENSE-2.0
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MDCFontTextStyle.h"

@interface UIFontDescriptor (MaterialTypography)

/**
 Returns an instance of the font descriptor associated with the Material text style and scaled
 based on the content size category.

 @param style The Material font text style for which to return a font descriptor.
 @return The font descriptor associated with the specified style.
 */
+ (nonnull UIFontDescriptor *)mdc_preferredFontDescriptorForMaterialTextStyle:
    (MDCFontTextStyle)style;

/**
 Returns an instance of the font descriptor associated with the Material text style.
 This font descriptor is *not* scaled based on the content size category (Dynamic Type).

 @param style The Material font text style for which to return a font descriptor.
 @return The font descriptor associated with the specified style.
 */
+ (nonnull UIFontDescriptor *)mdc_standardFontDescriptorForMaterialTextStyle:
    (MDCFontTextStyle)style;

@end
