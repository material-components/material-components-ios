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
#import "MaterialSnackbar+Theming.h"
#import "MDCSnackbarMessageViewInternal.h"
// clang-format on

/** The width of the Snackbar for testing. */
static const CGFloat kWidth = 180;

/** Height of a Snackbar with 1 line of message text. */
static const CGFloat kHeightSingleLineText = 48;

static NSString *const kItemTitleShort1Latin = @"Quando";
static NSString *const kItemTitleShort2Latin = @"No";

/** Snapshot tests for MDCSnackbarMessageView. */
@interface MDCSnackbarSnapshotThemingTests : MDCSnapshotTestCase

/** SnackbarManager to assign to snackbar views. */
@property(nonatomic, strong) MDCSnackbarManager *testManager;

@end

@implementation MDCSnackbarSnapshotThemingTests

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

- (MDCSnackbarMessageView *)snackbarMessageViewWithText:(NSString *)text
                                            actionTitle:(NSString *)title {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = text;
  if (title) {
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.title = title;
    message.action = action;
  }
  return [[MDCSnackbarMessageView alloc] initWithMessage:message
                                          dismissHandler:nil
                                         snackbarManager:self.testManager];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testWithDefaultContainerScheme {
  // Given
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

  // When
  [self.testManager applyThemeWithScheme:containerScheme];
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

- (void)testWithCustomContainerScheme {
  // Given
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterialDark201907];
  containerScheme.typographyScheme = [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  // When
  [self.testManager applyThemeWithScheme:containerScheme];
  MDCSnackbarMessageView *messageView = [self snackbarMessageViewWithText:kItemTitleShort1Latin
                                                              actionTitle:kItemTitleShort2Latin];
  messageView.frame = CGRectMake(0, 0, kWidth, kHeightSingleLineText);

  // Then
  [self generateSnapshotAndVerifyForView:messageView];
}

@end
