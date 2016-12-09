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

#import <XCTest/XCTest.h>
#import "MaterialFlexibleHeader.h"

// Extension to MDCFlexibleHeaderViewController for Tests Only to Expose Private Property
@interface MDCFlexibleHeaderViewController (Testable)

@property (nonatomic) CGFloat flexibleHeaderViewControllerHeightOffset;

@end

// Test ViewController Class Utilizing MDCFlexibleHeaderViewController
@interface TopLayoutGuideTestClass : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TopLayoutGuideTestClass

- (instancetype)init {
  self = [super init];
  if (self) {
    self.fhvc = [[MDCFlexibleHeaderViewController alloc] init];
    [self addChildViewController:self.fhvc];
    self.scrollView = [[UIScrollView alloc] init];
  }
  return self;
}

// Mock Setup
- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView.delegate = self;
  self.scrollView.frame = self.view.bounds;
  self.scrollView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 2000);
  [self.view addSubview:self.scrollView];
  self.fhvc.headerView.trackingScrollView = self.scrollView;
  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self.fhvc updateTopLayoutGuide];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                                    targetContentOffset:targetContentOffset];
  }
}

@end

@interface FlexibleHeaderViewControllerTopLayoutGuideTests : XCTestCase

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) TopLayoutGuideTestClass *vc;

@end

@implementation FlexibleHeaderViewControllerTopLayoutGuideTests

- (void)setUp {
  [super setUp];

  // Given
  self.window = [[UIWindow alloc] init];
  self.vc = [[TopLayoutGuideTestClass alloc] init];

  self.window.rootViewController = self.vc;
  self.vc.view.frame = [UIScreen mainScreen].bounds;
  [self.window addSubview:self.vc.view];
}

- (void)tearDown {
  self.window = nil;
  self.vc = nil;
  [super tearDown];
}

// Test the Flexible Header View Height Offset After Initial Setup
- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffsetSettingMinHeight {

  // When
  CGFloat randomHeight = arc4random_uniform(200.0) + 20.0; // Height Greater Than Status Bar
  self.vc.fhvc.headerView.minimumHeight = randomHeight;

  // Then
  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, randomHeight);
}

- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffsetScrollingUpOffscreenKeepStatus {

  // When
  self.vc.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
  CGRect offScreenScroll = CGRectMake(0,
                                      [UIScreen mainScreen].bounds.size.height,
                                      [UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.height);
  [self.vc.scrollView scrollRectToVisible:offScreenScroll animated:NO];

  // Then
  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, 20);
}

- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffsetScrollingUpOffscreenHideStatus {

  // When
  self.vc.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
  CGRect offScreenScroll = CGRectMake(0,
                                      [UIScreen mainScreen].bounds.size.height,
                                      [UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.height);
  [self.vc.scrollView scrollRectToVisible:offScreenScroll animated:NO];

  // Then
  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, 0);
}

- (void)testFlexibleHeaderViewControllerTopLayoutGuideHeightOffPullDownRelease {

  // When
  CGFloat randomHeight = arc4random_uniform(200.0) + 20.0;
  self.vc.fhvc.headerView.maximumHeight = randomHeight;
  CGFloat initialYOffset = -self.vc.scrollView.contentInset.top;
  CGRect initialFrame = CGRectMake(0,
                                   self.vc.scrollView.contentInset.top,
                                   [UIScreen mainScreen].bounds.size.width,
                                   [UIScreen mainScreen].bounds.size.height);
  CGRect pulledFrame = CGRectMake(0,
                                  -600,
                                  [UIScreen mainScreen].bounds.size.width,
                                  [UIScreen mainScreen].bounds.size.height);

  // Pull Down
  [self.vc.scrollView scrollRectToVisible:pulledFrame animated:NO];
  // Release
  [self.vc.scrollView scrollRectToVisible:initialFrame animated:NO];

  // Then
  XCTAssertEqual(self.vc.fhvc.flexibleHeaderViewControllerHeightOffset, randomHeight);
}

@end
