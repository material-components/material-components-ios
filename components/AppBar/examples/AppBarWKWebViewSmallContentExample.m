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

// This demonstrates that a WKWebView with minimal content as the tracking scroll view is not able
// to scroll as expected. This requires enabling useAdditionalSafeAreaInsetsForWebKitScrollViews
// and adjusting the frame of the web view on pre-iOS 11 devices by using the topLayoutGuide.

@interface AppBarWKWebViewSmallContentExample : UIViewController
@property(nonatomic, strong) MDCAppBar *appBar;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation AppBarWKWebViewSmallContentExample

- (void)dealloc {
  // Required for pre-iOS 11 devices because we've enabled observesTrackingScrollViewScrollEvents.
  self.appBar.headerViewController.headerView.trackingScrollView = nil;
}

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"App Bar";

    _appBar = [[MDCAppBar alloc] init];

    _appBar.inferTopSafeAreaInsetFromViewController = YES;
    _appBar.headerViewController.topLayoutGuideViewController = self;
    _appBar.headerViewController.headerView.minMaxHeightIncludesSafeArea = NO;
    _appBar.headerViewController.headerView.observesTrackingScrollViewScrollEvents = YES;

    // Fixes the WKWebView contentSize.height bug on iOS 11+.
    _appBar.headerViewController.useAdditionalSafeAreaInsetsForWebKitScrollViews = YES;

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

  [self setNeedsStatusBarAppearanceUpdate];

  WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
  [self.view addSubview:webView];

  [webView loadHTMLString:@"<html>\n<head></head><body>Hi</body></html>" baseURL:nil];

  if (@available(iOS 11.0, *)) {
    // No need to do anything - additionalSafeAreaInsets will inset our content.
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  } else {
    // Fixes the WKWebView contentSize.height bug pre-iOS 11.
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [NSLayoutConstraint constraintWithItem:webView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.topLayoutGuide
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:webView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:webView
                                   attribute:NSLayoutAttributeLeft
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeLeft
                                  multiplier:1.0
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:webView
                                   attribute:NSLayoutAttributeRight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeRight
                                  multiplier:1.0
                                    constant:0]
    ]];
  }

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

@implementation AppBarWKWebViewSmallContentExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"App Bar", @"WKWebView small content" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
