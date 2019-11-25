// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

/** The visibility of the track tick marks. */
typedef NS_ENUM(NSUInteger, MDCSliderTrackTickVisibility) {
  /** Track tick marks are never shown. */
  MDCSliderTrackTickVisibilityNever = 0,
  /** Track tick marks are only shown when the thumb is pressed or dragging. */
  MDCSliderTrackTickVisibilityWhenDragging = 1U,
  /** Track tick marks are always shown. */
  MDCSliderTrackTickVisibilityAlways = 2U,
};

@protocol MDCSliderDelegate;

/**
 A Material slider.

 @see https://material.io/go/design-sliders for full details.

 Differences between UISlider and MDCSlider:
   Does not have api to
     set right and left icons
     set the thumb image
     set the right and left track images (if you wanted a custom track)
     set the right (background track) color
   Same features
     set color for thumb via @c color
     set color of track via @c trackColor
   New features
     making the slider a snap to discrete values via @c numberOfDiscreteValues.
 */
IB_DESIGNABLE
@interface MDCSlider
    : UIControl <MDCElevatable, MDCElevationOverriding, UIContentSizeCategoryAdjusting>

/** When @c YES, the forState: APIs are enabled. Defaults to @c NO. */
@property(nonatomic, assign, getter=isStatefulAPIEnabled) BOOL statefulAPIEnabled;

/** The delegate for the slider. */
@property(nullable, nonatomic, weak) id<MDCSliderDelegate> delegate;

/**
 Sets the color of the thumb for the specified state.

 In general, if a property is not specified for a state, the default is to use the
 @c UIControlStateNormal value. If the @c UIControlStateNormal value is not set, then the property
 defaults to a default value. Therefore, at a minimum, you should set the value for the
 normal state.

 @param thumbColor The color of the thumb (cursor).
 @param state The state of the slider.
 */
- (void)setThumbColor:(nullable UIColor *)thumbColor forState:(UIControlState)state;

/**
 Returns the thumb color associated with the specified state.

 @params state The state that uses the thumb color.
 @returns The thumb color for the specified state. If no color has been set for the specific state,
          this method returns the color associated with the @c UIControlStateNormal state.
 */
- (nullable UIColor *)thumbColorForState:(UIControlState)state;

/**
 Sets the color of the filled track area for the specified state.

 In general, if a property is not specified for a state, the default is to use the
 @c UIControlStateNormal value. If the @c UIControlStateNormal value is not set, then the property
 defaults to a default value. Therefore, at a minimum, you should set the value for the
 normal state.

 @param fillColor The color of the filled track.
 @param state The state of the slider.
 */
- (void)setTrackFillColor:(nullable UIColor *)fillColor forState:(UIControlState)state;

/**
 Returns the track fill color associated with the specified state.

 @params state The state that uses the track fill color.
 @returns The track fill color for the specified state. If no color has been set for the specific
          state, this method returns the color associated with the @c UIControlStateNormal state.
 */
- (nullable UIColor *)trackFillColorForState:(UIControlState)state;

/**
 Sets the color of the background (unfilled) track for the specified state.

 In general, if a property is not specified for a state, the default is to use the
 @c UIControlStateNormal value. If the @c UIControlStateNormal value is not set, then the property
 defaults to a default value. Therefore, at a minimum, you should set the value for the
 normal state.

 @param backgroundColor The color of the inactive track.
 @param state The state of the slider.
 */
- (void)setTrackBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state;

/**
 Returns the track background color associated with the specified state.

 @params state The state that uses the track background color.
 @returns The track background color for the specified state. If no color has been set for the
          specific state, this method returns the color associated with the @c UIControlStateNormal
          state.
 */
- (nullable UIColor *)trackBackgroundColorForState:(UIControlState)state;

/**
 Sets the color of the ticks within the filled track to use for the specified state.

 In general, if a property is not specified for a state, the default is to use the
 @c UIControlStateNormal value. If the @c UIControlStateNormal value is not set, then the property
 defaults to a default value. Therefore, at a minimum, you should set the value for the
 normal state.

 @param tickColor The color of the tick marks within the filled track.
 @param state The state of the slider.
 */
- (void)setFilledTrackTickColor:(nullable UIColor *)tickColor forState:(UIControlState)state;

/**
 Returns the tick color for the filled track portion associated with the specified state.

 @params state The state that uses the filled-track tick color.
 @returns The filled-track tick color for the specified state. If no color has been set for the
          specific state, this method returns the color associated with the @c UIControlStateNormal
          state.
 */
- (nullable UIColor *)filledTrackTickColorForState:(UIControlState)state;

/**
 Sets the color of the ticks for the background (unfilled) track to use for the specified state.

 In general, if a property is not specified for a state, the default is to use the
 @c UIControlStateNormal value. If the @c UIControlStateNormal value is not set, then the property
 defaults to a default value. Therefore, at a minimum, you should set the value for the
 normal state.

 @param tickColor The color of the tick marks outside the filled track.
 @param state The state of the slider.
 */
