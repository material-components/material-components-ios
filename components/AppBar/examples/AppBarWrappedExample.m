/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialAppBar.h"
#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"


@interface WrappedDemoViewController : UIViewController
@end

@implementation WrappedDemoViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"Wrapped App Bar";

  self.view.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1];

  UILabel *label = [[UILabel alloc] init];
  label.text = @"Wrapped UIViewController";
  [self.view addSubview:label];

  [label sizeToFit];
  label.center = self.view.center;
}

@end

@interface AppBarWrappedExample : UIViewController

@property(nonatomic, strong) MDCAppBarContainerViewController *appBarContainerViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation AppBarWrappedExample

- (void)viewDidLoad {
  [super viewDidLoad];

  WrappedDemoViewController *demoVC = [[WrappedDemoViewController alloc] init];
  self.appBarContainerViewController =
      [[MDCAppBarContainerViewController alloc] initWithContentViewController:demoVC];

  [MDCAppBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toAppBar:self.appBarContainerViewController.appBar];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                                          toAppBar:self.appBarContainerViewController.appBar];

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  [self addChildViewController:self.appBarContainerViewController];
  self.appBarContainerViewController.view.frame = self.view.bounds;
  [self.view addSubview:self.appBarContainerViewController.view];
  [self.appBarContainerViewController didMoveToParentViewController:self];
}

@end

@implementation AppBarWrappedExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Wrapped" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

@end
