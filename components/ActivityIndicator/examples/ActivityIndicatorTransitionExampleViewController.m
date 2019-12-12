// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialActivityIndicator.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialButtons.h"

static const CGFloat kActivityIndicatorExampleArrowHeadSize = 5;
static const CGFloat kActivityIndicatorExampleStrokeWidth = 2;

static const NSTimeInterval kActivityIndicatorExampleAnimationDuration = 2.0 / 3.0;

@interface ActivityIndicatorTransitionExampleViewController
    : UIViewController <MDCActivityIndicatorDelegate>
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation ActivityIndicatorTransitionExampleViewController {
  MDCActivityIndicator *_activityIndicator;
  MDCButton *_button;

  CALayer *_rotationContainer;
  CALayer *_refreshArrowContainer;
  CAShapeLayer *_refreshArrowPoint;
  CAShapeLayer *_refreshStrokeLayer;
}

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Activity Indicator Transition";
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.colorScheme.backgroundColor;

  _activityIndicator = [[MDCActivityIndicator alloc] initWithFrame:CGRectZero];
  [_activityIndicator sizeToFit];
  _activityIndicator.center = CGPointMake(self.view.bounds.size.width / 2, 130);
  _activityIndicator.autoresizingMask =
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  _activityIndicator.delegate = self;
  [self.view addSubview:_activityIndicator];

  _button = [[MDCButton alloc] init];
  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:_button];
  [_button addTarget:self
                action:@selector(startRefreshing)
      forControlEvents:UIControlEventTouchUpInside];
  [_button setTitle:@"Refresh" forState:UIControlStateNormal];
  [_button sizeToFit];
  _button.center = CGPointMake(self.view.bounds.size.width / 2, 200);
  _button.autoresizingMask =
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  [self.view addSubview:_button];

  // Layers used in the custom transition animation.

  _rotationContainer = [CALayer layer];
  [_activityIndicator.layer addSublayer:_rotationContainer];

  _refreshArrowContainer = [CALayer layer];
  [_rotationContainer addSublayer:_refreshArrowContainer];

  CGMutablePathRef refreshArrowPath = CGPathCreateMutable();
  CGPathMoveToPoint(refreshArrowPath, NULL, 0, -kActivityIndicatorExampleArrowHeadSize);
  CGPathAddLineToPoint(refreshArrowPath, NULL, kActivityIndicatorExampleArrowHeadSize, 0);
  CGPathAddLineToPoint(refreshArrowPath, NULL, 0, kActivityIndicatorExampleArrowHeadSize);
  CGPathCloseSubpath(refreshArrowPath);

  _refreshArrowPoint = [CAShapeLayer layer];
  _refreshArrowPoint.anchorPoint = CGPointMake(0.5, 1);
  _refreshArrowPoint.path = refreshArrowPath;
  [_refreshArrowContainer addSublayer:_refreshArrowPoint];

  CGPathRelease(refreshArrowPath);

  _refreshStrokeLayer = [CAShapeLayer layer];
  _refreshStrokeLayer.lineWidth = kActivityIndicatorExampleStrokeWidth;
  _refreshStrokeLayer.fillColor = [UIColor clearColor].CGColor;
  _refreshStrokeLayer.strokeColor = [UIColor blackColor].CGColor;
  _refreshStrokeLayer.strokeStart = 0;
  _refreshStrokeLayer.strokeEnd = (CGFloat)0.8;
  [_rotationContainer addSublayer:_refreshStrokeLayer];

  _rotationContainer.transform = CATransform3DMakeRotation((CGFloat)M_PI * (CGFloat)0.65, 0, 0, 1);
  _refreshArrowContainer.transform = CATransform3DMakeRotation((CGFloat)1.6 * (float)M_PI, 0, 0, 1);

  [CATransaction commit];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [CATransaction begin];
  [CATransaction setDisableActions:YES];

  CGRect bounds = _activityIndicator.bounds;
  _rotationContainer.bounds = bounds;
  _rotationContainer.position = CGPointMake(bounds.size.width / 2, bounds.size.height / 2);

  _refreshStrokeLayer.bounds = _rotationContainer.bounds;
  _refreshStrokeLayer.position = _rotationContainer.position;

  _refreshArrowContainer.bounds = _rotationContainer.bounds;
  _refreshArrowContainer.position = _rotationContainer.position;

  _refreshArrowPoint.position =
      CGPointMake(bounds.size.width / 2, kActivityIndicatorExampleStrokeWidth / 2);

  CGFloat offsetRadius = _activityIndicator.radius - kActivityIndicatorExampleStrokeWidth / 2;
  UIBezierPath *strokePath = [UIBezierPath bezierPathWithArcCenter:_refreshStrokeLayer.position
                                                            radius:offsetRadius
                                                        startAngle:-1 * (CGFloat)M_PI_2
                                                          endAngle:3 * (CGFloat)M_PI_2
                                                         clockwise:YES];
  _refreshStrokeLayer.path = strokePath.CGPath;
}

- (void)startRefreshing {
  _button.enabled = NO;

  MDCActivityIndicatorTransition *transition =
      [[MDCActivityIndicatorTransition alloc] initWithAnimation:^(CGFloat start, CGFloat end) {
        [self addFromRefreshIconAnimationsToActivityIndicatorWithStrokeStart:start strokeEnd:end];
      }];
  transition.duration = kActivityIndicatorExampleAnimationDuration;
  transition.completion = ^{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self->_rotationContainer.hidden = YES;
    [self->_refreshArrowContainer removeAllAnimations];
    [self->_refreshArrowPoint removeAllAnimations];
    [CATransaction commit];

    dispatch_time_t stopTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(stopTime, dispatch_get_main_queue(), ^{
      [self stopRefreshing];
    });
  };

  [_activityIndicator startAnimatingWithTransition:transition cycleStartIndex:1];
}

