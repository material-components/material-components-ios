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

//#import "MDCContainedInputView.h"
#import "MaterialMath.h"

@interface MDCContainedInputViewLabelAnimator ()
@end

@implementation MDCContainedInputViewLabelAnimator

- (instancetype)init {
  self = [super init];
  if (self) {
    self.animationDuration = 0.2;
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
  BOOL floatingLabelShouldHide = NO;
  switch (labelState) {
    case MDCContainedInputViewLabelStateFloating:
      targetFont = floatingFont;
      targetFrame = floatingLabelFrame;
      break;
    case MDCContainedInputViewLabelStateNormal:
      break;
    case MDCContainedInputViewLabelStateNone:
      floatingLabelShouldHide = YES;
      break;
    default:
      break;
  }

  CGRect currentFrame = floatingLabel.frame;
  CGAffineTransform trasformNeededToMakeTargetLookLikeCurrent =
      [self transformFromRect:targetFrame toRect:currentFrame];
  CATransform3D transformFromValueTransform3D =
      CATransform3DMakeAffineTransform(trasformNeededToMakeTargetLookLikeCurrent);
  CATransform3D transformToValueTransform3D = CATransform3DIdentity;

  floatingLabel.frame = targetFrame;
  floatingLabel.font = targetFont;
  floatingLabel.transform = CGAffineTransformIdentity;

  CABasicAnimation *preexistingTransformAnimation = (CABasicAnimation *)[floatingLabel.layer
      animationForKey:self.floatingLabelTransformAnimationKey];

  floatingLabel.hidden = floatingLabelShouldHide;

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [floatingLabel.layer removeAnimationForKey:self.floatingLabelTransformAnimationKey];
    }];
    if (preexistingTransformAnimation) {
      [floatingLabel.layer removeAnimationForKey:self.floatingLabelTransformAnimationKey];
    } else {
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
      animation.fromValue = [NSValue valueWithCATransform3D:transformFromValueTransform3D];
      animation.toValue = [NSValue valueWithCATransform3D:transformToValueTransform3D];
      animation.duration = self.animationDuration;
      animation.removedOnCompletion = NO;
      animation.fillMode = kCAFillModeForwards;
      [floatingLabel.layer addAnimation:animation forKey:self.floatingLabelTransformAnimationKey];
    }
  }
  [CATransaction commit];
}

- (void)layOutPlaceholderLabel:(UILabel *)placeholderLabel
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

  //  BOOL placeholderShouldHide = NO;

  //  CGRect currentFrame = placeholderLabel.frame;
  //  CGAffineTransform trasformNeededToMakeTargetLookLikeCurrent =
  //  [self transformFromRect:targetFrame toRect:currentFrame];
  //  CATransform3D transformFromValueTransform3D =
  //  CATransform3DMakeAffineTransform(trasformNeededToMakeTargetLookLikeCurrent);
  //  CATransform3D transformToValueTransform3D = CATransform3DIdentity;

  placeholderLabel.frame = targetFrame;
  placeholderLabel.transform = CGAffineTransformIdentity;

  CABasicAnimation *preexistingTransformAnimation = (CABasicAnimation *)[placeholderLabel.layer
      animationForKey:self.placeholderLabelTransformAnimationKey];

  CGFloat currentOpacity = (CGFloat)placeholderLabel.layer.opacity;
  CGFloat opacityFromValue = currentOpacity;
  CGFloat opacityToValue = targetOpacity;

  placeholderLabel.layer.opacity = (float)targetOpacity;

  CABasicAnimation *preexistingOpacityAnimation = (CABasicAnimation *)[placeholderLabel.layer
      animationForKey:self.placeholderLabelOpacityAnimationKey];

  //  placeholderLabel.hidden = placeholderShouldHide;

  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      [placeholderLabel.layer removeAnimationForKey:self.placeholderLabelTransformAnimationKey];
      [placeholderLabel.layer removeAnimationForKey:self.placeholderLabelOpacityAnimationKey];
    }];
    if (preexistingTransformAnimation) {
      [placeholderLabel.layer removeAnimationForKey:self.placeholderLabelTransformAnimationKey];
    } else {
      //      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
      //      animation.fromValue = [NSValue valueWithCATransform3D:transformFromValueTransform3D];
      //      animation.toValue = [NSValue valueWithCATransform3D:transformToValueTransform3D];
      //      animation.duration = self.animationDuration;
      //      animation.removedOnCompletion = NO;
      //      animation.fillMode = kCAFillModeForwards;
      //      [placeholderLabel.layer addAnimation:animation
      //      forKey:self.placeholderLabelTransformAnimationKey];
    }
    if (preexistingOpacityAnimation) {
      [placeholderLabel.layer removeAnimationForKey:self.placeholderLabelOpacityAnimationKey];
    } else if (opacityToValue == 1) {
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
      animation.fromValue = @(opacityFromValue);
      animation.toValue = @(opacityToValue);
      animation.duration = self.animationDuration;
      animation.removedOnCompletion = NO;
      animation.fillMode = kCAFillModeForwards;
      [placeholderLabel.layer addAnimation:animation
                                    forKey:self.placeholderLabelOpacityAnimationKey];
    }
  }
  [CATransaction commit];
}

- (CGAffineTransform)transformFromRect:(CGRect)sourceRect toRect:(CGRect)finalRect {
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform =
      CGAffineTransformTranslate(transform, -(CGRectGetMidX(sourceRect) - CGRectGetMidX(finalRect)),
                                 -(CGRectGetMidY(sourceRect) - CGRectGetMidY(finalRect)));
  transform = CGAffineTransformScale(transform, finalRect.size.width / sourceRect.size.width,
                                     finalRect.size.height / sourceRect.size.height);

  return transform;
}

- (NSString *)floatingLabelTransformAnimationKey {
  return @"floatingLabelTransformAnimationKey";
}

- (NSString *)placeholderLabelTransformAnimationKey {
  return @"placeholderLabelTransformAnimationKey";
}

- (NSString *)placeholderLabelOpacityAnimationKey {
  return @"placeholderLabelOpacityAnimationKey";
}

@end
