/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCPageControl.h"

@interface PageControlAnimationBlockExample : UIViewController <UIScrollViewDelegate>
@end

#define RGBCOLOR(r, g, b) \
  [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define HEXCOLOR(hex) RGBCOLOR((((hex) >> 16) & 0xFF), (((hex) >> 8) & 0xFF), ((hex)&0xFF))

@implementation PageControlAnimationBlockExample {
  UIScrollView *_scrollView;
  MDCPageControl *_pageControl;
  NSArray *_pages;
  UIButton *_incrementButton;
  UIButton *_decrementButton;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Page Control", @"Page Control with animation block" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGFloat boundsWidth = CGRectGetWidth(self.view.bounds);
  CGFloat boundsHeight = CGRectGetHeight(self.view.bounds);

  NSArray *pageColors = @[
    HEXCOLOR(0x55C4f5), HEXCOLOR(0x35B7F3), HEXCOLOR(0x1EAAF1), HEXCOLOR(0x35B7F3),
    HEXCOLOR(0x1EAAF1)
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
  for (NSInteger i = 0; i < pageColors.count; i++) {
    CGRect pageFrame = CGRectOffset(self.view.bounds, i * boundsWidth, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    page.text = [NSString stringWithFormat:@"Page %zd", i + 1];
    page.font = [UIFont systemFontOfSize:50];
    page.textColor = [UIColor colorWithWhite:0 alpha:0.8];
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
  _incrementButton.center =
      CGPointMake(boundsWidth - _incrementButton.frame.size.width / 2 - 16, _pageControl.center.y);
  _incrementButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
  [_incrementButton addTarget:self
                       action:@selector(didTapButton:)
             forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_incrementButton];

  _decrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_decrementButton setTitle:@"-2 Pages" forState:UIControlStateNormal];
  [_decrementButton sizeToFit];
  _decrementButton.center =
      CGPointMake(_decrementButton.frame.size.width / 2 + 16, _pageControl.center.y);
  _decrementButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
  [_decrementButton addTarget:self
                       action:@selector(didTapButton:)
             forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_decrementButton];
}

#pragma mark - Frame changes

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  NSInteger pageBeforeFrameChange = _pageControl.currentPage;
  NSInteger pageCount = _pages.count;
  CGFloat boundsWidth = CGRectGetWidth(self.view.bounds);
  CGFloat boundsHeight = CGRectGetHeight(self.view.bounds);
  for (NSInteger i = 0; i < pageCount; i++) {
    UILabel *page = [_pages objectAtIndex:i];
    page.frame = CGRectOffset(self.view.bounds, i * boundsWidth, 0);
  }
  _scrollView.contentSize = CGSizeMake(boundsWidth * pageCount, boundsHeight);
  CGPoint offset = _scrollView.contentOffset;
  offset.x = pageBeforeFrameChange * boundsWidth;
  // This non-anmiated change of offset ensures we keep the same page
  [_scrollView setContentOffset:offset animated:NO];
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
  [UIView animateWithDuration:2
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     _scrollView.contentOffset = offset;
                   }
                   completion:nil];
}

@end
