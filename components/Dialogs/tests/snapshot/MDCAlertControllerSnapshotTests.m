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

static NSString *const kActionHighTitleLatin = @"High";
static NSString *const kActionMediumTitleLatin = @"Medium";
static NSString *const kActionLowTitleLatin = @"Low";
static NSString *const kTitleShortLatin = @"Title";
static NSString *const kTitleLongLatin =
    @"Title Title Title Title Title Title Title Title Title Title Title Title Title Title";
static NSString *const kMessageShortLatin = @"Message";
static NSString *const kMessageLongLatin =
    @"Lorem ipsum dolor sit amet, consul docendi indoctum id quo, ad unum suavitate incorrupte "
     "sea. An his meis consul cotidieque, eam recteque mnesarchum et, mundi volumus cu cum. Quo "
     "falli dicunt an. Praesent molestiae vim ut.\n\n"
     "Nec eirmod voluptua reformidans ne, viderer voluptua senserit at vis, est omnis accusam "
     "adipisci cu. Vis eu singulis deseruisse elaboraret. Cu sit possit scribentur, integre "
     "complectitur eu sit. Ei qui everti instructior, in vis harum quidam vituperata, te velit "
     "epicuri dissentias ius. Id est consul graecis consequat, id eam ancillae detraxit convenire, "
     "ne possim noluisse mei.";

static NSString *const kTitleShortArabic = @"الأمريكي كل.";
static NSString *const kTitleLongArabic = @"ما جيوب لمحاكم تحرّكت بعض, و نفس ٢٠٠٤ المسرح استدعى. "
                                          @"الا الثقيل اقتصادية ثم, مع إستعمل مشاركة بلا. مدن هو.";
static NSString *const kMessageShortArabic = @"قد لغات ";
static NSString *const kMessageLongArabic =
    @"قد لغات هاربر الموسوعة الا, بلديهما الأمريكي في وقد. وفي تم هناك بداية, مرجع العصبة عسكرياً قد"
     "أما. يكن ومضى واتّجه الأمريكي كل. منتصف استمرار أسر بل.\n\n"

    @" ومن مشارف التبرعات الأوروبيّون عن, نهاية نتيجة ٣٠ إيو. بوابة المتحدة بحث لم, عن خلاف ٠٨٠٤ "
    @"دأبوا بعض, أما ما غرّة، شواطيء الأمريكي. على لهذه الهجوم مليارات عل, وقبل واحدة بتخصيص إيو "
    @"قد. أفاق بشرية الأخذ لكل مع, الشهير وبريطانيا عل شيء, ألمّ لإعادة المواد مدن إذ. إجلاء "
    @"للأراضي ضرب ما, عن لكون لعملة ويعزى تلك, الآلاف استدعى الثقيل بحق إذ. ٣٠ عدم وعُرفت الصفحات.";

@interface MDCAlertControllerSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCAlertController *alertController;
@property(nonatomic, strong) MDCAlertAction *actionHigh;
@property(nonatomic, strong) MDCAlertAction *actionMedium;
@property(nonatomic, strong) MDCAlertAction *actionLow;
@property(nonatomic, strong) UIImage *iconImage;
@property(nonatomic, strong) UIView *accessoryView;
@end

