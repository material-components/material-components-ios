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
#import "MDCTextControlState.h"
#import "MDCTextControl.h"
#import "UIBezierPath+MDCTextControlStyle.h"
#import "MDCTextControlVerticalPositioningReferenceUnderlined.h"

static const CGFloat kUnderlinedContainerStyleUnderlineThicknessNormal = 1.0f;
static const CGFloat kUnderlinedContainerStyleUnderlineThicknessEditing = 2.0f;

static const CGFloat kUnderlinedFloatingLabelScaleFactor = 0.75f;
static const CGFloat kUnderlinedHorizontalEdgePaddingDefault = 2;

@interface MDCTextControlStyleUnderlined () <CAAnimationDelegate>

@property(strong, nonatomic) CAShapeLayer *normalUnderlineLayer;
@property(strong, nonatomic) CAShapeLayer *editingUnderlineLayer;

@property(strong, nonatomic, readonly, class) NSString *editingUnderlineGrowKey;
@property(strong, nonatomic, readonly, class) NSString *editingUnderlineShrinkKey;
@property(strong, nonatomic, readonly, class) NSString *normalUnderlineGrowKey;
@property(strong, nonatomic, readonly, class) NSString *normalUnderlineShrinkKey;

@property(strong, nonatomic, readonly, class) NSString *editingUnderlineThicknessKey;
@property(strong, nonatomic, readonly, class) NSString *normalUnderlineThicknessKey;

@property(strong, nonatomic) NSMutableDictionary<NSNumber *, UIColor *> *underlineColors;

@property(nonatomic, assign) CGRect mostRecentBounds;
@property(nonatomic, assign) BOOL isEditing;
@property(nonatomic, assign) CGFloat containerHeight;
@property(nonatomic, assign) NSTimeInterval animationDuration;

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
  self.mostRecentBounds = CGRectZero;
  self.normalUnderlineThickness = kUnderlinedContainerStyleUnderlineThicknessNormal;
  self.editingUnderlineThickness = kUnderlinedContainerStyleUnderlineThicknessEditing;
  [self setUpUnderlineColors];
  [self setUpUnderlineSublayers];
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
  self.normalUnderlineLayer = [[CAShapeLayer alloc] init];
  self.editingUnderlineLayer = [[CAShapeLayer alloc] init];
}

#pragma mark Accessors

- (UIColor *)underlineColorForState:(MDCTextControlState)state {
  return self.underlineColors[@(state)];
}

- (void)setUnderlineColor:(nonnull UIColor *)underlineColor forState:(MDCTextControlState)state {
  self.underlineColors[@(state)] = underlineColor;
}

- (void)setEditingUnderlineThickness:(CGFloat)editingUnderlineThickness {
  [self setEditingUnderlineThickness:editingUnderlineThickness animated:NO];
}

- (void)setNormalUnderlineThickness:(CGFloat)normalUnderlineThickness {
  [self setNormalUnderlineThickness:normalUnderlineThickness animated:NO];
}

- (void)setEditingUnderlineThickness:(CGFloat)thickness animated:(BOOL)animated {
  _editingUnderlineThickness = thickness;

  UIBezierPath *targetUnderlineBezier = [self targetEditingUnderlineBezier];
  [self.editingUnderlineLayer removeAllAnimations];
  if (animated) {
    [CATransaction begin];
    [CATransaction setAnimationDuration:self.animationDuration];
    [self.editingUnderlineLayer addAnimation:[self pathAnimationTo:targetUnderlineBezier]
                                      forKey:self.class.editingUnderlineThicknessKey];
    [CATransaction commit];
  } else {
    self.editingUnderlineLayer.path = targetUnderlineBezier.CGPath;
  }
}

