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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MDCRippleTouchController.h"
#import "MDCRippleTouchControllerDelegate.h"

#import "supplemental/RippleExampleSupplemental.h"

@interface RippleTypicalUseExample () <MDCRippleTouchControllerDelegate>
@end

@implementation RippleTypicalUseExample {
  NSMutableArray *_rippleTouchControllers;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.whiteColor;

  UIView *containerView = [[UIView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:containerView];
  self.containerView = containerView;

  CGRect customFrame = CGRectMake(0, 0, 200, 200);

  // ExampleShapes is a custom UIView with several subviews of various shapes.
  self.surfaces = [[RippleSurfaces alloc] initWithFrame:customFrame];

  _rippleTouchControllers = [[NSMutableArray alloc] init];

  for (UIView *view in self.surfaces.subviews) {
    MDCRippleTouchController *rippleTouchController =
        [[MDCRippleTouchController alloc] initWithView:view];
    rippleTouchController.delegate = self;
    [_rippleTouchControllers addObject:rippleTouchController];
  }
  [containerView addSubview:self.surfaces];
}

#pragma mark - Private

- (void)rippleTouchController:(MDCRippleTouchController *)rippleTouchController
         didProcessRippleView:(MDCRippleView *)rippleView
              atTouchLocation:(CGPoint)location {
  NSLog(@"RippleTouchController %p did process ripple view: %p at touch location: %@",
        rippleTouchController, rippleView, NSStringFromCGPoint(location));
}

@end
