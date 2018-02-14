/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <CoreGraphics/CoreGraphics.h>

#import "MDCBottomAppBarView.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialNavigationBar.h"
#import "private/MDCBottomAppBarAttributes.h"
#import "private/MDCBottomAppBarLayer.h"

static NSString *kMDCBottomAppBarViewAnimKeyString = @"AnimKey";
static NSString *kMDCBottomAppBarViewPathString = @"path";
static NSString *kMDCBottomAppBarViewPositionString = @"position";
static const CGFloat kMDCBottomAppBarViewFloatingButtonElevationPrimary = 6.f;
static const CGFloat kMDCBottomAppBarViewFloatingButtonElevationSecondary = 4.f;
static const int kMDCButtonAnimationDuration = 200;

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
@property(nonatomic, strong) MDCNavigationBar *navBar;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@end

@implementation MDCBottomAppBarView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomAppBarViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomAppBarViewInit];
  }
  return self;
}

- (void)commonMDCBottomAppBarViewInit {
  self.cutView = [[MDCBottomAppBarCutView alloc] initWithFrame:self.bounds];
  [self addSubview:self.cutView];
  self.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                           UIViewAutoresizingFlexibleLeftMargin |
                           UIViewAutoresizingFlexibleRightMargin);
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  [self addFloatingButton];
  [self addBottomBarLayer];
  [self addNavBar];
}

- (void)addFloatingButton {
  MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
  [self setFloatingButton:floatingButton];
  [self setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionCenter];
  [self setFloatingButtonElevation:MDCBottomAppBarFloatingButtonElevationPrimary];
  [self setFloatingButtonHidden:NO];
}

- (void)addNavBar {
  _navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  [self addSubview:_navBar];

  _navBar.backgroundColor = [UIColor clearColor];
  _navBar.tintColor = [UIColor blackColor];
}

- (void)addBottomBarLayer {
  if (_bottomBarLayer) {
    [_bottomBarLayer removeFromSuperlayer];
  }
  _bottomBarLayer = [MDCBottomAppBarLayer layer];
  [_cutView.layer addSublayer:_bottomBarLayer];
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

- (void)showBarButtonItemsWithFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition {
  switch (floatingButtonPosition) {
    case MDCBottomAppBarFloatingButtonPositionCenter:
      [self.navBar setLeadingBarButtonItems:_leadingBarButtonItems];
      [self.navBar setTrailingBarButtonItems:_trailingBarButtonItems];
      break;
    case MDCBottomAppBarFloatingButtonPositionLeading:
      [self.navBar setLeadingBarButtonItems:nil];
      [self.navBar setTrailingBarButtonItems:_trailingBarButtonItems];
      break;
    case MDCBottomAppBarFloatingButtonPositionTrailing:
      [self.navBar setLeadingBarButtonItems:_leadingBarButtonItems];
      [self.navBar setTrailingBarButtonItems:nil];
      break;
    default:
      break;
  }
}

#pragma mark - UIView overrides

- (void)layoutSubviews {
  [super layoutSubviews];
  self.floatingButton.center =
      [self getFloatingButtonCenterPositionForWidth:CGRectGetWidth(self.bounds)];
  [self renderPathBasedOnFloatingButtonVisibitlityAnimated:NO];

  CGRect navBarFrame = CGRectMake(0,
                                  kMDCBottomAppBarYOffset,
                                  CGRectGetWidth(self.bounds),
                                  kMDCBottomAppBarHeight - kMDCBottomAppBarYOffset);
  self.navBar.frame = navBarFrame;
}

- (UIEdgeInsets)mdc_safeAreaInsets {
  UIEdgeInsets insets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {

    // Accommodate insets for iPhone X.
    insets = self.safeAreaInsets;
  }
#endif
  return insets;
}

- (CGSize)sizeThatFits:(CGSize)size {
  UIEdgeInsets insets = self.mdc_safeAreaInsets;
  CGFloat heightWithInset = kMDCBottomAppBarHeight + insets.bottom;
  CGSize insetSize = CGSizeMake(size.width, heightWithInset);
  return insetSize;
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

#pragma mark - CAAnimationDelegate

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

#pragma mark - Setters

- (void)setFloatingButton:(MDCFloatingButton *)floatingButton {
  if (_floatingButton == floatingButton) {
    return;
  }
  [_floatingButton removeFromSuperview];
  _floatingButton = floatingButton;
  _floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [_floatingButton sizeToFit];
}

- (void)setFloatingButtonElevation:(MDCBottomAppBarFloatingButtonElevation)floatingButtonElevation {
  [self setFloatingButtonElevation:floatingButtonElevation animated:NO];
}

- (void)setFloatingButtonElevation:(MDCBottomAppBarFloatingButtonElevation)floatingButtonElevation
                          animated:(BOOL)animated {
  if (_floatingButton.superview == self && _floatingButtonElevation == floatingButtonElevation) {
    return;
  }
  _floatingButtonElevation = floatingButtonElevation;

  CGFloat elevation = kMDCBottomAppBarViewFloatingButtonElevationPrimary;
  NSInteger subViewIndex = 1;
  if (floatingButtonElevation == MDCBottomAppBarFloatingButtonElevationSecondary) {
    elevation = kMDCBottomAppBarViewFloatingButtonElevationSecondary;
    subViewIndex = 0;
  }
  if (animated) {
    [_floatingButton setElevation:1 forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kMDCButtonAnimationDuration * NSEC_PER_MSEC),
                   dispatch_get_main_queue(), ^{
                     [self insertSubview:self.floatingButton atIndex:subViewIndex];
                     [self.floatingButton setElevation:elevation forState:UIControlStateNormal];
                   });
  } else {
    [self insertSubview:_floatingButton atIndex:subViewIndex];
    [_floatingButton setElevation:elevation forState:UIControlStateNormal];
  }
}

- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition {
  [self setFloatingButtonPosition:floatingButtonPosition animated:NO];
}

- (void)setFloatingButtonPosition:(MDCBottomAppBarFloatingButtonPosition)floatingButtonPosition
                         animated:(BOOL)animated {
  if (_floatingButtonPosition == floatingButtonPosition) {
    return;
  }
  _floatingButtonPosition = floatingButtonPosition;
  [self moveFloatingButtonCenterAnimated:animated];
  [self renderPathBasedOnFloatingButtonVisibitlityAnimated:animated];
  [self showBarButtonItemsWithFloatingButtonPosition:floatingButtonPosition];
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
      self.floatingButton.hidden = YES;
    }];
  } else {
    _floatingButton.hidden = NO;
    [self cutBottomAppBarViewAnimated:animated];
    [_floatingButton expand:animated completion:nil];
  }
}

- (void)setLeadingBarButtonItems:(NSArray<UIBarButtonItem *> *)leadingBarButtonItems {
  _leadingBarButtonItems = [leadingBarButtonItems copy];
  [self showBarButtonItemsWithFloatingButtonPosition:self.floatingButtonPosition];
}

- (void)setTrailingBarButtonItems:(NSArray<UIBarButtonItem *> *)trailingBarButtonItems {
  _trailingBarButtonItems = [trailingBarButtonItems copy];
  [self showBarButtonItemsWithFloatingButtonPosition:self.floatingButtonPosition];
}

@end