- (void)setNormalUnderlineThickness:(CGFloat)thickness animated:(BOOL)animated {
  _normalUnderlineThickness = thickness;

  UIBezierPath *targetUnderlineBezier = [self targetNormalUnderlineBezier];
  [self.normalUnderlineLayer removeAllAnimations];
  if (animated) {
    [CATransaction begin];
    [CATransaction setAnimationDuration:self.animationDuration];
    [self.normalUnderlineLayer addAnimation:[self pathAnimationTo:targetUnderlineBezier]
                                     forKey:self.class.normalUnderlineThicknessKey];
    [CATransaction commit];
  } else {
    self.normalUnderlineLayer.path = targetUnderlineBezier.CGPath;
  }
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
  [self.normalUnderlineLayer removeFromSuperlayer];
  [self.editingUnderlineLayer removeFromSuperlayer];
}

- (id<MDCTextControlVerticalPositioningReference>)
    positioningReferenceWithFloatingFontLineHeight:(CGFloat)floatingLabelHeight
                              normalFontLineHeight:(CGFloat)normalFontLineHeight
                                     textRowHeight:(CGFloat)textRowHeight
                                  numberOfTextRows:(CGFloat)numberOfTextRows
                                           density:(CGFloat)density
                          preferredContainerHeight:(CGFloat)preferredContainerHeight
                            isMultilineTextControl:(BOOL)isMultilineTextControl {
  return [[MDCTextControlVerticalPositioningReferenceUnderlined alloc]
      initWithFloatingFontLineHeight:floatingLabelHeight
                normalFontLineHeight:normalFontLineHeight
                       textRowHeight:textRowHeight
                    numberOfTextRows:numberOfTextRows
                             density:density
            preferredContainerHeight:preferredContainerHeight
              isMultilineTextControl:isMultilineTextControl];
}

- (UIFont *)floatingFontWithNormalFont:(UIFont *)font {
  CGFloat scaleFactor = kUnderlinedFloatingLabelScaleFactor;
  CGFloat floatingFontSize = font.pointSize * scaleFactor;
  return [font fontWithSize:floatingFontSize];
}

