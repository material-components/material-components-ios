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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialElevation.h"
#import "MaterialShadowElevations.h"
#import "MaterialShapes.h"

/*
 A Material chip.

 @see https://material.io/go/design-chips for full details.

 Chips are compact elements that represent an attribute, text, entity, or action.

 Chips contain an optional leading image, a title label and an optional trailing accessory view.
 They can also contain a leading image that appears only when the chip is selected.

 Chips currently support two contentHorizontalAlignment styles: centered
 (UIControlContentHorizontalAlignmentCenter) and default
 (any other UIControlContentHorizontalAlignment value). In the default mode, the image and text will
 be left-aligned, and the accessory view will be right aligned. In the centered mode, all three will
 appear together in the center of the chip.
 */
@interface MDCChipView : UIControl <MDCElevatable, MDCElevationOverriding>

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

/**
 Enabling the selection of the Chip on tap (when RippleBehavior is enabled).
 When rippleAllowsSelection is enabled, tapping a chip automatically toggles the chip's selected
 state (after a short ripple animation). When disabled, tapping a chip creates a momentary ripple
 animation while the chip remains unselected.

 @note: This property is ignored when RippleBehavior is disabled.

 Defaults to: Yes.
 */
@property(nonatomic) BOOL rippleAllowsSelection;

/*
 The shape generator used to define the chip's shape.
 */
@property(nullable, nonatomic, strong) id<MDCShapeGenerating> shapeGenerator UI_APPEARANCE_SELECTOR;

/**
 The corner radius for the chip.

 Use this property to configure corner radius instead of @c self.layer.cornerRadius.

 By default, it is set to keep the chip fully rounded.
 */
@property(nonatomic) CGFloat cornerRadius;

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

/**
 Custom insets to use when computing touch targets. A positive inset value will shrink the hit
 area for the Chip.
 */
@property(nonatomic, assign) UIEdgeInsets hitAreaInsets;

/**
 A Boolean value that determines whether the visible area is centered in the bounds of the view.

 If set to YES, the visible area is centered in the bounds of the view, which is often used to
 configure invisible tappable area. If set to NO, the visible area fills its bounds. This property
 doesn't affect the result of @c sizeThatFits:.

 The default value is @c NO.
*/
@property(nonatomic, assign) BOOL centerVisibleArea;

/**
 A block that is invoked when the MDCChipView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCChipView *_Nonnull chip, UITraitCollection *_Nullable previousTraitCollection);

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
- (void)setBackgroundColor:(nullable UIColor *)backgroundColor
                  forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setBorderColor:(nullable UIColor *)borderColor
              forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setElevation:(MDCShadowElevation)elevation
            forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setInkColor:(nullable UIColor *)inkColor
           forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

/*
 Returns the ripple color associated with the specified state.

 The ripple color for the specified state. If no ripple color has been set for the specific state,
 this method returns the title associated with the @c UIControlStateNormal state.

 @note Defaults to @c nil. When @c nil transparent black is used.

 @param state The state that uses the ripple color.
 @return The ripple color for the requested state.
 */
- (nullable UIColor *)rippleColorForState:(UIControlState)state;

/*
 Sets the ripple color for a particular control state.

 @param rippleColor The ripple color to use for the specified state.
 @param state The state that uses the specified ripple color.
 */
- (void)setRippleColor:(nullable UIColor *)rippleColor forState:(UIControlState)state;

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
- (void)setShadowColor:(nullable UIColor *)shadowColor
              forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

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
- (void)setTitleColor:(nullable UIColor *)titleColor
             forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

#pragma mark - Deprecated

/**
The inset or outset margins for the rectangle surrounding all of the chip’s visible area.

A positive value shrinks the visible area of the chip. A negative value expands the visible area
of the chip.
*/
@property(nonatomic, assign) UIEdgeInsets visibleAreaInsets
    __attribute__((deprecated("Consider using centerVisibleArea to adjust visible area.")));

@end

@interface MDCChipView (ToBeDeprecated)

/*
 This property determines if an @c MDCChipView should use the @c MDCRippleView behavior or not.
 By setting this property to @c YES, @c MDCStatefulRippleView is used to provide the user visual
 touch feedback, instead of the legacy @c MDCInkView.
 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 Affects the fallback behavior for when a scaled font is not provided.

 If enabled, the font size will adjust even if a scaled font has not been provided for
 a given UIFont property on this component.

 If disabled, the font size will only be adjusted if a scaled font has been provided.
 This behavior most closely matches UIKit's.

 Default value is YES, but this flag will eventually default to NO and then be deprecated
 and deleted.
 */
@property(nonatomic, assign) BOOL adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;

@end
