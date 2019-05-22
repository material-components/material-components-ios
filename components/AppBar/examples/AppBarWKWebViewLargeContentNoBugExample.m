// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
#import <WebKit/WebKit.h>

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialAppBar.h"

// This demonstrates that a WKWebView with large content as the tracking scroll view is able to
// scroll as expected, even without the useAdditionalSafeAreaInsetsForWebKitScrollViews flag
// enabled.

@interface AppBarWKWebViewLargeContentNoBugExample : UIViewController

@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation AppBarWKWebViewLargeContentNoBugExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBar.headerViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"App Bar";

    _appBar = [[MDCAppBar alloc] init];

    // Behavioral flags.
    _appBar.inferTopSafeAreaInsetFromViewController = YES;
    _appBar.headerViewController.topLayoutGuideViewController = self;
    _appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = NO;
    _appBar.headerViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

    [self addChildViewController:_appBar.headerViewController];

    _appBar.navigationBar.inkColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:(CGFloat)0.1];

    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [MDCAppBarColorThemer applySemanticColorScheme:self.colorScheme toAppBar:_appBar];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme toAppBar:_appBar];

  // Need to update the status bar style after applying the theme.
  [self setNeedsStatusBarAppearanceUpdate];

  WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
  webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:webView];

  NSMutableArray *content = [@[ @"<html>\n<head></head><body>" ] mutableCopy];
  for (NSInteger ix = 0; ix < 500; ++ix) {
    [content addObject:@"<p>Hello</p>"];
  }
  [content addObject:@"</body></html>"];
  [webView loadHTMLString:[content componentsJoinedByString:@"\n"] baseURL:nil];

  self.appBar.headerViewController.headerView.trackingScrollView = webView.scrollView;
  [self.appBar addSubviewsToParent];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.appBar.headerViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.appBar.headerViewController;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

@implementation AppBarWKWebViewLargeContentNoBugExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"WKWebView large content no bug" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