@implementation MDCAlertControllerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.actionHigh = [MDCAlertAction actionWithTitle:@"High"
                                           emphasis:MDCActionEmphasisHigh
                                            handler:nil];
  self.actionMedium = [MDCAlertAction actionWithTitle:@"Medium"
                                             emphasis:MDCActionEmphasisMedium
                                              handler:nil];
  self.actionLow = [MDCAlertAction actionWithTitle:@"Low"
                                          emphasis:MDCActionEmphasisLow
                                           handler:nil];
  self.iconImage = [[UIImage mdc_testImageOfSize:CGSizeMake(40, 40)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
  [self.accessoryView setBackgroundColor:[UIColor redColor]];
  self.alertController = [[MDCAlertController alloc] init];
  self.alertController.view.bounds = CGRectMake(0, 0, 300, 300);
  [self.alertController addAction:self.actionHigh];
  [self.alertController addAction:self.actionMedium];
  [self.alertController addAction:self.actionLow];
}

- (void)tearDown {
  if (self.alertController.presentingViewController) {
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Alert controller is dismissed"];
    [self.alertController dismissViewControllerAnimated:NO
                                             completion:^{
                                               [expectation fulfill];
                                             }];
    [self waitForExpectations:@[ expectation ] timeout:5];
  }
  self.alertController = nil;
  self.accessoryView = nil;
  self.actionLow = nil;
  self.actionMedium = nil;
  self.actionHigh = nil;
  self.iconImage = nil;

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

- (void)testDefaultAppearanceWithShortTitleShortMessageLatin {
  // When
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageShortLatin;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithShortTitleShortMessageArabic {
  // When
  self.alertController.title = kTitleShortArabic;
  self.alertController.message = kMessageShortArabic;
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithLongTitleLongMessageLatin {
  // When
  self.alertController.title = kTitleLongLatin;
  self.alertController.message = kMessageLongLatin;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithLongTitleLongMessageArabic {
  // When
  self.alertController.title = kTitleLongArabic;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithSmallIconShortMessageLatin {
  // When
  self.alertController.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.alertController.message = kMessageShortLatin;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithSmallIconShortMessageArabic {
  // When
  self.alertController.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.alertController.message = kMessageShortArabic;
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithLargeIconLongMessageLatin {
  // When
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithLargeIconLongMessageArabic {
  // When
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithLargeIconLongTitleLongMessageLatin {
  // When
  self.alertController.title = kTitleLongLatin;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithLargeIconLongTitleLongMessageArabic {
  // When
  self.alertController.title = kTitleLongArabic;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultAppearanceWithAccessoryView {
  // When
  [self.alertController setAccessoryView:self.accessoryView];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testPreferredContentSizeWithLargeIconLongTitleLongMessageLatin {
  // When
  self.alertController.title = kTitleLongLatin;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;
  CGSize preferredContentSize = self.alertController.preferredContentSize;
  self.alertController.view.bounds =
      CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testPreferredContentSizeWithLargeIconLongTitleLongMessageArabic {
  // When
  self.alertController.title = kTitleLongArabic;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];
  CGSize preferredContentSize = self.alertController.preferredContentSize;
  self.alertController.view.bounds =
      CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testPreferredContentSizeWithAccessoryView {
  // When
  [self.alertController setAccessoryView:self.accessoryView];
  CGSize preferredContentSize = self.alertController.preferredContentSize;
  self.alertController.view.bounds =
      CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testPreferredContentSizeWithLargeIconLongTitleLongMessageArabicAccessoryView {
  // When
  self.alertController.title = kTitleLongArabic;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];
  [self.alertController setAccessoryView:self.accessoryView];
  CGSize preferredContentSize = self.alertController.preferredContentSize;
  self.alertController.view.bounds =
      CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height);

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testSizeToFitWithLargeIconLongTitleLongMessageLatin {
  // When
  self.alertController.title = kTitleLongLatin;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;
  [self.alertController.view sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testSizeToFitWithLargeIconLongTitleLongMessageArabic {
  // When
  self.alertController.title = kTitleLongArabic;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];
  [self.alertController.view sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testSizeToFitWithShortTitleShortMessageLatinAccessoryView {
  // When
  self.alertController.title = kMessageShortLatin;
  self.alertController.message = kMessageShortLatin;
  [self.alertController setAccessoryView:self.accessoryView];
  [self.alertController.view sizeToFit];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testAlertWithLongButtonTitlesLTR {
  // Given
  MDCAlertController *controller = [MDCAlertController alertControllerWithTitle:kTitleShortLatin
                                                                        message:kMessageShortLatin];

  // When
  MDCAlertAction *shortAction = [MDCAlertAction actionWithTitle:kTitleShortLatin handler:nil];
  MDCAlertAction *longAction = [MDCAlertAction actionWithTitle:kMessageLongLatin handler:nil];
  [controller addAction:shortAction];
  [controller addAction:longAction];
  controller.view.frame = CGRectMake(0, 0, 300, 300);

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testAlertWithLongButtonTitlesRTL {
  // Given
  MDCAlertController *controller =
      [MDCAlertController alertControllerWithTitle:kTitleShortArabic message:kMessageShortArabic];

  // When
  MDCAlertAction *shortAction = [MDCAlertAction actionWithTitle:kTitleShortArabic handler:nil];
  MDCAlertAction *longAction = [MDCAlertAction actionWithTitle:kMessageLongArabic handler:nil];
  [controller addAction:shortAction];
  [controller addAction:longAction];
  controller.view.frame = CGRectMake(0, 0, 300, 300);
  [self changeToRTL:controller];

  // Then
  [self generateSnapshotAndVerifyForView:controller.view];
}

- (void)testDefaultPresentationStyleWithShortTitleShortMessageLatinOniOS13 {
  // When
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  UIViewController *currentViewController = window.rootViewController;
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageShortLatin;
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"Alert controller is presented"];
  [currentViewController presentViewController:self.alertController
                                      animated:NO
                                    completion:^{
                                      [expectation fulfill];
                                    }];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:5];
  [self snapshotVerifyViewForIOS13:window];
  expectation = [self expectationWithDescription:@"Alert dismissed."];
  [currentViewController dismissViewControllerAnimated:NO
                                            completion:^{
                                              [expectation fulfill];
                                            }];
  [self waitForExpectations:@[ expectation ] timeout:5];
}

@end
