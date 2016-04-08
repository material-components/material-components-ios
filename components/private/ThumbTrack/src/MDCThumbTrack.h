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

@class MDCThumbView;
@protocol MDCThumbTrackDelegate;

@interface MDCThumbTrack : UIControl

/** The delegate for the thumb track. */
@property(nonatomic, weak) id<MDCThumbTrackDelegate> delegate;

@property(nonatomic, strong) UIColor *primaryColor;

/** The color of the thumb off color. */
@property(nonatomic, strong) UIColor *thumbOffColor;

/** The color of the track off color. */
@property(nonatomic, strong) UIColor *trackOffColor;

/** The color of the thumb disabled color. */
@property(nonatomic, strong) UIColor *thumbDisabledColor;

/** The color of the track disabled color. */
@property(nonatomic, strong) UIColor *trackDisabledColor;

/**
 The number of discrete values that the thumb can take along the track. If this property is zero,
 then the slider operates continuously and doesn't do any snapping after the user releases the
 thumb. If this property is greater or equal to two, then the thumb will snap to the nearest
 discrete value on when the user lifts their finger or taps. The set of discrete values is
 equivalent to
 { minimumValue +  (i / (numDiscreteValues - 1.0)) * (maximumValue - minimumValue) } for
 i = 0..numDiscreteValues-1.

 The default value is zero. If numDiscreteValues is set to one, then the thumb track will act as
 if numDiscreteValues is zero and will judge you silently.
 */
@property(nonatomic, assign) NSUInteger numDiscreteValues;

/**
  The value of the thumb along the track.

 Setting this property causes the receiver to redraw itself using the new value. To render an
 animated transition from the current value to the new value you should use the setValue:animated:
 method instead. Setting the value to does not result in an action message being sent.

 If you try to set a value that is below the minimum or above the maximum value, the minimum or
 maximum value is set instead. The default value of this property is 0.0.
 */
@property(nonatomic, assign) CGFloat value;

/**
  The minimum value of the thumb along the track.

 If you change the value of this property, and the current value of the receiver is below the new
 minimum, the current value is adjusted to match the new minimum value automatically.

 The default value of this property is 0.0.
 */
@property(nonatomic, assign) CGFloat minimumValue;

/**
 The maximum value of the thumb along the track.

 If you change the value of this property, and the current value of the receiver is above the new
 maximum, the current value is adjusted to match the new maximum value automatically.

 The default value of this property is 1.0.
 */
@property(nonatomic, assign) CGFloat maximumValue;

/** The current position of the center of the thumb in this view's coordinates. */
@property(nonatomic, assign, readonly) CGPoint thumbPosition;

/** The height of the track that the thumb moves along. */
@property(nonatomic, assign) CGFloat trackHeight;

/** The radius of the track thumb that moves along the track. */
@property(nonatomic, assign) CGFloat thumbRadius;

/** The max radius of the ripple when the user touches the thumb. */
@property(nonatomic, assign) CGFloat thumbMaxRippleRadius;

/** Whether the thumb should display ink splashes on touch. */
@property(nonatomic, assign) BOOL shouldDisplayInk;

/** Whether a disabled thumb track includes gaps on either side of the thumb. The default is NO. */
@property(nonatomic, assign) BOOL disabledTrackHasThumbGaps;

/** Whether the ends of the thumb track should be rounded. The default is NO. */
@property(nonatomic, assign) BOOL trackEndsAreRounded;

/** Whether the ends of the track are inset by the radius of the thumb. The default is NO. */
@property(nonatomic, assign) BOOL trackEndsAreInset;

/** Whether the thumb and the track interpolate between on and off color. The default is NO. */
@property(nonatomic, assign) BOOL interpolateOnOffColors;

/**
 The value from which the filled part of the track is anchored. If set to a value between
 minimumValue and maximumValue, then the filled/colored part of the track extends from the
 trackAnchorValue to the thumb. Values beyond the minimum/maximum values are effectively capped.
 The default value is -CGFLOAT_MAX, so the filled part of the track extends from the minimum value
 to the thumb.
 */
@property(nonatomic, assign) CGFloat filledTrackAnchorValue;

/** The thumb view that user moves along the track. */
@property(nonatomic, strong) MDCThumbView *thumbView;

/**
 Contains a Boolean value indicating whether a user's changes in the value generate continuous
 update events.

 If YES, the slider sends update events continuously to the associated target’s action method.
 If NO, the slider only sends an action event when the user releases the slider’s thumb control to
 set the final value.

 The default value of this property is YES.
 */
@property(nonatomic, assign) BOOL continuousUpdateEvents;

/**
 Whether the control should react to pan gestures all along the track, or just on the thumb.

 The default value of this property is NO.
 */
@property(nonatomic, assign) BOOL panningAllowedOnEntireControl;

/**
 Whether the control should react to taps on the thumb itself, as opposed to the track.

 The default value of this property is NO.
 */
@property(nonatomic, assign) BOOL tapsAllowedOnThumb;

/**
 Initialize an instance with a particular frame and color group.

 Designated initializer.
 */
- (instancetype)initWithFrame:(CGRect)frame onTintColor:(UIColor *)onTintColor;

/**
 Set the value of the thumb along the track.

 If animated is YES, the thumb is animated into its new position. Setting the value does not
 result in an action message being sent.

 @param value The value to set the slider to.
 @param animated If YES, the thumb will animate to its new position.
 */
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

/**
 Set the value of the thumb along the track.

 If animated is YES, the thumb is animated into its new position. Setting the value to does not
 result in an action message being sent.

 @param value The value to set the thumb to.
 @param animated If YES, the thumb will animate to its new position.
 @param userGenerated Is this call a direct result of a user's action?
 @param completion If not NULL, the block will be called after the value is set.
 */
- (void)setValue:(CGFloat)value
         animated:(BOOL)animated
    userGenerated:(BOOL)userGenerated
       completion:(void (^)())completion;

@end

/** MDCThumbtrack delegate which allows setting custom behavior. */
@protocol MDCThumbTrackDelegate <NSObject>
@optional

/**
 Called when the user taps on the MDCThumbTrack.
 If not implemented, the MDCThumbTrack will always be allowed to jump to any value.
 */
- (BOOL)thumbTrack:(MDCThumbTrack *)thumbTrack shouldJumpToValue:(CGFloat)value;

/**
 Called when the thumb track will jump to a specific value.

 @param thumbTrack The @c MDCThumbTrack sender.
 @param value The new value for the slider.
 */
- (void)thumbTrack:(MDCThumbTrack *)thumbTrack willJumpToValue:(CGFloat)value;

/**
 Called when the thumb track will animate to a specific value.

 @param thumbTrack The @c MDCThumbTrack sender.
 @param value The new value for the slider.
 */
- (void)thumbTrack:(MDCThumbTrack *)thumbTrack willAnimateToValue:(CGFloat)value;

/**
 Called just after the thumb track has animated to a specific value.

 @param thumbTrack The @c MDCThumbTrack sender.
 @param value The new value for the slider.
 */
- (void)thumbTrack:(MDCThumbTrack *)thumbTrack didAnimateToValue:(CGFloat)value;

@end
