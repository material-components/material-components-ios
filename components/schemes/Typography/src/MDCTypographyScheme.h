// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

/**
 A simple typography scheme that provides semantic fonts. There are no optional
 properties, all fonts must be provided, supporting more reliable typography theming.
 */
@protocol MDCTypographyScheming

/**
 The headline 1 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline1;

/**
 The headline 2 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline2;

/**
 The headline 3 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline3;

/**
 The headline 4 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline4;

/**
 The headline 5 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline5;

/**
 The headline 6 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *headline6;

/**
 The subtitle 1 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *subtitle1;

/**
 The subtitle 2 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *subtitle2;

/**
 The body 1 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *body1;

/**
 Return the body 2 font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *body2;

/**
 Return the caption font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *caption;

/**
 Return the button font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *button;

/**
 Return the overline font.
 */
@property(nonatomic, nonnull, readonly, copy) UIFont *overline;

/**
 Whether user interface elements should automatically resize based on the device's setting.

 This can be used by client to communicate whether they support dynamic type to both our theming
 functionality and embedded frameworks that also render UI.
*/
@property(nonatomic, readonly) BOOL mdc_adjustsFontForContentSizeCategory;

@end

/**
 An enum of default typography schemes that are supported.
 */
typedef NS_ENUM(NSInteger, MDCTypographySchemeDefaults) {
  /**
   The Material defaults, circa April 2018.
   */
  MDCTypographySchemeDefaultsMaterial201804,

  /**
   The Material defaults, circa February 2019.

   This scheme implements fonts with the similar metrics as
   MDCTypographySchemeDefaultsMaterial201804 with the addition that vended fonts will have
   appropriate scalingCurves attached.
   */
  MDCTypographySchemeDefaultsMaterial201902,
};

/**
 A simple implementation of @c MDCTypographyScheming that provides Material default fonts
 from which basic customizations can be made.
 */
@interface MDCTypographyScheme : NSObject <MDCTypographyScheming, NSCopying>

// Redeclare protocol properties as readwrite
@property(nonatomic, nonnull, readwrite, copy) UIFont *headline1;
@property(nonatomic, nonnull, readwrite, copy) UIFont *headline2;
@property(nonatomic, nonnull, readwrite, copy) UIFont *headline3;
@property(nonatomic, nonnull, readwrite, copy) UIFont *headline4;
@property(nonatomic, nonnull, readwrite, copy) UIFont *headline5;
@property(nonatomic, nonnull, readwrite, copy) UIFont *headline6;
@property(nonatomic, nonnull, readwrite, copy) UIFont *subtitle1;
@property(nonatomic, nonnull, readwrite, copy) UIFont *subtitle2;
@property(nonatomic, nonnull, readwrite, copy) UIFont *body1;
@property(nonatomic, nonnull, readwrite, copy) UIFont *body2;
@property(nonatomic, nonnull, readwrite, copy) UIFont *caption;
@property(nonatomic, nonnull, readwrite, copy) UIFont *button;
@property(nonatomic, nonnull, readwrite, copy) UIFont *overline;
@property(nonatomic, readwrite) BOOL mdc_adjustsFontForContentSizeCategory;

/**
 Initializes the typography scheme with the latest material defaults.
 */
- (nonnull instancetype)init;

/**
 Initializes the typography scheme with the values associated with the given defaults.
 */
- (nonnull instancetype)initWithDefaults:(MDCTypographySchemeDefaults)defaults;

@end
