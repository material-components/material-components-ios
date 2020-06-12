// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTextControlStyleUnderlined.h"

#import <Foundation/Foundation.h>

#include "MaterialAvailability.h"
#import "MDCTextControl.h"
#import "UIBezierPath+MDCTextControlStyle.h"
#import "MDCTextControlVerticalPositioningReferenceUnderlined.h"

static const CGFloat kUnderlinedContainerStyleUnderlineWidthThin = 1.0f;
static const CGFloat kUnderlinedContainerStyleUnderlineWidthThick = 2.0f;

static const CGFloat kUnderlinedFloatingLabelScaleFactor = 0.75f;
static const CGFloat kUnderlinedHorizontalEdgePaddingDefault = 2;

@interface MDCTextControlStyleUnderlined () <CAAnimationDelegate>

@property(strong, nonatomic) CAShapeLayer *thinUnderlineLayer;
@property(strong, nonatomic) CAShapeLayer *thickUnderlineLayer;

@property(strong, nonatomic, readonly, class) NSString *thickUnderlineGrowKey;
@property(strong, nonatomic, readonly, class) NSString *thickUnderlineShrinkKey;
@property(strong, nonatomic, readonly, class) NSString *thinUnderlineGrowKey;
@property(strong, nonatomic, readonly, class) NSString *thinUnderlineShrinkKey;

@property(strong, nonatomic) NSMutableDictionary<NSNumber *, UIColor *> *underlineColors;

@property(nonatomic, assign) CGRect mostRecentBounds;

@end

@implementation MDCTextControlStyleUnderlined

#pragma mark Object Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCTextControlStyleUnderlinedInit];
  }
  return self;
}

#pragma mark Setup

- (void)commonMDCTextControlStyleUnderlinedInit {
  [self setUpUnderlineColors];
  [self setUpUnderlineSublayers];
  self.mostRecentBounds = CGRectZero;
}

- (void)setUpUnderlineColors {
  self.underlineColors = [[NSMutableDictionary alloc] init];
  UIColor *underlineColor = UIColor.blackColor;
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    underlineColor = UIColor.labelColor;
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  self.underlineColors[@(MDCTextControlStateNormal)] = underlineColor;
  self.underlineColors[@(MDCTextControlStateEditing)] = underlineColor;
  self.underlineColors[@(MDCTextControlStateDisabled)] = underlineColor;
}

- (void)setUpUnderlineSublayers {
  self.thinUnderlineLayer = [[CAShapeLayer alloc] init];
  self.thickUnderlineLayer = [[CAShapeLayer alloc] init];
}

#pragma mark Accessors

- (UIColor *)underlineColorForState:(MDCTextControlState)state {
  return self.underlineColors[@(state)];
}

- (void)setUnderlineColor:(nonnull UIColor *)underlineColor forState:(MDCTextControlState)state {
  self.underlineColors[@(state)] = underlineColor;
}

#pragma mark MDCTextControl

- (void)applyStyleToTextControl:(UIView<MDCTextControl> *)textControl
              animationDuration:(NSTimeInterval)animationDuration {
  [self applyUnderlineStyleToView:textControl
                            state:textControl.textControlState
                   containerFrame:textControl.containerFrame
                animationDuration:animationDuration];
}

- (void)removeStyleFrom:(id<MDCTextControl>)textControl {
  [self.thinUnderlineLayer removeFromSuperlayer];
  [self.thickUnderlineLayer removeFromSuperlayer];
}

- (id<MDCTextControlVerticalPositioningReference>)
    positioningReferenceWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                              normalFontLineHeight:(CGFloat)normalFontLineHeight
                                     textRowHeight:(CGFloat)textRowHeight
                                  numberOfTextRows:(CGFloat)numberOfTextRows
                                           density:(CGFloat)density
                          preferredContainerHeight:(CGFloat)preferredContainerHeight {
  return [[MDCTextControlVerticalPositioningReferenceUnderlined alloc]
      initWithFloatingFontLineHeight:floatingLabelHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight];
}

- (UIFont *)floatingFontWithNormalFont:(UIFont *)font {
  CGFloat scaleFactor = kUnderlinedFloatingLabelScaleFactor;
  CGFloat floatingFontSize = font.pointSize * scaleFactor;
  return [font fontWithSize:floatingFontSize];
}

