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

#import "MDCAppBarViewController.h"

#import "MDCAppBarViewController+ios.h"

#import "MaterialNavigationBar.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialHeaderStackView.h"

static NSString *const kBarStackKey = @"barStack";
static NSString *const kStatusBarHeightKey = @"statusBarHeight";
static const CGFloat kStatusBarHeight = 20;

@implementation MDCAppBarViewController

- (MDCHeaderStackView *)headerStackView {
  // Removed call to loadView here as we should never be calling it manually.
  // It previously replaced loadViewIfNeeded call that is only iOS 9.0+ to
  // make backwards compatible.
  // Underlying issue is you need view loaded before accessing. Below change will accomplish that
  // by calling for view.bounds initializing the stack view
  if (!_headerStackView) {
    _headerStackView = [[MDCHeaderStackView alloc] initWithFrame:CGRectZero];
  }
  return _headerStackView;
}

- (MDCNavigationBar *)navigationBar {
  if (!_navigationBar) {
    _navigationBar = [[MDCNavigationBar alloc] init];
  }
  return _navigationBar;
}

- (UIViewController *)flexibleHeaderParentViewController {
  NSAssert([self.parentViewController isKindOfClass:[MDCFlexibleHeaderViewController class]],
           @"Expected the parent of %@ to be a type of %@", NSStringFromClass([self class]),
           NSStringFromClass([MDCFlexibleHeaderViewController class]));
  return self.parentViewController.parentViewController;
}

+ (NSBundle *)baseBundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // We may not be included by the main bundle, but rather by an embedded framework, so figure out
    // to which bundle our code is compiled, and use that as the starting point for bundle loading.
    bundle = [NSBundle bundleForClass:[self class]];
  });

  return bundle;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.headerStackView.translatesAutoresizingMaskIntoConstraints = NO;
  self.headerStackView.topBar = self.navigationBar;

  [self.view addSubview:self.headerStackView];

  // Bar stack expands vertically, but has a margin above it for the status bar.

  NSArray<NSLayoutConstraint *> *horizontalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[%@]|", kBarStackKey]
                          options:0
                          metrics:nil
                            views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:horizontalConstraints];

  NSArray<NSLayoutConstraint *> *verticalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%@-[%@]|", kStatusBarHeightKey,
                                                             kBarStackKey]
                          options:0
                          metrics:@{
                            kStatusBarHeightKey : @(kStatusBarHeight)
                          }
                            views:@{kBarStackKey : self.headerStackView}];
  [self.view addConstraints:verticalConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

#if TARGET_OS_IOS
  UIBarButtonItem *backBarButtonItem = [self backButtonItem];
  if (backBarButtonItem && !self.navigationBar.backItem) {
    self.navigationBar.backItem = backBarButtonItem;
  }
#endif // #if TARGET_OS_IOS
}

@end
