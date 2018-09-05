// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialInk.h"
#import "MaterialPalettes.h"

#import "supplemental/InkTypicalUseSupplemental.h"

@interface InkTypicalUseViewController () <MDCInkTouchControllerDelegate>

@property(nonatomic, strong) NSMutableArray *inkTouchControllers;  // MDCInkTouchControllers.

@end

@implementation InkTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *containerView = [[UIView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:containerView];
  self.containerView = containerView;

  UIColor *blueColor = MDCPalette.bluePalette.tint500;
  CGFloat spacing = 16;
  CGRect customFrame = CGRectMake(0, 0, 200, 200);
  CGRect legacyFrame = CGRectMake(spacing / 2, spacing / 2, CGRectGetWidth(customFrame) - spacing,
                                  CGRectGetHeight(customFrame) - spacing);

  // ExampleShapes is a custom UIView with several subviews of various shapes.
  self.shapes = [[ExampleShapes alloc] initWithFrame:customFrame];
  self.legacyShape = [[UIView alloc] initWithFrame:legacyFrame];

  [self setupExampleViews];

  _inkTouchControllers = [[NSMutableArray alloc] init];

  for (UIView *view in self.shapes.subviews) {
    MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:view];
    inkTouchController.delegate = self;
    inkTouchController.defaultInkView.inkColor = blueColor;
    inkTouchController.defaultInkView.usesLegacyInkRipple = NO;
    [inkTouchController addInkView];
    [_inkTouchControllers addObject:inkTouchController];
  }
  [containerView addSubview:self.shapes];

  MDCInkTouchController *inkTouchController =
      [[MDCInkTouchController alloc] initWithView:self.legacyShape];
  inkTouchController.delegate = self;
  inkTouchController.defaultInkView.inkColor = blueColor;
  [inkTouchController addInkView];
  [_inkTouchControllers addObject:inkTouchController];
  [containerView addSubview:self.legacyShape];
}

#pragma mark - Private

- (void)inkTouchController:(MDCInkTouchController *)inkTouchController
         didProcessInkView:(MDCInkView *)inkView
           atTouchLocation:(CGPoint)location {
  NSLog(@"InkTouchController %p did process ink view: %p at touch location: %@", inkTouchController,
        inkView, NSStringFromCGPoint(location));
}

@end
