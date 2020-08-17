// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <XCTest/XCTest.h>

#import "MaterialAvailability.h"
#import "MaterialButtonBar.h"

@interface MDCButtonBar (Testing)
- (NSArray<UIView *> *)viewsForItems:(NSArray<UIBarButtonItem *> *)barButtonItems;
@end

/// Unit tests for MDCButtonBar.
@interface MDCButtonBarTests : XCTestCase

@property(nonatomic, strong, nullable) MDCButtonBar *buttonBar;

@end

@implementation MDCButtonBarTests

- (void)setUp {
  [super setUp];

  self.buttonBar = [[MDCButtonBar alloc] init];
  self.buttonBar.uppercasesButtonTitles = NO;
  self.buttonBar.items = @[ [[UIBarButtonItem alloc] initWithTitle:@"Test"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil] ];
}

- (void)tearDown {
  self.buttonBar = nil;

  [super tearDown];
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCButtonBar *passedButtonBar;
  self.buttonBar.traitCollectionDidChangeBlock =
      ^(MDCButtonBar *_Nonnull buttonBar, UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedButtonBar = buttonBar;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.buttonBar traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedButtonBar, self.buttonBar);
}

#pragma mark - UILargeContentViewerItem

#if MDC_AVAILABLE_SDK_IOS(13_0)

- (void)testLargeContentTitleEqualsToTitle {
  if (@available(iOS 13.0, *)) {
    // Given
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];

    // When
    NSString *largeContentTitle = itemViews.firstObject.largeContentTitle;

    // Then
    XCTAssertEqualObjects(largeContentTitle, self.buttonBar.items.firstObject.title);
  }
}

/**
 Tests the large content image is the @c image property when no @c largeContentImage is
 specified.
 */
- (void)testLargeContentImageEqualsToDefaultImage {
  if (@available(iOS 13.0, *)) {
    // Given
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];

    // When
    UIImage *largeContentImage = itemViews.firstObject.largeContentImage;

    // Then
    XCTAssertEqualObjects(largeContentImage, self.buttonBar.items.firstObject.image);
  }
}

- (void)testSettingLargeContentImageOnBarButtonSetsItOnButtonBarView {
  if (@available(iOS 13.0, *)) {
    // Given
    UIImage *image = [[UIImage alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil];
    item.largeContentSizeImage = image;
    self.buttonBar.items = @[ item ];

    // When
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];
    UIImage *largeContentImage = itemViews.firstObject.largeContentImage;

    // Then
    XCTAssertEqualObjects(largeContentImage, image);
  }
}

- (void)testSettingImageWihNoTitleFallbacksToAccessibilityLabel {
  if (@available(iOS 13.0, *)) {
    // Given
    UIImage *image = [[UIImage alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil];
    item.accessibilityLabel = @"foo";
    self.buttonBar.items = @[ item ];

    // When
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];
    NSString *largeContentTitle = itemViews.firstObject.largeContentTitle;

    // Then
    XCTAssertEqualObjects(largeContentTitle, item.accessibilityLabel);
  }
}

- (void)testSettingLargeContentSizeImageInsetsOnBarButtonSetsItOnButtonBarView {
  if (@available(iOS 13.0, *)) {
    // Given
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Title"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil];
    item.largeContentSizeImageInsets = insets;
    self.buttonBar.items = @[ item ];

    // When
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];
    UIEdgeInsets largeImageInsets = itemViews.firstObject.largeContentImageInsets;

    // Then
    XCTAssertEqual(largeImageInsets.bottom, insets.bottom);
    XCTAssertEqual(largeImageInsets.top, insets.top);
    XCTAssertEqual(largeImageInsets.left, insets.left);
    XCTAssertEqual(largeImageInsets.right, insets.right);
  }
}

- (void)testLargeContentImageUpdatesWhenButtonBarPropertyUpdates {
  if (@available(iOS 13.0, *)) {
    // Given
    UIImage *image = [[UIImage alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil];
    self.buttonBar.items = @[ item ];

    // When
    item.largeContentSizeImage = image;
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];
    UIImage *largeContentImage = itemViews.firstObject.largeContentImage;

    // Then
    XCTAssertEqualObjects(largeContentImage, image);
  }
}

- (void)testLargeContentInsetUpdatesWhenButtonBarPropertyUpdates {
  if (@available(iOS 13.0, *)) {
    // Given
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Title"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil];
    self.buttonBar.items = @[ item ];

    // When
    item.largeContentSizeImageInsets = insets;
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];
    UIEdgeInsets largeImageInsets = itemViews.firstObject.largeContentImageInsets;

    // Then
    XCTAssertEqual(largeImageInsets.bottom, insets.bottom);
    XCTAssertEqual(largeImageInsets.top, insets.top);
    XCTAssertEqual(largeImageInsets.left, insets.left);
    XCTAssertEqual(largeImageInsets.right, insets.right);
  }
}

- (void)testLargeContentViewerInteractionWhenItemIsSelectedThenDeselectedButStillInNavBarBounds {
  if (@available(iOS 13.0, *)) {
    // Given
    NSString *title1 = @"Title1";
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:title1
                                                              style:UIBarButtonItemStylePlain
                                                             target:nil
                                                             action:nil];
    self.buttonBar.items = @[ item1 ];
    self.buttonBar.frame = CGRectMake(0, 0, 350, 125);
    [self.buttonBar layoutIfNeeded];
    UILargeContentViewerInteraction *interaction = [[UILargeContentViewerInteraction alloc] init];
    self.continueAfterFailure = NO;

    // When/Then
    XCTAssertTrue([self.buttonBar respondsToSelector:@selector(largeContentViewerInteraction:
                                                                                 itemAtPoint:)]);
    NSArray<UIView *> *itemViews = [self.buttonBar viewsForItems:self.buttonBar.items];
    CGPoint itemViewOrigin = itemViews.firstObject.frame.origin;
    id<UILargeContentViewerItem> largeContentItem =
        [self.buttonBar largeContentViewerInteraction:interaction itemAtPoint:itemViewOrigin];
    XCTAssertEqualObjects(largeContentItem.largeContentTitle, title1);

    largeContentItem = [self.buttonBar largeContentViewerInteraction:interaction
                                                         itemAtPoint:CGPointZero];
    XCTAssertEqualObjects(largeContentItem.largeContentTitle, title1);
  }
}

/**
 Tests the large content item is nil when the touch point is outside the navigation bar bounds.
 */
- (void)testLargeContentViewerInteractionWhenPointIsOutSideNavBarBounds {
  if (@available(iOS 13.0, *)) {
    // Given
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Title"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil];
    self.buttonBar.items = @[ item ];
    self.buttonBar.frame = CGRectMake(0, 0, 350, 125);
    [self.buttonBar layoutIfNeeded];
    UILargeContentViewerInteraction *interaction = [[UILargeContentViewerInteraction alloc] init];
    self.continueAfterFailure = NO;

    // When/Then
    XCTAssertTrue([self.buttonBar respondsToSelector:@selector(largeContentViewerInteraction:
                                                                                 itemAtPoint:)]);
    CGPoint pointOutsideNavBar = CGPointMake(-1, -1);

    id<UILargeContentViewerItem> largeContentItem =
        [self.buttonBar largeContentViewerInteraction:interaction itemAtPoint:pointOutsideNavBar];
    XCTAssertNil(largeContentItem);
  }
}
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

@end
