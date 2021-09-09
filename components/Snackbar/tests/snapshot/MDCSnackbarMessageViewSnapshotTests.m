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

#import "MaterialSnapshot.h"

// Clang-format wants to reorder these imports, but CocoaPods will fail to build if the main target
// isn't imported first.
// clang-format off
#import "MaterialSnackbar.h"
#import "../../src/private/MDCSnackbarMessageViewInternal.h"
#import "../../src/private/MDCSnackbarManagerInternal.h"
#import "../../src/private/MDCSnackbarOverlayView.h"
// clang-format on

/** The width of the Snackbar for testing. */
static const CGFloat kWidth = 180;

static const CGFloat kAccessibilityFontSize = 25;

static NSString *const kItemTitleShort1Latin = @"Quando";
static NSString *const kItemTitleShort2Latin = @"No";

static NSString *const kItemTitleLong1Latin =
    @"Quando volumus maluisset cum ei, ad zril quodsi cum.";
static NSString *const kItemTitleLong2Latin = @"No quis modo nam, sea ea dicit tollit.";

static NSString *const kItemTitleShort1Arabic = @"عل";
static NSString *const kItemTitleShort2Arabic = @"قد";

static NSString *const kItemTitleLong1Arabic =
    @"عل أخذ استطاعوا الانجليزية. قد وحتّى بزمام التبرعات مكن.";
static NSString *const kItemTitleLong2Arabic =
    @"وتم عل والقرى إتفاقية, عن هذا وباءت الغالي وفرنسا.";

@interface MDCSnackbarManagerInternal (SnackbarManagerSnapshotTesting)
@property(nonatomic) MDCSnackbarOverlayView *overlayView;
@end

@interface MDCSnackbarManager (SnackbarManagerSnapshotTesting)
@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;
@end

/** A subclass of MDCSnackbarMessageView for testing that allows overriding the traitCollection. */
@interface MDCSnackbarSnapshotTestsMessageView : MDCSnackbarMessageView

/** Allows overriding @c traitCollection for testing. */
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;

@end

@implementation MDCSnackbarSnapshotTestsMessageView

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/** Snapshot tests for MDCSnackbarMessageView. */
@interface MDCSnackbarMessageViewSnapshotTests : MDCSnapshotTestCase

/** SnackbarManager to assign to snackbar views. */
@property(nonatomic, strong) MDCSnackbarManager *testManager;

@end

@implementation MDCSnackbarMessageViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.testManager = [[MDCSnackbarManager alloc] init];
}

- (void)tearDown {
  self.testManager = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
  [self snapshotVerifyView:snapshotView];
}

- (MDCSnackbarSnapshotTestsMessageView *)snackbarMessageViewWithMessage:
    (MDCSnackbarMessage *)message {
  MDCSnackbarSnapshotTestsMessageView *view =
      [[MDCSnackbarSnapshotTestsMessageView alloc] initWithMessage:message
                                                    dismissHandler:nil
                                                   snackbarManager:self.testManager];
  // The intrinsic content size will only be correct when the width of the frame is set due to
  // multiline label sizing. Note: this should not be an issue when the view is in actual use, but
  // is here in the artificial environment of a snapshot test.
  view.frame = CGRectMake(0, 0, kWidth, 0);
  return view;
}

- (MDCSnackbarSnapshotTestsMessageView *)snackbarMessageViewWithText:(NSString *)text
                                                         actionTitle:(NSString *)title {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = text;
  if (title) {
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.title = title;
    message.action = action;
  }
  return [self snackbarMessageViewWithMessage:message];
}

#pragma mark - Tests

- (void)testWithShortMessageNoActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:nil];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithShortMessageNoActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Arabic
                                                              actionTitle:nil];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageNoActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Latin
                                                              actionTitle:nil];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageNoActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Arabic
                                                              actionTitle:nil];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithShortMessageShortActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithShortMessageShortActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Arabic
                                                              actionTitle:kItemTitleShort2Arabic];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageLongActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Latin
                                                              actionTitle:kItemTitleLong2Latin];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

// Note that this test doesn't test whether or not the actual font size changes, only that the
// snackbar grows vertically with more text.
- (void)testWithLongMessageShortActionLTRLatinDynamicType {
  // Given
  MDCSnackbarSnapshotTestsMessageView *messageView =
      [self snackbarMessageViewWithText:kItemTitleLong1Latin actionTitle:kItemTitleShort2Latin];

  // When
  messageView
      .traitCollectionOverride = [UITraitCollection traitCollectionWithTraitsFromCollections:@[
    [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraExtraExtraLarge],
    [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular]
  ]];

  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

// Note that this test doesn't test whether or not the actual font size changes, only that layout
// switches from horizontal to vertical.
- (void)testWithLongMessageShortActionLTRLatinDynamicTypeAccessibilitySize {
  // Given
  MDCSnackbarSnapshotTestsMessageView *messageView =
      [self snackbarMessageViewWithText:kItemTitleLong1Latin actionTitle:kItemTitleShort2Latin];

  // When
  messageView.traitCollectionOverride =
      [UITraitCollection traitCollectionWithTraitsFromCollections:@[
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge],
        [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular]
      ]];
  messageView.messageFont = [UIFont systemFontOfSize:kAccessibilityFontSize];

  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageLongActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Arabic
                                                              actionTitle:kItemTitleLong2Arabic];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithZeroElevation {
  // Given
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // When
  messageView.elevation = 0;

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithCustomElevation {
  // Given
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // When
  messageView.elevation = 12;

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

// TODO(https://github.com/material-components/material-components-ios/issues/9372): determine why
// running this in Bazel produces a different-sized screenshot than what is produced by Xcode.
- (void)testSnackbarOverlayViewWithHighElevation {
  // Given
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // When
  messageView.elevation = 24;
  [self.testManager.internalManager.overlayView showSnackbarView:messageView
                                                        animated:NO
                                                      completion:nil];

  // This run loop drain is here to resolve Bazel flakiness.
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.testManager.internalManager.overlayView];
}

- (void)testSnackbarOverlayViewWithConfiguredMargins {
  // Given
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  [messageView mdc_layoutAndApplyBestFitFrameWithWidth:kWidth];

  // When
  self.testManager.leadingMargin = 100;
  self.testManager.trailingMargin = 5;
  [self.testManager.internalManager.overlayView showSnackbarView:messageView
                                                        animated:NO
                                                      completion:nil];

  // This run loop drain is here to resolve Bazel flakiness.
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_async(dispatch_get_main_queue(), ^{
    [expectation fulfill];
  });
  [self waitForExpectationsWithTimeout:3 handler:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.testManager.internalManager.overlayView];
}

@end
