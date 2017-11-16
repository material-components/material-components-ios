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
 Shapes for Material Floating buttons.

 The mini size should only be used when required for visual continuity with other elements on the
 screen.
 */
typedef NS_ENUM(NSInteger, MDCFloatingButtonShape) {
  /**
   A 56-point circular button surrounding a 24-point square icon or short text.
   */
  MDCFloatingButtonShapeDefault = 0,
  /**
   A 40-point circular button surrounding a 24-point square icon or short text.
   */
  MDCFloatingButtonShapeMini = 1,
  /**
   A 56-point circular button surrounding a 36-point square icon or short text.
   */
  MDCFloatingButtonShapeLargeIcon = 2,
  /**
   An Extended FAB with a 24-point square icon on the leading side of the text.
   */
  MDCFloatingButtonShapeExtendedLeadingIcon = 3,
  /**
   An Extended FAB with a 24-point square icon on the trailing side of the text.
   */
  MDCFloatingButtonShapeExtendedTrailingIcon = 4
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
 The shape of this floating button.

 Changing this value will effect how the title and image are positioned.
 */
@property(nonatomic, assign) MDCFloatingButtonShape shape;

/**
 The horizontal padding between the |imageView| and |titleLabel| when the button has an "extended"
 shape (.extendedLeadingIcon and .extendedTrailingIcon).  If set to a negative value, the imageView
 and titleLabel may overlap.
 */
@property(nonatomic, assign) CGFloat imageTitlePadding UI_APPEARANCE_SELECTOR;

/**
 Returns a MDCFloatingButton with default colors and the given @c shape.

 @param shape Button shape.
 @return Button with shape.
 */
+ (nonnull instancetype)floatingButtonWithShape:(MDCFloatingButtonShape)shape;

/**
 @return The default floating button size dimension.
 */
+ (CGFloat)defaultDimension;

/**
 @return The mini floating button size dimension.
 */
+ (CGFloat)miniDimension;

/**
 Initializes self to a button with the given @c shape.

 @param frame Button frame.
 @param shape Button shape.
 @return Button with shape.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame
                                shape:(MDCFloatingButtonShape)shape NS_DESIGNATED_INITIALIZER;

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

- (void)setMinimumSize:(CGSize)minimumSize forShape:(MDCFloatingButtonShape)shape
    UI_APPEARANCE_SELECTOR;

- (void)setMaximumSize:(CGSize)maximumSize NS_UNAVAILABLE;

- (void)setMaximumSize:(CGSize)maximumSize forShape:(MDCFloatingButtonShape)shape
    UI_APPEARANCE_SELECTOR;

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets NS_UNAVAILABLE;

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets forShape:(MDCFloatingButtonShape)shape
    UI_APPEARANCE_SELECTOR;

- (void)setHitAreaInsets:(UIEdgeInsets)hitAreaInsets NS_UNAVAILABLE;

- (void)setHitAreaInsets:(UIEdgeInsets)insets forShape:(MDCFloatingButtonShape)shape
    UI_APPEARANCE_SELECTOR;

- (void)setElevation:(CGFloat)elevation forState:(UIControlState)state NS_UNAVAILABLE;

- (void)setElevation:(CGFloat)elevation
            forState:(UIControlState)state
               shape:(MDCFloatingButtonShape)shape UI_APPEARANCE_SELECTOR;

#pragma mark - Deprecations

+ (nonnull instancetype)buttonWithShape:(MDCFloatingButtonShape)shape
    __deprecated_msg("Use floatingButtonWithShape: instead.");

@end
