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
  UIColor *placeholderLabelColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.60];
  UIColor *errorColor = [UIColor redColor];
  UIColor *clearButtonTintColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)0.20];
  self.textColor = textColor;
  self.underlineLabelColor = underlineLabelColor;
  self.placeholderLabelColor = placeholderLabelColor;
  self.clearButtonTintColor = clearButtonTintColor;
  self.errorColor = errorColor;
}

@end

@implementation MDCContainerStyleBase
@synthesize densityInformer = _densityInformer;

#pragma mark Object Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUp];
  }
  return self;
}

- (void)setUp {
  [self setUpDensityInformer];
}

- (void)setUpDensityInformer {
  self.densityInformer = [[MDCContainerStyleBaseDensityInformer alloc] init];
}

- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:
    (MDCContainedInputViewState)state {
  MDCContainedInputViewColorScheme *colorScheme = [[MDCContainedInputViewColorScheme alloc] init];

  UIColor *placeholderLabelColor = colorScheme.placeholderLabelColor;
  UIColor *underlineLabelColor = colorScheme.underlineLabelColor;
  UIColor *textColor = colorScheme.underlineLabelColor;

  switch (state) {
    case MDCContainedInputViewStateNormal:
      break;
    case MDCContainedInputViewStateActivated:
      break;
    case MDCContainedInputViewStateDisabled:
      placeholderLabelColor = [placeholderLabelColor colorWithAlphaComponent:(CGFloat)0.10];
      break;
    case MDCContainedInputViewStateErrored:
      textColor = colorScheme.errorColor;
      underlineLabelColor = colorScheme.errorColor;
      placeholderLabelColor = colorScheme.errorColor;
      break;
    case MDCContainedInputViewStateFocused:
      placeholderLabelColor = [UIColor blackColor];
      break;
    default:
      break;
  }

  colorScheme.textColor = textColor;
  colorScheme.underlineLabelColor = underlineLabelColor;
  colorScheme.placeholderLabelColor = placeholderLabelColor;

  return colorScheme;
}

- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)inputView
    withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme {
}

- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView {
}

- (MDCContainedInputViewState)containedInputViewStateWithIsEnabled:(BOOL)isEnabled
                                                         isErrored:(BOOL)isErrored
                                                         isEditing:(BOOL)isEditing
                                                        isSelected:(BOOL)isSelected
                                                       isActivated:(BOOL)isActivated {
  if (isEnabled) {
    if (isErrored) {
      return MDCContainedInputViewStateErrored;
    } else {
      if (isEditing) {
        return MDCContainedInputViewStateFocused;
      } else {
        if (isSelected || isActivated) {
          return MDCContainedInputViewStateActivated;
        } else {
          return MDCContainedInputViewStateNormal;
        }
      }
    }
  } else {
    return MDCContainedInputViewStateDisabled;
  }
}

- (MDCContainedInputViewPlaceholderState)placeholderStateWithPlaceholder:(NSString *)placeholder
                                                                    text:(NSString *)text
                                                     canPlaceholderFloat:(BOOL)canPlaceholderFloat
                                                               isEditing:(BOOL)isEditing {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;
  if (hasPlaceholder) {
    if (canPlaceholderFloat) {
      if (isEditing) {
        return MDCContainedInputViewPlaceholderStateFloating;
      } else {
        if (hasText) {
          return MDCContainedInputViewPlaceholderStateFloating;
        } else {
          return MDCContainedInputViewPlaceholderStateNormal;
        }
      }
    } else {
      if (hasText) {
        return MDCContainedInputViewPlaceholderStateNone;
      } else {
        return MDCContainedInputViewPlaceholderStateNormal;
      }
    }
  } else {
    return MDCContainedInputViewPlaceholderStateNone;
  }
}

#pragma mark Accessors

- (void)setDensityInformer:(id<MDCContainedInputViewStyleDensityInforming>)densityInformer {
  _densityInformer = densityInformer;
}

- (id<MDCContainedInputViewStyleDensityInforming>)densityInformer {
  if (_densityInformer) {
    return _densityInformer;
  }
  return [[MDCContainerStyleBaseDensityInformer alloc] init];
}

