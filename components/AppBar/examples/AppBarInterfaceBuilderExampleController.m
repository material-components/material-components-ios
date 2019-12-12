// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar.h"

@interface AppBarInterfaceBuilderExample : UIViewController <UIScrollViewDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) MDCAppBarViewController *appBarViewController;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;

@end

@implementation AppBarInterfaceBuilderExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBarViewController.headerView.trackingScrollView = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonAppBarInterfaceBuilderExampleSetup];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self commonAppBarInterfaceBuilderExampleSetup];
}

- (void)commonAppBarInterfaceBuilderExampleSetup {
  self.appBarViewController = [[MDCAppBarViewController alloc] init];

  // Behavioral flags.
  self.appBarViewController.inferTopSafeAreaInsetFromViewController = YES;
  self.appBarViewController.headerView.minMaxHeightIncludesSafeArea = NO;

  self.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  [self addChildViewController:self.appBarViewController];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:self.appBarViewController];

  // Allows us to avoid forwarding events, but means we can't enable shift behaviors.
  self.appBarViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

  self.appBarViewController.headerView.trackingScrollView = self.scrollView;

  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

@end

@implementation AppBarInterfaceBuilderExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"Interface Builder" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
    @"storyboardName" : @"AppBarInterfaceBuilderExampleController"
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
