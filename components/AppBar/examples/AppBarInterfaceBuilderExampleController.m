/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

@interface AppBarInterfaceBuilderExample : UIViewController <UIScrollViewDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) MDCAppBar *appBar;

@end

@implementation AppBarInterfaceBuilderExample

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
  [self addChildViewController:self.appBar.headerViewController];
  UIColor *headerColor = [UIColor colorWithRed:0.01 green:0.67 blue:0.96 alpha:1.0];
  self.appBar.headerViewController.headerView.backgroundColor = headerColor;

  MDCAppBarAccessibilityEnforcer *enforcer = [[MDCAppBarAccessibilityEnforcer alloc] init];
  [enforcer enforceFontColorAccessibility:_appBar];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.appBar.headerViewController.headerView.trackingScrollView = self.scrollView;

  self.scrollView.delegate = self.appBar.headerViewController;

  [self.appBar addSubviewsToParent];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  // Ensure that our status bar is white.
  return UIStatusBarStyleLightContent;
}

@end

@implementation AppBarInterfaceBuilderExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"App Bar", @"Interface Builder" ];
}

+ (NSString *)catalogStoryboardName {
  return @"AppBarInterfaceBuilderExampleController";
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
