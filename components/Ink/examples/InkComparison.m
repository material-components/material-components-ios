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

#import <UIKit/UIKit.h>

#import "MaterialInk.h"

@interface InkComparisonViewController : UIViewController

@property(nonatomic, strong) MDCInkTouchController *inkTouchController;
@property(nonatomic, strong) MDCSimpleInkView *simpleInkView;
@property(nonatomic, strong) UIView *inkView;

@end

@implementation InkComparisonViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect inkFrame = CGRectMake(0, 0, 200, 200);
  self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];

  self.simpleInkView = [[MDCSimpleInkView alloc] initWithFrame:inkFrame];
  self.simpleInkView.backgroundColor = [UIColor whiteColor];
  self.simpleInkView.clipsToBounds = YES;
  [self.simpleInkView addInkGestureRecognizer];
  [self.view addSubview:self.simpleInkView];

  self.inkView = [[UIView alloc] initWithFrame:inkFrame];
  self.inkView.backgroundColor = [UIColor whiteColor];
  self.inkTouchController = [[MDCInkTouchController alloc] initWithView:self.inkView];
  [self.inkTouchController addInkView];
  [self.view addSubview:self.inkView];

  UILabel *simpleInkLabel = [[UILabel alloc] init];
  simpleInkLabel.text = @"Simple Ink";
  [simpleInkLabel sizeToFit];
  simpleInkLabel.center = self.simpleInkView.center;
  [self.simpleInkView addSubview:simpleInkLabel];

  UILabel *inkLabel = [[UILabel alloc] init];
  inkLabel.text = @"Classic Ink";
  [inkLabel sizeToFit];
  inkLabel.center = self.inkView.center;
  [self.inkView addSubview:inkLabel];
}

- (void)viewWillLayoutSubviews {
  CGFloat offset = 8;
  CGFloat shapeDimension = 200;
  CGFloat spacing = 16;
  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.simpleInkView.center =
        CGPointMake(self.view.center.x, self.view.center.y - shapeDimension - offset);
    self.inkView.center =
        CGPointMake(self.view.center.x, self.view.center.y + spacing * 2 + offset);
  } else {
    self.simpleInkView.center = CGPointMake(self.view.center.x - shapeDimension / 2 - spacing * 2,
                                            self.view.center.y / 2 + spacing * 2);
    self.inkView.center = CGPointMake(self.view.center.x + shapeDimension / 2 + spacing * 2,
                                             self.view.center.y / 2 + spacing * 2);
  }
}

@end

#pragma mark - SimpleInkTypicalUseViewController

@implementation InkComparisonViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Ink", @"Ink Comparison" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
