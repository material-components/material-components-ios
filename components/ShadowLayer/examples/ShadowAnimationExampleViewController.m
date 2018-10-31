// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "ShadowAnimationExampleViewController.h"

#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialShadowLayer.h"
#import "MaterialAnimationTiming.h"

static const CGFloat kAnimationDuration = (CGFloat)2.0;
static const CGFloat kStartCornerRadius = (CGFloat)0.001;
static const CGFloat kEndCornerRadius = (CGFloat)20.0;

@interface MDCShadowLayer (CustomAnimation)

@property(nonatomic, strong) CAShapeLayer *topShadow;
@property(nonatomic, strong) CAShapeLayer *bottomShadow;
@property(nonatomic, strong) CAShapeLayer *topShadowMask;
@property(nonatomic, strong) CAShapeLayer *bottomShadowMask;
+ (CGSize)shadowSpreadForElevation:(CGFloat)elevation;

@end

@interface CustomView : UIView

@end

@implementation CustomView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (MDCShadowLayer *)shadowLayer {
  return (MDCShadowLayer *)self.layer;
}

- (void)setElevation:(CGFloat)points {
  [(MDCShadowLayer *)self.layer setElevation:points];
}

@end

@interface ShadowAnimationExampleViewController ()

@property(nonatomic, strong, nullable) CustomView *customView;
@property(nonatomic, strong, nullable) MDCButton *button;

@end

@implementation ShadowAnimationExampleViewController {
  BOOL _animated;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.whiteColor;

  _animated = NO;

  self.button = [[MDCButton alloc] init];
  [self.button setTitle:@"Update view" forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:[[MDCButtonScheme alloc] init] toButton:self.button];
  [self.button addTarget:self action:@selector(animateView)
        forControlEvents:UIControlEventTouchUpInside];
  [self.button sizeToFit];
  [self.view addSubview:self.button];

  self.customView = [[CustomView alloc] initWithFrame:CGRectZero];
  self.customView.backgroundColor = UIColor.lightGrayColor;
  [self.customView setElevation:(CGFloat)8.0];
  self.customView.layer.cornerRadius = kStartCornerRadius;
  [self.view addSubview:self.customView];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.button.center = CGPointMake(self.view.center.x, self.view.center.y - 100);

  self.customView.bounds = CGRectMake(0, 0, 100, 100);
  self.customView.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
}

