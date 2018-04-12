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
#import <CoreGraphics/CoreGraphics.h>

#import "MaterialShadowElevations.h"
#import "MaterialShapes.h"

/*
 A Material chip.

 @see https://material.io/guidelines/components/chips.html for full details.

 Chips are compact elements that represent an attribute, text, entity, or action.

 Chips contain an optional leading image, a title label and an optional trailing accessory view.
 They can also contain a leading image that appears only when the chip is selected.
 */
@interface MDCChipView : UIControl

/*
 A UIImageView that leads the title label.
 */
@property(nonatomic, readonly, nonnull) IBInspectable UIImageView *imageView;

/*
 A UIImageView that leads the title label. Appears in front of the imageView. Only visible when the
 chip is selected.

 This image view is typically used to show some icon that denotes the chip as selected, such as a
 check mark. If imageView has no image then the chip will require resizing when selected or
 deselected to account for the changing visibility of selectedImageView.
 */
@property(nonatomic, readonly, nonnull) IBInspectable UIImageView *selectedImageView;

/*
 A UIView that trails the title label.

 It will be given a size based on the value returned from sizeThatFits:.
 */
@property(nonatomic, strong, nullable) IBInspectable UIView *accessoryView;

/*
 The title label.

 @note The title color is controlled by setTitleColor:forState:.
 @note The title font is controlled by setTitleFont.
 */
@property(nonatomic, readonly, nonnull) IBInspectable UILabel *titleLabel;

/*
 Padding around the chip content. Each subview can be further padded with their invidual padding
 property.

 The chip uses this property to determine intrinsicContentSize and sizeThatFits.

 Defaults to (4, 4, 4, 4).
 */
@property(nonatomic, assign) UIEdgeInsets contentPadding UI_APPEARANCE_SELECTOR;

/*
 Padding around the image view. Only used if the image view has a non-nil image.

 The chip uses this property to determine intrinsicContentSize and sizeThatFits.

 Defaults to (0, 0, 0, 0).
 */
@property(nonatomic, assign) UIEdgeInsets imagePadding UI_APPEARANCE_SELECTOR;

/*
 Padding around the accessory view. Only used if the accessory view is non-nil.

 The chip uses this property to determine intrinsicContentSize and sizeThatFits.

 Defaults to (0, 0, 0, 0).
 */
@property(nonatomic, assign) UIEdgeInsets accessoryPadding UI_APPEARANCE_SELECTOR;

/*
 Padding around the title.

 The chip uses this property to determine intrinsicContentSize and sizeThatFits.

 Defaults to (3, 8, 4, 8). The top padding is shorter so the default height of a chip is 32 pts.
 */
@property(nonatomic, assign) UIEdgeInsets titlePadding UI_APPEARANCE_SELECTOR;

/*
 Font used to render the title.

 If nil, the chip will use the system font.
 */
@property(nonatomic, strong, nullable) UIFont *titleFont UI_APPEARANCE_SELECTOR;

/*
 The color of the ink ripple.
 */
@property(nonatomic, strong, null_resettable) UIColor *inkColor UI_APPEARANCE_SELECTOR
    __deprecated_msg("Use setInkColor:forState:");

/*
 The shape generator used to define the chip's shape.
 */
@property(nullable, nonatomic, strong) id<MDCShapeGenerating> shapeGenerator UI_APPEARANCE_SELECTOR;

/*
 Indicates whether the chip should automatically update its font when the device’s
 UIContentSizeCategory is changed.

 This property is modeled after the adjustsFontForContentSizeCategory property in the
 UIContentSizeCategoryAdjusting protocol added by Apple in iOS 10.0.

 If set to YES, this button will base its text font on MDCFontTextStyleButton.

 Default value is NO.
 */
@property(nonatomic, readwrite, setter=mdc_setAdjustsFontForContentSizeCategory:)
    BOOL mdc_adjustsFontForContentSizeCategory UI_APPEARANCE_SELECTOR;

/**
 The minimum dimensions of the Chip. A non-positive value for either height or width is equivalent
 to no minimum for that dimension.

 Defaults to a minimum height of 32 points, and no minimum width.
 */
@property(nonatomic, assign) CGSize minimumSize UI_APPEARANCE_SELECTOR;

/*
 A color used as the chip's @c backgroundColor for @c state.

 If no background color has been set for a given state, the returned value will fall back to the
 value set for UIControlStateNormal.

 @param state The control state.
 @return The background color.
 */
- (nullable UIColor *)backgroundColorForState:(UIControlState)state;

/*
 A color used as the chip's @c backgroundColor.

 Defaults to blue.

 @param backgroundColor The background color.
 @param state The control state.
 */
- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/*
 A color used as the chip's background overlay color for @c state.

 If no background overlay color has been set for a given state, the returned value will fall back to
 the value set for UIControlStateNormal.

 @param state The control state.
 @return The background overlay color.
 */
- (nullable UIColor *)backgroundOverlayColorForState:(UIControlState)state;

/*
 A color used as the chip's background overlay @c color.

 @param backgroundOverlayColor The chip background overlay color.
 @param state The control state.
 */
- (void)setBackgroundOverlayColor:(nullable UIColor *)backgroundOverlayColor
                         forState:(UIControlState)state;

/*
 Returns the border color for a particular control state.

 If no border width has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The control state.
 @return The border color for the requested state.
 */
- (nullable UIColor *)borderColorForState:(UIControlState)state;

/*
 Sets the border color for a particular control state.

 @param borderColor The border color.
 @param state The control state.
 */
- (void)setBorderColor:(nullable UIColor *)borderColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/*
 Returns the border width for a particular control state.

 If no border width has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The control state.
 @return The border width for the requested state.
 */
- (CGFloat)borderWidthForState:(UIControlState)state;

/*
 Sets the border width for a particular control state.

 @param borderWidth The border width.
 @param state The control state.
 */
- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/*
 Returns the elevation for a particular control state.

 If no elevation has been set for a given state, the returned value will fall back to the value set
 for UIControlStateNormal.

 @param state The control state.
 @return The elevation for the requested state.
 */
- (MDCShadowElevation)elevationForState:(UIControlState)state;

/*
 Sets the elevation for a particular control state.

 @param elevation The elevation.
 @param state The control state.
 */
- (void)setElevation:(MDCShadowElevation)elevation forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/*
 Returns the ink color for a particular control state.

 If no ink color has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal. Defaults to nil. When nil MDCInkView.defaultInkColor is used.

 @param state The control state.
 @return The ink color for the requested state.
 */
- (nullable UIColor *)inkColorForState:(UIControlState)state;

/*
 Sets the ink color for a particular control state.

 @param inkColor The ink color.
 @param state The control state.
 */
- (void)setInkColor:(nullable UIColor *)inkColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/*
 Returns the shadow color for a particular control state.

 If no shadow color has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The control state.
 @return The shadow color for the requested state.
 */
- (nullable UIColor *)shadowColorForState:(UIControlState)state;

/*
 Sets the shadow color for a particular control state.

 @param elevation The shadow color.
 @param state The control state.
 */
- (void)setShadowColor:(nullable UIColor *)shadowColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

/*
 Returns the title color for a particular control state.

 If no title color has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The control state.
 @return The title color for the requested state.
 */
- (nullable UIColor *)titleColorForState:(UIControlState)state;

/*
 Sets the title color for a particular control state.

 @param titleColor The title color.
 @param state The control state.
 */
- (void)setTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

@end
