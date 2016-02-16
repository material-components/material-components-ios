/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

/**
 A material slider.

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

 @ingroup Slider
 */
IB_DESIGNABLE
@interface MDCSlider : UIControl <NSCoding>

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

 If you change the value of this property and the current value of the receiver is below the new
 minimum, the current value will be adjusted to match the new minimum value.

 The default value of this property is 0.0.
 */
@property(nonatomic, assign) CGFloat minimumValue;

/**
 The maximum value of the slider.

 If you change the value of this property and the current value of the receiver is above the new
 maximum, the current value will be adjusted to match the new maximum value.

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

@end
