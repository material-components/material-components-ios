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
// clang-format on

/** The width of the Snackbar for testing. */
static const CGFloat kWidth = 180;

/** The width of the Snackbar for testing XXXL fonts. */
static const CGFloat kXXXLWidth = 320;

/** Height of a Snackbar with 1 line of message text. */
static const CGFloat kHeightSingleLineText = 48;

/** Height of a Snackbar with an XXXL font size  */
static const CGFloat kHeightXXXLText = 100;

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

/** Snapshot tests for MDCSnackbarMessageView. */
@interface MDCSnackbarMessageViewSnapshotTests : MDCSnapshotTestCase

/** SnackbarManager to assign to snackbar views. */
@property(nonatomic, strong) MDCSnackbarManager *testManager;

@end

@interface MDCSnackbarMessageViewWithCustomTraitCollection : MDCSnackbarMessageView
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCSnackbarMessageViewWithCustomTraitCollection
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

@implementation MDCSnackbarMessageViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
//    self.recordMode = YES;

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

- (void)testPreferredFontForXXXLContentSizeCategoryWithTitle {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"Testing"];

    self.testManager.adjustsFontForContentSizeCategory = YES;
    MDCSnackbarMessageViewWithCustomTraitCollection *messageView =
        [[MDCSnackbarMessageViewWithCustomTraitCollection alloc] initWithMessage:message
                                                                  dismissHandler:nil
                                                                 snackbarManager:self.testManager];
    messageView.frame = CGRectMake(0, 0, kXXXLWidth, kHeightXXXLText);

    // When
    UITraitCollection *xsTraitCollection =
        [UITraitCollection
          traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    messageView.traitCollectionOverride = xsTraitCollection;
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    messageView.messageFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:14]];

    UITraitCollection *aXXXLTraitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    messageView.traitCollectionOverride = aXXXLTraitCollection;

    // Then
    [self generateSnapshotAndVerifyForView:messageView];
  }
}

- (void)testPreferredFontForXXXLContentSizeCategoryWithTitleAndAction {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"Testing"];
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.title = @"Tap me";
    message.action = action;

    self.testManager.adjustsFontForContentSizeCategory = YES;
    MDCSnackbarMessageViewWithCustomTraitCollection *messageView =
        [[MDCSnackbarMessageViewWithCustomTraitCollection alloc] initWithMessage:message
                                                                  dismissHandler:nil
                                                                 snackbarManager:self.testManager];
    messageView.frame = CGRectMake(0, 0, kXXXLWidth, kHeightXXXLText);

    // When
    UITraitCollection *xsTraitCollection =
        [UITraitCollection
          traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    messageView.traitCollectionOverride = xsTraitCollection;
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UIFont *originalFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:14]];
    messageView.messageFont = originalFont;
    messageView.buttonFont = originalFont;

    UITraitCollection *aXXXLTraitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    messageView.traitCollectionOverride = aXXXLTraitCollection;

    // Then
    [self generateSnapshotAndVerifyForView:messageView];
  }
}

- (void)testPreferredFontForXSContentSizeCategoryWithTitle {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"Testing"];

    self.testManager.adjustsFontForContentSizeCategory = YES;
    MDCSnackbarMessageViewWithCustomTraitCollection *messageView =
        [[MDCSnackbarMessageViewWithCustomTraitCollection alloc] initWithMessage:message
                                                                  dismissHandler:nil
                                                                 snackbarManager:self.testManager];
    messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

    // When
    UITraitCollection *aXXXLTraitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    messageView.traitCollectionOverride = aXXXLTraitCollection;

    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    messageView.messageFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:14]];

    UITraitCollection *xsTraitCollection =
        [UITraitCollection
          traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    messageView.traitCollectionOverride = xsTraitCollection;

    // Then
    [self generateSnapshotAndVerifyForView:messageView];
  }
}

- (void)testPreferredFontForXSContentSizeCategoryWithTitleAndAction {
  if (@available(iOS 11.0, *)) {
    // Given
    MDCSnackbarMessage *message = [MDCSnackbarMessage messageWithText:@"Testing"];
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.title = @"Tap me";
    message.action = action;

    self.testManager.adjustsFontForContentSizeCategory = YES;
    MDCSnackbarMessageViewWithCustomTraitCollection *messageView =
        [[MDCSnackbarMessageViewWithCustomTraitCollection alloc] initWithMessage:message
                                                                  dismissHandler:nil
                                                                 snackbarManager:self.testManager];
    messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

    // When
    UITraitCollection *aXXXLTraitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    messageView.traitCollectionOverride = aXXXLTraitCollection;

    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UIFont *originalFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:14]];
    messageView.messageFont = originalFont;
    messageView.buttonFont = originalFont;

    UITraitCollection *xsTraitCollection =
        [UITraitCollection
          traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    messageView.traitCollectionOverride = xsTraitCollection;

    // Then
    [self generateSnapshotAndVerifyForView:messageView];
  }
}

@end
