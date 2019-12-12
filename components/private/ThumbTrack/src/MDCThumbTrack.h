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

#import <UIKit/UIKit.h>

#import "MaterialShadowElevations.h"

/** The visibility of the discrete dots. */
typedef NS_ENUM(NSUInteger, MDCThumbDiscreteDotVisibility) {
  /** Discrete dots are never shown. */
  MDCThumbDiscreteDotVisibilityNever = 0,
  /** Discrete dots are only shown when the thumb is pressed or dragging. */
  MDCThumbDiscreteDotVisibilityWhenDragging = 1U,
  /** Discrete dots are always shown. */
  MDCThumbDiscreteDotVisibilityAlways = 2U,
};

@class MDCThumbView;
@protocol MDCThumbTrackDelegate;

@interface MDCThumbTrack : UIControl <UIContentSizeCategoryAdjusting>

/** The delegate for the thumb track. */
@property(nullable, nonatomic, weak) id<MDCThumbTrackDelegate> delegate;

/**
 The color of the thumb when enabled.

 Defaults and resets to blue.
 */
@property(null_resettable, nonatomic, strong) UIColor *thumbEnabledColor;

/** The color of the thumb when disabled. */
@property(nullable, nonatomic, strong) UIColor *thumbDisabledColor;

/**
 The color of the 'on' portion of the track.

 Defaults and resets to blue.
 */
@property(null_resettable, nonatomic, strong) UIColor *trackOnColor;

/** The color of the 'off' portion of the track. */
@property(nullable, nonatomic, strong) UIColor *trackOffColor;

/** The color of the track when disabled. */
@property(nullable, nonatomic, strong) UIColor *trackDisabledColor;

/** The color of the discrete "ticks" in the "on" portion of the track. */
@property(nullable, nonatomic, strong) UIColor *trackOnTickColor;

/** The color of the discrete "ticks" in the "off" portion of the track. */
@property(nullable, nonatomic, strong) UIColor *trackOffTickColor;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/** The color of the ripple. */
@property(nullable, nonatomic, strong) UIColor *rippleColor;

/**
 The color of the value label's text.

 Defaults and resets to white.
 */
@property(null_resettable, nonatomic, strong) UIColor *valueLabelTextColor;

/**
 The color of the value label's background.

 Defaults and resets to blue.
 */
@property(null_resettable, nonatomic, strong) UIColor *valueLabelBackgroundColor;

/**
 The number of discrete values that the thumb can take along the track.

 The set of discrete values is equivalent to
 { minimumValue +  (i / (numDiscreteValues - 1.0)) * (maximumValue - minimumValue) } for
 i = 0..numDiscreteValues-1.

 The default value is zero. If @c numDiscreteValues is set to one, then the thumb track will act as
 if @c numDiscreteValues is zero.
 */
@property(nonatomic, assign) NSUInteger numDiscreteValues;

/**
 When @c YES, and @c numDiscreteValues is greater than 2, then the value can only ever be one of the
 calculated discrete values. The resulting value is the one closest to the current position of the
 touch that is dragging the thumb.

 Defaults to @c YES.

 @note This property has no effect if @c numDiscreteValues is less than 2.
 */
@property(nonatomic, assign, getter=isDiscrete) BOOL discrete;

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

/** The elevation of the track thumb that moves along the track. */
@property(nonatomic, assign) MDCShadowElevation thumbElevation;

/** The shadow color of the track thumb. Defaults to black */
@property(nonnull, nonatomic, strong) UIColor *thumbShadowColor;

/** Whether or not the thumb should be smaller when the track is disabled. Defaults to NO. */
@property(nonatomic, assign) BOOL thumbIsSmallerWhenDisabled;

/**
 Whether or not the thumb view should be a hollow circle when at the start position. Defaults to
 NO.
 */
@property(nonatomic, assign) BOOL thumbIsHollowAtStart;

/** Whether or not the thumb should grow when the user is dragging it. Default is NO. */
@property(nonatomic, assign) BOOL thumbGrowsWhenDragging;

/** The max radius of the ripple when the user touches the thumb. */
@property(nonatomic, assign) CGFloat thumbRippleMaximumRadius;

/** Whether the thumb should display ripple splashes on touch. */
@property(nonatomic, assign) BOOL shouldDisplayRipple;

/**
 Configures the visibility of the discrete dots.
*/
@property(nonatomic, assign) MDCThumbDiscreteDotVisibility discreteDotVisibility;

/**
 Whether or not to show the numeric value label when dragging a discrete slider.

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL shouldDisplayDiscreteValueLabel;

/**
 Whether or not to show the filled track on the left of the thumb. If NO, the left track will be
 displayed with the same tint color as the right track.

 Defaults to YES.
 */
@property(nonatomic, assign) BOOL shouldDisplayFilledTrack;