- (nonnull MDCTextControlHorizontalPositioningReference *)horizontalPositioningReference {
  MDCTextControlHorizontalPositioningReference *positioningReference =
      [[MDCTextControlHorizontalPositioningReference alloc] init];
  positioningReference.horizontalEdgePadding = kUnderlinedHorizontalEdgePaddingDefault;
  return positioningReference;
}

#pragma mark Custom Styling

- (void)applyUnderlineStyleToView:(UIView *)view
                            state:(MDCTextControlState)state
                   containerFrame:(CGRect)containerFrame
                animationDuration:(NSTimeInterval)animationDuration {
  BOOL didChangeBounds = NO;
  if (!CGRectEqualToRect(self.mostRecentBounds, view.bounds)) {
    didChangeBounds = YES;
    self.mostRecentBounds = view.bounds;
  }

  self.thinUnderlineLayer.fillColor = [self.underlineColors[@(state)] CGColor];
  self.thickUnderlineLayer.fillColor = [self.underlineColors[@(state)] CGColor];

  CGFloat containerHeight = CGRectGetMaxY(containerFrame);

  BOOL styleIsBeingAppliedToView = NO;
  if (self.thickUnderlineLayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.thickUnderlineLayer atIndex:0];
    styleIsBeingAppliedToView = YES;
  }
  if (self.thinUnderlineLayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.thinUnderlineLayer atIndex:0];
    styleIsBeingAppliedToView = YES;
  }

  BOOL shouldShowThickUnderline = [self shouldShowThickUnderlineWithState:state];
  CGFloat viewWidth = CGRectGetWidth(view.bounds);
  CGFloat thickUnderlineThickness = shouldShowThickUnderline ? viewWidth : 0;
  UIBezierPath *targetThickUnderlineBezier =
      [self filledSublayerUnderlinePathWithViewBounds:view.bounds
                                      containerHeight:containerHeight
                                   underlineThickness:kUnderlinedContainerStyleUnderlineWidthThick
                                       underlineWidth:thickUnderlineThickness];
  CGFloat thinUnderlineThickness =
      shouldShowThickUnderline ? 0 : kUnderlinedContainerStyleUnderlineWidthThin;
  UIBezierPath *targetThinUnderlineBezier =
      [self filledSublayerUnderlinePathWithViewBounds:view.bounds
                                      containerHeight:containerHeight
                                   underlineThickness:thinUnderlineThickness
                                       underlineWidth:viewWidth];

  if (animationDuration <= 0 || styleIsBeingAppliedToView || didChangeBounds) {
    [self.thinUnderlineLayer removeAllAnimations];
    [self.thickUnderlineLayer removeAllAnimations];
    self.thinUnderlineLayer.path = targetThinUnderlineBezier.CGPath;
    self.thickUnderlineLayer.path = targetThickUnderlineBezier.CGPath;
    return;
  }

  CABasicAnimation *preexistingThickUnderlineShrinkAnimation =
      (CABasicAnimation *)[self.thickUnderlineLayer
          animationForKey:self.class.thickUnderlineShrinkKey];
  CABasicAnimation *preexistingThickUnderlineGrowAnimation =
      (CABasicAnimation *)[self.thickUnderlineLayer
          animationForKey:self.class.thickUnderlineGrowKey];

  CABasicAnimation *preexistingThinUnderlineGrowAnimation =
      (CABasicAnimation *)[self.thinUnderlineLayer animationForKey:self.class.thinUnderlineGrowKey];
  CABasicAnimation *preexistingThinUnderlineShrinkAnimation =
      (CABasicAnimation *)[self.thinUnderlineLayer
          animationForKey:self.class.thinUnderlineShrinkKey];

  [CATransaction begin];
  {
    [CATransaction setAnimationDuration:animationDuration];

    if (shouldShowThickUnderline) {
      if (preexistingThickUnderlineShrinkAnimation) {
        [self.thickUnderlineLayer removeAnimationForKey:self.class.thickUnderlineShrinkKey];
      }
      BOOL needsThickUnderlineGrowAnimation = NO;
      if (preexistingThickUnderlineGrowAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingThickUnderlineGrowAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetThickUnderlineBezier.CGPath)) {
          [self.thickUnderlineLayer removeAnimationForKey:self.class.thickUnderlineGrowKey];
          needsThickUnderlineGrowAnimation = YES;
          self.thickUnderlineLayer.path = targetThickUnderlineBezier.CGPath;
        }
      } else {
        needsThickUnderlineGrowAnimation = YES;
      }
      if (needsThickUnderlineGrowAnimation) {
        [self.thickUnderlineLayer addAnimation:[self pathAnimationTo:targetThickUnderlineBezier]
                                        forKey:self.class.thickUnderlineGrowKey];
      }

      if (preexistingThinUnderlineGrowAnimation) {
        [self.thinUnderlineLayer removeAnimationForKey:self.class.thinUnderlineGrowKey];
      }
      BOOL needsThinUnderlineShrinkAnimation = NO;
      if (preexistingThinUnderlineShrinkAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingThinUnderlineShrinkAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetThinUnderlineBezier.CGPath)) {
          [self.thinUnderlineLayer removeAnimationForKey:self.class.thinUnderlineShrinkKey];
          needsThinUnderlineShrinkAnimation = YES;
          self.thinUnderlineLayer.path = targetThinUnderlineBezier.CGPath;
        }
      } else {
        needsThinUnderlineShrinkAnimation = YES;
      }
      if (needsThinUnderlineShrinkAnimation) {
        [self.thinUnderlineLayer addAnimation:[self pathAnimationTo:targetThinUnderlineBezier]
                                       forKey:self.class.thinUnderlineShrinkKey];
      }

    } else {
      if (preexistingThickUnderlineGrowAnimation) {
        [self.thickUnderlineLayer removeAnimationForKey:self.class.thickUnderlineGrowKey];
      }
      BOOL needsThickUnderlineShrinkAnimation = NO;
      if (preexistingThickUnderlineShrinkAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingThickUnderlineShrinkAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetThickUnderlineBezier.CGPath)) {
          [self.thickUnderlineLayer removeAnimationForKey:self.class.thickUnderlineShrinkKey];
          needsThickUnderlineShrinkAnimation = YES;
          self.thickUnderlineLayer.path = targetThickUnderlineBezier.CGPath;
        }
      } else {
        needsThickUnderlineShrinkAnimation = YES;
      }
      if (needsThickUnderlineShrinkAnimation) {
        [self.thickUnderlineLayer addAnimation:[self pathAnimationTo:targetThickUnderlineBezier]
                                        forKey:self.class.thickUnderlineShrinkKey];
      }

      if (preexistingThinUnderlineShrinkAnimation) {
        [self.thinUnderlineLayer removeAnimationForKey:self.class.thinUnderlineShrinkKey];
      }
      BOOL needsThickUnderlineGrowAnimation = NO;
      if (preexistingThinUnderlineGrowAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingThinUnderlineGrowAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetThinUnderlineBezier.CGPath)) {
          [self.thinUnderlineLayer removeAnimationForKey:self.class.thinUnderlineGrowKey];
          needsThickUnderlineGrowAnimation = YES;
          self.thinUnderlineLayer.path = targetThinUnderlineBezier.CGPath;
        }
      } else {
        needsThickUnderlineGrowAnimation = YES;
      }
      if (needsThickUnderlineGrowAnimation) {
        [self.thinUnderlineLayer addAnimation:[self pathAnimationTo:targetThinUnderlineBezier]
                                       forKey:self.class.thinUnderlineGrowKey];
      }
    }
  }
  [CATransaction commit];
}