- (void)animateView {
  CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut];
  if (!_animated) {
    CGPathRef toShadowPath = [UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                        cornerRadius:kEndCornerRadius].CGPath;
    CGPathRef fromShadowPath = [UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                          cornerRadius:kStartCornerRadius].CGPath;
    [CATransaction begin];
    CABasicAnimation *topAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    topAnimation.fromValue = (__bridge id)fromShadowPath;
    topAnimation.toValue = (__bridge id)toShadowPath;
    topAnimation.duration = kAnimationDuration;
    topAnimation.timingFunction = timingFunction;
    [self.customView.shadowLayer.topShadow addAnimation:topAnimation forKey:@"shadowPath"];

    CABasicAnimation *bottomAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    bottomAnimation.fromValue = (__bridge id)fromShadowPath;
    bottomAnimation.toValue = (__bridge id)toShadowPath;
    bottomAnimation.duration = kAnimationDuration;
    bottomAnimation.timingFunction = timingFunction;
    [self.customView.shadowLayer.bottomShadow addAnimation:bottomAnimation forKey:@"shadowPath"];

    CABasicAnimation *cornerRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadius.fromValue = @((CGFloat)kStartCornerRadius);
    cornerRadius.toValue = @((CGFloat)kEndCornerRadius);
    cornerRadius.duration = kAnimationDuration;
    cornerRadius.timingFunction = timingFunction;
    [self.customView.layer addAnimation:cornerRadius forKey:@"cornerRadius"];

    CGRect maskRect = [self maskRect];
    UIBezierPath *fromMaskPath = [UIBezierPath bezierPathWithRect:maskRect];
    UIBezierPath *toMaskPath = [UIBezierPath bezierPathWithRect:maskRect];
    if (self.customView.shadowLayer.shadowMaskEnabled) {
      [fromMaskPath appendPath:[UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                          cornerRadius:kStartCornerRadius]];
      [fromMaskPath setUsesEvenOddFillRule:YES];

      [toMaskPath appendPath:[UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                        cornerRadius:kEndCornerRadius]];
      [toMaskPath setUsesEvenOddFillRule:YES];

      CABasicAnimation *topMaskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
      topMaskAnimation.timingFunction = timingFunction;
      topMaskAnimation.fromValue = (__bridge id)fromMaskPath.CGPath;
      topMaskAnimation.toValue = (__bridge id)toMaskPath.CGPath;
      topMaskAnimation.duration = kAnimationDuration;
      [self.customView.shadowLayer.topShadowMask addAnimation:topMaskAnimation forKey:@"path"];

      CABasicAnimation *bottomMaskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
      bottomMaskAnimation.timingFunction = timingFunction;
      bottomMaskAnimation.fromValue = (__bridge id)fromMaskPath.CGPath;
      bottomMaskAnimation.toValue = (__bridge id)toMaskPath.CGPath;
      bottomMaskAnimation.duration = kAnimationDuration;
      [self.customView.shadowLayer.bottomShadowMask addAnimation:bottomMaskAnimation forKey:@"path"];
    }

    [CATransaction setAnimationDuration:kAnimationDuration];
    [CATransaction setCompletionBlock:^(void){
      self.customView.layer.cornerRadius = kEndCornerRadius;
      self.customView.shadowLayer.topShadow.shadowPath = toShadowPath;
      self.customView.shadowLayer.bottomShadow.shadowPath = toShadowPath;
      self.customView.shadowLayer.topShadowMask.path = toMaskPath.CGPath;
      self.customView.shadowLayer.bottomShadowMask.path = toMaskPath.CGPath;
    }];

    [CATransaction setDisableActions:NO];
    [CATransaction commit];
  } else {
    CGPathRef fromShadowPath = [UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                        cornerRadius:kEndCornerRadius].CGPath;
    CGPathRef toShadowPath = [UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                          cornerRadius:kStartCornerRadius].CGPath;
    [CATransaction begin];
    CABasicAnimation *topAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    topAnimation.fromValue = (__bridge id)fromShadowPath;
    topAnimation.toValue = (__bridge id)toShadowPath;
    topAnimation.duration = kAnimationDuration;
    topAnimation.timingFunction = timingFunction;
    [self.customView.shadowLayer.topShadow addAnimation:topAnimation forKey:@"shadowPath"];

    CABasicAnimation *bottomAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
    bottomAnimation.fromValue = (__bridge id)fromShadowPath;
    bottomAnimation.toValue = (__bridge id)toShadowPath;
    bottomAnimation.duration = kAnimationDuration;
    bottomAnimation.timingFunction = timingFunction;
    [self.customView.shadowLayer.bottomShadow addAnimation:bottomAnimation forKey:@"shadowPath"];

    CABasicAnimation *cornerRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadius.fromValue = @((CGFloat)kEndCornerRadius);
    cornerRadius.toValue = @((CGFloat)kStartCornerRadius);
    cornerRadius.duration = kAnimationDuration;
    cornerRadius.timingFunction = timingFunction;
    [self.customView.layer addAnimation:cornerRadius forKey:@"cornerRadius"];

    CGRect maskRect = [self maskRect];
    UIBezierPath *toMaskPath = [UIBezierPath bezierPathWithRect:maskRect];
    UIBezierPath *fromMaskPath = [UIBezierPath bezierPathWithRect:maskRect];
    if (self.customView.shadowLayer.shadowMaskEnabled) {
      [toMaskPath appendPath:[UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                          cornerRadius:kStartCornerRadius]];
      [toMaskPath setUsesEvenOddFillRule:YES];

      [fromMaskPath appendPath:[UIBezierPath bezierPathWithRoundedRect:self.customView.bounds
                                                        cornerRadius:kEndCornerRadius]];
      [fromMaskPath setUsesEvenOddFillRule:YES];

      CABasicAnimation *topMaskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
      topMaskAnimation.timingFunction = timingFunction;
      topMaskAnimation.fromValue = (__bridge id)fromMaskPath.CGPath;
      topMaskAnimation.toValue = (__bridge id)toMaskPath.CGPath;
      topMaskAnimation.duration = kAnimationDuration;
      [self.customView.shadowLayer.topShadowMask addAnimation:topMaskAnimation forKey:@"path"];

      CABasicAnimation *bottomMaskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
      bottomMaskAnimation.timingFunction = timingFunction;
      bottomMaskAnimation.fromValue = (__bridge id)fromMaskPath.CGPath;
      bottomMaskAnimation.toValue = (__bridge id)toMaskPath.CGPath;
      bottomMaskAnimation.duration = kAnimationDuration;
      [self.customView.shadowLayer.bottomShadowMask addAnimation:bottomMaskAnimation forKey:@"path"];
    }

    [CATransaction setAnimationDuration:kAnimationDuration];
    [CATransaction setCompletionBlock:^(void){
      self.customView.shadowLayer.cornerRadius = kEndCornerRadius;
      self.customView.shadowLayer.topShadow.shadowPath = toShadowPath;
      self.customView.shadowLayer.bottomShadow.shadowPath = toShadowPath;
      self.customView.shadowLayer.topShadowMask.path = toMaskPath.CGPath;
      self.customView.shadowLayer.bottomShadowMask.path = toMaskPath.CGPath;
    }];

    [CATransaction setDisableActions:NO];
    [CATransaction commit];
  }
  _animated = !_animated;
}

- (CGRect)maskRect {
  CGSize shadowSpread = [MDCShadowLayer shadowSpreadForElevation:(CGFloat)24.0];
  return CGRectInset(self.customView.bounds, -shadowSpread.width * 2, -shadowSpread.height * 2);
}

@end

@implementation ShadowAnimationExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
           @"breadcrumbs" : @[ @"Shadow", @"Custom Animation" ],
           @"primaryDemo" : @YES,
           @"presentable" : @NO
           };
}

@end
