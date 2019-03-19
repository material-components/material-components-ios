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

/** Snapshot tests for MDCActionSheetController's view. */
@interface MDCActionSheetControllerSnapshotTests : MDCSnapshotTestCase

@end

@implementation MDCActionSheetControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;
}

- (void)changeViewToRTL:(UIView *)view {
  if (@available(iOS 9.0, *)) {
    view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    for (UIView *subview in view.subviews) {
      if ([subview isKindOfClass:[UIImageView class]]) {
        continue;
      }
      [self changeViewToRTL:subview];
    }
  }
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testFiveActionsSufficientSizeShortTextLTR {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kShortTitle4Latin
                                                       message:kShortTitle2Latin];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsSufficientSizeShortTextRTL {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kShortTitle2Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kShortTitle3Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kShortTitle4Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kShortTitle5Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kShortTitle4Arabic
                                                       message:kShortTitle2Arabic];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 320, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsSufficientSizeLongTextLTR {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kLongTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kLongTitle2Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kLongTitle3Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kLongTitle4Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kLongTitle5Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 640);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsSufficientSizeLongTextRTL {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kLongTitle1Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kLongTitle2Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kLongTitle3Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kLongTitle4Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kLongTitle5Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 320, 640);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooShortLTR {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 320, 180);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooShortRTL {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kShortTitle1Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kShortTitle2Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kShortTitle3Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kShortTitle4Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kShortTitle5Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 320, 180);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooNarrowLTR {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kLongTitle1Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kLongTitle2Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kLongTitle3Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kLongTitle4Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kLongTitle5Latin
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Latin
                                                       message:kLongTitle2Latin];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  controller.view.bounds = CGRectMake(0, 0, 120, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testFiveActionsTooNarrowRTL {
  // Given
  MDCActionSheetAction *action1 = [MDCActionSheetAction
      actionWithTitle:kLongTitle1Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleCheckerboard]
              handler:nil];
  MDCActionSheetAction *action2 = [MDCActionSheetAction
      actionWithTitle:kLongTitle2Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleRectangles]
              handler:nil];
  MDCActionSheetAction *action3 = [MDCActionSheetAction
      actionWithTitle:kLongTitle3Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleEllipses]
              handler:nil];
  MDCActionSheetAction *action4 = [MDCActionSheetAction
      actionWithTitle:kLongTitle4Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleDiagonalLines]
              handler:nil];
  MDCActionSheetAction *action5 = [MDCActionSheetAction
      actionWithTitle:kLongTitle5Arabic
                image:[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)
                                         withStyle:MDCSnapshotTestImageStyleFramedX]
              handler:nil];

  MDCActionSheetController *controller =
      [MDCActionSheetController actionSheetControllerWithTitle:kLongTitle4Arabic
                                                       message:kLongTitle2Arabic];
  [controller addAction:action1];
  [controller addAction:action2];
  [controller addAction:action3];
  [controller addAction:action4];
  [controller addAction:action5];

  // When
  [controller.view layoutIfNeeded];
  [self changeViewToRTL:controller.view];
  controller.view.bounds = CGRectMake(0, 0, 120, 480);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

@end
