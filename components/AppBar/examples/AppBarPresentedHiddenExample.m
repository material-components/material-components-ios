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
#import "MaterialAvailability.h"
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialContainerScheme.h"

// This example demonstrates a view controller being presented with the AppBar initially hidden.
// When the view controller is presented, you can tap anywhere on the view controller to dismiss it.
@interface AppBarPresentedHiddenExample : UIViewController

@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation AppBarPresentedHiddenExample

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.95 alpha:1];

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
  [self presentDemoAnimated:YES modalPresentationStyle:UIModalPresentationFullScreen];
}

- (void)presentDemoAnimated:(BOOL)animated
     modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
  AppBarSampleViewController *demoViewController = [[AppBarSampleViewController alloc] init];
  demoViewController.appBarViewController.headerView.shiftBehavior =
      MDCFlexibleHeaderShiftBehaviorHideable;
  [demoViewController.appBarViewController.headerView shiftHeaderOffScreenAnimated:NO];
  demoViewController.containerScheme = self.containerScheme;

  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDemo)];
  [demoViewController.view addGestureRecognizer:tap];

  demoViewController.modalPresentationStyle = modalPresentationStyle;
  [self presentViewController:demoViewController animated:animated completion:nil];
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
  [self dismissViewControllerAnimated:NO completion:nil];

  [self presentDemoAnimated:NO modalPresentationStyle:UIModalPresentationFullScreen];
}

- (void)testPresentedAutomatic {
  [self dismissViewControllerAnimated:NO completion:nil];

#if MDC_AVAILABLE_SDK_IOS(13_0)
  [self presentDemoAnimated:NO modalPresentationStyle:UIModalPresentationAutomatic];
#else
  [self presentDemoAnimated:NO modalPresentationStyle:UIModalPresentationFullScreen];
#endif
}

@end
