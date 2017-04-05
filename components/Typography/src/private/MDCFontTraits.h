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

/**
 Provides a means of storing defining font metrics based on size categories.

 This class is based off Apple recommendation in WWDC 2016 - 803 - Typography and Fonts @ 17:33.
 */
@interface MDCFontTraits : NSObject

/**
 The size to which the font is scaled.

 This value, in points, must be greater than 0.0.
 */
@property(nonatomic, readonly) CGFloat pointSize;

/**
 The weight of the font, specified as a font weight constant.

 For a list of possible values, see "Font Weights” in UIFontDescriptor. Avoid passing an arbitrary
 floating-point number for weight, because a font might not include a variant for every weight.
 */
@property(nonatomic, readonly) CGFloat weight;

/**
 The leading value represents additional space between lines of text and is measured in points.
 */
@property(nonatomic, readonly) CGFloat leading;

/**
 The tracking value represents additional horizontal space between glyphs and is measured in points.
 */
@property(nonatomic, readonly) CGFloat tracking;

/**
 @param style MDCFontStyle of font traits being requested.
 @param sizeCategory UIContentSizeCategory of the font traits being requested.

 @return Font traits that can be used to initialize a UIFont or UIFontDescriptor.
 */
+ (nonnull MDCFontTraits *)traitsForTextStyle:(MDCFontTextStyle)style
                                 sizeCategory:(nonnull NSString *)sizeCategory;

@end
