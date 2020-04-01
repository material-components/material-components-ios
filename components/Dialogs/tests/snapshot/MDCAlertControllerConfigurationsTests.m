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

#import "MDCAlertController+Customize.h"
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

#pragma mark - Helpers

- (void)sizeAlertToFitContent {
  // Ensure snapshot view size resembles actual runtime size of the alert. This is the closest
  // simulation to how an actual dialog will be sized on a screen. The dialog layouts itself with
  // final size when calculatePreferredContentSizeForBounds: is called - after all the dialog
  // configuration is complete.
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alertController.view;
  CGSize bounds = [alertView calculatePreferredContentSizeForBounds:alertView.bounds.size];
  alertView.bounds = CGRectMake(0.f, 0.f, bounds.width, bounds.height);
}

- (void)addOutlinedActionWithTitle:(NSString *)actionTitle {
  [self.alertController addAction:[MDCAlertAction actionWithTitle:actionTitle
                                                         emphasis:MDCActionEmphasisMedium
                                                          handler:nil]];
}

- (void)generateHighlightedSnapshotAndVerifyForAlert:(MDCAlertController *)alert {
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)alert.view;
  alertView.titleScrollView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
  alert.titleIconImageView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
  alert.titleIconView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.3f];
  alertView.titleLabel.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
  alertView.contentScrollView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:.1f];
  alertView.messageLabel.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:.2f];
  alertView.actionsScrollView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.2f];
  [self generateSizedSnapshotAndVerifyForView:alertView];
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

- (void)configAlertWithTitleIcon {
  self.alertController.titleIcon = self.titleIcon;
  [self configAlertWithResetSettings];
}

- (void)configAlertWithImageNamed:(NSString *)imageName {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCAlertControllerConfigurationsTests class]];
  self.alertController.titleIcon = [UIImage imageNamed:imageName
                                              inBundle:bundle
                         compatibleWithTraitCollection:nil];
  [self configAlertWithResetSettings];
}

- (void)configAlertWithWideImage {
  [self configAlertWithImageNamed:@"wide-image"];
}

- (void)configAlertWithSquareImage {
  [self configAlertWithImageNamed:@"square-image"];
}

- (void)configAlertWithLongImage {
  [self configAlertWithImageNamed:@"long-image"];
}

- (void)configAlertWithResetSettings {
  self.alertController.title = @"Reset Settings?";
  self.alertController.message = @"This will reset your device to its default factory settings.";
  [self addOutlinedActionWithTitle:@"Cancel"];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
}

#pragma mark - Tests

