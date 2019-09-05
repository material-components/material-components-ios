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
#import "MaterialMath.h"

static const CGFloat kMDCContainedInputViewLabelAnimatorDefaultAnimationDuration = (CGFloat)0.15;

@implementation MDCContainedInputViewLabelAnimation

- (instancetype)init {
  self = [super init];
  if (self) {
    self.animationDuration = 0.2;
  }
  return self;
}

+ (void)layOutLabel:(nonnull UILabel *)label
                 state:(MDCContainedInputViewLabelState)labelState
      normalLabelFrame:(CGRect)normalLabelFrame
    floatingLabelFrame:(CGRect)floatingLabelFrame
            normalFont:(nonnull UIFont *)normalFont
          floatingFont:(nonnull UIFont *)floatingFont {
  UIFont *targetFont;
  CGRect targetFrame;
  MDCAnimationTimingFunction mdcTimingFunction;
  if (labelState == MDCContainedInputViewLabelStateFloating) {
    targetFont = floatingFont;
    targetFrame = floatingLabelFrame;
    mdcTimingFunction = MDCAnimationTimingFunctionAcceleration;
  } else {
    targetFont = normalFont;
    targetFrame = normalLabelFrame;
    mdcTimingFunction = MDCAnimationTimingFunctionDeceleration;
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
                               duration:kMDCContainedInputViewLabelAnimatorDefaultAnimationDuration
                                  delay:0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                               label.transform = CGAffineTransformIdentity;
                             }
                             completion:nil];
}

+ (void)layOutPlaceholderLabel:(UILabel *)placeholderLabel
              placeholderFrame:(CGRect)placeholderFrame
          isPlaceholderVisible:(BOOL)isPlaceholderVisible {
  CGRect hiddenFrame =
      CGRectOffset(placeholderFrame, 0, CGRectGetHeight(placeholderFrame) * (CGFloat)0.5);
  CGRect targetFrame = hiddenFrame;
  CGFloat hiddenOpacity = 0;
  CGFloat targetOpacity = hiddenOpacity;
  if (isPlaceholderVisible) {
    targetFrame = placeholderFrame;
    targetOpacity = 1;
  }

  placeholderLabel.frame = targetFrame;
  placeholderLabel.transform = CGAffineTransformIdentity;

  CGFloat currentOpacity = (CGFloat)placeholderLabel.layer.opacity;
  CGFloat opacityFromValue = currentOpacity;
  CGFloat opacityToValue = targetOpacity;

  placeholderLabel.layer.opacity = (float)targetOpacity;

  CABasicAnimation *preexistingOpacityAnimation = (CABasicAnimation *)[placeholderLabel.layer
      animationForKey:self.placeholderLabelOpacityAnimationKey];

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [placeholderLabel.layer removeAnimationForKey:self.placeholderLabelOpacityAnimationKey];
    }];
    if (preexistingOpacityAnimation) {
      [placeholderLabel.layer removeAnimationForKey:self.placeholderLabelOpacityAnimationKey];
    } else if (opacityToValue == 1) {
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
      animation.fromValue = @(opacityFromValue);
      animation.toValue = @(opacityToValue);
      animation.duration = kMDCContainedInputViewLabelAnimatorDefaultAnimationDuration;
      animation.removedOnCompletion = NO;
      animation.fillMode = kCAFillModeForwards;
      [placeholderLabel.layer addAnimation:animation
                                    forKey:self.placeholderLabelOpacityAnimationKey];
    }
  }
  [CATransaction commit];
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

+ (NSString *)placeholderLabelOpacityAnimationKey {
  return @"placeholderLabelOpacityAnimationKey";
}

@end
