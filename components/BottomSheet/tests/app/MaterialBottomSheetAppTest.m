#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MaterialBottomSheet.h"

static CGSize const kContentSize = {200, 74};
static NSTimeInterval const kExpectationTimeout = 1;

#define MDCAssertEqualCGSizes(size1, size2)                            \
  XCTAssertTrue(CGSizeEqualToSize((size1), (size2)), @"Size %@ != %@", \
                NSStringFromCGSize((size1)), NSStringFromCGSize((size2)));

#define MDCAssertEqualUIEdgeInsets(insets1, insets2)                                     \
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets((insets1), (insets2)), @"Insets %@ != %@", \
                NSStringFromUIEdgeInsets((insets1)), NSStringFromUIEdgeInsets((insets2)));

@interface MaterialBottomSheetAppTest : XCTestCase

@property(nonatomic) UIWindow *window;
@property(nonatomic, nullable) UIViewController *viewController;
@property(nonatomic, nullable) UICollectionViewController *collectionViewController;

@end

@implementation MaterialBottomSheetAppTest

#pragma mark - XCTestCase

- (void)setUp {
  [super setUp];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
  [self.window makeKeyAndVisible];
}

- (void)tearDown {
  [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
  self.window = nil;
  self.viewController = nil;
  self.collectionViewController = nil;
  [super tearDown];
}

#pragma mark - Common bottom sheet presentation logic

- (void)presentViewControllerInBottomSheetAndWaitForCompletion:(UIViewController *)viewController
                                        withTrackingScrollView:
                                            (nullable UIScrollView *)trackingScrollView {
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Presentation should complete"];
  MDCBottomSheetController *controller =
      [[MDCBottomSheetController alloc] initWithContentViewController:viewController];
  if (trackingScrollView) {
    controller.trackingScrollView = trackingScrollView;
  }
  [self.window.rootViewController presentViewController:controller
                                               animated:NO
                                             completion:^{
                                               [expectation fulfill];
                                             }];
  [self waitForExpectationsWithTimeout:kExpectationTimeout handler:nil];
}

- (void)presentViewControllerInBottomSheetWithTrackingScrollView:
    (nullable UIScrollView *)trackingScrollView {
  self.viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
  self.viewController.preferredContentSize = kContentSize;
  if (trackingScrollView) {
    trackingScrollView.frame = self.viewController.view.bounds;
    trackingScrollView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.viewController.view addSubview:trackingScrollView];
  }
  [self presentViewControllerInBottomSheetAndWaitForCompletion:self.viewController
                                        withTrackingScrollView:trackingScrollView];
}

- (void)presentCollectionViewControllerInBottomSheet {
  self.collectionViewController = [[UICollectionViewController alloc]
      initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
  self.collectionViewController.preferredContentSize = kContentSize;
  self.collectionViewController.collectionView.contentSize = kContentSize;
  [self presentViewControllerInBottomSheetAndWaitForCompletion:self.collectionViewController
                                        withTrackingScrollView:nil];
}

#pragma mark - Test cases

- (void)testPlainViewControllerUsesPreferredContentSize {
  [self presentViewControllerInBottomSheetWithTrackingScrollView:nil];

  CGSize expectedSize = kContentSize;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    expectedSize.height += self.viewController.view.safeAreaInsets.bottom;
  }
#endif
  MDCAssertEqualCGSizes(self.viewController.view.bounds.size, expectedSize);
}

- (void)testCollectionViewControllerSetsContentInset {
  [self presentCollectionViewControllerInBottomSheet];

  UIEdgeInsets expectedEdgeInsets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    expectedEdgeInsets.bottom = self.collectionViewController.view.safeAreaInsets.bottom;
  }
#endif
  MDCAssertEqualUIEdgeInsets(self.collectionViewController.collectionView.contentInset,
                             expectedEdgeInsets);
}

- (void)testCollectionViewControllerSetsBoundsToPreferredContentSize {
  [self presentCollectionViewControllerInBottomSheet];

  CGSize expectedSize = kContentSize;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    expectedSize.height += self.collectionViewController.view.safeAreaInsets.bottom;
  }
#endif
  MDCAssertEqualCGSizes(self.collectionViewController.view.bounds.size, expectedSize);
}

- (void)testViewControllerWithTrackingScrollViewSetsContentInset {
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  scrollView.contentSize = kContentSize;
  [self presentViewControllerInBottomSheetWithTrackingScrollView:scrollView];

  UIEdgeInsets expectedEdgeInsets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    expectedEdgeInsets.bottom = self.viewController.view.safeAreaInsets.bottom;
  }
#endif
  MDCAssertEqualUIEdgeInsets(scrollView.contentInset, expectedEdgeInsets);
}

- (void)testViewControllerWithTrackingScrollViewSetsBoundsToPreferredSize {
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  scrollView.contentSize = kContentSize;
  [self presentViewControllerInBottomSheetWithTrackingScrollView:scrollView];

  CGSize expectedSize = kContentSize;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    expectedSize.height += self.viewController.view.safeAreaInsets.bottom;
  }
#endif
  MDCAssertEqualCGSizes(self.viewController.view.bounds.size, expectedSize);
}

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)

// These tests only make sense for iOS 11 and later.
- (void)testViewControllerWithTrackingScrollViewAndContentInsetAdjustmentAlwaysSetsContentInset {
  // Unfortunately, we cannot use if (!@available(...)) { return }; that raises a compiler warning:
  //
  //   error: @available does not guard availability here; use if (@available) instead
  //   [-Werror,-Wunsupported-availability-guard]
  if (@available(iOS 11.0, *)) {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollView.contentSize = kContentSize;
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    [self presentViewControllerInBottomSheetWithTrackingScrollView:scrollView];
    UIEdgeInsets expectedEdgeInsets = UIEdgeInsetsZero;
    expectedEdgeInsets.bottom = self.viewController.view.safeAreaInsets.bottom;
    MDCAssertEqualUIEdgeInsets(scrollView.contentInset, expectedEdgeInsets);
  }
}

- (void)testViewControllerWithTrackingScrollViewAndContentInsetAdjustmentAlwaysSetsBounds {
  if (@available(iOS 11.0, *)) {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollView.contentSize = kContentSize;
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    [self presentViewControllerInBottomSheetWithTrackingScrollView:scrollView];
    CGSize expectedSize = kContentSize;
    expectedSize.height += self.viewController.view.safeAreaInsets.bottom;
    MDCAssertEqualCGSizes(self.viewController.view.bounds.size, expectedSize);
  }
}

#endif

@end