- (void)stopRefreshing {
  [_refreshStrokeLayer removeAllAnimations];
  [_rotationContainer removeAllAnimations];

  MDCActivityIndicatorTransition *transition =
      [[MDCActivityIndicatorTransition alloc] initWithAnimation:^(CGFloat start, CGFloat end) {
        [self addToRefreshIconAnimationsFromActivityIndicatorWithStrokeStart:start strokeEnd:end];
      }];
  transition.duration = kActivityIndicatorExampleAnimationDuration;
  transition.completion = ^{
    self->_button.enabled = YES;
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self->_button);
  };

  [_activityIndicator stopAnimatingWithTransition:transition];
}

#pragma mark - Private

- (void)addFromRefreshIconAnimationsToActivityIndicatorWithStrokeStart:(CGFloat)strokeStart
                                                             strokeEnd:(CGFloat)strokeEnd {
  // Outer rotation
  CABasicAnimation *outerRotationAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  outerRotationAnimation.fromValue = @((CGFloat)M_PI * (CGFloat)0.65);
  outerRotationAnimation.toValue = @(strokeEnd * 2 * M_PI);
  outerRotationAnimation.fillMode = kCAFillModeForwards;
  outerRotationAnimation.removedOnCompletion = NO;
  [_rotationContainer addAnimation:outerRotationAnimation forKey:@"transform.rotation.z"];

  CGFloat difference = strokeEnd - strokeStart;

  // Stroke start
  CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
  strokeStartAnimation.fromValue = @(0);
  // Ensure the stroke never disappears by never hitting stroke end's toValue.
  strokeStartAnimation.toValue = @(1 - difference);
  strokeStartAnimation.fillMode = kCAFillModeBoth;
  strokeStartAnimation.removedOnCompletion = NO;
  [_refreshStrokeLayer addAnimation:strokeStartAnimation forKey:@"strokeStart"];

  // Stroke end
  CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  strokeEndAnimation.fromValue = @(_refreshStrokeLayer.strokeEnd);
  strokeEndAnimation.toValue = @(1);
  strokeEndAnimation.fillMode = kCAFillModeBoth;
  strokeEndAnimation.removedOnCompletion = NO;
  [_refreshStrokeLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];

  // Refresh arrow rotation and scale
  CABasicAnimation *refreshArrowRotation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  refreshArrowRotation.fromValue = @(M_PI * (CGFloat)1.6);
  refreshArrowRotation.toValue = @(M_PI * 2);
  refreshArrowRotation.fillMode = kCAFillModeForwards;
  refreshArrowRotation.removedOnCompletion = NO;
  [_refreshArrowContainer addAnimation:refreshArrowRotation forKey:@"transform.rotation.z"];

  CABasicAnimation *arrowPointScaleAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  arrowPointScaleAnimation.fromValue = @(1);
  arrowPointScaleAnimation.toValue = @(0);
  arrowPointScaleAnimation.fillMode = kCAFillModeForwards;
  arrowPointScaleAnimation.removedOnCompletion = NO;
  [_refreshArrowPoint addAnimation:arrowPointScaleAnimation forKey:@"transform.scale"];
}

- (void)addToRefreshIconAnimationsFromActivityIndicatorWithStrokeStart:(CGFloat)strokeStart
                                                             strokeEnd:(CGFloat)strokeEnd {
  // Adjust stroke position to offset outer rotation angle and ensure stroke position is in range
  // [0,1] for smooth animation
  strokeStart -= (CGFloat)0.325;
  strokeStart = strokeStart < 0 ? strokeStart + 1 : strokeStart;
  strokeEnd -= (CGFloat)0.325;
  strokeEnd = strokeEnd < 0 ? strokeEnd + 1 : strokeEnd;

  _rotationContainer.hidden = NO;

  // Stroke start
  CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
  strokeStartAnimation.fromValue = @(strokeStart);
  strokeStartAnimation.toValue = @(0);
  strokeStartAnimation.fillMode = kCAFillModeBoth;
  strokeStartAnimation.removedOnCompletion = NO;
  [_refreshStrokeLayer addAnimation:strokeStartAnimation forKey:@"strokeStart"];

  // Stroke end
  CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  strokeEndAnimation.fromValue = @(strokeEnd);
  strokeEndAnimation.toValue = @((CGFloat)0.8);
  strokeEndAnimation.fillMode = kCAFillModeBoth;
  strokeEndAnimation.removedOnCompletion = NO;
  [_refreshStrokeLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];

  // Refresh arrow rotation and scale
  CABasicAnimation *refreshArrowRotation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  refreshArrowRotation.fromValue = @(strokeStart * 2 * M_PI);
  refreshArrowRotation.toValue = @((CGFloat)1.6 * M_PI);
  refreshArrowRotation.fillMode = kCAFillModeForwards;
  refreshArrowRotation.removedOnCompletion = NO;
  [_refreshArrowContainer addAnimation:refreshArrowRotation forKey:@"transform.rotation.z"];

  CABasicAnimation *arrowPointScaleAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  arrowPointScaleAnimation.fromValue = @(0);
  arrowPointScaleAnimation.toValue = @(1);
  arrowPointScaleAnimation.fillMode = kCAFillModeForwards;
  arrowPointScaleAnimation.removedOnCompletion = NO;
  [_refreshArrowPoint addAnimation:arrowPointScaleAnimation forKey:@"transform.scale"];
}

#pragma mark - Catalog by Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Activity Indicator", @"Activity Indicator Transition" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES
  };
}

@end
