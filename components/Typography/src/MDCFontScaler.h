// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

// Material's text styles, which are similar, but not quite equivalent to Apple's UIFontTextStyle.
typedef NSString *_Nonnull MDCTextStyle NS_TYPED_EXTENSIBLE_ENUM;

extern MDCTextStyle MDCTextStyleHeadline1;
extern MDCTextStyle MDCTextStyleHeadline2;
extern MDCTextStyle MDCTextStyleHeadline3;
extern MDCTextStyle MDCTextStyleHeadline4;
extern MDCTextStyle MDCTextStyleHeadline5;
extern MDCTextStyle MDCTextStyleHeadline6;
extern MDCTextStyle MDCTextStyleSubtitle1;
extern MDCTextStyle MDCTextStyleSubtitle2;
extern MDCTextStyle MDCTextStyleBody1;
extern MDCTextStyle MDCTextStyleBody2;
extern MDCTextStyle MDCTextStyleButton;
extern MDCTextStyle MDCTextStyleCaption;
extern MDCTextStyle MDCTextStyleOverline;

/**
 MDCFontScaler attaches a scaling curve to a UIFont via an associated object on that font instance.

 Instances of fonts processed through MDCFontScaler will have an associated dictionary that maps
 UIFontTextStyle to Font Size.  Category methods on UIFont allow clients to get instances of
 resized fonts based on this associated dictionary.  Note that an instance of MDCFontScaler is
 NOT attached to the processed font.

 This interface is similar to UIFontMetrics, but the fonts returned from MDCFontScaler do *not*
 automatically adjust when the device's text size / content size category is changed.
 */
@interface MDCFontScaler : NSObject

/**
 Initializes a font scaler object with the specified text style.

 @param textStyle The style that will be used to determine the scaling curver associated with the
   returned font.  For example, MaterialTextStyleBody1.
 @return An initialized font scaler object.
 */
- (nonnull instancetype)initForMaterialTextStyle:(MDCTextStyle)textStyle;

/**
 Creates and returns a font scaler object with the specified text style.

 @param textStyle The style that will be used to determine the scaling curver associated with the
 returned font.  For example, MaterialTextStyleBody1.
 @return An initialized font scaler object.
 */
+ (nonnull instancetype)scalerForMaterialTextStyle:(MDCTextStyle)textStyle;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Returns an instance of the specified font with an associated scaling curve.

 @param font The base font to use when applying the scaling curve.
 @return An instance of the specified font with an associated scaling curve, and scaled to the
   current Dynamic Type setting.
 */
- (nonnull UIFont *)scalableFontWithFont:(nonnull UIFont *)font;

@end
