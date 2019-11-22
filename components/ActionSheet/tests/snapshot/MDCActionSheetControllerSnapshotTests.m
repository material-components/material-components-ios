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

static NSString *const kShortTitle1Latin = @"Item 1";
static NSString *const kShortTitle2Latin = @"Item 2";
static NSString *const kShortTitle3Latin = @"Item 3";
static NSString *const kShortTitle4Latin = @"Item 4";
static NSString *const kShortTitle5Latin = @"Item 5";

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

static NSString *const kShortTitle1Arabic = @"قد وحتّى";
static NSString *const kShortTitle2Arabic = @"بزمام";
static NSString *const kShortTitle3Arabic = @"لالتبر";
static NSString *const kShortTitle4Arabic = @"ل أخذ";
static NSString *const kShortTitle5Arabic = @"الانجليزية";

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

/**
 A custom superview that supports setting `safeAreaInsets` used for testing the Action Sheet
 controller.
 */
@interface MDCActionSheetControllerSnapshotTestsSuperview : UIView
@property(nonatomic, assign) UIEdgeInsets customSafeAreaInsets;
@end

@implementation MDCActionSheetControllerSnapshotTestsSuperview

- (UIEdgeInsets)safeAreaInsets {
  return _customSafeAreaInsets;
}

@end

/** Snapshot tests for MDCActionSheetController's view. */
@interface MDCActionSheetControllerSnapshotTests : MDCSnapshotTestCase

/** The action sheet being tested. */
@property(nonatomic, strong, nullable) MDCActionSheetController *actionSheetController;

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

@implementation MDCActionSheetControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.action1 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  self.action2 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  self.action3 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  self.action4 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  self.action5 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];
}

