// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MDCAlertController+Testing.h"
#import "MaterialDialogs+Theming.h"
#import "MDCAlertControllerView+Private.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

static NSString *const kTitleShortLatin = @"Short Title";
static NSString *const kTitleLongLatin = @"Lorem ipsum dolor sit amet";
static NSString *const kMessageMediumLatin =
    @"Lorem ipsum dolor sit amet, consul docendi indoctum id quo ad unum suavitate incorrupte sea.";
static NSString *const kFirstLongAction = @"First Long Long Action";

@interface MDCAlertControllerInsetsTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCAlertController *alertController;
@property(nonatomic, strong) MDCAlertControllerView *alertView;
@property(nonatomic, strong) MDCContainerScheme *containerScheme2019;
@property(nonatomic, strong) UIImage *titleIcon;
@property(nonatomic, strong) UIImage *titleImageFullwidth;
@property(nonatomic, strong) UIView *accessoryView;
@property(nonatomic, assign) CGFloat alertWidth;
@end

@implementation MDCAlertControllerInsetsTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alertController = [MDCAlertController alertControllerWithTitle:kTitleLongLatin
                                                              message:kMessageMediumLatin];
  self.alertView = (MDCAlertControllerView *)self.alertController.view;
  self.alertWidth = 300.f;

  [self addOKAction];
  [self addCancelAction];

  self.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(24.f, 24.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.titleImageFullwidth = [[UIImage mdc_testImageOfSize:CGSizeMake(self.alertWidth, 60.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 150.f, 150.f)];
  [self.accessoryView setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.2f]];

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
  [alert sizeToFitContentInBounds:CGSizeMake(self.alertWidth, self.alertWidth)];
  [self generateSnapshotAndVerifyForView:alert.view];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [self setElementsBackgroundColors];
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL:(MDCAlertController *)alertController {
  [self changeViewToRTL:alertController.view];
}

#pragma mark - Default insets

- (void)testDefaultAlertHasDefaultInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testDefaultAlertTitleImageHasDefaultInsets {
  // Given
  CGFloat imageWidth =
      self.alertWidth - self.alertView.titleIconInsets.left - self.alertView.titleIconInsets.right;
  self.alertController.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(imageWidth, 60.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testDefaultAlertNoContentHasDefaultInsets {
  // Given
  self.alertController.message = nil;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testDefaultAlertNoTitleHasDefaultInsets {
  // Given
  self.alertController.title = nil;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testDefaultAlertAccessoryHasDefaultInsets {
  // Given
  self.alertController.message = nil;
  self.alertController.accessoryView = self.accessoryView;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testDefaultAlertContentAndAccessoryHaveDefaultInsets {
  // Given
  self.alertController.accessoryView = self.accessoryView;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Custom insets

- (void)testAlertTitleImageHasNoInsets {
  // Given
  self.alertController = [MDCAlertController alertControllerWithTitle:kTitleShortLatin
                                                              message:kMessageMediumLatin];
  self.alertView = (MDCAlertControllerView *)self.alertController.view;

  [self addActionWithTitle:@"Extra Long Action Label"];
  [self addActionWithTitle:@"Another Long Action Label"];
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;

  self.alertController.titleIcon = self.titleImageFullwidth;
  self.alertController.titleAlignment = NSTextAlignmentCenter;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(0.f, 0.f, 20.f, 0.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertHasCustomInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
  self.alertView.titleInsets = UIEdgeInsetsMake(10.f, 10.f, 20.f, 10.f);
  self.alertView.contentInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
  self.alertView.actionsInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Custom title view insets

- (void)testAlertTitleHasCustomInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleInsets = UIEdgeInsetsMake(12.f, 12.f, 12.f, 12.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertTitleIconHasDefaultInsets {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertTitleIconHasCustomInsets {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(12.f, 12.f, 20.f, 12.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertTitleIconHasCustomInsetsAndImageIsLarge {
  // Given
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  self.alertController.titleIcon = [UIImage imageNamed:@"wide-image"
                                              inBundle:bundle
                         compatibleWithTraitCollection:nil];
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(20.f, 20.f, 8.f, 20.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertTitleIconTitleZeroInsets {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(12.f, 12.f, 12.f, 12.f);
  self.alertView.titleInsets = UIEdgeInsetsZero;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertTitleIconInsetsOverrideTitleInsets {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsZero;
  self.alertView.titleInsets = UIEdgeInsetsMake(12.f, 12.f, 12.f, 12.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertTitleImageTitleZeroInsets {
  // Given
  CGFloat imageWidth = self.alertWidth - 30;
  self.alertController.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(imageWidth, 60.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(12.f, 12.f, 12.f, 12.f);
  self.alertView.titleInsets = UIEdgeInsetsZero;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Custom content insets

- (void)testAlertContentHasZeroInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.contentInsets = UIEdgeInsetsZero;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertContentHasCustomInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.contentInsets = UIEdgeInsetsMake(30.f, 10.f, 10.f, 10.f);

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertContentAccessoryHaveCustomInsets {
  // Given
  self.alertController.accessoryView = self.accessoryView;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.contentInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
  self.alertView.accessoryViewVerticalInset = 0.f;
  self.alertView.accessoryViewHorizontalInset = -5.0f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Custom actions insets

- (void)testAlertActionsHaveZeroInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsZero;
  self.alertView.actionsHorizontalMargin = 0.f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertActionsHaveCustomInsets {
  // Given
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(4.f, 0.f, 0.f, 10.f);
  self.alertView.actionsHorizontalMargin = 20.f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertActionsHaveCenteredCustomInsets {
  // Given
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentCenter;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(12.f, 0.f, 12.f, 0.f);
  self.alertView.actionsHorizontalMargin = 12.f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertActionsHaveJustifiedCustomInsets {
  // Given
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(4.f, 0.f, 0.f, 10.f);
  self.alertView.actionsHorizontalMargin = 20.f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertActionsHaveVerticalCustomInsets {
  // Given
  [self addActionWithTitle:kFirstLongAction];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(14.f, 14.f, 14.f, 14.f);
  self.alertView.actionsHorizontalMargin = 14.f;
  self.alertView.actionsVerticalMargin = 1.f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

- (void)testAlertActionsHaveJustifiedVerticalCustomInsets {
  // Given
  [self addActionWithTitle:kFirstLongAction];
  self.alertController.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(14.f, 14.f, 14.f, 14.f);
  self.alertView.actionsHorizontalMargin = 14.f;
  self.alertView.actionsVerticalMargin = 6.f;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

// Testing regression reported in: "b/157470757 - Dialog with too little bottom padding".
- (void)testAlertVerticalActionsHaveCorrectVerticalCustomInsets {
  // Given
  [self addActionWithTitle:kFirstLongAction];
  self.alertController.actionsHorizontalAlignmentInVerticalLayout =
      MDCContentHorizontalAlignmentJustified;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  self.alertView.actionsInsets = UIEdgeInsetsMake(4.f, 20.f, 20.f, 20.f);

  // When
  self.alertController.orderVerticalActionsByEmphasis = YES;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Helpers

- (void)setElementsBackgroundColors {
  self.alertView.titleScrollView.backgroundColor =
      [UIColor.purpleColor colorWithAlphaComponent:.2f];
  self.alertView.titleLabel.backgroundColor = [UIColor.purpleColor colorWithAlphaComponent:.1f];
  self.alertView.contentScrollView.backgroundColor =
      [UIColor.orangeColor colorWithAlphaComponent:.2f];
  self.alertView.messageTextView.backgroundColor =
      [UIColor.orangeColor colorWithAlphaComponent:.2f];
  self.alertView.actionsScrollView.backgroundColor =
      [UIColor.blueColor colorWithAlphaComponent:.2f];
}

- (void)addActionWithTitle:(NSString *)actionTitle {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:actionTitle
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
}

- (void)addOKAction {
  [self addActionWithTitle:@"OK"];
}

- (void)addCancelAction {
  [self addActionWithTitle:@"Cancel"];
}

@end
