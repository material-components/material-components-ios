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

#import "ShadowCornerRadiusAnimationViewController.h"

#import "MDCButtonScheme.h"
#import "MDCContainedButtonThemer.h"
#import "MDCButton.h"
#import "MDCShadowLayer.h"

static const CGFloat kStartCornerRadius = (CGFloat)0.001;
static const CGFloat kEndCornerRadius = (CGFloat)25.0;
static const CGFloat kAnimationDuration = (CGFloat)2.5;

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

@interface ShadowCornerRadiusAnimationViewController ()
@property(nonatomic, strong, nullable) MDCButton *button;
@property(nonatomic, strong, nullable) CustomView *customView;
@end

@implementation ShadowCornerRadiusAnimationViewController {
  BOOL _animated;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _animated = NO;
  self.view.backgroundColor = UIColor.whiteColor;
  self.button = [[MDCButton alloc] init];
  [self.button setTitle:@"Animation View" forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:[[MDCButtonScheme alloc] init] toButton:self.button];
  [self.button sizeToFit];
  [self.button addTarget:self
                  action:@selector(animateView)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.button];

  self.customView = [[CustomView alloc] initWithFrame:CGRectZero];
  self.customView.backgroundColor = UIColor.lightGrayColor;
  [self.customView setElevation:(CGFloat)8.0];
  [self.view addSubview:self.customView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.button.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
  self.customView.bounds = CGRectMake(0, 0, 100, 100);
  self.customView.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
}

- (void)animateView {
  CAMediaTimingFunction *timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  if (!_animated) {
    [self.customView.shadowLayer animateCornerRadius:kEndCornerRadius
                                  withTimingFunction:timingFunction
                                            duration:kAnimationDuration];
  } else {
    [self.customView.shadowLayer animateCornerRadius:kStartCornerRadius
                                  withTimingFunction:timingFunction
                                            duration:kAnimationDuration];
  }
  _animated = !_animated;
}

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Shadow", @"Shadow Corner Animation" ],
    @"description" : @"Animate shadows within a CABasicAnimation.",
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
