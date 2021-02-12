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
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

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

@interface MDCAlertController_ThemingSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCAlertController *alertController;
@property(nonatomic, strong) MDCAlertAction *actionHigh;
@property(nonatomic, strong) MDCAlertAction *actionMedium;
@property(nonatomic, strong) MDCAlertAction *actionLow;
@property(nonatomic, strong) UIImage *iconImage;
@property(nonatomic, strong) MDCContainerScheme *defaultScheme;
@property(nonatomic, readonly, strong) MDCContainerScheme *customScheme;
@end

@implementation MDCAlertController_ThemingSnapshotTests

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
  self.alertController = [[MDCAlertController alloc] init];
  [self.alertController addAction:self.actionHigh];
  [self.alertController addAction:self.actionMedium];
  [self.alertController addAction:self.actionLow];
  // TODO(https://github.com/material-components/material-components-ios/pull/6638): Remove
  // once the PR lands.
  (void)self.alertController.view;  // Force loading the view so it doesn't overwrite button fonts.

  self.defaultScheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.alertController = nil;
  self.actionLow = nil;
  self.actionMedium = nil;
  self.actionHigh = nil;
  self.iconImage = nil;
  self.defaultScheme = nil;

  [super tearDown];
}

- (MDCContainerScheme *)customScheme {
  MDCContainerScheme *container = [[MDCContainerScheme alloc] init];
  MDCSemanticColorScheme *colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  colorScheme.primaryColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
  colorScheme.primaryColorVariant = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
  colorScheme.secondaryColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
  colorScheme.errorColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
  colorScheme.surfaceColor = [UIColor colorWithWhite:(CGFloat)0.25 alpha:1];
  colorScheme.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];
  colorScheme.onPrimaryColor = [UIColor colorWithRed:1
                                               green:(CGFloat)0.5
                                                blue:(CGFloat)0.25
                                               alpha:1];
  colorScheme.onSecondaryColor = [UIColor colorWithRed:(CGFloat)0.5
                                                 green:1
                                                  blue:(CGFloat)0.25
                                                 alpha:1];
  colorScheme.onSurfaceColor = [UIColor colorWithRed:(CGFloat)0.25
                                               green:(CGFloat)0.5
                                                blue:1
                                               alpha:1];
  colorScheme.onBackgroundColor = [UIColor colorWithRed:(CGFloat)0.25
                                                  green:0
                                                   blue:(CGFloat)0.75
                                                  alpha:1];
  container.colorScheme = colorScheme;

  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  typographyScheme.headline1 = [UIFont systemFontOfSize:30];
  typographyScheme.headline2 = [UIFont systemFontOfSize:28];
  typographyScheme.headline3 = [UIFont systemFontOfSize:26];
  typographyScheme.headline4 = [UIFont systemFontOfSize:24];
  typographyScheme.headline5 = [UIFont systemFontOfSize:22];
  typographyScheme.headline6 = [UIFont systemFontOfSize:20];
  typographyScheme.subtitle1 = [UIFont systemFontOfSize:18];
  typographyScheme.subtitle2 = [UIFont systemFontOfSize:16];
  typographyScheme.body1 = [UIFont systemFontOfSize:14];
  typographyScheme.body2 = [UIFont systemFontOfSize:12];
  typographyScheme.caption = [UIFont systemFontOfSize:10];
  typographyScheme.button = [UIFont systemFontOfSize:8];
  typographyScheme.overline = [UIFont systemFontOfSize:6];
  container.typographyScheme = typographyScheme;

  MDCShapeScheme *shapeScheme =
      [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  shapeScheme.smallComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:8];
  shapeScheme.mediumComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded andSize:16];
  shapeScheme.largeComponentShape =
      [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut andSize:24];
  container.shapeScheme = shapeScheme;

  return container;
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  view.bounds = CGRectMake(0, 0, 300, 300);
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL:(MDCAlertController *)alertController {
  [self changeViewToRTL:alertController.view];
}

#pragma mark - Tests

- (void)testDefaultThemeWithLongTitleLongMessageLatin {
  // Given
  self.alertController.title = kTitleLongLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.defaultScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultThemeWithLongTitleLongMessageArabic {
  // Given
  self.alertController.title = kTitleLongArabic;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // When
  [self.alertController applyThemeWithScheme:self.defaultScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testCustomThemeWithLongTitleLongMessageLatin {
  // Given
  self.alertController.title = kTitleLongLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.customScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testCustomThemeWithLongTitleLongMessageArabic {
  // Given
  self.alertController.title = kTitleLongArabic;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // When
  [self.alertController applyThemeWithScheme:self.customScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultThemeWithLargeIconLongMessageLatin {
  // Given
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.defaultScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultThemeWithLargeIconLongMessageArabic {
  // Given
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // When
  [self.alertController applyThemeWithScheme:self.defaultScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testCustomThemeWithLargeIconLongMessageLatin {
  // Given
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.customScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testCustomThemeWithLargeIconLongMessageArabic {
  // Given
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // When
  [self.alertController applyThemeWithScheme:self.customScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultThemeWithLargeIconLongTitleLongMessageLatin {
  // Given
  self.alertController.title = kTitleLongLatin;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.defaultScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testDefaultThemeWithLargeIconLongTitleLongMessageArabic {
  // Given
  self.alertController.title = kTitleLongArabic;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // When
  [self.alertController applyThemeWithScheme:self.defaultScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testCustomThemeWithLargeIconLongTitleLongMessageLatin {
  // Given
  self.alertController.title = kTitleLongLatin;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.customScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testCustomThemeWithLargeIconLongTitleLongMessageArabic {
  // Given
  self.alertController.title = kTitleLongArabic;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageLongArabic;
  [self changeToRTL:self.alertController];

  // When
  [self.alertController applyThemeWithScheme:self.customScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

@end
