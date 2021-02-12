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

#import "MaterialButtons.h"
#import "MaterialSnapshot.h"

#import "MDCAlertController+ButtonForAction.h"
#import "MaterialDialogs.h"
#import "MDCAlertController+Testing.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

static NSString *const kTitleShortLatin = @"Title";
static NSString *const kMessageShortLatin = @"Message";
static NSString *const kMessageLongLatin =
    @"Lorem ipsum dolor sit amet, consul docendi indoctum id quo, ad unum suavitate incorrupte "
     "sea. An his meis consul cotidieque, eam recteque mnesarchum et, mundi volumus cu cum. Quo "
     "falli dicunt an. Praesent molestiae vim ut.";
static NSString *const kFirstShortActionRTL = @"כפתור ראשון";
static NSString *const kSecondShortActionRTL = @"כפתור שני";
static NSString *const kFirstLongActionRTL = @"כפתור ראשון עם שם ארוך";
static NSString *const kSecondLongActionRTL = @"כפתור שני עם שם ארוך";
static NSString *const kFirstLongAction = @"First Long Long Action";
static NSString *const kSecondLongAction = @"Second Long Long Action";

@interface MDCAlertControllerActionsTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCAlertController *alertController;
@property(nonatomic, strong) MDCContainerScheme *containerScheme2019;
@end

@interface MDCAlertControllerView (Testing)
@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;
@end

@implementation MDCAlertControllerActionsTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alertController = [MDCAlertController alertControllerWithTitle:kTitleShortLatin
                                                              message:kMessageLongLatin];

  self.containerScheme2019 = [[MDCContainerScheme alloc] init];
  self.containerScheme2019.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
  self.containerScheme2019.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
}

- (void)tearDown {
  self.alertController = nil;
  self.containerScheme2019 = nil;

  [super tearDown];
}