- (CGFloat)floatingPlaceholderFontSizeScaleFactor {
  return 0.75;
}

@end

@implementation MDCContainerStyleBaseDensityInformer
@synthesize verticalDensity = _verticalDensity;

-(instancetype)init {
  self = [super init];
  if (self) {
    self.verticalDensity = 0.5;
  }
  return self;
}


- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight {
  return 10;
}

- (CGFloat)contentAreaVerticalPaddingNormalWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  return 20;
}

- (CGFloat)contentAreaTopPaddingFloatingPlaceholderWithFloatingPlaceholderMaxY:(CGFloat)floatingPlaceholderMaxY {
  return floatingPlaceholderMaxY + 10;
}

@end

// static const CGFloat kFloatingPlaceholderAnimationVelocityInPointsPerSecond = (CGFloat)200;

@interface MDCContainedInputViewPlaceholderManager ()
@property(nonatomic, assign) BOOL isAnimating;
@end

@implementation MDCContainedInputViewPlaceholderManager

- (UIFont *)floatingPlaceholderFontWithFont:(UIFont *)font
                             containerStyle:(id<MDCContainedInputViewStyle>)containerStyle {
  CGFloat scaleFactor = [containerStyle floatingPlaceholderFontSizeScaleFactor];
  CGFloat floatingPlaceholderFontSize = font.pointSize * scaleFactor;
  return [font fontWithSize:floatingPlaceholderFontSize];
}

- (void)layOutPlaceholderWithPlaceholderLabel:(UILabel *)placeholderLabel
                                        state:
                                            (MDCContainedInputViewPlaceholderState)placeholderState
                                  normalFrame:(CGRect)normalFrame
                                floatingFrame:(CGRect)floatingFrame
                                   normalFont:(UIFont *)normalFont
                                 floatingFont:(UIFont *)floatingFont {
  UIFont *targetFont = normalFont;
  CGRect targetFrame = normalFrame;
  BOOL placeholderShouldHide = NO;
  switch (placeholderState) {
    case MDCContainedInputViewPlaceholderStateFloating:
      targetFont = floatingFont;
      targetFrame = floatingFrame;
      break;
    case MDCContainedInputViewPlaceholderStateNormal:
      break;
    case MDCContainedInputViewPlaceholderStateNone:
      placeholderShouldHide = YES;
      break;
    default:
      break;
  }

  CGAffineTransform currentTransform = placeholderLabel.transform;
  CGAffineTransform targetTransform = CGAffineTransformIdentity;

  CGRect currentFrame = placeholderLabel.frame;
  if (self.isAnimating || CGRectEqualToRect(currentFrame, CGRectZero)) {
    placeholderLabel.transform = CGAffineTransformIdentity;
    placeholderLabel.frame = targetFrame;
    placeholderLabel.font = targetFont;
    return;
  } else if (!CGRectEqualToRect(currentFrame, targetFrame)) {
    targetTransform = [self transformFromRect:currentFrame toRect:targetFrame];
  }

  self.isAnimating = YES;
  placeholderLabel.hidden = placeholderShouldHide;

  //  CGFloat lowerMinY = MIN(CGRectGetMinY(currentFrame), CGRectGetMinY(targetFrame));
  //  CGFloat higherMinY = MAX(CGRectGetMinY(currentFrame), CGRectGetMinY(targetFrame));
  //  CGFloat distanceTravelled = higherMinY - lowerMinY;
  CGFloat animationDuration = 0.2;
  //      distanceTravelled / kFloatingPlaceholderAnimationVelocityInPointsPerSecond;

  __weak typeof(self) weakSelf = self;
  [CATransaction begin];
  {
    [CATransaction setCompletionBlock:^{
      placeholderLabel.transform = CGAffineTransformIdentity;
      placeholderLabel.frame = targetFrame;
      placeholderLabel.font = targetFont;
      weakSelf.isAnimating = NO;
    }];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue =
        [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(currentTransform)];
    animation.toValue =
        [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(targetTransform)];
    animation.duration = animationDuration;
    animation.removedOnCompletion = YES;
    placeholderLabel.transform = targetTransform;
    [placeholderLabel.layer addAnimation:animation forKey:animation.keyPath];
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

@end
