// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import <MDFInternationalization/MDFInternationalization.h>
#import <UIKit/UIKit.h>

#import "MaterialPageControl.h"

@interface PageControlTypicalUseViewController : UIViewController <UIScrollViewDelegate>
@end

@implementation PageControlTypicalUseViewController {
  UIScrollView *_scrollView;
  MDCPageControl *_pageControl;
  NSMutableDictionary *_pages;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect standardizedFrame = CGRectStandardize(self.view.frame);
  CGFloat boundsWidth = CGRectGetWidth(standardizedFrame);
  CGFloat boundsHeight = CGRectGetHeight(standardizedFrame);

  NSArray *pageColors = @[
    [UIColor colorWithWhite:(CGFloat)0.9 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.8 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.7 alpha:1],
  ];

  // Scroll view configuration
  _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  if (@available(iOS 11.0, *)) {
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  }
  _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _scrollView.delegate = self;
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(boundsWidth * pageColors.count, boundsHeight);
  _scrollView.showsHorizontalScrollIndicator = NO;
  [self.view addSubview:_scrollView];

  NSMutableDictionary *pages = [NSMutableDictionary new];

  // Add pages to scrollView.
  for (NSUInteger i = 0; i < pageColors.count; i++) {
    CGFloat offsetMultiplier = i;
    if (self.view.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      offsetMultiplier = pageColors.count - 1 - i;
    }
    CGRect pageFrame = CGRectOffset(self.view.bounds, offsetMultiplier * boundsWidth, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    page.text = [NSString stringWithFormat:@"Page %lu", (unsigned long)i + 1];
    page.font = [UIFont systemFontOfSize:50];
    page.textColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.8];
    page.textAlignment = NSTextAlignmentCenter;
    page.backgroundColor = pageColors[i];
    page.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_scrollView addSubview:page];
    pages[@(i)] = page;
  }
  _pages = [pages copy];

  // Page control configuration.
  _pageControl = [[MDCPageControl alloc] initWithFrame:CGRectZero];
  _pageControl.numberOfPages = pageColors.count;
  _pageControl.respectsUserInterfaceLayoutDirection = YES;

  [_pageControl addTarget:self
                   action:@selector(didChangePage:)
         forControlEvents:UIControlEventValueChanged];
  _pageControl.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pageControl];

  [self.view setNeedsLayout];
}

#pragma mark - Frame changes

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  NSInteger pageBeforeFrameChange = _pageControl.currentPage;
  NSInteger pageCount = _pages.count;
  CGRect standardizedFrame = CGRectStandardize(self.view.frame);
  NSInteger numberOfPages = _pages.allKeys.count;
  BOOL isRightToLeft = self.view.mdf_effectiveUserInterfaceLayoutDirection ==
                       UIUserInterfaceLayoutDirectionRightToLeft;
  for (NSInteger i = 0; i < pageCount; i++) {
    UILabel *page = _pages[@(i)];
    NSInteger offsetMultiplier = isRightToLeft ? numberOfPages - 1 - i : i;
    page.frame =
        CGRectOffset(self.view.bounds, offsetMultiplier * CGRectGetWidth(standardizedFrame), 0);
  }
  _scrollView.contentSize =
      CGSizeMake(CGRectGetWidth(standardizedFrame) * pageCount, CGRectGetHeight(standardizedFrame));
  CGPoint offset = _scrollView.contentOffset;
  NSInteger offsetMultiplier =
      isRightToLeft ? numberOfPages - 1 - pageBeforeFrameChange : pageBeforeFrameChange;
  offset.x = offsetMultiplier * CGRectGetWidth(standardizedFrame);
  // This non-anmiated change of offset ensures we keep the same page
  [_scrollView setContentOffset:offset animated:NO];
  _scrollView.frame = self.view.bounds;

  // We want the page control to hug the bottom of the screen.
  UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    // Accommodate insets for iPhone X.
    edgeInsets = self.view.safeAreaInsets;
  }
  [_pageControl sizeToFit];
  CGFloat yOffset =
      CGRectGetHeight(self.view.frame) - CGRectGetHeight(_pageControl.frame) - edgeInsets.bottom;
  _pageControl.frame =
      CGRectMake(0, yOffset, CGRectGetWidth(self.view.frame), CGRectGetHeight(_pageControl.frame));
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_pageControl scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [_pageControl scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [_pageControl scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - User events

- (void)didChangePage:(MDCPageControl *)sender {
  NSInteger page = sender.currentPage;
  CGFloat pageWidth = CGRectGetWidth(_scrollView.bounds);
  CGPoint offset = _scrollView.contentOffset;
  CGFloat offsetMultiplier = page;
  if (self.view.mdf_effectiveUserInterfaceLayoutDirection ==
      UIUserInterfaceLayoutDirectionRightToLeft) {
    offsetMultiplier = _pages.count - 1 - page;
  }
  offset.x = offsetMultiplier * pageWidth;
  [_scrollView setContentOffset:offset animated:YES];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Page Control", @"Page Control" ],
    @"description": @"This control is designed to be a drop-in replacement for UIPageControl, "
    @"with a user experience influenced by Material Design.",
    @"primaryDemo": @YES,
    @"presentable": @YES,
  };
}

@end