- (nonnull MDCTextControlHorizontalPositioningReference *)horizontalPositioningReference {
  MDCTextControlHorizontalPositioningReference *positioningReference =
      [[MDCTextControlHorizontalPositioningReference alloc] init];
  positioningReference.leadingEdgePadding = kUnderlinedHorizontalEdgePaddingDefault;
  positioningReference.trailingEdgePadding = kUnderlinedHorizontalEdgePaddingDefault;
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

  self.containerHeight = CGRectGetMaxY(containerFrame);
  self.isEditing = state == MDCTextControlStateEditing;
  self.animationDuration = animationDuration;

  self.normalUnderlineLayer.fillColor = [self.underlineColors[@(state)] CGColor];
  self.editingUnderlineLayer.fillColor = [self.underlineColors[@(state)] CGColor];

  BOOL styleIsBeingAppliedToView = NO;
  if (self.editingUnderlineLayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.editingUnderlineLayer atIndex:0];
    styleIsBeingAppliedToView = YES;
  }
  if (self.normalUnderlineLayer.superlayer != view.layer) {
    [view.layer insertSublayer:self.normalUnderlineLayer atIndex:0];
    styleIsBeingAppliedToView = YES;
  }

  UIBezierPath *targetEditingUnderlineBezier = [self targetEditingUnderlineBezier];
  UIBezierPath *targetNormalUnderlineBezier = [self targetNormalUnderlineBezier];
  if (animationDuration <= 0 || styleIsBeingAppliedToView || didChangeBounds) {
    [self.normalUnderlineLayer removeAllAnimations];
    [self.editingUnderlineLayer removeAllAnimations];
    self.normalUnderlineLayer.path = targetNormalUnderlineBezier.CGPath;
    self.editingUnderlineLayer.path = targetEditingUnderlineBezier.CGPath;
    return;
  }

  CABasicAnimation *preexistingEditingUnderlineShrinkAnimation =
      (CABasicAnimation *)[self.editingUnderlineLayer
          animationForKey:self.class.editingUnderlineShrinkKey];
  CABasicAnimation *preexistingEditingUnderlineGrowAnimation =
      (CABasicAnimation *)[self.editingUnderlineLayer
          animationForKey:self.class.editingUnderlineGrowKey];

  CABasicAnimation *preexistingNormalUnderlineGrowAnimation =
      (CABasicAnimation *)[self.normalUnderlineLayer
          animationForKey:self.class.normalUnderlineGrowKey];
  CABasicAnimation *preexistingNormalUnderlineShrinkAnimation =
      (CABasicAnimation *)[self.normalUnderlineLayer
          animationForKey:self.class.normalUnderlineShrinkKey];

  [CATransaction begin];
  {
    [CATransaction setAnimationDuration:animationDuration];

    if (self.isEditing) {
      if (preexistingEditingUnderlineShrinkAnimation) {
        [self.editingUnderlineLayer removeAnimationForKey:self.class.editingUnderlineShrinkKey];
      }
      BOOL needsEditingUnderlineGrowAnimation = NO;
      if (preexistingEditingUnderlineGrowAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingEditingUnderlineGrowAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetEditingUnderlineBezier.CGPath)) {
          [self.editingUnderlineLayer removeAnimationForKey:self.class.editingUnderlineGrowKey];
          needsEditingUnderlineGrowAnimation = YES;
          self.editingUnderlineLayer.path = targetEditingUnderlineBezier.CGPath;
        }
      } else {
        needsEditingUnderlineGrowAnimation = YES;
      }
      if (needsEditingUnderlineGrowAnimation) {
        [self.editingUnderlineLayer addAnimation:[self pathAnimationTo:targetEditingUnderlineBezier]
                                          forKey:self.class.editingUnderlineGrowKey];
      }

      if (preexistingNormalUnderlineGrowAnimation) {
        [self.normalUnderlineLayer removeAnimationForKey:self.class.normalUnderlineGrowKey];
      }
      BOOL needsNormalUnderlineShrinkAnimation = NO;
      if (preexistingNormalUnderlineShrinkAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingNormalUnderlineShrinkAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetNormalUnderlineBezier.CGPath)) {
          [self.normalUnderlineLayer removeAnimationForKey:self.class.normalUnderlineShrinkKey];
          needsNormalUnderlineShrinkAnimation = YES;
          self.normalUnderlineLayer.path = targetNormalUnderlineBezier.CGPath;
        }
      } else {
        needsNormalUnderlineShrinkAnimation = YES;
      }
      if (needsNormalUnderlineShrinkAnimation) {
        [self.normalUnderlineLayer addAnimation:[self pathAnimationTo:targetNormalUnderlineBezier]
                                         forKey:self.class.normalUnderlineShrinkKey];
      }

    } else {
      if (preexistingEditingUnderlineGrowAnimation) {
        [self.editingUnderlineLayer removeAnimationForKey:self.class.editingUnderlineGrowKey];
      }
      BOOL needsEditingUnderlineShrinkAnimation = NO;
      if (preexistingEditingUnderlineShrinkAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingEditingUnderlineShrinkAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetEditingUnderlineBezier.CGPath)) {
          [self.editingUnderlineLayer removeAnimationForKey:self.class.editingUnderlineShrinkKey];
          needsEditingUnderlineShrinkAnimation = YES;
          self.editingUnderlineLayer.path = targetEditingUnderlineBezier.CGPath;
        }
      } else {
        needsEditingUnderlineShrinkAnimation = YES;
      }
      if (needsEditingUnderlineShrinkAnimation) {
        [self.editingUnderlineLayer addAnimation:[self pathAnimationTo:targetEditingUnderlineBezier]
                                          forKey:self.class.editingUnderlineShrinkKey];
      }

      if (preexistingNormalUnderlineShrinkAnimation) {
        [self.normalUnderlineLayer removeAnimationForKey:self.class.normalUnderlineShrinkKey];
      }
      BOOL needsEditingUnderlineGrowAnimation = NO;
      if (preexistingNormalUnderlineGrowAnimation) {
        CGPathRef toValue = (__bridge CGPathRef)preexistingNormalUnderlineGrowAnimation.toValue;
        if (!CGPathEqualToPath(toValue, targetNormalUnderlineBezier.CGPath)) {
          [self.normalUnderlineLayer removeAnimationForKey:self.class.normalUnderlineGrowKey];
          needsEditingUnderlineGrowAnimation = YES;
          self.normalUnderlineLayer.path = targetNormalUnderlineBezier.CGPath;
        }
      } else {
        needsEditingUnderlineGrowAnimation = YES;
      }
      if (needsEditingUnderlineGrowAnimation) {
        [self.normalUnderlineLayer addAnimation:[self pathAnimationTo:targetNormalUnderlineBezier]
                                         forKey:self.class.normalUnderlineGrowKey];
      }
    }
  }
  [CATransaction commit];
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

  CABasicAnimation *thickGrowAnimation = (CABasicAnimation *)[self.editingUnderlineLayer
      animationForKey:self.class.editingUnderlineGrowKey];
  CABasicAnimation *thickShrinkAnimation = (CABasicAnimation *)[self.editingUnderlineLayer
      animationForKey:self.class.editingUnderlineShrinkKey];
  CABasicAnimation *thinGrowAnimation = (CABasicAnimation *)[self.normalUnderlineLayer
      animationForKey:self.class.normalUnderlineGrowKey];
  CABasicAnimation *thinShrinkAnimation = (CABasicAnimation *)[self.normalUnderlineLayer
      animationForKey:self.class.normalUnderlineShrinkKey];

  CABasicAnimation *editingUnderlineAnimation = (CABasicAnimation *)[self.editingUnderlineLayer
      animationForKey:self.class.editingUnderlineThicknessKey];
  CABasicAnimation *normalUnderlineAnimation = (CABasicAnimation *)[self.normalUnderlineLayer
      animationForKey:self.class.normalUnderlineThicknessKey];

  if (flag) {
    if ((animation == thickGrowAnimation) || (animation == thickShrinkAnimation)) {
      self.editingUnderlineLayer.path = toValue;
    }
    if ((animation == thinGrowAnimation) || (animation == thinShrinkAnimation)) {
      self.normalUnderlineLayer.path = toValue;
    }
    if (animation == editingUnderlineAnimation) {
      self.editingUnderlineLayer.path = toValue;
    }
    if (animation == normalUnderlineAnimation) {
      self.normalUnderlineLayer.path = toValue;
    }
  }
}