- (void)setBackgroundTrackTickColor:(nullable UIColor *)tickColor forState:(UIControlState)state;

/**
 Returns the tick color for the background (unfilled) track portion associated with the specified
 state.

 @params state The state that uses the background-track tick color.
 @returns The background-track tick color for the specified state. If no color has been set for the
          specific state, this method returns the color associated with the @c UIControlStateNormal
          state.
 */
- (nullable UIColor *)backgroundTrackTickColorForState:(UIControlState)state;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 The color of the ripple.

 Defaults to transparent blue.
 */
@property(nonatomic, strong, nullable) UIColor *rippleColor;

/**
 The radius of the cursor (thumb).

 Default value is 6 points.
 */
@property(nonatomic, assign) CGFloat thumbRadius UI_APPEARANCE_SELECTOR;

/**
 The elevation of the cursor (thumb).

 Default value is MDCElevationNone.
 */
@property(nonatomic, assign) MDCShadowElevation thumbElevation UI_APPEARANCE_SELECTOR;

/**
 The shadow color of the cursor (thumb).

 Default value is black
 */
@property(nonatomic, strong, nonnull) UIColor *thumbShadowColor;

/**
 The number of discrete values that the slider can take.

 The discrete values are evenly spaced between the @c minimumValue and
 @c maximumValue. If 0 or 1, the slider's value will not change when the user releases the thumb.

 The default value is zero.
 */
@property(nonatomic, assign) NSUInteger numberOfDiscreteValues;

/**
 If @c YES and @c numberOfDiscreteValues is greater than 1, the thumb will snap to the nearest
 discrete value when the user drags the Thumb or taps.

 Defaults to @c YES.

 @note This property has no effect if @c numberOfDiscreteValues is less than 2.
 */
@property(nonatomic, assign, getter=isDiscrete) BOOL discrete;

/**
 Configures the visibility of the track tick marks.

 The default value is @c MDCSliderTrackTickVisibilityWhenDragging.
 */
@property(nonatomic, assign) MDCSliderTrackTickVisibility trackTickVisibility;

/**
 The value of the slider.

 To animate from the current value to the new value, instead use @see setValue:animated:. The value
 will be clamped between @c minimumValue and @c maximumValue. Setting the value will not send an
 action message.

 The default value of this property is 0.
 */
@property(nonatomic, assign) CGFloat value;

/**
 Set the value of the slider, allowing you to animate the change visually.

 If animated is YES, the thumb is animated into its new position. Setting the value does not
 result in an action message being sent.

 @param value The value to set the slider to.
 @param animated If YES, the thumb will animate to its new position.
 */
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

/**
 The minimum value of the slider.

 If you change the value of this property and the @c value of the receiver is below the new minimum,
 the current value will be adjusted to match the new minimum value.
 If you change the value of this property and @c maximumValue of the receiver is below the new
 minimum, the @c maximumValue will also be set to this new minimum value.

 The default value of this property is 0.0.
 */
@property(nonatomic, assign) CGFloat minimumValue;

/**
 The maximum value of the slider.

 If you change the value of this property and the @c value of the receiver is above the new maximum,
 the current value will be adjusted to match the new maximum value.
 If you change the value of this property and @c minimumValue of the receiver is above the new
 maximum, the @c minimumValue will also be set to this new maximum value.

 The default value of this property is 1.0.
 */
@property(nonatomic, assign) CGFloat maximumValue;

/**
 Indicates  whether changes in the slider's value generate continuous update events.

 If YES, the slider sends update events continuously to the associated target's action method.
 If NO, the slider only sends an action event when the user releases the slider's thumb control to
 set the final value.

 The default value of this property is YES.
 */
@property(nonatomic, assign, getter=isContinuous) BOOL continuous;

/**
 The value from which the filled part of the track is anchored. If set to a value between
 minimumValue and maximumValue, then the filled/colored part of the track extends from the
 trackAnchorValue to the thumb. Values beyond the minimum/maximum values are effectively capped.

 The default value is -CGFLOAT_MAX, so the filled part of the track extends from the minimum value
 to the thumb.
 */
@property(nonatomic, assign) CGFloat filledTrackAnchorValue;

/**
 Whether or not to show the numeric value label when dragging a discrete slider. If YES, consider
 implementing MDCSliderDelegate's @c -slider:displayedStringForValue: method to customize the string
 displayed for each discrete value.

 Defaults to YES.
 */
@property(nonatomic, assign) BOOL shouldDisplayDiscreteValueLabel;

/**
 The color of the discrete value label's text.

 Resets to the default color.
 */
@property(nonatomic, strong, null_resettable) UIColor *valueLabelTextColor;

/**
 The color of the discrete value label's background.

 Resets to the default color.
 */
@property(nonatomic, strong, null_resettable) UIColor *valueLabelBackgroundColor;

