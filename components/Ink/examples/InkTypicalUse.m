/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "MaterialInk.h"

#import "InkTypicalUseSupplemental.h"

@interface InkTypicalUseViewController () <MDCInkTouchControllerDelegate>

@property(nonatomic, strong) NSMutableArray *inkTouchControllers;  // MDCInkTouchControllers.

@end

@implementation InkTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  CGFloat spacing = 16;
  CGRect customFrame = CGRectMake(0, 0, 200, 200);
  CGRect unboundedFrame = CGRectMake(spacing / 2,
                                     spacing / 2,
                                     customFrame.size.width - spacing,
                                     customFrame.size.height - spacing);

  // ExampleShapes is a custom UIView with several subviews of various shapes.
  self.boundedShapes = [[ExampleShapes alloc] initWithFrame:customFrame];
  self.unboundedShape = [[UIView alloc] initWithFrame:unboundedFrame];

  [self setupExampleViews];

  _inkTouchControllers = [[NSMutableArray alloc] init];

  for (UIView *view in self.boundedShapes.subviews) {
    MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:view];
    inkTouchController.delegate = self;
    [inkTouchController addInkView];
    [_inkTouchControllers addObject:inkTouchController];
  }
  [self.view addSubview:self.boundedShapes];

  MDCInkTouchController *inkTouchController =
      [[MDCInkTouchController alloc] initWithView:self.unboundedShape];
  inkTouchController.delegate = self;
  [inkTouchController addInkView];

  UIColor *blueColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];
  inkTouchController.defaultInkView.inkColor = blueColor;
  inkTouchController.defaultInkView.inkStyle = MDCInkStyleUnbounded;
  [_inkTouchControllers addObject:inkTouchController];
  [self.view addSubview:self.unboundedShape];
}

#pragma mark - Private

- (void)inkTouchController:(MDCInkTouchController *)inkTouchController
         didProcessInkView:(MDCInkView *)inkView
           atTouchLocation:(CGPoint)location {
  NSLog(@"InkTouchController %p did process ink view: %p at touch location: %@",
        inkTouchController,
        inkView,
        NSStringFromCGPoint(location));
}

@end
