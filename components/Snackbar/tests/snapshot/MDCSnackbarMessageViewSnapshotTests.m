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
#import "../../src/private/MDCSnackbarManagerInternal.h"
#import "../../src/private/MDCSnackbarMessageViewInternal.h"
#import "../../src/private/MDCSnackbarOverlayView.h"
// clang-format on

/** The snackbar's animate-in duration, pulled from MDCSnackbarOverlayView.m */
NSTimeInterval const MDCSnackbarEnterTransitionDuration = 0.15;

/** The legacy snackbar's animate-in duration, pulled from MDCSnackbarOverlayView.m */
NSTimeInterval const MDCSnackbarLegacyTransitionDuration = 0.5;

/** Extra delay to ensure the snackbar finishes animating in */
NSTimeInterval const MDCSnackbarDurationPadding = 0.05;

/** The width of the Snackbar for testing. */
static const CGFloat kWidth = 180;

/** Height of a Snackbar with 1 line of message text. */
static const CGFloat kHeightSingleLineText = 48;

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

@interface MDCSnackbarManagerInternal (MDCSnackbarMessageViewSnapshotTests)

@property(nonatomic) MDCSnackbarOverlayView *overlayView;

@end

@interface MDCSnackbarManager (MDCSnackbarMessageViewSnapshotTests)

@property(nonnull, nonatomic, strong) MDCSnackbarManagerInternal *internalManager;

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
  MDCSnackbarMessage.usesLegacySnackbar = NO;
  self.testManager = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
  [self snapshotVerifyView:snapshotView];
}

- (MDCSnackbarMessageView *)snackbarMessageViewWithMessage:(MDCSnackbarMessage *)message {
  return [[MDCSnackbarMessageView alloc] initWithMessage:message
                                          dismissHandler:nil
                                         snackbarManager:self.testManager];
}

- (MDCSnackbarMessageView *)snackbarMessageViewWithText:(NSString *)text
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
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithShortMessageNoActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Arabic
                                                              actionTitle:nil];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageNoActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Latin
                                                              actionTitle:nil];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageNoActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Arabic
                                                              actionTitle:nil];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithShortMessageShortActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithShortMessageShortActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Arabic
                                                              actionTitle:kItemTitleShort2Arabic];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageLongActionLTRLatin {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Latin
                                                              actionTitle:kItemTitleLong2Latin];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithLongMessageLongActionRTLArabic {
  // When
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleLong1Arabic
                                                              actionTitle:kItemTitleLong2Arabic];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);
  [self changeViewToRTL:messageView];

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithZeroElevation {
  // Given
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // When
  messageView.elevation = 0;

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithCustomElevation {
  // Given
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // When
  messageView.elevation = 12;

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testLegacyWithTallHeight {
  // Given
  MDCSnackbarMessage.usesLegacySnackbar = YES;
  MDCSnackbarMessage *message = [MDCSnackbarMessage
      messageWithText:
          @"long text long text long text long text long text long text long text long text long "
          @"text long text long text long text long text long text long text long text long text "
          @"long text long text long text long text long text long text long text"];
  self.testManager.internalManager.overlayView.backgroundColor = UIColor.whiteColor;

  // When
  [self.testManager showMessage:message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((MDCSnackbarLegacyTransitionDuration +
                                                             MDCSnackbarDurationPadding) *
                                                            NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   [self.testManager.internalManager.overlayView layoutSubviews];
                   [expectation fulfill];
                 });
  [self waitForExpectationsWithTimeout:2 handler:nil];

  // Then
  [self snapshotVerifyView:self.testManager.internalManager.overlayView];
}

- (void)testLegacyWithTallHeightAndAction {
  // Given
  MDCSnackbarMessage.usesLegacySnackbar = YES;
  MDCSnackbarMessage *message = [MDCSnackbarMessage
      messageWithText:
          @"long text long text long text long text long text long text long text long text long "
          @"text long text long text long text long text long text long text long text long text "
          @"long text long text long text long text long text long text long text"];
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap me";
  message.action = action;
  self.testManager.internalManager.overlayView.backgroundColor = UIColor.whiteColor;

  // When
  [self.testManager showMessage:message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((MDCSnackbarLegacyTransitionDuration +
                                                             MDCSnackbarDurationPadding) *
                                                            NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   [self.testManager.internalManager.overlayView layoutSubviews];
                   [expectation fulfill];
                 });
  [self waitForExpectationsWithTimeout:2 handler:nil];

  // Then
  [self snapshotVerifyView:self.testManager.internalManager.overlayView];
}

- (void)testWithTallHeight {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage
      messageWithText:
          @"long text long text long text long text long text long text long text long text long "
          @"text long text long text long text long text long text long text long text long text "
          @"long text long text long text long text long text long text long text"];
  self.testManager.internalManager.overlayView.backgroundColor = UIColor.whiteColor;

  // When
  [self.testManager showMessage:message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((MDCSnackbarEnterTransitionDuration +
                                                             MDCSnackbarDurationPadding) *
                                                            NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   [expectation fulfill];
                 });
  [self waitForExpectationsWithTimeout:2 handler:nil];

  // Then
  [self snapshotVerifyView:self.testManager.internalManager.overlayView];
}

- (void)testWithTallHeightAndAction {
  // Given
  MDCSnackbarMessage *message = [MDCSnackbarMessage
      messageWithText:
          @"long text long text long text long text long text long text long text long text long "
          @"text long text long text long text long text long text long text long text long text "
          @"long text long text long text long text long text long text long text"];
  MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
  action.title = @"Tap me";
  message.action = action;
  self.testManager.internalManager.overlayView.backgroundColor = UIColor.whiteColor;

  // When
  [self.testManager showMessage:message];
  XCTestExpectation *expectation = [self expectationWithDescription:@"completed"];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((MDCSnackbarEnterTransitionDuration +
                                                             MDCSnackbarDurationPadding) *
                                                            NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   [expectation fulfill];
                 });
  [self waitForExpectationsWithTimeout:2 handler:nil];

  // Then
  [self snapshotVerifyView:self.testManager.internalManager.overlayView];
}

@end
