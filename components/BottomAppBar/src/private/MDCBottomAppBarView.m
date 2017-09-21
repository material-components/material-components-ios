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

#import "MDCBottomAppBarView.h"

#import "MDCBottomAppBarAttributes.h"
#import "MDCBottomAppBarLayer.h"
#import "MaterialRTL.h"

static NSString *kMDCBottomAppBarViewAnimKeyString = @"AnimKey";
static NSString *kMDCBottomAppBarViewEmptyString = @"";
static NSString *kMDCBottomAppBarViewPathString = @"path";
static NSString *kMDCBottomAppBarViewPositionString = @"position";

@interface MDCBottomAppBarCutView : UIView

@end

@implementation MDCBottomAppBarCutView

// Allows touch events to pass through so MDCBottomAppBarController can handle touch events.
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  return view == self ? nil : view;
}

@end

@interface MDCBottomAppBarView () <CAAnimationDelegate>

@property(nonatomic, assign) CGFloat bottomBarHeight;
@property(nonatomic, strong) MDCBottomAppBarCutView *cutView;
@property(nonatomic, strong) MDCBottomAppBarLayer *bottomBarLayer;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@end

@implementation MDCBottomAppBarView

- (void)setupBottomBarView {
  self.cutView = [[MDCBottomAppBarCutView alloc] initWithFrame:self.bounds];
  [self addSubview:self.cutView];
  self.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                           UIViewAutoresizingFlexibleLeftMargin |
                           UIViewAutoresizingFlexibleRightMargin);
  self.layoutDirection = self.mdc_effectiveUserInterfaceLayoutDirection;
  [self setFloatingButtonHidden:NO];
  [self addBottomBarLayer];
}

- (void)addBottomBarLayer {
  if (self.bottomBarLayer) {
    [self.bottomBarLayer removeFromSuperlayer];
  }
  self.bottomBarLayer = [MDCBottomAppBarLayer layer];
  [self.cutView.layer addSublayer:self.bottomBarLayer];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.floatingButton.center =
      [self getFloatingButtonCenterPositionForWidth:CGRectGetWidth(self.bounds)];
  [self renderPathBasedOnFloatingButtonVisibitlityAnimated:NO];
}

- (void)renderPathBasedOnFloatingButtonVisibitlityAnimated:(BOOL)animated {
  if (!self.floatingButtonHidden) {
    [self cutBottomAppBarViewAnimated:animated];
  } else {
    [self healBottomAppBarViewAnimated:animated];
  }
}

- (CGPoint)getFloatingButtonCenterPositionForWidth:(CGFloat)width {
  CGPoint floatingButtonPoint = CGPointZero;
  CGFloat halfDefaultDimension = CGRectGetMidX(self.floatingButton.bounds);
  CGFloat midX = width / 2;
  switch (self.floatingButtonPosition) {
    case MDCBottomAppBarFloatingButtonPositionLeading: {
      if (self.layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
        floatingButtonPoint = CGPointMake(kMDCBottomAppBarFloatingButtonPositionX,
                                          halfDefaultDimension);
      } else {
        floatingButtonPoint = CGPointMake(width - kMDCBottomAppBarFloatingButtonPositionX,
                                          halfDefaultDimension);
      }
      break;
    }
    case MDCBottomAppBarFloatingButtonPositionCenter: {
      floatingButtonPoint = CGPointMake(midX, halfDefaultDimension);
      break;
    }
    case MDCBottomAppBarFloatingButtonPositionTrailing: {
      if (self.layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
        floatingButtonPoint = CGPointMake(width - kMDCBottomAppBarFloatingButtonPositionX,
                                          halfDefaultDimension);
      } else {
        floatingButtonPoint = CGPointMake(kMDCBottomAppBarFloatingButtonPositionX,
                                          halfDefaultDimension);
      }
      break;
    }
    default:
      break;
  }
  return floatingButtonPoint;
}

- (void)cutBottomAppBarViewAnimated:(BOOL)animated {
  CGPathRef cutPath =
      [self.bottomBarLayer pathWithCutFromRect:self.bounds
                        floatingButtonPosition:self.floatingButtonPosition
                               layoutDirection:self.layoutDirection];
  if (animated) {
    CABasicAnimation *pathAnimation =
        [CABasicAnimation animationWithKeyPath:kMDCBottomAppBarViewPathString];
    pathAnimation.duration = kMDCFloatingButtonExitDuration;
    pathAnimation.fromValue = (id)self.bottomBarLayer.presentationLayer.path;
    pathAnimation.toValue = (__bridge id _Nullable)(cutPath);
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.delegate = self;
    [pathAnimation setValue:kMDCBottomAppBarViewPathString
                     forKey:kMDCBottomAppBarViewAnimKeyString];
    [self.bottomBarLayer addAnimation:pathAnimation forKey:kMDCBottomAppBarViewPathString];
  } else {
    self.bottomBarLayer.path = cutPath;
  }
}

