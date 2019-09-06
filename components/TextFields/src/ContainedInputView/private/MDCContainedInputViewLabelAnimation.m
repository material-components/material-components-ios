// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCContainedInputViewLabelAnimation.h"

#import "MaterialAnimationTiming.h"

static const CGFloat kDefaultAnimationDuration = (CGFloat)0.15;

@implementation MDCContainedInputViewLabelAnimation

+ (void)layOutLabel:(nonnull UILabel *)label
                 state:(MDCContainedInputViewLabelState)labelState
      normalLabelFrame:(CGRect)normalLabelFrame
    floatingLabelFrame:(CGRect)floatingLabelFrame
            normalFont:(nonnull UIFont *)normalFont
          floatingFont:(nonnull UIFont *)floatingFont {
  UIFont *targetFont;
  CGRect targetFrame;
  if (labelState == MDCContainedInputViewLabelStateFloating) {
    targetFont = floatingFont;
    targetFrame = floatingLabelFrame;
  } else {
    targetFont = normalFont;
    targetFrame = normalLabelFrame;
  }

  CGRect currentFrame = label.frame;
  CGAffineTransform trasformNeededToMakeViewWithTargetFrameLookLikeItHasCurrentFrame =
      [self transformFromRect:targetFrame toRect:currentFrame];

  label.frame = targetFrame;
  label.font = targetFont;
  label.transform = trasformNeededToMakeViewWithTargetFrameLookLikeItHasCurrentFrame;

  CAMediaTimingFunction *timingFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionStandard];
  [UIView mdc_animateWithTimingFunction:timingFunction
                               duration:kDefaultAnimationDuration
                                  delay:0
                                options:0
                             animations:^{
                               label.transform = CGAffineTransformIdentity;
                             }
                             completion:nil];
}

/**
 This helper method returns the transform that would need to be applied to a view with a frame of @c
 sourceRect in order for it to appear as though its frame was @c finalRect.
 */
+ (CGAffineTransform)transformFromRect:(CGRect)sourceRect toRect:(CGRect)finalRect {
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform =
      CGAffineTransformTranslate(transform, -(CGRectGetMidX(sourceRect) - CGRectGetMidX(finalRect)),
                                 -(CGRectGetMidY(sourceRect) - CGRectGetMidY(finalRect)));
  transform = CGAffineTransformScale(transform, finalRect.size.width / sourceRect.size.width,
                                     finalRect.size.height / sourceRect.size.height);

  return transform;
}

@end
