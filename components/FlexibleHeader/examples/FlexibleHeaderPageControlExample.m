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

#import "FlexibleHeaderPageControlSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialPageControl.h"

static const CGFloat kFlexibleHeaderMinHeight = 200.f;

@interface FlexibleHeaderPageControlExample () <UIScrollViewDelegate>

@property(nonatomic) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic) MDCPageControl *pageControl;
@property(nonatomic) NSArray *pages;
@property(nonatomic) UIScrollView *pageScrollView;

@end

@implementation FlexibleHeaderPageControlExample

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
  _fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];
  _fhvc.headerView.minimumHeight = kFlexibleHeaderMinHeight;
  [self addChildViewController:_fhvc];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.backgroundColor = [UIColor whiteColor];
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.scrollView];

  self.scrollView.delegate = self;
  self.fhvc.headerView.trackingScrollView = self.scrollView;

  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  self.fhvc.headerView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];

  CGFloat boundsWidth = CGRectGetWidth(self.fhvc.headerView.bounds);
  CGFloat boundsHeight = CGRectGetHeight(self.fhvc.headerView.bounds);

  NSArray *pageColors = @[ [UIColor colorWithWhite:0.1 alpha:1],
                           [UIColor colorWithWhite:0.2 alpha:1],
                           [UIColor colorWithWhite:0.3 alpha:1]];


  // Scroll view configuration
  CGRect pageScrollViewFrame = CGRectMake(0, 0, boundsWidth, boundsHeight);
  self.pageScrollView = [[UIScrollView alloc] initWithFrame:pageScrollViewFrame];
  self.pageScrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.pageScrollView.delegate = self;
  self.pageScrollView.pagingEnabled = YES;
  self.pageScrollView.contentSize = CGSizeMake(boundsWidth * pageColors.count, boundsHeight);
  self.pageScrollView.showsHorizontalScrollIndicator = NO;
  [self.fhvc.headerView addSubview:self.pageScrollView];

  NSMutableArray *pages = [NSMutableArray array];

  // Add pages to scrollView.
  for (NSInteger i = 0; i < pageColors.count; i++) {
    CGRect pageFrame = CGRectOffset(pageScrollViewFrame, i * boundsWidth, 0);
    UILabel *page = [[UILabel alloc] initWithFrame:pageFrame];
    page.text = [NSString stringWithFormat:@"Page %zd", i + 1];
    page.font = [UIFont systemFontOfSize:18];
    page.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    page.textAlignment = NSTextAlignmentCenter;
    page.backgroundColor = pageColors[i];
    page.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.pageScrollView addSubview:page];
    [pages addObject:page];
  }
  self.pages = [pages copy];

  // Page control configuration.
  self.pageControl = [[MDCPageControl alloc] init];
  self.pageControl.numberOfPages = pageColors.count;

  // We want the page control to span the bottom of the screen.
  CGSize pageControlSize = [self.pageControl sizeThatFits:self.view.bounds.size];
  self.pageControl.frame =
      CGRectMake(0, boundsHeight - pageControlSize.height, boundsWidth, pageControlSize.height);
  [self.pageControl addTarget:self
                       action:@selector(didChangePage:)
             forControlEvents:UIControlEventValueChanged];
  self.pageControl.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
  [self.fhvc.headerView addSubview:self.pageControl];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
  // comment this line:
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.scrollView) {
    [self.fhvc scrollViewDidScroll:scrollView];
  } else if (scrollView == self.pageScrollView) {
    [_pageControl scrollViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.pageScrollView) {
    [_pageControl scrollViewDidEndDecelerating:scrollView];
  }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  if (scrollView == self.pageScrollView) {
    [_pageControl scrollViewDidEndScrollingAnimation:scrollView];
  }
}

#pragma mark - User events

- (void)didChangePage:(MDCPageControl *)sender {
  CGPoint offset = self.pageScrollView.contentOffset;
  offset.x = sender.currentPage * self.pageScrollView.bounds.size.width;
  [self.pageScrollView setContentOffset:offset animated:YES];
}

@end
