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

/** The animation mode when animating backward progress. */
typedef NS_ENUM(NSInteger, MDCProgressViewBackwardAnimationMode) {

  /** Animate negative progress by resetting to 0 and then animating to the new value. */
  MDCProgressViewBackwardAnimationModeReset,

  /** Animate negative progress by animating from the current value. */
  MDCProgressViewBackwardAnimationModeAnimate
};

/**
 A Material linear determinate progress view.

 See https://material.io/guidelines/components/progress-activity.html
 */
IB_DESIGNABLE
@interface MDCProgressView : UIView

/**
 The color shown for the portion of the progress view that is filled.

 The default is a blue color. When changed, the trackTintColor is reset.
 */
@property(nonatomic, strong, null_resettable) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;

/**
 The color shown for the portion of the progress view that is not filled.

 The default is a light version of the current progressTintColor.
 */
@property(nonatomic, strong, null_resettable) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;

/**
 The current progress.

 The current progress is represented by a floating-point value between 0.0 and 1.0, inclusive, where
 1.0 indicates the completion of the task. The default value is 0.0. Values less than 0.0 and
 greater than 1.0 are pinned to those limits.
 To animate progress changes, use -setProgress:animated:completion:.
 */
@property(nonatomic, assign) float progress;

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

@end
