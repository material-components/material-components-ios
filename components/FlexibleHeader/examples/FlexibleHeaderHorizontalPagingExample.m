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

#import "MDCFlexibleHeaderView.h"
#import "MDCFlexibleHeaderViewController.h"

static UIColor *HexColor(uint32_t hex) {
  return [UIColor colorWithRed:(CGFloat)((uint8_t)(hex >> 16)) / (CGFloat)255
                         green:(CGFloat)((uint8_t)(hex >> 8)) / (CGFloat)255
                          blue:(CGFloat)((uint8_t)hex) / (CGFloat)255
                         alpha:1];
}

static const NSUInteger kNumberOfPages = 10;

@interface FlexibleHeaderHorizontalPagingViewController : UIViewController <UIScrollViewDelegate>
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@end

@implementation FlexibleHeaderHorizontalPagingViewController {
  UIScrollView *_pagingScrollView;
  NSArray *_pageScrollViews;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _pagingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  _pagingScrollView.pagingEnabled = YES;
  _pagingScrollView.delegate = self;
  _pagingScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  _pagingScrollView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _pagingScrollView.scrollsToTop = NO;
  self.title = @"Swipe Right From Left Edge to Go Back";

  NSArray *pageColors = @[ HexColor(0x55C4F5), HexColor(0x8BC34A), HexColor(0xFFC107) ];

  NSMutableArray *pageScrollViews = [NSMutableArray array];
  for (NSUInteger ix = 0; ix < kNumberOfPages; ++ix) {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self.fhvc;
    scrollView.backgroundColor = pageColors[ix % [pageColors count]];
    [_pagingScrollView addSubview:scrollView];

    [pageScrollViews addObject:scrollView];
  }
  _pageScrollViews = pageScrollViews;

  [self.view addSubview:_pagingScrollView];

  self.fhvc.headerView.trackingScrollView = [_pageScrollViews firstObject];

  [self typicalFlexibleHeaderViewDidLoad];
}

- (void)recalculatePageBounds {
  CGRect frame = self.view.bounds;
  for (NSUInteger ix = 0; ix < [_pageScrollViews count]; ++ix) {
    UIScrollView *scrollView = _pageScrollViews[ix];

    scrollView.frame = frame;
    scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height * 10);

    frame.origin.x += frame.size.width;
  }

  _pagingScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * [_pageScrollViews count],
                                             self.view.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self recalculatePageBounds];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [self recalculatePageBounds];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (scrollView == _pagingScrollView) {
    NSInteger pageIndex = (NSInteger)(scrollView.contentOffset.x / self.view.bounds.size.width);
    for (NSInteger ix = MAX(0, pageIndex - 1);
         ix <= MIN((NSInteger)_pageScrollViews.count - 1, pageIndex + 1); ++ix) {
      if (ix != pageIndex) {
        [self.fhvc.headerView trackingScrollWillChangeToScrollView:_pageScrollViews[ix]];
      }
    }
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == _pagingScrollView) {
    NSUInteger pageIndex = (NSUInteger)(scrollView.contentOffset.x / self.view.bounds.size.width);
    self.fhvc.headerView.trackingScrollView = _pageScrollViews[pageIndex];
    [self.fhvc.headerView.trackingScrollView flashScrollIndicators];
  }
}

#pragma mark - From the Typical Use example

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (void)commonMDCFlexibleHeaderViewControllerInit {
  self.fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];

  // Behavioral flags.
  self.fhvc.topLayoutGuideAdjustmentEnabled = YES;
  self.fhvc.inferTopSafeAreaInsetFromViewController = YES;
  self.fhvc.headerView.minMaxHeightIncludesSafeArea = NO;

  self.fhvc.headerView.sharedWithManyScrollViews = YES;
  self.fhvc.headerView.maximumHeight = 200;
  [self addChildViewController:_fhvc];
}

- (void)typicalFlexibleHeaderViewDidLoad {
  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  self.fhvc.headerView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

@end

@implementation FlexibleHeaderHorizontalPagingViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Flexible Header", @"Horizontal Paging" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