- (void)generateSizedSnapshotAndVerifyForAlert:(MDCAlertController *)alert {
  [alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];
  [self generateSnapshotAndVerifyForView:alert.view];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL:(MDCAlertController *)alertController {
  [self changeViewToRTL:alertController.view];
}

#pragma mark - Actions Layout Tests

// Horizontal Layout | Low Emphasis | Default Alignment (trailing)
- (void)testLowEmphasisActionsOrderInHorizontalLayout {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"First Low"
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"Second Low"
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Low Emphasis | Default Alignment (center)
- (void)testAutomaticChangeToVerticalLayoutForLongLowEmphasisActions {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"First Low Emphasis Long Text"
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"Second Low Emphasis Long Text"
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | High Emphasis | Default Alignment (trailing)
- (void)testMediumEmphasisActionsOrderInHorizontalLayout {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"First Med"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"Second Med"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | High Emphasis | Default Alignment (center)
- (void)testAutomaticChangeToVerticalLayoutForLongMediumEmphasisActions {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongAction
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondLongAction
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | Low Emphasis | RTL | Default Alignment (trailing)
- (void)testLowEmphasisActionsOrderInHorizontalLayoutInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstShortActionRTL
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondShortActionRTL
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Low Emphasis | RTL | Default Alignment (center)
- (void)testAutomaticChangeToVerticalLayoutForLongLowEmphasisActionsInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongActionRTL
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondLongActionRTL
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | High Emphasis | RTL | Default Alignment (trailing)
- (void)testMediumEmphasisActionsOrderInHorizontalLayoutInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstShortActionRTL
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondShortActionRTL
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | High Emphasis | RTL | Default Alignment (center)
- (void)testAutomaticChangeToVerticalLayoutForLongMediumEmphasisActionsInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongActionRTL
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondLongActionRTL
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Verify correct layout for issues reported in:
//    https://github.com/material-components/material-components-ios/issues/8434.
- (void)testActionsLayoutHorizontallyForCapitalizedButtonCase {
  // Given
  self.alertController.title = @"Recurring actions";
  self.alertController.message = nil;
  [self addLowEmphasisAction:@"This event"];
  [self addLowEmphasisAction:@"This and all following events"];
  [self addLowEmphasisAction:@"All events"];
  [self addLowEmphasisAction:@"Cancel"];

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  for (MDCAlertAction *action in self.alertController.actions) {
    MDCButton *button = [self.alertController buttonForAction:action];
    button.uppercaseTitle = NO;
  }

  // Then
  // An extra wide view (generated using CGRectInfinite.size) is required for this test case.
  [self.alertController sizeToFitContentInBounds:CGRectInfinite.size];
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testActionsLayoutHorizontallyForExtraLongButtons {
  // Given
  self.alertController.title = @"Recurring actions";
  self.alertController.message = nil;
  [self addLowEmphasisAction:@"This and all following events"];
  [self addLowEmphasisAction:@"This and all following events"];

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Alignment Tests

// Horizontal Layout | Low Emphasis | Center Alignment
- (void)testLowEmphasisActionsAreCenteredInHorizontalLayout {
  // Given
  [self addOKActionWithEmphasis:MDCActionEmphasisLow];
  [self addCancelActionWithEmphasis:MDCActionEmphasisLow];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentCenter;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | Low Emphasis | Leading Alignment
- (void)testLowEmphasisActionsAreLeadingInHorizontalLayout {
  // Given
  [self addOKActionWithEmphasis:MDCActionEmphasisLow];
  [self addCancelActionWithEmphasis:MDCActionEmphasisLow];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | Low Emphasis | Justified Alignment
- (void)testLowEmphasisActionsAreJustifiedInHorizontalLayout {
  // Given
  [self addOKActionWithEmphasis:MDCActionEmphasisLow];
  [self addCancelActionWithEmphasis:MDCActionEmphasisLow];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | Medium Emphasis | Center Alignment
- (void)testMediumEmphasisActionsAreCenteredInHorizontalLayout {
  // Given
  [self addOKActionWithEmphasis:MDCActionEmphasisMedium];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentCenter;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | Medium Emphasis | Leading Alignment
- (void)testMediumEmphasisActionsAreLeadingInHorizontalLayout {
  // Given
  [self addOKActionWithEmphasis:MDCActionEmphasisMedium];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Horizontal Layout | Medium Emphasis | Justified Alignment
- (void)testMediumEmphasisActionsAreJustifiedInHorizontalLayout {
  // Given
  [self addOKActionWithEmphasis:MDCActionEmphasisMedium];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Low Emphasis | Trailing Alignment
- (void)testLowEmphasisActionsAreTrailingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisLow];
  [self addCancelActionWithEmphasis:MDCActionEmphasisLow];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentTrailing;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Low Emphasis | Leading Alignment
- (void)testLowEmphasisActionsAreLeadingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisLow];
  [self addCancelActionWithEmphasis:MDCActionEmphasisLow];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Low Emphasis | Justified Alignment
- (void)testLowEmphasisActionsAreJustifiedInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisLow];
  [self addCancelActionWithEmphasis:MDCActionEmphasisLow];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Medium Emphasis | Trailing Alignment
- (void)testMediumEmphasisActionsAreTrailingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisMedium];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentTrailing;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Medium Emphasis | Leading Alignment
- (void)testMediumEmphasisActionsAreLeadingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisMedium];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Vertical Layout | Medium Emphasis | Justified Alignment
- (void)testMediumEmphasisActionsAreJustifiedInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisMedium];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// b/155350470: test long justified actions are vertically aligned.
- (void)testLongJustifiedActionsAreVerticallyAligned {
  // Given
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"First Long Action"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alertController.view;

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
  XCTAssertEqual(alertView.isVerticalActionsLayout, true);
}

// b/155350470: test long justified actions are horizontally aligned when there's enough space.
- (void)testLongJustifiedActionsAreHorizontallyAligned {
  // Given
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"Promoted Action"
                                                         emphasis:MDCActionEmphasisHigh
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"Cancel Action"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  CGFloat width = 359.0f;  // Minimum width that fits both actions (calculated manually).
  [self.alertController sizeToFitContentInBounds:CGSizeMake(width, 300.0f)];
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alertController.view;

  // When
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
  XCTAssertEqual(alertView.isVerticalActionsLayout, false);
}

#pragma mark - Vertical Order Tests

- (void)testVerticalActionsAreOrderedByEmphasis {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisHigh];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.orderVerticalActionsByEmphasis = YES;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testVerticalTrailingActionsAreOrderedByEmphasis {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisHigh];
  [self addCancelActionWithEmphasis:MDCActionEmphasisMedium];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.orderVerticalActionsByEmphasis = YES;
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentTrailing;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Helpers

- (void)addFirstLongActionWithEmphasis:(MDCActionEmphasis)emphasis {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongAction
                                                         emphasis:emphasis
                                                          handler:nil]];
}

- (void)addOKActionWithEmphasis:(MDCActionEmphasis)emphasis {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"OK"
                                                         emphasis:emphasis
                                                          handler:nil]];
}

- (void)addCancelActionWithEmphasis:(MDCActionEmphasis)emphasis {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"Cancel"
                                                         emphasis:emphasis
                                                          handler:nil]];
}

- (void)addLowEmphasisAction:(NSString *)action {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:action
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
}

@end
