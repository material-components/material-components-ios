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
#import "MDCAlertControllerView+Private.h"
#import "MaterialContainerScheme.h"

static NSString *const kTitleShortLatin = @"Title";
static NSString *const kMessageShortLatin = @"A short message.";
static NSString *const kMessageLongLatin =
    @"Lorem ipsum dolor sit amet, consul docendi indoctum id quo, ad unum suavitate incorrupte "
     "sea. An his meis consul cotidieque, eam recteque mnesarchum et, mundi volumus cu cum. Quo "
     "falli dicunt an. Praesent molestiae vim ut.";

@interface MDCAlertControllerConfigurationsTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCAlertController *alertController;
@property(nonatomic, strong) MDCContainerScheme *containerScheme2019;
@property(nonatomic, strong) UIImage *titleIcon;
@property(nonatomic, strong) UIImage *titleImage;
@property(nonatomic, strong) UIView *accessoryView;
@end

@implementation MDCAlertControllerConfigurationsTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alertController = [MDCAlertController alertControllerWithTitle:nil message:nil];
  [self addOutlinedActionWithTitle:@"OK"];

  self.alertController.view.bounds = CGRectMake(0.f, 0.f, 300.f, 300.f);

  //  Uncomment to test with the adjustableInserts flag enabled:
  //    MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alertController.view;
  //    alertView.enableAdjustableInsets = YES;

  self.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(24.f, 24.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.titleImage = [[UIImage mdc_testImageOfSize:CGSizeMake(180.f, 120.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 150.f, 150.f)];
  [self.accessoryView setBackgroundColor:[[UIColor purpleColor] colorWithAlphaComponent:0.5f]];

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

- (void)sizeAlertToFitContent {
  CGSize preferredContentSize = self.alertController.preferredContentSize;
  self.alertController.view.bounds =
      CGRectMake(0.f, 0.f, preferredContentSize.width, preferredContentSize.height);
}

- (void)addOutlinedActionWithTitle:(NSString *)actionTitle {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:actionTitle
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
}

- (void)generateSizedSnapshotAndVerifyForView:(UIView *)view {
  [self sizeAlertToFitContent];
  [self generateSnapshotAndVerifyForView:view];
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

// title + actions
- (void)testAlignmentOfTitle {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.title = kTitleShortLatin;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-icon + actions
- (void)testAlignmentOfTitleIcon {
  // Given
  self.alertController.titleIcon = self.titleIcon;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-image + actions
- (void)testAlignmentOfTitleImage {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleImage;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message + actions
- (void)testAlignmentOfMessage {
  // Given
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// accessory-view + actions
- (void)testAlignmentOfAccessoryView {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-icon + message + actions
- (void)testAlignmentOfTitleIconAndMessage {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.message = kMessageShortLatin;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-image + message + actions
- (void)testAlignmentOfTitleImageAndMessage {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleImage;
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-icon + accessory-view + actions
- (void)testAlignmentOfTitleIconAndAccessoryView {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-image + accessory-view + actions
- (void)testAlignmentOfTitleImageAndAccessoryView {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleImage;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message + accessory-view + actions
- (void)testAlignmentOfMessageAndAccessoryView {
  // When
  self.alertController.message = kMessageLongLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + accessory-view + actions
- (void)testAlignmentOfTitleAndAccessoryView {
  // When
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.title = kTitleShortLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + title-icon + accessory-view + actions
- (void)testAlignmentOfTitleAndTitleIconAndAccessoryView {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.title = kTitleShortLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + title-image + accessory-view + actions
- (void)testAlignmentOfTitleAndTitleImageAndAccessoryView {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleImage;
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageShortLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + title-icon + message + accessory-view + actions
- (void)testAlignmentOfTitleAndTitleIconAndMessageAndAccessoryView {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + title-image + message + accessory-view + actions
- (void)testAlignmentOfTtitleAndTitleImageAndMessageAndAccessoryView {
  // Given
  self.alertController.titleIcon = self.titleImage;
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-image + vertical actions
- (void)testAlignmentOfTitleImageAndVerticalButtons {
  // Given
  [self addOutlinedActionWithTitle:@"Verticallly Aligned Buttons"];
  self.alertController.titleIcon = self.titleImage;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  // Avoid sizing of snapshot view - to allow butttons to auto-align vertically.
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// title-icon + message + accessory-view + vertical actions
- (void)testAlignmentOfTitleIconAndMessageAndAccessoryViewAndVerticalButtons {
  // Given

  [self addOutlinedActionWithTitle:@"Buttons?"];
  [self addOutlinedActionWithTitle:@"Vertical"];
  [self addOutlinedActionWithTitle:@"Four"];
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.message = kMessageShortLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  // Ensure enough vertical space for all buttons before layout, then size to fit content.
  self.alertController.view.bounds = CGRectMake(0, 0, 300, 500);
  [self.alertController.view layoutIfNeeded];
  [self sizeAlertToFitContent];
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// accessory-view + actions in RTL
- (void)testAlignmentOfAccessoryViewInRTL {
  // Given
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + title-icon + message + accessory-view + actions in RTL
- (void)testAlignmentOfTitleAndTitleIconAndMessageAndAccessoryViewInRTL {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

@end
