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

#import "MDCAlertControllerView+Private.h"
#import "MaterialContainerScheme.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialDialogs.h"

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

@implementation MDCAlertControllerActionsTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alertController = [MDCAlertController alertControllerWithTitle:kTitleShortLatin
                                                              message:kMessageLongLatin];
  self.alertController.view.bounds = CGRectMake(0, 0, 300, 300);

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

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL:(MDCAlertController *)alertController {
  [self changeViewToRTL:alertController.view];
}

#pragma mark - Tests

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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
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
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

#pragma mark - Alignment Tests

// Horizontal Layout | Low Emphasis | Center Alignment
- (void)testLowEmphasisActionsAreCenteredInHorizontalLayout {
  // Given
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:NO];
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignment = MDCContentHorizontalAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | Low Emphasis | Leading Alignment
- (void)testLowEmphasisActionsAreLeadingInHorizontalLayout {
  // Given
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:NO];
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignment = MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | Low Emphasis | Justified Alignment
- (void)testLowEmphasisActionsAreJustifiedInHorizontalLayout {
  // Given
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:NO];
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | Medium Emphasis | Center Alignment
- (void)testMediumEmphasisActionsAreCenteredInHorizontalLayout {
  // Given
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:NO];
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignment = MDCContentHorizontalAlignmentCenter;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | Medium Emphasis | Leading Alignment
- (void)testMediumEmphasisActionsAreLeadingInHorizontalLayout {
  // Given
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:NO];
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignment = MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | Medium Emphasis | Justified Alignment
- (void)testMediumEmphasisActionsAreJustifiedInHorizontalLayout {
  // Given
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:NO];
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Low Emphasis | Trailing Alignment
- (void)testLowEmphasisActionsAreTrailingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisLow];
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentTrailing;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Low Emphasis | Leading Alignment
- (void)testLowEmphasisActionsAreLeadingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisLow];
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Low Emphasis | Justified Alignment
- (void)testLowEmphasisActionsAreJustifiedInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisLow];
  [self addShortActionWithEmphasis:MDCActionEmphasisLow cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Medium Emphasis | Trailing Alignment
- (void)testMediumEmphasisActionsAreTrailingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisMedium];
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentTrailing;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Medium Emphasis | Leading Alignment
- (void)testMediumEmphasisActionsAreLeadingInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisMedium];
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Medium Emphasis | Justified Alignment
- (void)testMediumEmphasisActionsAreJustifiedInVerticalLayout {
  // Given
  [self addFirstLongActionWithEmphasis:MDCActionEmphasisMedium];
  [self addShortActionWithEmphasis:MDCActionEmphasisMedium cancelAction:YES];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  MDCAlertControllerView *view = (MDCAlertControllerView *)self.alertController.view;
  view.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentJustified;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

#pragma mark - Helpers

- (void)addFirstLongActionWithEmphasis:(MDCActionEmphasis)emphasis {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongAction
                                                         emphasis:emphasis
                                                          handler:nil]];
}

- (void)addShortActionWithEmphasis:(MDCActionEmphasis)emphasis cancelAction:(BOOL)cancelAction {
  NSString *title = cancelAction ? @"Cancel" : @"OK";
  [self.alertController addAction:[MDCAlertAction actionWithTitle:title
                                                         emphasis:emphasis
                                                          handler:nil]];
}

@end
