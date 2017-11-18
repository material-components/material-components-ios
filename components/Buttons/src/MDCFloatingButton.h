/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

#import "MDCButton.h"

/**
 Types of Material Floating buttons.

 The mini size should only be used when required for visual continuity with other elements on the
 screen.
 */
typedef NS_ENUM(NSInteger, MDCFloatingButtonType) {
  /**
   A 56-point circular button surrounding a 24-point or 36-point square icon or short text.
   */
  MDCFloatingButtonTypeDefault = 0,
  /**
   A 40-point circular button surrounding a 24-point square icon or short text.
   */
  MDCFloatingButtonTypeMini = 1,
};

typedef NS_ENUM(NSInteger, MDCFloatingButtonMode) {
  /**
   The floating button is a circle with its contents centered.
   @c type initialization argument.
   */
  MDCFloatingButtonModeNormal = 0,

  /**
   The floating button is a "pill shape" with the image to one side of the title.
   */
  MDCFloatingButtonModeExtended = 1,
};

typedef NS_ENUM(NSInteger, MDCFloatingButtonImagePosition) {
  /**
   The image of the floating button is on the leading side of the title.
   */
  MDCFloatingButtonImagePositionLeading = 0,

  /**
   The image of the floating button is on the trailing side of the title.
   */
  MDCFloatingButtonImagePositionTrailing = 1,
};

/**
 A "floating" MDCButton.

 Floating action buttons are circular, float a considerable amount above their parent, have
 their own background color, and also raise briefly when touched. Floating action buttons should
 only be used rarely, for the main action of a screen.

 @see https://material.io/guidelines/components/buttons.html#buttons-main-buttons
 */
@interface MDCFloatingButton : MDCButton

/**
 The mode of the floating button can either be .normal (a circle) or .extended (a pill-shaped
 rounded rectangle).

 The default value is @c .normal .
 */
@property(nonatomic, assign) MDCFloatingButtonMode mode UI_APPEARANCE_SELECTOR;

/**
 The position of the image relative to the title.

 The default value is @c .leading .
 */
@property(nonatomic, assign) MDCFloatingButtonImagePosition imagePosition UI_APPEARANCE_SELECTOR;

/**
 If @c YES, any values for @c contentEdgeInsets:forType:mode: will be flipped when the FAB is
 in @c MDCFloatingButtonModeExtended and its @c imagePosition is
 @c MDCFloatingButtonImagePositionTrailing.

 The default value is NO.
 */
@property(nonatomic, assign) BOOL contentEdgeInsetsFlippedForTrailingImagePosition
    UI_APPEARANCE_SELECTOR;

/**
 The horizontal padding between the |imageView| and |titleLabel| when the button is in its
 "extended" mode.  If set to a negative value, the imageView and titleLabel may overlap.
 */
@property(nonatomic, assign) CGFloat imageTitlePadding UI_APPEARANCE_SELECTOR;

/**
 Initializes self to a button with the given @c type with a @c .normal mode.

 @param frame Button frame.
 @param type Button type.
 @return Button with type.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame
                                type:(MDCFloatingButtonType)type NS_DESIGNATED_INITIALIZER;

/**
 Initializes self to a button with the MDCFloatingButtonShapeDefault shape.

 @param frame Button frame.
 @return Button with MDCFloatingButtonShapeDefault shape.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame;

/**
 Initializes self to a button with the MDCFloatingButtonShapeDefault shape.

 @return Button with MDCFloatingButtonShapeDefault shape.
 */
- (nonnull instancetype)init;

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)setMinimumSize:(CGSize)minimumSize NS_UNAVAILABLE;

- (void)setMinimumSize:(CGSize)minimumSize
               forType:(MDCFloatingButtonType)type
                  mode:(MDCFloatingButtonMode)mode UI_APPEARANCE_SELECTOR;

- (void)setMaximumSize:(CGSize)maximumSize NS_UNAVAILABLE;

- (void)setMaximumSize:(CGSize)maximumSize
               forType:(MDCFloatingButtonType)type
                  mode:(MDCFloatingButtonMode)mode UI_APPEARANCE_SELECTOR;

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets NS_UNAVAILABLE;

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                     forType:(MDCFloatingButtonType)type
                        mode:(MDCFloatingButtonMode)mode UI_APPEARANCE_SELECTOR;

- (void)setHitAreaInsets:(UIEdgeInsets)hitAreaInsets NS_UNAVAILABLE;

- (void)setHitAreaInsets:(UIEdgeInsets)insets
                 forType:(MDCFloatingButtonType)type
                    mode:(MDCFloatingButtonMode)mode UI_APPEARANCE_SELECTOR;

#pragma mark - Deprecations

+ (nonnull instancetype)buttonWithShape:(MDCFloatingButtonType)shape
    __deprecated_msg("Use initWithFrame:type: instead.");

/**
 Returns a MDCFloatingButton with default colors and the given @c shape.

 @param shape Button shape.
 @return Button with shape.
 */
+ (nonnull instancetype)floatingButtonWithShape:(MDCFloatingButtonType)shape
    __deprecated_msg("Use initWithFrame:type: instead");

@end
