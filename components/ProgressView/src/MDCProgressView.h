// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

/** The animation mode when animating backward progress. */
typedef NS_ENUM(NSInteger, MDCProgressViewBackwardAnimationMode) {

  /** Animate negative progress by resetting to 0 and then animating to the new value. */
  MDCProgressViewBackwardAnimationModeReset,

  /** Animate negative progress by animating from the current value. */
  MDCProgressViewBackwardAnimationModeAnimate
};

/** The mode the progress bar is in. */
typedef NS_ENUM(NSInteger, MDCProgressViewMode) {
  /** Display the progress in a determinate way. */
  MDCProgressViewModeDeterminate,

  /** Display the progress in an indeterminate way. */
  MDCProgressViewModeIndeterminate
};

/**
 A Material linear determinate progress view.

 See https://material.io/go/design-progress-indicators
 */
IB_DESIGNABLE
@interface MDCProgressView : UIView

/**
 The color shown for the portion of the progress view that is filled.

 The default is a blue color.
 */
@property(nonatomic, strong, nullable) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;

/**
 An array of CGColorRef objects used to defining the color of each gradient stop.
 All colors are spread uniformly across the range.

 Setting @c progressTintColor resets this property to @c nil.

 The default is nil.
*/
@property(nonatomic, copy, nullable) NSArray *progressTintColors;

/**
 The color shown for the portion of the progress view that is not filled.

 The default is a light blue color.
 */
@property(nonatomic, strong, nullable) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;

/**
 The corner radius for both the portion of the progress view that is filled and the track.

 This is not equivalent to configuring self.layer.cornerRadius; it instead configures the progress
 and track views directly.

 Under @c MDCProgressViewModeIndeterminate mode, the progress view is fully rounded if this value
 is larger than 0.

 The default is 0.
 */
@property(nonatomic) CGFloat cornerRadius;

/**
 The current progress.

 The current progress is represented by a floating-point value between 0.0 and 1.0, inclusive, where
 1.0 indicates the completion of the task. The default value is 0.0. Values less than 0.0 and
 greater than 1.0 are pinned to those limits.
 To animate progress changes, use -setProgress:animated:completion:.
 */
@property(nonatomic, assign) float progress;

/**
 If the progress view shows a constant loading animation (MDCProgressViewModeIndeterminate) or is
 based on the progress property (MDCProgressViewModeDeterminate).
 The default value is MDCProgressViewModeDeterminate.
 */
@property(nonatomic, assign) MDCProgressViewMode mode;

/**
 Indicates if the progress view is animating when @c mode is @MDCProgressViewModeIndeterminate.

 The default value is NO.
 */
@property(nonatomic, assign, getter=isAnimating) BOOL animating;

/**
 The backward progress animation mode.

 When animating progress which is lower than the current progress value, this mode
 will determine which animation to use. The default is MDCProgressViewBackwardAnimationModeReset.
 */
@property(nonatomic, assign) MDCProgressViewBackwardAnimationMode backwardProgressAnimationMode;

/**
 Adjusts the current progress, optionally animating the change.

 @param progress The progress to set.
 @param animated Whether the change should be animated.
 @param completion The completion block executed at the end of the animation.
 */
- (void)setProgress:(float)progress
           animated:(BOOL)animated
         completion:(void (^__nullable)(BOOL finished))completion;

/**
 Changes the hidden state, optionally animating the change.

 @param hidden The hidden state to set.
 @param animated Whether the change should be animated.
 @param completion The completion block executed at the end of the animation.
 */
- (void)setHidden:(BOOL)hidden
         animated:(BOOL)animated
       completion:(void (^__nullable)(BOOL finished))completion;

/**
 Start the progress bar's indeterminate animation.
 */
- (void)startAnimating;

/**
 Stop the progress bar's indeterminate animation.
 */
- (void)stopAnimating;

/**
 A block that is invoked when the @c MDCProgressView receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCProgressView *_Nonnull progressView, UITraitCollection *_Nullable previousTraitCollection);

@end
