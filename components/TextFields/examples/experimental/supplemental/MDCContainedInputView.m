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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#import "MDCContainedInputView.h"

@implementation MDCContainedInputViewColorScheme

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCContainedInputViewColorSchemeInit];
  }
  return self;
}

- (void)commonMDCContainedInputViewColorSchemeInit {
  UIColor *textColor = [UIColor blackColor];
  UIColor *underlineLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *floatingLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *errorColor = [UIColor redColor];
  UIColor *clearButtonTintColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.20];
  self.textColor = textColor;
  self.underlineLabelColor = underlineLabelColor;
  self.floatingLabelColor = floatingLabelColor;
  self.placeholderColor = floatingLabelColor;
  self.clearButtonTintColor = clearButtonTintColor;
  self.errorColor = errorColor;
}

@end

@implementation MDCContainerStylerBase
@synthesize positioningDelegate = _positioningDelegate;

- (instancetype)initWithPositioningDelegate:
    (id<MDCContainedInputViewStylerPositioningDelegate>)positioningDelegate {
  self = [super init];
  if (self) {
    _positioningDelegate = positioningDelegate;
  }
  return self;
}

- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state {
  MDCContainedInputViewColorScheme *colorScheme = [[MDCContainedInputViewColorScheme alloc] init];

  UIColor *floatingLabelColor = colorScheme.floatingLabelColor;
  UIColor *underlineLabelColor = colorScheme.underlineLabelColor;
  UIColor *textColor = colorScheme.textColor;

  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      floatingLabelColor = [floatingLabelColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      textColor = colorScheme.errorColor;
      underlineLabelColor = colorScheme.errorColor;
      floatingLabelColor = colorScheme.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      floatingLabelColor = [UIColor blackColor];
      break;
    default:
      break;
  }

  colorScheme.textColor = textColor;
  colorScheme.underlineLabelColor = underlineLabelColor;
  colorScheme.floatingLabelColor = floatingLabelColor;

  return colorScheme;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)inputView
    withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme {
}

- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
}

- (CGFloat)floatingFontSizeScaleFactor {
  return 0.75;
}

@end

@implementation MDCContainerStylerBasePositioningDelegate
@synthesize verticalDensity = _verticalDensity;

- (instancetype)init {
  self = [super init];
  if (self) {
    self.verticalDensity = 0.5;
  }
  return self;
}

- (CGFloat)floatingLabelMinYWithFloatingLabelHeight:(CGFloat)floatingLabelHeight {
  return 10;
}

- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:(CGFloat)floatingLabelMaxY {
  return 20;
}

- (CGFloat)contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:(CGFloat)floatingLabelMaxY {
  return floatingLabelMaxY + 10;
}

@end

@interface MDCContainedInputViewFloatingLabelManager ()
@end

@implementation MDCContainedInputViewFloatingLabelManager

- (UIFont *)floatingFontWithFont:(UIFont *)font
                 containerStyler:(id<MDCContainedInputViewStyler>)containerStyler {
  CGFloat scaleFactor = [containerStyler floatingFontSizeScaleFactor];
  CGFloat floatingFontSize = font.pointSize * scaleFactor;
  return [font fontWithSize:floatingFontSize];
}

- (void)layOutFloatingLabel:(UILabel *)floatingLabel
                      state:(MDCContainedInputViewFloatingLabelState)floatingLabelState
                normalFrame:(CGRect)normalFrame
              floatingFrame:(CGRect)floatingFrame
                 normalFont:(UIFont *)normalFont
               floatingFont:(UIFont *)floatingFont {
  UIFont *targetFont = normalFont;
  CGRect targetFrame = normalFrame;
  BOOL floatingLabelShouldHide = NO;
  switch (floatingLabelState) {
    case MDCContainedInputViewFloatingLabelStateFloating:
      targetFont = floatingFont;
      targetFrame = floatingFrame;
      break;
    case MDCContainedInputViewFloatingLabelStateNormal:
      break;
    case MDCContainedInputViewFloatingLabelStateNone:
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

- (CGFloat)animationDuration {
  //  CGFloat lowerMinY = MIN(CGRectGetMinY(currentFrame), CGRectGetMinY(targetFrame));
  //  CGFloat higherMinY = MAX(CGRectGetMinY(currentFrame), CGRectGetMinY(targetFrame));
  //  CGFloat distanceTravelled = higherMinY - lowerMinY;
  CGFloat animationDuration = (CGFloat)0.2;
  //      distanceTravelled / kFloatingLabelAnimationVelocityInPointsPerSecond;
  return animationDuration;
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