+ (NSString *)normalUnderlineShrinkKey {
  return @"normalUnderlineShrinkKey";
}

+ (NSString *)normalUnderlineGrowKey {
  return @"normalUnderlineGrowKey";
}

+ (NSString *)editingUnderlineShrinkKey {
  return @"editingUnderlineShrinkKey";
}

+ (NSString *)editingUnderlineGrowKey {
  return @"editingUnderlineGrowKey";
}

+ (NSString *)normalUnderlineThicknessKey {
  return @"normalUnderlineThicknessKey";
}

+ (NSString *)editingUnderlineThicknessKey {
  return @"editingUnderlineThicknessKey";
}

#pragma mark Path Drawing

- (UIBezierPath *)targetEditingUnderlineBezier {
  CGFloat editingUnderlineWidth = self.isEditing ? CGRectGetWidth(self.mostRecentBounds) : 0;
  CGFloat editingUnderlineThickness = self.isEditing ? self.editingUnderlineThickness : 0;
  UIBezierPath *targetEditingUnderlineBezier =
      [self underlinePathWithViewBounds:self.mostRecentBounds
                        containerHeight:self.containerHeight
                     underlineThickness:editingUnderlineThickness
                         underlineWidth:editingUnderlineWidth];
  return targetEditingUnderlineBezier;
}

- (UIBezierPath *)targetNormalUnderlineBezier {
  CGFloat normalUnderlineThickness = self.isEditing ? 0 : self.normalUnderlineThickness;
  UIBezierPath *targetNormalUnderlineBezier =
      [self underlinePathWithViewBounds:self.mostRecentBounds
                        containerHeight:self.containerHeight
                     underlineThickness:normalUnderlineThickness
                         underlineWidth:CGRectGetWidth(self.mostRecentBounds)];
  return targetNormalUnderlineBezier;
}

- (UIBezierPath *)underlinePathWithViewBounds:(CGRect)viewBounds
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