- (BOOL)shouldShowThickUnderlineWithState:(MDCTextControlState)state {
  BOOL shouldShow = NO;
  switch (state) {
    case MDCTextControlStateEditing:
      shouldShow = YES;
      break;
    case MDCTextControlStateNormal:
    case MDCTextControlStateDisabled:
    default:
      break;
  }
  return shouldShow;
}

#pragma mark Animation

- (CABasicAnimation *)pathAnimationTo:(UIBezierPath *)path {
  CABasicAnimation *animation = [self basicAnimationWithKeyPath:@"path"];
  animation.toValue = (id)(path.CGPath);
  return animation;
}

- (CABasicAnimation *)basicAnimationWithKeyPath:(NSString *)keyPath {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
  animation.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.repeatCount = 0;
  animation.removedOnCompletion = NO;
  animation.delegate = self;
  animation.fillMode = kCAFillModeForwards;
  return animation;
}

- (void)animationDidStart:(CAAnimation *)anim {
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  if (![anim isKindOfClass:[CABasicAnimation class]]) {
    return;
  }

  CABasicAnimation *animation = (CABasicAnimation *)anim;
  CGPathRef toValue = (__bridge CGPathRef)animation.toValue;

  CABasicAnimation *thickGrowAnimation = (CABasicAnimation *)[self.thickUnderlineLayer
      animationForKey:self.class.thickUnderlineGrowKey];
  CABasicAnimation *thickShrinkAnimation = (CABasicAnimation *)[self.thickUnderlineLayer
      animationForKey:self.class.thickUnderlineShrinkKey];
  CABasicAnimation *thinGrowAnimation =
      (CABasicAnimation *)[self.thinUnderlineLayer animationForKey:self.class.thinUnderlineGrowKey];
  CABasicAnimation *thinShrinkAnimation = (CABasicAnimation *)[self.thinUnderlineLayer
      animationForKey:self.class.thinUnderlineShrinkKey];

  if (flag) {
    if ((animation == thickGrowAnimation) || (animation == thickShrinkAnimation)) {
      self.thickUnderlineLayer.path = toValue;
    }
    if ((animation == thinGrowAnimation) || (animation == thinShrinkAnimation)) {
      self.thinUnderlineLayer.path = toValue;
    }
  }
}

