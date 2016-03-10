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

#import "MaterialScrollViewDelegateMultiplexer.h"
#import "ObservingPageControl.h"

@interface SVDMTypicalUseViewController : UIViewController <UIScrollViewDelegate>
@end

#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define HEXCOLOR(hex) RGBCOLOR((((hex) >> 16) & 0xFF), (((hex) >> 8) & 0xFF), ((hex)&0xFF))

@implementation SVDMTypicalUseViewController {
  UIScrollView *_scrollView;
  UIPageControl *_pageControl;

  MDCScrollViewDelegateMultiplexer *_multiplexer;
}

+ (NSArray *)catalogHierarchy {
  return @[ @"ScrollViewDelegate Multiplexer", @"Typical use" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGFloat boundsWidth = CGRectGetWidth(self.view.bounds);
  CGFloat boundsHeight = CGRectGetHeight(self.view.bounds);

  NSArray *pageColors = @[ HEXCOLOR(0x81D4FA), HEXCOLOR(0x80CBC4), HEXCOLOR(0xFFCC80) ];

  // Scroll view configuration

  _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  _scrollView.pagingEnabled = YES;
  _scrollView.contentSize = CGSizeMake(boundsWidth * pageColors.count, boundsHeight);
  _scrollView.minimumZoomScale = 0.5;
  _scrollView.maximumZoomScale = 6.0;

  // Add pages to scrollView.
  for (NSInteger i = 0; i < pageColors.count; i++) {
    CGRect pageFrame = CGRectOffset(self.view.bounds, i * boundsWidth, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    page.text = [NSString stringWithFormat:@"Page %zd", i + 1];
    page.font = [UIFont systemFontOfSize:50];
    page.textColor = [UIColor colorWithWhite:0 alpha:0.8];
    page.textAlignment = NSTextAlignmentCenter;
    page.backgroundColor = pageColors[i];
    [_scrollView addSubview:page];
  }

  // Page control configuration

  ObservingPageControl *pageControl = [[ObservingPageControl alloc] init];
  pageControl.numberOfPages = pageColors.count;

  pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.2];
  pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.8];

  CGSize pageControlSize = [pageControl sizeThatFits:self.view.bounds.size];
  // We want the page control to span the bottom of the screen.
  pageControlSize.width = self.view.bounds.size.width;
  pageControl.frame = CGRectMake(0,
                                 self.view.bounds.size.height - pageControlSize.height,
                                 self.view.bounds.size.width,
                                 pageControlSize.height);
  [pageControl addTarget:self
                  action:@selector(didChangePage:)
        forControlEvents:UIControlEventValueChanged];
  pageControl.defersCurrentPageDisplay = YES;
  _pageControl = pageControl;

  // Add subviews

  [self.view addSubview:_scrollView];
  [self.view addSubview:pageControl];

  // Create scrollView delegate multiplexer and register observers

  _multiplexer = [[MDCScrollViewDelegateMultiplexer alloc] init];
  _scrollView.delegate = _multiplexer;
  [_multiplexer addObservingDelegate:self];
  [_multiplexer addObservingDelegate:pageControl];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  NSLog(@"%@", NSStringFromSelector(_cmd));

  [_pageControl updateCurrentPageDisplay];
}

#pragma mark - User events

- (void)didChangePage:(UIPageControl *)sender {
  CGPoint offset = _scrollView.contentOffset;
  offset.x = sender.currentPage * _scrollView.bounds.size.width;
  [_scrollView setContentOffset:offset animated:YES];
}

@end