- (void)healBottomAppBarViewAnimated:(BOOL)animated  {
  CGPathRef withoutCutPath =
      [self.bottomBarLayer pathWithoutCutFromRect:self.bounds
                           floatingButtonPosition:self.floatingButtonPosition
                                  layoutDirection:self.layoutDirection];
  if (animated) {
    CABasicAnimation *pathAnimation =
        [CABasicAnimation animationWithKeyPath:kMDCBottomAppBarViewPathString];
    pathAnimation.duration = kMDCFloatingButtonEnterDuration;
    pathAnimation.fromValue = (id)self.bottomBarLayer.presentationLayer.path;
    pathAnimation.toValue = (__bridge id _Nullable)(withoutCutPath);
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.delegate = self;
    [pathAnimation setValue:kMDCBottomAppBarViewPathString
                     forKey:kMDCBottomAppBarViewAnimKeyString];
    [self.bottomBarLayer addAnimation:pathAnimation forKey:kMDCBottomAppBarViewPathString];
  } else {
    self.bottomBarLayer.path = withoutCutPath;
  }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
  if (flag) {
    [self renderPathBasedOnFloatingButtonVisibitlityAnimated:NO];
    NSString *animValueForKeyString = [animation valueForKey:kMDCBottomAppBarViewAnimKeyString];
    if ([animValueForKeyString isEqualToString:kMDCBottomAppBarViewPathString]) {
      [self.bottomBarLayer removeAnimationForKey:kMDCBottomAppBarViewPathString];
    } else if ([animValueForKeyString isEqualToString:kMDCBottomAppBarViewPositionString]) {
      [self.floatingButton.layer removeAnimationForKey:kMDCBottomAppBarViewPositionString];
    }
  }
}

- (void)moveFloatingButtonCenterAnimated:(BOOL)animated {
  CGPoint endPoint = [self getFloatingButtonCenterPositionForWidth:CGRectGetWidth(self.bounds)];
  if (animated) {
    CABasicAnimation *animation =
        [CABasicAnimation animationWithKeyPath:kMDCBottomAppBarViewPositionString];
    animation.duration = kMDCFloatingButtonExitDuration;
    animation.fromValue = [NSValue valueWithCGPoint:self.floatingButton.center];
    animation.toValue = [NSValue valueWithCGPoint:endPoint];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [animation setValue:kMDCBottomAppBarViewPositionString
                 forKey:kMDCBottomAppBarViewAnimKeyString];
    [self.floatingButton.layer addAnimation:animation forKey:kMDCBottomAppBarViewPositionString];
  }
  self.floatingButton.center = endPoint;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

  // Make sure the floating button can always be tapped.
  BOOL contains = CGRectContainsPoint(self.floatingButton.frame, point);
  if (contains) {
    return self.floatingButton;
  }
  UIView *view = [super hitTest:point withEvent:event];
  return view;
}

#pragma mark - Setters

- (void)setFloatingButton:(MDCFloatingButton *)floatingButton {
  if (_floatingButton == floatingButton) {
    return;
  }
  [_floatingButton removeFromSuperview];
  _floatingButton = floatingButton;
  _floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [_floatingButton sizeToFit];
  [self insertSubview:_floatingButton atIndex:0];
}

- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition {
  [self setFloatingButtonPosition:floatingButtonPosition animated:NO];
}

- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition
                         animated:(BOOL)animated {
  _floatingButtonPosition = floatingButtonPosition;
  [self moveFloatingButtonCenterAnimated:animated];
  [self renderPathBasedOnFloatingButtonVisibitlityAnimated:animated];
}

- (void)setFloatingButtonHidden:(BOOL)floatingButtonHidden {
  [self setFloatingButtonHidden:floatingButtonHidden animated:NO];
}

- (void)setFloatingButtonHidden:(BOOL)floatingButtonHidden animated:(BOOL)animated {
  if (_floatingButtonHidden == floatingButtonHidden) {
    return;
  }
  _floatingButtonHidden = floatingButtonHidden;
  if (floatingButtonHidden) {
    [self healBottomAppBarViewAnimated:animated];
    [_floatingButton collapse:animated completion:^{
      _floatingButton.hidden = YES;
    }];
  } else {
    _floatingButton.hidden = NO;
    [self cutBottomAppBarViewAnimated:animated];
    [_floatingButton expand:animated completion:nil];
  }
}

@end
