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

#import "MaterialDialogs.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialContainerScheme.h"

static NSString *const kTitleShortLatin = @"Title";
static NSString *const kMessageShortLatin = @"Message";
static NSString *const kMessageLongLatin =
    @"Lorem ipsum dolor sit amet, consul docendi indoctum id quo, ad unum suavitate incorrupte "
     "sea. An his meis consul cotidieque, eam recteque mnesarchum et, mundi volumus cu cum. Quo "
     "falli dicunt an. Praesent molestiae vim ut.";
static NSString *const kFirstShortAction = @"טקסט ראשון";
static NSString *const kSecondShortAction = @"טקסט שני";
static NSString *const kFirstLongAction = @"כפתור ראשון עם שם ארוך";
static NSString *const kSecondLongAction = @"כפתור שני עם שם ארוך";

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

// Horizontal Layout | Low Emphasis
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

// Vertical Layout | Low Emphasis
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

// Horizontal Layout | High Emphasis
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

// Vertical Layout | High Emphasis
- (void)testAutomaticChangeToVerticalLayoutForLongMediumEmphasisActions {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:@"First Medium Emphasis Long Text"
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController
      addAction:[MDCAlertAction actionWithTitle:@"Second Medium Emphasis Long Text"
                                       emphasis:MDCActionEmphasisMedium
                                        handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | Low Emphasis | RTL
- (void)testLowEmphasisActionsOrderInHorizontalLayoutInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstShortAction
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondShortAction
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | Low Emphasis | RTL
- (void)testAutomaticChangeToVerticalLayoutForLongLowEmphasisActionsInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongAction
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondLongAction
                                                         emphasis:MDCActionEmphasisLow
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Horizontal Layout | High Emphasis | RTL
- (void)testMediumEmphasisActionsOrderInHorizontalLayoutInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstShortAction
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondShortAction
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// Vertical Layout | High Emphasis | RTL
- (void)testAutomaticChangeToVerticalLayoutForLongMediumEmphasisActionsInRTL {
  // When
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kFirstLongAction
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController addAction:[MDCAlertAction actionWithTitle:kSecondLongAction
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

@end