/** Whether a disabled thumb track includes gaps on either side of the thumb. The default is NO. */
@property(nonatomic, assign) BOOL disabledTrackHasThumbGaps;

/** Whether the ends of the thumb track should be rounded. The default is NO. */
@property(nonatomic, assign) BOOL trackEndsAreRounded;

/** Whether the ends of the track are inset by the radius of the thumb. The default is NO. */
@property(nonatomic, assign) BOOL trackEndsAreInset;

/**
 The value from which the filled part of the track is anchored. If set to a value between
 minimumValue and maximumValue, then the filled/colored part of the track extends from the
 trackAnchorValue to the thumb. Values beyond the minimum/maximum values are effectively capped.
 The default value is -CGFLOAT_MAX, so the filled part of the track extends from the minimum value
 to the thumb.
 */
@property(nonatomic, assign) CGFloat filledTrackAnchorValue;

/** The thumb view that user moves along the track. */
@property(nullable, nonatomic, strong) MDCThumbView *thumbView;

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
 The font of the discrete value label.

 This font will come into effect only when @c numDiscreteValues is larger than 0 and when @c
 shouldDisplayDiscreteValueLabel is
 @c YES.

 Defaults to [[MDCTypography fontLoader] regularFontOfSize:12].
 */
@property(nonatomic, strong, null_resettable) UIFont *discreteValueLabelFont;

/**
 Initialize an instance with a particular frame and color group.

 Designated initializer.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame onTintColor:(nullable UIColor *)onTintColor;

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
 @param animated If YES, the change of value will be animated.
 @param animateThumbAfterMove If YES, animate the thumb to its new state after moving it into place.
 @param userGenerated Is this call a direct result of a user's action?
 @param completion If not NULL, the block will be called after the value is set.
 */
- (void)setValue:(CGFloat)value
                 animated:(BOOL)animated
    animateThumbAfterMove:(BOOL)animateThumbAfterMove
            userGenerated:(BOOL)userGenerated
               completion:(nullable void (^)(void))completion;

/** Set the @c icon shown on the thumb. */
- (void)setIcon:(nullable UIImage *)icon;

/** Disable setting multitouch. Has to be NO. */
- (void)setMultipleTouchEnabled:(BOOL)multipleTouchEnabled NS_UNAVAILABLE;

#pragma mark - To be deprecated

/**
 The color of the thumb and left track.

 @note This API will be deprecated. Use @c thumbEnabledColor, @c trackOnColor, and
       @c inkColor instead.
 */
@property(nullable, nonatomic, strong) UIColor *primaryColor;

@end

@interface MDCThumbTrack (ToBeDeprecated)

/**
 The color of the Ink ripple.
 @warning This method will eventually be deprecated. Opt-in to Ripple by setting
 enableRippleBehavior to YES, and then use rippleColor instead. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple
 */
@property(nullable, nonatomic, strong) UIColor *inkColor;

/**
 Whether the thumb should display ink splashes on touch.
 @warning This method will eventually be deprecated. Opt-in to Ripple by setting
 enableRippleBehavior to YES, and then use shouldDisplayRipple instead. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple
 */
@property(nonatomic, assign) BOOL shouldDisplayInk;

@end

/** MDCThumbtrack delegate which allows setting custom behavior. */
@protocol MDCThumbTrackDelegate <NSObject>
@optional

/**
 For discrete thumb tracks, used when determining the string label to display for a given discrete
 value.

 If not implemented, or if no delegate is specified, the thumb track displays the empty string ""
 for all values.

 @param thumbTrack The thumb track sender.
 @param value The value whose label needs to be calculated.
 */
- (nonnull NSString *)thumbTrack:(nonnull MDCThumbTrack *)thumbTrack stringForValue:(CGFloat)value;

/**
 Called when the user taps on the MDCThumbTrack.
 If not implemented, the MDCThumbTrack will always be allowed to jump to any value.
 */
- (BOOL)thumbTrack:(nonnull MDCThumbTrack *)thumbTrack shouldJumpToValue:(CGFloat)value;

/**
 Called when the thumb track will jump to a specific value.

 @param thumbTrack The @c MDCThumbTrack sender.
 @param value The new value for the slider.
 */
- (void)thumbTrack:(nonnull MDCThumbTrack *)thumbTrack willJumpToValue:(CGFloat)value;

/**
 Called when the thumb track will animate to a specific value.

 @param thumbTrack The @c MDCThumbTrack sender.
 @param value The new value for the slider.
 */
- (void)thumbTrack:(nonnull MDCThumbTrack *)thumbTrack willAnimateToValue:(CGFloat)value;

/**
 Called just after the thumb track has animated to a specific value.

 @param thumbTrack The @c MDCThumbTrack sender.
 @param value The new value for the slider.
 */
- (void)thumbTrack:(nonnull MDCThumbTrack *)thumbTrack didAnimateToValue:(CGFloat)value;

@end
