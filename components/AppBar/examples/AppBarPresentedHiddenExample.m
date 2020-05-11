// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "AppBarSampleViewController.h"
#import "MaterialAppBar.h"
#import "MaterialAppBar+Theming.h"
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialContainerScheme.h"

@interface AppBarPresentedHiddenExample : UIViewController

@property(nonatomic, strong) AppBarSampleViewController *demoViewController;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation AppBarPresentedHiddenExample

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.95 alpha:1];

  self.demoViewController = [[AppBarSampleViewController alloc] init];
  self.demoViewController.appBarViewController.headerView.shiftBehavior =
      MDCFlexibleHeaderShiftBehaviorHideable;
  [self.demoViewController.appBarViewController.headerView shiftHeaderOffScreenAnimated:NO];
  self.demoViewController.containerScheme = self.containerScheme;

  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDemo)];
  [self.demoViewController.view addGestureRecognizer:tap];

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  CGFloat buttonMargin = 10;
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Present Modal App Bar Demo" forState:UIControlStateNormal];
  [button sizeToFit];
  button.center = self.view.center;
  button.frame = CGRectMake(button.frame.origin.x, button.center.y - 48 * 2 - buttonMargin,
                            button.bounds.size.width, MAX(button.bounds.size.height, 48));
  [button addTarget:self
                action:@selector(presentDemo)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  [button applyContainedThemeWithScheme:self.containerScheme];
}

- (void)dismissDemo {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentDemo {
  [self presentDemoAnimated:YES];
}

- (void)presentDemoAnimated:(BOOL)animated {
  self.demoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:self.demoViewController animated:animated completion:nil];
}

@end

@implementation AppBarPresentedHiddenExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"Presented hidden" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation AppBarPresentedHiddenExample (SnapshotTestingByConvention)

- (void)testPresentedFullScreen {
  [self dismissDemo];

  // TODO(b/152510959): The AppBar is not presented fully hidden on an iPhone 5s on iOS 10.
  self.demoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:self.demoViewController animated:NO completion:nil];
}

- (void)testPresentedAutomatic {
  [self dismissDemo];

  // TODO(b/152510959): The AppBar is not presented fully hidden on an iPhone 5s on iOS 10.
  if (@available(iOS 13, *)) {
    self.demoViewController.modalPresentationStyle = UIModalPresentationAutomatic;
  } else {
    self.demoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  }
  [self presentViewController:self.demoViewController animated:NO completion:nil];
}

@end