- (void)tearDown {
  if (self.actionSheetController.presentingViewController) {
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Action sheet is dismissed"];
    [self.actionSheetController dismissViewControllerAnimated:NO
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
  self.actionSheetController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/** Update the @c MDCActionSheetAction properties to use short Arabic text. */
- (void)changeToShortArabicTitles {
  self.action1 = [MDCActionSheetAction actionWithTitle:kShortTitle1Arabic
                                                 image:self.action1.image
                                               handler:nil];
  self.action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Arabic
                                                 image:self.action2.image
                                               handler:nil];
  self.action3 = [MDCActionSheetAction actionWithTitle:kShortTitle3Arabic
                                                 image:self.action3.image
                                               handler:nil];
  self.action4 = [MDCActionSheetAction actionWithTitle:kShortTitle4Arabic
                                                 image:self.action4.image
                                               handler:nil];
  self.action5 = [MDCActionSheetAction actionWithTitle:kShortTitle5Arabic
                                                 image:self.action5.image
                                               handler:nil];
}

/** Update the @c MDCActionSheetAction properties to use long Arabic text. */
- (void)changeToLongArabicTitles {
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
}

/** Update the @c MDCActionSheetAction properties to use long Latin text. */
- (void)changeToLongLatinTitles {
  self.action1 = [MDCActionSheetAction actionWithTitle:kLongTitle1Latin
                                                 image:self.action1.image
                                               handler:nil];
  self.action2 = [MDCActionSheetAction actionWithTitle:kLongTitle2Latin
                                                 image:self.action2.image
                                               handler:nil];
  self.action3 = [MDCActionSheetAction actionWithTitle:kLongTitle3Latin
                                                 image:self.action3.image
                                               handler:nil];
  self.action4 = [MDCActionSheetAction actionWithTitle:kLongTitle4Latin
                                                 image:self.action4.image
                                               handler:nil];
  self.action5 = [MDCActionSheetAction actionWithTitle:kLongTitle5Latin
                                                 image:self.action5.image
                                               handler:nil];
}

#pragma mark - Tests

- (void)testFiveActionsSufficientSizeShortTextLTR {
  // Given
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kShortTitle4Latin
                                                       message:kShortTitle2Latin];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsSufficientSizeShortTextRTL {
  // Given
  [self changeToShortArabicTitles];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kShortTitle4Arabic
                                                       message:kShortTitle2Arabic];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 320, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsSufficientSizeLongTextLTR {
  // Given
  [self changeToLongLatinTitles];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 640);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsSufficientSizeLongTextRTL {
  // Given
  [self changeToLongArabicTitles];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 320, 640);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooShortLTR {
  // Given
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 180);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooShortRTL {
  // Given
  [self changeToShortArabicTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 320, 180);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooNarrowLTR {
  // Given
  [self changeToLongLatinTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 120, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooNarrowRTL {
  // Given
  [self changeToLongArabicTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];
  [controller addAction:self.action4];
  [controller addAction:self.action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 120, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

#pragma mark - Safe Area

- (void)testSafeAreaTopLeftBottomRightLTR {
  // Given
  MDCActionSheetControllerSnapshotTestsSuperview *superview =
      [[MDCActionSheetControllerSnapshotTestsSuperview alloc]
          initWithFrame:CGRectMake(0, 0, 360, 240)];
  [self changeToLongLatinTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:self.action1];
  [superview addSubview:controller.view];
  controller.view.frame = superview.bounds;

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(90, 80, 40, 20);
  [controller.view setNeedsLayout];
  [controller.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaTopLeftBottomRightRTL {
  // Given
  MDCActionSheetControllerSnapshotTestsSuperview *superview =
      [[MDCActionSheetControllerSnapshotTestsSuperview alloc]
          initWithFrame:CGRectMake(0, 0, 360, 240)];
  [self changeToLongArabicTitles];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:self.action1];
  [superview addSubview:controller.view];
  controller.view.frame = superview.bounds;

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(90, 80, 40, 20);
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  [controller.view setNeedsLayout];
  [controller.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaTopLeftLTR {
  // Given
  MDCActionSheetControllerSnapshotTestsSuperview *superview =
      [[MDCActionSheetControllerSnapshotTestsSuperview alloc]
          initWithFrame:CGRectMake(0, 0, 360, 240)];
  [self changeToLongLatinTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:self.action1];
  [superview addSubview:controller.view];
  controller.view.frame = superview.bounds;

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(120, 120, 0, 0);
  [controller.view setNeedsLayout];
  [controller.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaTopLeftRTL {
  // Given
  MDCActionSheetControllerSnapshotTestsSuperview *superview =
      [[MDCActionSheetControllerSnapshotTestsSuperview alloc]
          initWithFrame:CGRectMake(0, 0, 360, 240)];
  [self changeToLongArabicTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:self.action1];
  [superview addSubview:controller.view];
  controller.view.frame = superview.bounds;

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(120, 120, 0, 0);
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  [controller.view setNeedsLayout];
  [controller.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaBottomRightLTR {
  // Given
  MDCActionSheetControllerSnapshotTestsSuperview *superview =
      [[MDCActionSheetControllerSnapshotTestsSuperview alloc]
          initWithFrame:CGRectMake(0, 0, 360, 240)];
  [self changeToLongLatinTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:self.action1];
  [superview addSubview:controller.view];
  controller.view.frame = superview.bounds;

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(0, 0, 80, 80);
  [controller.view setNeedsLayout];
  [controller.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testSafeAreaBottomRightRTL {
  // Given
  MDCActionSheetControllerSnapshotTestsSuperview *superview =
      [[MDCActionSheetControllerSnapshotTestsSuperview alloc]
          initWithFrame:CGRectMake(0, 0, 360, 240)];
  [self changeToLongArabicTitles];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:self.action1];
  [superview addSubview:controller.view];
  controller.view.frame = superview.bounds;

  // When
  superview.customSafeAreaInsets = UIEdgeInsetsMake(0, 0, 80, 80);
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  [controller.view setNeedsLayout];
  [controller.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:superview];
}

- (void)testActionSheetWhenActionsOnlyHaveTitles {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction actionWithTitle:kShortTitle1Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [controller addAction:action1];
  [controller addAction:action2];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWhenActionsOnlyHaveTitlesAndAlignTitlesEnabled {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction actionWithTitle:kShortTitle1Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];

  // When
  // Enable early to guard against implementation bugs identified in #8609
  controller.alwaysAlignTitleLeadingEdges = YES;
  [controller addAction:action1];
  [controller addAction:action2];
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWhenActionsOnlyHaveTitlesAndAlignTitlesDisabled {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction actionWithTitle:kShortTitle1Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];

  // When
  [controller addAction:action1];
  [controller addAction:action2];
  controller.alwaysAlignTitleLeadingEdges = NO;
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWhenSomeActionsHaveIconsAndTitlesAndSomeActionsOnlyHaveTitles {
  // Given
  MDCActionSheetAction *action1 =
      [MDCActionSheetAction actionWithTitle:kShortTitle1Latin
                                      image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                                    handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [controller addAction:action1];
  [controller addAction:action2];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)
    testActionSheetWhenSomeActionsHaveIconsAndTitlesAndSomeActionsOnlyHavingTitlesAndAlignTitlesDisabled {
  // Given
  MDCActionSheetAction *action1 =
      [MDCActionSheetAction actionWithTitle:kShortTitle1Latin
                                      image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                                    handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];

  // When
  [controller addAction:action1];
  [controller addAction:action2];
  controller.alwaysAlignTitleLeadingEdges = NO;
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)
    testActionSheetWhenSomeActionsHaveIconsAndTitlesAndSomeActionsOnlyHavingTitlesAndAlignTitlesEnabled {
  // Given
  MDCActionSheetAction *action1 =
      [MDCActionSheetAction actionWithTitle:kShortTitle1Latin
                                      image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                                    handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction actionWithTitle:kShortTitle2Latin
                                                                  image:nil
                                                                handler:nil];
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];

  // When
  // Enable early to guard against implementation bugs identified in #8609
  controller.alwaysAlignTitleLeadingEdges = YES;
  [controller addAction:action1];
  [controller addAction:action2];
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWithCustomActionSheetControllerTitleColorAndOneActionCustomTitleColor {
  // Given
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];

  // When
  controller.actionTextColor = UIColor.blueColor;
  self.action2.titleColor = UIColor.orangeColor;
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWhenEveryActionHasCustomTitleColor {
  // Given
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];

  // When
  self.action1.titleColor = UIColor.blueColor;
  self.action2.titleColor = UIColor.redColor;
  self.action3.titleColor = UIColor.greenColor;
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWithCustomActionSheetControllerTintColorAndOneActionCustomTintColor {
  // Given
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];

  // When
  controller.actionTintColor = UIColor.blueColor;
  self.action2.tintColor = UIColor.orangeColor;
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testActionSheetWhenEveryActionHasCustomTintColor {
  // Given
  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [controller addAction:self.action1];
  [controller addAction:self.action2];
  [controller addAction:self.action3];

  // When
  self.action1.tintColor = UIColor.blueColor;
  self.action2.tintColor = UIColor.redColor;
  self.action3.tintColor = UIColor.greenColor;
  controller.view.bounds = CGRectMake(0, 0, 320, 200);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testThreeActionsSufficientSizeShortTextLTRWithDefaultPresentationStyleOniOS13 {
  // Given
  self.actionSheetController = [MDCActionSheetController actionSheetControllerWithTitle:nil];
  [self.actionSheetController addAction:self.action1];
  [self.actionSheetController addAction:self.action2];
  [self.actionSheetController addAction:self.action3];
  self.actionSheetController.view.bounds = CGRectMake(0, 0, 320, 200);

  // When
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  UIViewController *currentViewController = window.rootViewController;
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"Action sheet is presented"];
  [currentViewController presentViewController:self.actionSheetController
                                      animated:NO
                                    completion:^{
                                      [expectation fulfill];
                                    }];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:5];
  [self snapshotVerifyViewForIOS13:window];
}

- (void)testActionSheetWithHeaderShown {
  // Given
  self.actionSheetController = [MDCActionSheetController actionSheetControllerWithTitle:@"Foo"];
  [self.actionSheetController addAction:self.action1];
  [self.actionSheetController addAction:self.action2];
  self.actionSheetController.view.bounds = CGRectMake(0, 0, 320, 200);

  // When
  self.actionSheetController.showsHeaderDivider = YES;
  self.actionSheetController.headerDividerColor = UIColor.blackColor;
  [self.actionSheetController.view setNeedsLayout];
  [self.actionSheetController.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.actionSheetController.view];
}

- (void)testActionSheetWithHeaderShownButNoTitleOrMessage {
  // Given
  self.actionSheetController = [MDCActionSheetController actionSheetControllerWithTitle:nil
                                                                                message:nil];
  [self.actionSheetController addAction:self.action1];
  [self.actionSheetController addAction:self.action2];
  self.actionSheetController.view.bounds = CGRectMake(0, 0, 320, 200);

  // When
  self.actionSheetController.showsHeaderDivider = YES;
  self.actionSheetController.headerDividerColor = UIColor.blackColor;
  [self.actionSheetController.view setNeedsLayout];
  [self.actionSheetController.view layoutIfNeeded];

  // Then
  [self generateSnapshotAndVerifyForView:self.actionSheetController.view];
}

@end
