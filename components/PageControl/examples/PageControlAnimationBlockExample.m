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

@interface PageControlAnimationBlockExample : UIViewController <UIScrollViewDelegate>
@end

@implementation PageControlAnimationBlockExample {
  UIScrollView *_scrollView;
  MDCPageControl *_pageControl;
  NSArray *_pages;
  UIButton *_incrementButton;
  UIButton *_decrementButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGFloat boundsWidth = CGRectGetWidth(self.view.bounds);
  CGFloat boundsHeight = CGRectGetHeight(self.view.bounds);

  NSArray *pageColors = @[
    [UIColor colorWithWhite:(CGFloat)0.2 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.3 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.4 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.5 alpha:1],
    [UIColor colorWithWhite:(CGFloat)0.6 alpha:1],
  ];

  // Scroll view configuration
  _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _scrollView.delegate = self;
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(boundsWidth * pageColors.count, boundsHeight);
  _scrollView.showsHorizontalScrollIndicator = NO;
  [self.view addSubview:_scrollView];

  NSMutableArray *pages = [NSMutableArray array];

  // Add pages to scrollView.
  for (NSUInteger i = 0; i < pageColors.count; i++) {
    CGRect pageFrame = CGRectOffset(self.view.bounds, i * boundsWidth, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    page.text = [NSString stringWithFormat:@"Page %lu", (unsigned long)(i + 1)];
    page.font = [UIFont systemFontOfSize:24];
    page.textColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.8];
    page.textAlignment = NSTextAlignmentCenter;
    page.backgroundColor = pageColors[i];
    page.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_scrollView addSubview:page];
    [pages addObject:page];
  }
  _pages = [pages copy];

  // Page control configuration.
  _pageControl = [[MDCPageControl alloc] init];
  _pageControl.numberOfPages = pageColors.count;
  _pageControl.currentPageIndicatorTintColor = UIColor.whiteColor;
  _pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;

  // We want the page control to span the bottom of the screen.
  CGSize pageControlSize = [_pageControl sizeThatFits:self.view.bounds.size];
  _pageControl.frame =
      CGRectMake(0, boundsHeight - pageControlSize.height, boundsWidth, pageControlSize.height);

  [_pageControl addTarget:self
                   action:@selector(didChangePage:)
         forControlEvents:UIControlEventValueChanged];
  _pageControl.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_pageControl];

  _incrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_incrementButton setTitle:@"+2 Pages" forState:UIControlStateNormal];
  [_incrementButton sizeToFit];
  _incrementButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
  [_incrementButton addTarget:self
                       action:@selector(didTapButton:)
             forControlEvents:UIControlEventTouchUpInside];
  [_incrementButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateDisabled];
  [self.view addSubview:_incrementButton];

  _decrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_decrementButton setTitle:@"-2 Pages" forState:UIControlStateNormal];
  _decrementButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
  [_decrementButton addTarget:self
                       action:@selector(didTapButton:)
             forControlEvents:UIControlEventTouchUpInside];
  [_decrementButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateDisabled];
  [self.view addSubview:_decrementButton];
}

#pragma mark - Frame changes

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  NSInteger pageBeforeFrameChange = _pageControl.currentPage;
  NSInteger pageCount = _pages.count;
  CGFloat boundsWidth = CGRectGetWidth(self.view.frame);
  CGFloat boundsHeight = CGRectGetHeight(self.view.frame);
  for (NSInteger i = 0; i < pageCount; i++) {
    UILabel *page = [_pages objectAtIndex:i];
    page.frame = CGRectOffset(self.view.bounds, i * boundsWidth, 0);
  }
  _scrollView.contentSize = CGSizeMake(boundsWidth * pageCount, boundsHeight);
  CGPoint offset = _scrollView.contentOffset;
  offset.x = pageBeforeFrameChange * boundsWidth;
  // This non-anmiated change of offset ensures we keep the same page
  [_scrollView setContentOffset:offset animated:NO];

  // We want the page control to span the bottom of the screen.
  CGRect standardizedFrame = CGRectStandardize(self.view.frame);
  [_pageControl sizeThatFits:standardizedFrame.size];
  UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    // Accommodate insets for iPhone X.
    edgeInsets = self.view.safeAreaInsets;
  }
  CGFloat yOffset =
      CGRectGetHeight(self.view.frame) - CGRectGetHeight(_pageControl.frame) - edgeInsets.bottom;
  _pageControl.frame =
      CGRectMake(0, yOffset, CGRectGetWidth(self.view.frame), CGRectGetHeight(_pageControl.frame));

  CGFloat buttonCenterX;

  [_incrementButton sizeToFit];
  buttonCenterX = boundsWidth - CGRectGetWidth(_incrementButton.frame) / 2 - 16 - edgeInsets.right;
  _incrementButton.center = CGPointMake(buttonCenterX, _pageControl.center.y);

  [_decrementButton sizeToFit];
  buttonCenterX = CGRectGetWidth(_decrementButton.frame) / 2 + 16 + edgeInsets.left;
  _decrementButton.center = CGPointMake(buttonCenterX, _pageControl.center.y);

  [self updateButtonStates];
}

- (void)updateButtonStates {
  if (_pageControl.currentPage == _pageControl.numberOfPages - 1) {
    _incrementButton.enabled = NO;
    _decrementButton.enabled = YES;
  } else if (_pageControl.currentPage == 0) {
    _decrementButton.enabled = NO;
    _incrementButton.enabled = YES;
  } else {
    _incrementButton.enabled = YES;
    _decrementButton.enabled = YES;
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_pageControl scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [_pageControl scrollViewDidEndDecelerating:scrollView];
  [self updateButtonStates];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [_pageControl scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - User events

- (void)didChangePage:(MDCPageControl *)sender {
  CGPoint offset = _scrollView.contentOffset;
  offset.x = sender.currentPage * _scrollView.bounds.size.width;
  [_scrollView setContentOffset:offset animated:YES];
}

- (void)didTapButton:(id)sender {
  NSInteger incrementAmount = 2;
  if ([sender isEqual:_incrementButton]) {
    incrementAmount = 2;
  } else if ([sender isEqual:_decrementButton]) {
    incrementAmount = -2;
  }
  NSUInteger nextPage =
      MIN(MAX(0, _pageControl.currentPage + incrementAmount), _pageControl.numberOfPages - 1);
  CGPoint offset = _scrollView.contentOffset;
  offset.x = nextPage * CGRectGetWidth(_scrollView.frame);
  [UIView animateWithDuration:0.2
      delay:0
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{
        self->_scrollView.contentOffset = offset;
      }
      completion:^(BOOL completed) {
        if (completed) {
          [self updateButtonStates];
        }
      }];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Page Control", @"Page Control with animation block" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
