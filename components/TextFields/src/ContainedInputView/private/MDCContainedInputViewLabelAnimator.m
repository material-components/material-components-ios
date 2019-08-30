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

#import "MDCContainedInputViewLabelAnimator.h"

#import "MaterialMath.h"

@interface MDCContainedInputViewLabelAnimator ()
@end

@implementation MDCContainedInputViewLabelAnimator

- (instancetype)init {
  self = [super init];
  if (self) {
    _animationDuration = 0.15;
  }
  return self;
}

- (void)layOutLabel:(nonnull UILabel *)floatingLabel
                 state:(MDCContainedInputViewLabelState)labelState
      normalLabelFrame:(CGRect)normalLabelFrame
    floatingLabelFrame:(CGRect)floatingLabelFrame
            normalFont:(nonnull UIFont *)normalFont
          floatingFont:(nonnull UIFont *)floatingFont {
  UIFont *targetFont = normalFont;
  CGRect targetFrame = normalLabelFrame;
  BOOL labelShouldHide = NO;
  switch (labelState) {
    case MDCContainedInputViewLabelStateFloating:
      targetFont = floatingFont;
      targetFrame = floatingLabelFrame;
      break;
    case MDCContainedInputViewLabelStateNormal:
      break;
    case MDCContainedInputViewLabelStateNone:
      labelShouldHide = YES;
      break;
    default:
      break;
  }

  floatingLabel.hidden = labelShouldHide;

  CGRect currentFrame = floatingLabel.frame;
  CGAffineTransform trasformNeededToMakeViewWithTargetFrameLookLikeItHasCurrentFrame =
      [self transformFromRect:targetFrame toRect:currentFrame];
  CATransform3D transformFromValueTransform3D = CATransform3DMakeAffineTransform(
      trasformNeededToMakeViewWithTargetFrameLookLikeItHasCurrentFrame);
  CATransform3D transformToValueTransform3D = CATransform3DIdentity;

  floatingLabel.frame = targetFrame;
  floatingLabel.font = targetFont;
  floatingLabel.transform = CGAffineTransformIdentity;

  CABasicAnimation *preexistingTransformAnimation =
      (CABasicAnimation *)[floatingLabel.layer animationForKey:self.labelTransformAnimationKey];

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [floatingLabel.layer removeAnimationForKey:self.labelTransformAnimationKey];
    }];
    if (preexistingTransformAnimation) {
      [floatingLabel.layer removeAnimationForKey:self.labelTransformAnimationKey];
    } else {
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
      animation.fromValue = [NSValue valueWithCATransform3D:transformFromValueTransform3D];
      animation.toValue = [NSValue valueWithCATransform3D:transformToValueTransform3D];
      animation.duration = self.animationDuration;
      animation.removedOnCompletion = NO;
      animation.fillMode = kCAFillModeForwards;
      [floatingLabel.layer addAnimation:animation forKey:self.labelTransformAnimationKey];
    }
  }
  [CATransaction commit];
}

/**
 This helper method returns the transform that would need to be applied to a view with a frame of @c
 sourceRect in order for it to appear as though its frame was @c finalRect.
 */
- (CGAffineTransform)transformFromRect:(CGRect)sourceRect toRect:(CGRect)finalRect {
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform =
      CGAffineTransformTranslate(transform, -(CGRectGetMidX(sourceRect) - CGRectGetMidX(finalRect)),
                                 -(CGRectGetMidY(sourceRect) - CGRectGetMidY(finalRect)));
  transform = CGAffineTransformScale(transform, finalRect.size.width / sourceRect.size.width,
                                     finalRect.size.height / sourceRect.size.height);

  return transform;
}

- (NSString *)labelTransformAnimationKey {
  return @"labelTransformAnimationKey";
}

@end