// title + actions
- (void)testAlertHasTitle {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.title = kTitleShortLatin;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-icon + actions
- (void)testAlertHasTitleIcon {
  // Given
  self.alertController.titleIcon = self.titleIcon;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-image + actions
- (void)testAlertHasTitleImage {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.titleIcon = self.titleImage;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message + actions
- (void)testAlertHasMessage {
  // Given
  self.alertController.message = kMessageLongLatin;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// accessory-view + actions
- (void)testAlertHasAccessoryView {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-icon + message + actions
- (void)testAlertHasTitleIconAndMessage {
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
- (void)testAlertHasTitleImageAndMessage {
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
- (void)testAlertHasTitleIconAndAccessoryView {
  // Given
  self.alertController.titleIcon = self.titleIcon;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title-image + accessory-view + actions
- (void)testAlertHasTitleImageAndAccessoryView {
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
- (void)testAlertHasMessageAndAccessoryView {
  // When
  self.alertController.message = kMessageLongLatin;
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + accessory-view + actions
- (void)testAlertHasTitleAndAccessoryView {
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
- (void)testAlertHasTitleAndTitleIconAndAccessoryView {
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
- (void)testAlertHasTitleAndTitleImageAndAccessoryView {
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
- (void)testAlertHasTitleAndTitleIconAndMessageAndAccessoryView {
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
- (void)testAlertHasTitleAndTitleImageAndMessageAndAccessoryView {
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
- (void)testAlertHasTitleImageAndVerticalButtons {
  // Given
  [self addOutlinedActionWithTitle:@"Verticallly Aligned Buttons"];
  self.alertController.titleIcon = self.titleImage;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  // Avoid sizing of snapshot view - to allow butttons to auto-align vertically.
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title-icon + message + accessory-view + vertical actions
- (void)testAlertHasTitleIconAndMessageAndAccessoryViewAndVerticalButtons {
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
  self.alertController.view.bounds = CGRectMake(0.f, 0.f, 300.f, 500.f);
  [self.alertController.view layoutIfNeeded];
  [self sizeAlertToFitContent];
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// accessory-view + actions in RTL
- (void)testAlertHasAccessoryViewInRTL {
  // Given
  self.alertController.accessoryView = self.accessoryView;

  // When
  [self.alertController applyThemeWithScheme:self.containerScheme2019];
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// title + title-icon + message + accessory-view + actions in RTL
- (void)testAlertHasTitleAndTitleIconAndMessageAndAccessoryViewInRTL {
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

#pragma mark - Use Cases Tests

- (void)testAlertHasAccessoryViewAndCustomInsets {
  // Given
  [self addOutlinedActionWithTitle:@"Cancel"];
  self.alertController.accessoryView = self.accessoryView;

  // When
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alertController.view;
  alertView.contentInsets = UIEdgeInsetsMake(0.f, 20.f, 0.f, 20.f);
  alertView.actionsInsets = UIEdgeInsetsMake(12.f, 20.f, 16.f, 20.f);

  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

#pragma mark - Message Alignment Tests

// message alignment: default alignment is natural
- (void)testMessageDefaultAlignmentIsNatural {
  // Given
  self.alertController.message = kMessageLongLatin;
  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message alignment: center
- (void)testMessageAlignmentIsCentered {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  self.alertController.messageAlignment = NSTextAlignmentCenter;

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message alignment: natural
- (void)testMessageAlignmentIsNatural {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.messageAlignment = NSTextAlignmentNatural;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// message alignment: natural in RTL
- (void)testMessageAlignmentIsNaturalInRTL {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  self.alertController.messageAlignment = NSTextAlignmentNatural;
  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message alignment: right
- (void)testMessageAlignmentIsRight {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  self.alertController.messageAlignment = NSTextAlignmentRight;

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

// message alignment: right in RTL
- (void)testMessageRightAlignmentIsRightInRTL {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  self.alertController.messageAlignment = NSTextAlignmentRight;
  [self changeToRTL:self.alertController];
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// message alignment: left
- (void)testMessageAlignmentIsLeft {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  self.alertController.messageAlignment = NSTextAlignmentLeft;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// message alignment: left in RTL
- (void)testMessageLeftAlignmentIsLeftInRTL {
  // Given
  self.alertController.title = @"A title that is longer than the message";
  self.alertController.message = kMessageShortLatin;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.messageAlignment = NSTextAlignmentLeft;
  [self changeToRTL:self.alertController];

  // Then
  self.alertController.view.bounds = CGRectMake(0.f, 0.f, 300.f, 200.f);
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

// message alignment: left in RTL. long message.
- (void)testLongMessageLeftAlignmentIsLeftInRTL {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;
  [self.alertController applyThemeWithScheme:self.containerScheme2019];

  // When
  self.alertController.messageAlignment = NSTextAlignmentLeft;
  [self changeToRTL:self.alertController];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// message alignment: justified
- (void)testMessageAlignmentIsJustified {
  // Given
  self.alertController.title = kTitleShortLatin;
  self.alertController.message = kMessageLongLatin;

  // When
  self.alertController.messageAlignment = NSTextAlignmentJustified;

  // Then
  [self generateSizedSnapshotAndVerifyForView:self.alertController.view];
}

#pragma mark - Title Icon View Tests

// title icon view: default alignment
- (void)testAlertHasTitleIconViewWithDefaultNaturalAlignment {
  // Given
  [self configAlertWithTitleIcon];
  self.alertController.titleIcon = nil;
  self.alertController.titleIconView =
      [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon view: natural alignment
- (void)testAlertHasTitleIconViewWithCenterAlignment {
  // Given
  [self configAlertWithTitleIcon];
  self.alertController.titleIcon = nil;
  self.alertController.titleIconView =
      [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon view: justified alignment
- (void)testAlertHasTitleIconViewWithJustifiedAlignment {
  // Given
  [self configAlertWithTitleIcon];
  self.alertController.titleIcon = nil;
  self.alertController.titleIconView =
      [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Title Icon - Default Alignment Tests

// title icon alignment: default to title alignment: center, image: wide
- (void)testTitleIconAlignmentDefaultIsCenteredForWideImage {
  // Given
  [self configAlertWithWideImage];

  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: center, image: square
- (void)testTitleIconAlignmentDefaultIsCenteredForSquareImage {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: center, image: long
- (void)testTitleIconAlignmentDefaultIsCenteredForLongImage {
  // Given
  [self configAlertWithLongImage];

  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: center, image: long, insets: custom
- (void)testTitleIconAlignmentDefaultIsCenteredForLongImageWithCustomInsets {
  // Given
  [self configAlertWithLongImage];

  // When
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alertController.view;
  alertView.titleInsets = UIEdgeInsetsMake(0.f, 0.f, 10.f, 0.f);
  self.alertController.titleAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: center
- (void)testTitleIconAlignmentDefaultIsCenteredWithCenteredTitle {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: natural
- (void)testTitleIconAlignmentDefaultIsNaturalWithNaturalTitle {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentNatural;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: justified
- (void)testTitleIconAlignmentDefaultIsJustifiedWithJustifiedTitle {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentJustified;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: left
- (void)testTitleIconAlignmentDefaultIsLeftWithLeftTitle {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentLeft;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: right
- (void)testTitleIconAlignmentDefaultIsRightWithRightTitle {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentRight;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: natural in RTL
- (void)testTitleIconAlignmentDefaultIsNaturalWithNaturalTitleInRTL {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentNatural;
  [self changeToRTL:self.alertController];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: left in RTL
- (void)testTitleIconAlignmentDefaultIsLeftWithLeftTitleInRTL {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentLeft;
  [self changeToRTL:self.alertController];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: default to title alignment: right - in RTL
- (void)testTitleIconAlignmentDefaultIsRightWithRightTitleInRTL {
  // Given
  [self configAlertWithTitleIcon];

  // When
  self.alertController.titleAlignment = NSTextAlignmentRight;
  [self changeToRTL:self.alertController];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

#pragma mark - Title Icon - Custom Alignment Tests

// title icon alignment: Center
- (void)testTitleIconAlignmentIsCentered {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentCenter;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Natural
- (void)testTitleIconAlignmentIsNatural {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentNatural;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Left
- (void)testTitleIconAlignmentIsLeft {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentLeft;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Natural in RTL
- (void)testTitleIconAlignmentIsNaturalInRTL {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentNatural;
  [self changeToRTL:self.alertController];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Left in RTL
- (void)testTitleIconAlignmentIsLeftInRTL {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentLeft;
  [self changeToRTL:self.alertController];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. Content mode: scale to fill
- (void)testTitleIconAlignmentIsJustifiedContentModeAspectFill {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  self.alertController.titleIconImageView.contentMode = UIViewContentModeScaleToFill;
  self.alertController.titleIconImageView.clipsToBounds = YES;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. Content mode: scale aspect fill
- (void)testTitleIconAlignmentIsJustifiedContentModeScaleAspectFill {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  self.alertController.titleIconImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.alertController.titleIconImageView.clipsToBounds = YES;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. Content mode: scale aspect fit
- (void)testTitleIconAlignmentIsJustifiedContentModeScaleAspectFit {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  self.alertController.titleIconImageView.contentMode = UIViewContentModeScaleAspectFit;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. Content mode: left
- (void)testTitleIconAlignmentIsJustifiedContentModeLeft {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  self.alertController.titleIconImageView.contentMode = UIViewContentModeLeft;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. Content mode: right
- (void)testTitleIconAlignmentIsJustifiedContentModeRight {
  // Given
  [self configAlertWithSquareImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  self.alertController.titleIconImageView.contentMode = UIViewContentModeRight;

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. image: extra wide
- (void)testTitleIconAlignmentIsJustifiedAndWideImageResized {
  // Given
  [self configAlertWithWideImage];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  // Recalculate layout and adjust the snapshot size to fit the new dialog size.
  [self sizeAlertToFitContent];
  [self.alertController.view layoutIfNeeded];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

// title icon alignment: Justified. image: extra wide, extra tall
- (void)testTitleIconAlignmentIsJustifiedAndSquareImageResized {
  // Given
  self.alertController.titleIcon = [[UIImage mdc_testImageOfSize:CGSizeMake(400.f, 360.f)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self configAlertWithResetSettings];

  // When
  self.alertController.titleIconAlignment = NSTextAlignmentJustified;
  // Recalculate layout and adjust the snapshot size to fit the new dialog size.
  [self sizeAlertToFitContent];
  [self.alertController.view layoutIfNeeded];

  // Then
  [self generateHighlightedSnapshotAndVerifyForAlert:self.alertController];
}

@end
