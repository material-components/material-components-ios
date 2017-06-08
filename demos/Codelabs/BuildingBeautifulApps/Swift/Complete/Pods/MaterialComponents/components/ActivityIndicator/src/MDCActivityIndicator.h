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

#import <UIKit/UIKit.h>

@protocol MDCActivityIndicatorDelegate;

/**
 Different operating modes for the activity indicator.

 This component can be used as a determinate progress indicator or an indeterminate activity
 indicator.

 Default value is MDCActivityIndicatorModeIndeterminate.
 */
typedef NS_ENUM(NSInteger, MDCActivityIndicatorMode) {
  /** Indeterminate indicators visualize an unspecified wait time. */
  MDCActivityIndicatorModeIndeterminate,
  /** Determinate indicators display how long an operation will take. */
  MDCActivityIndicatorModeDeterminate,
};

/**
 A Material Design activity indicator.

 The activity indicator is a circular spinner that shows progress of an operation. By default the
 activity indicator assumes indeterminate progress of an unspecified length of time. In contrast to
 a standard UIActivityIndicator, MDCActivityIndicator supports showing determinate progress and uses
 custom Material Design animation for indeterminate progress.

 See https://material.io/guidelines/components/progress-activity.html
 */
IB_DESIGNABLE
@interface MDCActivityIndicator : UIView

/**
 The callback delegate. See @c MDCActivityIndicatorDelegate.
 */
@property(nonatomic, weak, nullable) id<MDCActivityIndicatorDelegate> delegate;

/**
 Whether or not the activity indicator is currently animating.
 */
@property(nonatomic, assign, getter=isAnimating) BOOL animating;

/**
 Spinner radius width. Defaults to 12dp (24x24dp circle), constrained to range [8dp, 72dp]. The
 spinner is centered in the view's bounds. If the bounds are smaller than the diameter of the
 spinner, the spinner may be clipped when clipToBounds is true.
 */
@property(nonatomic, assign) CGFloat radius UI_APPEARANCE_SELECTOR;

/**
 Spinner stroke width. Defaults to 2dp.
 */
@property(nonatomic, assign) CGFloat strokeWidth UI_APPEARANCE_SELECTOR;

/**
 Show a faint ink track along the path of the indicator. Should be enabled when the activity
 indicator wraps around another circular element, such as an avatar or a FAB. Defaults to NO.
 */
@property(nonatomic, assign) IBInspectable BOOL trackEnabled;

/**
 The mode of the activity indicator. Default is MDCActivityIndicatorModeIndeterminate. If
 currently animating, it will animate the transition between the current mode to the new mode.
 */
@property(nonatomic, assign) IBInspectable MDCActivityIndicatorMode indicatorMode;

/**
 Set the mode of the activity indicator. If currently animating, it will animate the transition
 between the current mode to the new mode. Default is MDCActivityIndicatorModeIndeterminate with no
 animation.
 */
- (void)setIndicatorMode:(MDCActivityIndicatorMode)mode animated:(BOOL)animated;

/**
 Progress is the extent to which the activity indicator circle is drawn to completion when
 indicatorMode is MDCActivityIndicatorModeDeterminate. Progress is drawn clockwise to complete a
 circle. Valid range is between [0-1]. Default is zero. 0.5 progress is half the circle. The
 transitions between progress levels are animated.
 */
@property(nonatomic, assign) IBInspectable float progress;

/**
 The array of colors that are cycled through when animating the spinner. Populated with default
 colors of blue, red, yellow and green on initialization. An empty array results in a blue spinner
 with no color cycling.
 */
@property(nonatomic, copy, nonnull) NSArray<UIColor *> *cycleColors UI_APPEARANCE_SELECTOR;

/**
 Starts the animated activity indicator. Does nothing if the spinner is already animating.
 */
- (void)startAnimating;

/**
 Stops the animated activity indicator with a short opacity and stroke width animation. Does nothing
 if the spinner is not animating.
 */
- (void)stopAnimating;

@end

/**
 Delegate protocol for the MDCActivityIndicator.
 */
@protocol MDCActivityIndicatorDelegate <NSObject>

@optional
/**
 When stop is called, the spinner gracefully animates out using opacity and stroke width.
 This method is called after that fade-out animation completes.

 @param activityIndicator Caller
 */
- (void)activityIndicatorAnimationDidFinish:(nonnull MDCActivityIndicator *)activityIndicator;

@end
