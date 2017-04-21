/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

@protocol MDCSliderDelegate;

/**
 A Material slider.

 @see https://www.google.com/design/spec/components/sliders.html for full details.

 Differences between UISlider and MDCSlider:
   Does not have api to
     set right and left icons
     set the thumb image
     set the right and left track images (if you wanted a custom track)
     set the right (background track) color
   Same features
     set color for thumb via @c thumbColor
     set color of track via @c trackColor
   New features
     making the slider a snap to discrete values via @c numberOfDiscreteValues.
 */
IB_DESIGNABLE
@interface MDCSlider : UIControl <NSSecureCoding>

/** The delegate for the slider. */
@property(nullable, nonatomic, weak) id<MDCSliderDelegate> delegate;

/**
 The color of the cursor (thumb) and filled in portion of the track (left side).

 Default color is blue.
 */
@property(nonatomic, strong, null_resettable) UIColor *color;

/*
 The color of the unfilled track that the cursor moves along (right side).

 Default color is gray.
 */
@property(nonatomic, strong, null_resettable) UIColor *trackBackgroundColor;

/**
 The number of discrete values that the slider can take.

 If greater than or equal to 2, the thumb will snap to the nearest discrete value when the user
 lifts their finger or taps. The discrete values are evenly spaced between the @c minimumValue and
 @c maximumValue. If 0 or 1, the slider's value will not change when the user releases the thumb.

 The default value is zero.
 */
@property(nonatomic, assign) NSUInteger numberOfDiscreteValues;

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
 Whether or not the thumb view should be a hollow circle when at the minimum value. For sliders
 where the minimum value indicates that the associated property is off (for example a volume slider
 where a value of 0 = muted), this should be set to YES. In cases where this doesn't make sense (for
 instance a scrubber of an audio or video file), this should be set to NO.

 Defaults to YES.
 */
@property(nonatomic, assign, getter=isThumbHollowAtStart) BOOL thumbHollowAtStart;

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
