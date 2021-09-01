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

#import <UIKit/UIKit.h>

#import "MaterialPageControl.h"

@interface PageControlTypicalUseViewController : UIViewController <UIScrollViewDelegate>
@end

@implementation PageControlTypicalUseViewController {
  UIScrollView *_scrollView;
  MDCPageControl *_pageControl;
  NSArray *_pages;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect standardizedFrame = CGRectStandardize(self.view.frame);
  CGFloat boundsWidth = CGRectGetWidth(standardizedFrame);
  CGFloat boundsHeight = CGRectGetHeight(standardizedFrame);

  NSArray *pageColors = @[
    [UIColor colorWithWhite:(CGFloat)0.2 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.3 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.2 alpha:1],
  ];

  // Scroll view configuration
  _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _scrollView.delegate = self;
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(boundsWidth * pageColors.count, boundsHeight);
  _scrollView.showsHorizontalScrollIndicator = NO;
  [self.view addSubview:_scrollView];

  NSMutableArray *pages = [NSMutableArray array];

  // Add pages to scrollView.
  for (NSUInteger i = 0; i < pageColors.count; i++) {
    CGFloat xOffset = [self xOffsetForPage:i numberOfPages:pageColors.count width:boundsWidth];
    CGRect pageFrame = CGRectOffset(self.view.bounds, xOffset, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    CGFloat offsetMultiplier = [self offsetMultiplierForPage:i numberOfPages:pageColors.count];
    page.text = [NSString stringWithFormat:@"Page %lu", (unsigned long)offsetMultiplier + 1];
    page.font = [UIFont systemFontOfSize:50];
    page.textColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.8];
    page.textAlignment = NSTextAlignmentCenter;
    page.backgroundColor = pageColors[i];
    page.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_scrollView addSubview:page];
    if ([self isRTL]) {
      [pages insertObject:page atIndex:0];
    } else {
      [pages addObject:page];
    }
  }
  _pages = [pages copy];

  // Page control configuration.
  _pageControl = [[MDCPageControl alloc] initWithFrame:CGRectZero];
  _pageControl.numberOfPages = pageColors.count;
  _pageControl.respectsUserInterfaceLayoutDirection = YES;
  _pageControl.currentPageIndicatorTintColor = UIColor.whiteColor;
  _pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;

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
  for (NSInteger i = 0; i < pageCount; i++) {
    UILabel *page = _pages[i];
    CGFloat xOffset = [self xOffsetForPage:i
                             numberOfPages:pageCount
                                     width:CGRectGetWidth(standardizedFrame)];
    page.frame = CGRectOffset(self.view.bounds, xOffset, 0);
  }
  _scrollView.contentSize =
      CGSizeMake(CGRectGetWidth(standardizedFrame) * pageCount, CGRectGetHeight(standardizedFrame));
  CGPoint offset = _scrollView.contentOffset;
  CGFloat xOffset = [self xOffsetForPage:pageBeforeFrameChange
                           numberOfPages:pageCount
                                   width:CGRectGetWidth(standardizedFrame)];
  offset.x = xOffset;
  // This non-anmiated change of offset ensures we keep the same page
  [_scrollView setContentOffset:offset animated:NO];
  _scrollView.frame = self.view.bounds;

  // We want the page control to hug the bottom of the screen.
  UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
  // Accommodate insets for iPhone X.
  edgeInsets = self.view.safeAreaInsets;
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
  CGFloat xOffset = [self xOffsetForPage:page numberOfPages:_pages.count width:pageWidth];
  offset.x = xOffset;
  [_scrollView setContentOffset:offset animated:YES];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Page Control", @"Page Control" ],
    @"description" : @"This control is designed to be a drop-in replacement for UIPageControl, "
                     @"with a user experience influenced by Material Design.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

- (CGFloat)xOffsetForPage:(NSInteger)page
            numberOfPages:(NSInteger)numberOfPages
                    width:(CGFloat)width {
  return [self offsetMultiplierForPage:page numberOfPages:numberOfPages] * width;
}

- (CGFloat)offsetMultiplierForPage:(NSInteger)page numberOfPages:(NSInteger)numberOfPages {
  return [self isRTL] ? numberOfPages - page - 1 : page;
}

- (BOOL)isRTL {
  return self.view.effectiveUserInterfaceLayoutDirection ==
         UIUserInterfaceLayoutDirectionRightToLeft;
}

@end
