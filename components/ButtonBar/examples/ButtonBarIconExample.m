// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtonBar.h"
#import "MaterialIcons+ic_check_circle.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialPalettes.h"

@interface ButtonBarIconExample : UIViewController
@end

@implementation ButtonBarIconExample

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCButtonBar *buttonBar = [[MDCButtonBar alloc] init];
  buttonBar.tintColor = MDCPalette.indigoPalette.tint500;

  // MDCButtonBar ignores the style of UIBarButtonItem.
  UIBarButtonItemStyle ignored = UIBarButtonItemStyleDone;

  UIBarButtonItem *actionItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_info]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:ignored
             target:self
             action:@selector(didTapActionButton:)];
  UIBarButtonItem *secondActionItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_check_circle]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:ignored
             target:self
             action:@selector(didTapActionButton:)];

  NSArray *items = @[ actionItem, secondActionItem ];

  // Set the title text attributes before assigning to buttonBar.items
  // because of https://github.com/material-components/material-components-ios/issues/277
  for (UIBarButtonItem *item in items) {
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}
                        forState:UIControlStateNormal];
  }

  buttonBar.items = items;

  // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
  CGSize size = [buttonBar sizeThatFits:self.view.bounds.size];
  CGFloat x = (self.view.bounds.size.width - size.width) / 2;
  CGFloat y = self.view.bounds.size.height / 2 - size.height;
  buttonBar.frame = CGRectMake(x, y, size.width, size.height);
  buttonBar.autoresizingMask =
      (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
       UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:buttonBar];

  // Ensure that the controller's view isn't transparent.
  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];
}

#pragma mark - User actions

- (void)didTapActionButton:(id)sender {
  NSLog(@"Did tap action item: %@", sender);
}

@end

@implementation ButtonBarIconExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Button Bar", @"Button Bar (Icons)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

#pragma mark - Typical application code (not Material-specific)

@implementation ButtonBarIconExample (GeneralApplicationLogic)

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Button Bar Icons";
  }
  return self;
}

@end