+ (NSString *)thinUnderlineShrinkKey {
  return @"thinUnderlineShrinkKey";
}
+ (NSString *)thinUnderlineGrowKey {
  return @"thinUnderlineGrowKey";
}
+ (NSString *)thickUnderlineShrinkKey {
  return @"thickUnderlineShrinkKey";
}
+ (NSString *)thickUnderlineGrowKey {
  return @"thickUnderlineGrowKey";
}

#pragma mark Path Drawing

- (UIBezierPath *)filledSublayerUnderlinePathWithViewBounds:(CGRect)viewBounds
                                            containerHeight:(CGFloat)containerHeight
                                         underlineThickness:(CGFloat)underlineThickness
                                             underlineWidth:(CGFloat)underlineWidth {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat viewWidth = CGRectGetWidth(viewBounds);
  CGFloat halfViewWidth = 0.5f * viewWidth;
  CGFloat halfUnderlineWidth = underlineWidth * 0.5f;
  CGFloat sublayerMinX = halfViewWidth - halfUnderlineWidth;
  CGFloat sublayerMaxX = sublayerMinX + underlineWidth;
  CGFloat sublayerMaxY = containerHeight;
  CGFloat sublayerMinY = sublayerMaxY - underlineThickness;

  CGPoint startingPoint = CGPointMake(sublayerMinX, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(sublayerMaxX, sublayerMinY);
  [path moveToPoint:startingPoint];
  [path addLineToPoint:topRightCornerPoint1];

  CGPoint topRightCornerPoint2 = CGPointMake(sublayerMaxX, sublayerMinY);
  [path mdc_addTopRightCornerFromPoint:topRightCornerPoint1
                               toPoint:topRightCornerPoint2
                            withRadius:0];

  CGPoint bottomRightCornerPoint1 = CGPointMake(sublayerMaxX, sublayerMaxY);
  CGPoint bottomRightCornerPoint2 = CGPointMake(sublayerMaxX, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [path mdc_addBottomRightCornerFromPoint:bottomRightCornerPoint1
                                  toPoint:bottomRightCornerPoint2
                               withRadius:0];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(sublayerMinX, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(sublayerMinX, sublayerMaxY);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [path mdc_addBottomLeftCornerFromPoint:bottomLeftCornerPoint1
                                 toPoint:bottomLeftCornerPoint2
                              withRadius:0];

  CGPoint topLeftCornerPoint1 = CGPointMake(sublayerMinX, sublayerMinY);
  CGPoint topLeftCornerPoint2 = CGPointMake(sublayerMinX, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [path mdc_addTopLeftCornerFromPoint:topLeftCornerPoint1 toPoint:topLeftCornerPoint2 withRadius:0];

  return path;
}

@end
