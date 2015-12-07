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

#import "ViewController.h"

#import "MaterialInk.h"

@interface ViewController () <MDCInkTouchControllerDelegate>
@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 256, 144)];
  customView.center = self.view.center;
  customView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:customView];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.text = @"Tap here";
  label.textColor = [UIColor whiteColor];
  [label sizeToFit];
  [customView addSubview:label];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:customView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];
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
