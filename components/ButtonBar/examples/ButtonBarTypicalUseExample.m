/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MaterialButtonBar.h"

@interface ButtonBarTypicalUseExample : UIViewController
@end

@implementation ButtonBarTypicalUseExample

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCButtonBar *buttonBar = [[MDCButtonBar alloc] init];
  buttonBar.backgroundColor = [self buttonBarBackgroundColor];

  // MDCButtonBar ignores the style of UIBarButtonItem.
  UIBarButtonItemStyle ignored = UIBarButtonItemStyleDone;

  UIBarButtonItem *actionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Action"
                                       style:ignored
                                      target:self
                                      action:@selector(didTapActionButton:)];
  UIBarButtonItem *secondActionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Second action"
                                       style:ignored
                                      target:self
                                      action:@selector(didTapActionButton:)];

  NSArray *items = @[ actionItem, secondActionItem ];

  // Set the title text attributes before assigning to buttonBar.items
  // because of https://github.com/google/material-components-ios/issues/277
  for (UIBarButtonItem *item in items) {
    [item setTitleTextAttributes:[self itemTitleTextAttributes] forState:UIControlStateNormal];
  }

  buttonBar.items = items;

  // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
  CGSize size = [buttonBar sizeThatFits:self.view.bounds.size];
  buttonBar.frame = (CGRect){0, 100, size};
  buttonBar.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
  [self.view addSubview:buttonBar];

  // Ensure that the controller's view isn't transparent.
  self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - User actions

- (void)didTapActionButton:(id)sender {
  NSLog(@"Did tap action item: %@", sender);
}

#pragma mark - Visual configuration

- (UIColor *)buttonBarBackgroundColor {
  return [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];
}

- (NSDictionary *)itemTitleTextAttributes {
  UIColor *textColor = [UIColor colorWithWhite:0 alpha:0.8];
  return @{NSForegroundColorAttributeName : textColor};
}

@end

@implementation ButtonBarTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Button Bar", @"Typical use" ];
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation ButtonBarTypicalUseExample (GeneralApplicationLogic)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Typical use";
  }
  return self;
}

@end