/**
 Whether or not the thumb view should be a hollow circle when at the minimum value. For sliders
 where the minimum value indicates that the associated property is off (for example a volume slider
 where a value of 0 = muted), this should be set to YES. In cases where this doesn't make sense (for
 instance a scrubber of an audio or video file), this should be set to NO.

 Defaults to YES.
 */
@property(nonatomic, assign, getter=isThumbHollowAtStart) BOOL thumbHollowAtStart;

/**
 A block that is invoked when the @c MDCSlider receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCSlider *_Nonnull slider, UITraitCollection *_Nullable previousTraitCollection);

/**
 The height of the track that the thumb moves along.

 Default value is 2 points.
 */
@property(nonatomic, assign) CGFloat trackHeight;

#pragma mark - To be deprecated

/**
 The color of the cursor (thumb) and track while the slider is disabled.

 Default color is gray.

 @note This API is planned for deprecation. Use @c setThumbColor:forState: and
       @c setTrackBackgroundColor:forState: instead.
 @note Has no effect if @c statefulAPIEnabled is @c YES.
 */
@property(nonatomic, strong, null_resettable) UIColor *disabledColor UI_APPEARANCE_SELECTOR;

/**
 The color of the cursor (thumb) and filled in portion of the track (left side).

 Default color is blue.

 @note This API is planned for deprecation. Use @c inkColor, @c setThumbColor:forState:, and
       @c setTrackFillColor:forState: instead.
 @note Has no effect if @c statefulAPIEnabled is @c YES.
 */
@property(nonatomic, strong, null_resettable) UIColor *color UI_APPEARANCE_SELECTOR;

/**
 The color of the unfilled track that the cursor moves along (right side).

 Default color is gray.
 @note This API is planned for deprecation. Use @c setTrackBackgroundColor:forState: instead.
 @note Has no effect if @c statefulAPIEnabled is @c YES.
 */
@property(nonatomic, strong, null_resettable) UIColor *trackBackgroundColor UI_APPEARANCE_SELECTOR;

/** When @c YES, haptics for min and max are enabled. The haptics casue a light impact reaction when
 the slider reaches the minimum or maximum value. If the slider is anchored, it will also cause a
 light impact reaction when the slider reaches or crosses the anchored value.

 Defaults to @c YES in iOS 10 or later, @c NO otherwise
 */
@property(nonatomic, assign) BOOL hapticsEnabled;

/** When @c YES, haptics for any value change are enabled for discrete sliders. The haptics casue
 a light impact reaction when the slider value changes for discrete sliders. Can only be set to yes
 for discrete sliders. Haptics will only occur if hapticsEnabled is also set to @c YES.

 Defaults to @c NO
 */
@property(nonatomic, assign) BOOL shouldEnableHapticsForAllDiscreteValues;

/**
 The font of the discrete value label.

 This font will come into effect only when @c numberOfDiscreteValues is larger than 0 and when @c
 shouldDisplayDiscreteValueLabel is
 @c YES.

 Defaults to [[MDCTypography fontLoader] regularFontOfSize:12].
 Note: MDCTypography is planned for deprecation in the future and therefore this value may change.
 */
@property(nonatomic, strong, null_resettable) UIFont *discreteValueLabelFont;

@end

@interface MDCSlider (ToBeDeprecated)

/**
 The color of the Ink ripple.

 Defaults to transparent blue.
 @warning This method will eventually be deprecated. Opt-in to Ripple by setting
 enableRippleBehavior to YES, and then use rippleColor instead. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple
 */
@property(nonatomic, strong, nullable) UIColor *inkColor;

@end

/** MDCSlider delegate which allows setting custom behavior. */
@protocol MDCSliderDelegate <NSObject>
@optional

/**
 Called when the user taps on the MDCSlider.

 If not implemented, the MDCSlider will always be allowed to jump to any value.
 */
- (BOOL)slider:(nonnull MDCSlider *)slider shouldJumpToValue:(CGFloat)value;

/**
 For discrete sliders, called when the slider is determining the string label to display for a given
 discrete value.

 If not implemented, or if no slider delegate is specified, the slider defaults to displaying the
 value rounded to the closest relevant digit. For instance, 0.50000 would become "0.5"

 Override this to provide custom behavior, for instance if your slider deals in percentages, the
 above example could become "50%"

 @param slider The MDCSlider sender.
 @param value The value whose label needs to be calculated.
 */
- (nonnull NSString *)slider:(nonnull MDCSlider *)slider displayedStringForValue:(CGFloat)value;

/**
 Used to determine what string value should be used as the accessibility string for a given value.

 If not implemented, or if no slider delegate is specified, the slider defaults to how filled the
 slider is, as a percentage. Override this method to provide custom behavior, and when implementing,
 you may want to also implement @c -slider:displayedStringForValue: to ensure consistency between
 the displayed value and the accessibility label.

 @param slider The MDCSlider sender.
 @param value The value whose accessibility label needs to be calculated.
 */
- (nonnull NSString *)slider:(nonnull MDCSlider *)slider accessibilityLabelForValue:(CGFloat)value;

@end
