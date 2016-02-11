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

#import "InkTypicalUseViewController.h"

#import "MaterialInk.h"

@interface InkTypicalUseViewController () <MDCInkTouchControllerDelegate>
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@property(nonatomic, strong) MDCInkTouchController *inkTouchController2;
@end

@implementation InkTypicalUseViewController

// TODO: Support other categorizational methods.
+ (NSArray *)catalogHierarchy {
  return @[ @"Ink", @"Typical use" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f];

  CGRect customFrame = CGRectMake(0, 0, 256, 144);
  UIView *customView = [[UIView alloc] initWithFrame:customFrame];
  customView.center = CGPointMake(self.view.center.x, self.view.center.y - customFrame.size.height);
  customView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:customView];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.text = @"Tap here (bounded ink)";
  label.textColor = [UIColor grayColor];
  label.frame = customFrame;
  label.textAlignment = NSTextAlignmentCenter;
  [customView addSubview:label];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:customView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIView *customView2 = [[UIView alloc] initWithFrame:customFrame];
  customView2.center = CGPointMake(self.view.center.x,
                                   self.view.center.y + customFrame.size.height);
  customView2.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:customView2];

  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
  label2.text = @"Tap here (unbounded ink)";
  label2.textColor = [UIColor grayColor];
  label2.frame = customFrame;
  label2.textAlignment = NSTextAlignmentCenter;
  [customView2 addSubview:label2];

  _inkTouchController2 = [[MDCInkTouchController alloc] initWithView:customView2];
  _inkTouchController2.delegate = self;
  [_inkTouchController2 addInkView];
  [_inkTouchController2.inkView setInkColor:[UIColor colorWithRed:1.f green:0 blue:0 alpha:0.2f]];
  _inkTouchController2.inkView.clipsRippleToBounds = NO;
  _inkTouchController2.inkView.maxRippleRadius = 180.f;
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
