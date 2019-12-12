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

#import "MaterialActionSheet.h"

static NSString *const kLongTitle1Latin =
    @"Lorem ipsum dolor sit amet, ex graecis intellegam eos, vis tantas nusquam.";
static NSString *const kLongTitle2Latin =
    @"Eius minimum at cum. Ut has quas delicatissimi, movet elaboraret reformidans eu sed.";
static NSString *const kLongTitle3Latin =
    @"Duo nostro doctus indoctum eu. Summo viderer disputationi qui at, modus legendos.";
static NSString *const kLongTitle4Latin =
    @"Duo eu. Et fabulas platonem eum, ei semper animal accusamus eos.";
static NSString *const kLongTitle5Latin =
    @"Quot mazim liber sea et, eam latine sadipscing referrentur et, commune pertinax pro at.";

static NSString *const kLongTitle1Arabic =
    @"أضف إذ أراضي أطراف, وحتى العالم، بحث لم. وصل كل ويعزى اوروبا.";
static NSString *const kLongTitle2Arabic =
    @"إتفاقية وبالتحديد، قد كلّ. مع ذلك بشرية ترتيب, يكن إختار بالولايات من.";
static NSString *const kLongTitle3Arabic =
    @"هو نفس والإتحاد الفرنسية, غير المدن الأوروبي بـ. دنو أمام تمهيد قد.";
static NSString *const kLongTitle4Arabic =
    @"إيو أم جيوب الجوي واشتدّت, بها شمال واتّجه مع, ما لعدم الجنوب كان.";
static NSString *const kLongTitle5Arabic =
    @"بلا العظمى الدنمارك من, كلّ المارق لإعلان بالحرب ما, بخطوط مشروط عل دنو.";

/** Snapshot tests for MDCActionSheetController's various insets APIs. */
@interface MDCActionSheetControllerInsetsAPIsSnapshotTests : MDCSnapshotTestCase

/** The action sheet being tested. */
@property(nonatomic, strong, nullable) MDCActionSheetController *controller;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action1;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action2;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action3;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action4;

/** An Action Sheet action. */
@property(nonatomic, strong) MDCActionSheetAction *action5;

@end

@implementation MDCActionSheetControllerInsetsAPIsSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.action1 = [MDCActionSheetAction
      actionWithTitle:kLongTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  self.action2 = [MDCActionSheetAction
      actionWithTitle:kLongTitle2Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  self.action3 = [MDCActionSheetAction
      actionWithTitle:kLongTitle3Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  self.action4 = [MDCActionSheetAction
      actionWithTitle:kLongTitle4Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  self.action5 = [MDCActionSheetAction
      actionWithTitle:kLongTitle5Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  self.controller = [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                                     message:kLongTitle2Latin];
}

- (void)addAllFiveActions {
  [self.controller addAction:self.action1];
  [self.controller addAction:self.action2];
  [self.controller addAction:self.action3];
  [self.controller addAction:self.action4];
  [self.controller addAction:self.action5];
}

- (void)tearDown {
  if (self.controller.presentingViewController) {
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Action sheet is dismissed"];
    [self.controller dismissViewControllerAnimated:NO
                                        completion:^{
                                          [expectation fulfill];
                                        }];
    [self waitForExpectations:@[ expectation ] timeout:5];
  }
  self.action1 = nil;
  self.action2 = nil;
  self.action3 = nil;
  self.action4 = nil;
  self.action5 = nil;
  self.controller = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/** Configure the ActionSheetController to use long Arabic strings. */
- (void)useArabicStrings {
  self.controller.title = kLongTitle4Arabic;
  self.controller.message = kLongTitle2Arabic;
  self.action1 = [MDCActionSheetAction actionWithTitle:kLongTitle1Arabic
                                                 image:self.action1.image
                                               handler:nil];
  self.action2 = [MDCActionSheetAction actionWithTitle:kLongTitle2Arabic
                                                 image:self.action2.image
                                               handler:nil];
  self.action3 = [MDCActionSheetAction actionWithTitle:kLongTitle3Arabic
                                                 image:self.action3.image
                                               handler:nil];
  self.action4 = [MDCActionSheetAction actionWithTitle:kLongTitle4Arabic
                                                 image:self.action4.image
                                               handler:nil];
  self.action5 = [MDCActionSheetAction actionWithTitle:kLongTitle5Arabic
                                                 image:self.action5.image
                                               handler:nil];
  [self addAllFiveActions];
}

#pragma mark - contentEdgeInsets

- (void)testContentEdgeInsetsIncreaseActionRowHeight {
  // Given
  [self addAllFiveActions];

  // When
  self.controller.view.bounds = CGRectMake(0, 0, 320, 640);
  self.controller.contentEdgeInsets = UIEdgeInsetsMake(-30, 0, -30, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.controller.view];
}

- (void)testContentEdgeInsetsDecreaseActionRowHeight {
  // Given
  [self addAllFiveActions];

  // When
  self.controller.view.bounds = CGRectMake(0, 0, 320, 640);
  self.controller.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.controller.view];
}

- (void)testContentEdgeInsetsShiftActionRowToRightInLTR {
  // Given
  [self addAllFiveActions];

  // When
  self.controller.view.bounds = CGRectMake(0, 0, 320, 640);
  self.controller.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 50);

  // Then
  [self generateSnapshotAndVerifyForView:self.controller.view];
}

- (void)testContentEdgeInsetsShiftActionRowToLeftInLTR {
  // Given
  [self addAllFiveActions];

  // When
  self.controller.view.bounds = CGRectMake(0, 0, 320, 640);
  self.controller.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.controller.view];
}

- (void)testContentEdgeInsetsShiftActionRowToLeftInRTL {
  // Given
  [self useArabicStrings];

  // When
  [self.controller.view layoutIfNeeded];
  [self changeViewToRTL:self.controller.view];
  self.controller.view.bounds = CGRectMake(0, 0, 320, 640);
  self.controller.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 50);

  // Then
  [self generateSnapshotAndVerifyForView:self.controller.view];
}

- (void)testContentEdgeInsetsShiftActionRowToRightInRTL {
  // Given
  [self useArabicStrings];

  // When
  [self.controller.view layoutIfNeeded];
  [self changeViewToRTL:self.controller.view];
  self.controller.view.bounds = CGRectMake(0, 0, 320, 640);
  self.controller.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);

  // Then
  [self generateSnapshotAndVerifyForView:self.controller.view];
}

@end
