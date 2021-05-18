// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialDialogs.h"

#import "MaterialButtons.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MDCAlertControllerView+Private.h"

#import <XCTest/XCTest.h>

static inline UIImage *TestImage(CGSize size) {
  CGFloat scale = [UIScreen mainScreen].scale;
  UIGraphicsBeginImageContextWithOptions(size, false, scale);
  [UIColor.redColor setFill];
  CGRect fillRect = CGRectZero;
  fillRect.size = size;
  UIRectFill(fillRect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface MDCAlertControllerView (Testing)
@property(nonatomic, nullable, strong) UIImageView *titleIconImageView;
@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;
@end

@interface MDCAlertControllerCustomizationTests : XCTestCase
@property(nonatomic, nullable, strong) MDCAlertController *alert;
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@property(nonatomic, nullable, weak) MDCDialogPresentationController *presentationController;

@end

@implementation MDCAlertControllerCustomizationTests

- (void)setUp {
  [super setUp];
  self.alert = [MDCAlertController alertControllerWithTitle:@"Title" message:@"Message"];
  XCTAssertTrue([self.alert.view isKindOfClass:[MDCAlertControllerView class]]);
  self.alertView = (MDCAlertControllerView *)self.alert.view;
  self.presentationController = self.alert.mdc_dialogPresentationController;
}

- (void)tearDown {
  self.presentationController = nil;
  self.alertView = nil;
  self.alert = nil;
  [super tearDown];
}

- (void)testApplyingTitleAlignment {
  // Given
  NSTextAlignment titleAlignment = NSTextAlignmentCenter;

  // When
  self.alert.titleAlignment = titleAlignment;

  // Then
  XCTAssertEqual(self.alertView.titleAlignment, titleAlignment);
  XCTAssertEqual(self.alertView.titleLabel.textAlignment, titleAlignment);
}

- (void)testAddingTitleIconToAlert {
  // Given
  UIImage *icon = TestImage(CGSizeMake(24, 24));

  // When
  self.alert.titleIcon = icon;

  // Then
  XCTAssertNotNil(self.alert.titleIcon);
  XCTAssertEqual(self.alertView.titleIcon, icon);
  XCTAssertEqual(self.alertView.titleIconImageView.image, icon);
}

- (void)testApplyingTintToTitleIcon {
  // Given
  UIImage *icon = TestImage(CGSizeMake(24, 24));
  UIColor *tintColor = UIColor.orangeColor;

  // When
  self.alert.titleIcon = icon;
  self.alert.titleIconTintColor = tintColor;

  // Then
  XCTAssertNotNil(self.alert.titleIcon);
  XCTAssertEqualObjects(self.alertView.titleIcon, icon);
  XCTAssertEqualObjects(self.alertView.titleIconTintColor, tintColor);
  XCTAssertEqualObjects(self.alertView.titleIconImageView.tintColor, tintColor);
}

- (void)testApplyingTintToTitleIconInAnyOrder {
  // Given
  UIImage *icon = TestImage(CGSizeMake(24, 24));
  UIColor *tintColor = UIColor.orangeColor;

  // When
  self.alert.titleIconTintColor = tintColor;
  self.alert.titleIcon = icon;

  // Then
  XCTAssertNotNil(self.alert.titleIcon);
  XCTAssertEqualObjects(self.alertView.titleIcon, icon);
  XCTAssertEqualObjects(self.alertView.titleIconTintColor, tintColor);
  XCTAssertEqualObjects(self.alertView.titleIconImageView.tintColor, tintColor);
}

- (void)testApplyingScrimColorToPresentationController {
  // Given
  UIColor *scrimColor = [UIColor.orangeColor colorWithAlphaComponent:(CGFloat)0.5];

  // When
  self.presentationController.scrimColor = scrimColor;

  // Them
  XCTAssertEqualObjects(self.presentationController.scrimColor, scrimColor);
}

- (void)testApplyingScrimColorToAlert {
  // Given
  UIColor *scrimColor = [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.3];

  // When
  self.alert.scrimColor = scrimColor;

  // Then
  XCTAssertEqualObjects(self.presentationController.scrimColor, scrimColor);
}

- (void)testTitleIconHasDefaultAlignment {
  // Given
  CGSize imageSize = CGSizeMake(24.0f, 24.0f);
  self.alert.titleIcon = TestImage(imageSize);

  // Adjust the dialog size to the calculated preferred size.
  UIEdgeInsets insets = self.alertView.titleIconInsets;
  CGSize bounds = CGSizeMake(300.0f, 300.0f);
  CGSize alertSize = [self.alertView calculatePreferredContentSizeForBounds:bounds];
  self.alertView.bounds = CGRectMake(0.f, 0.f, alertSize.width, alertSize.height);
  [self.alertView layoutIfNeeded];

  // Then
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentNatural);
  CGRect iconFrame = CGRectMake(insets.left, insets.top, imageSize.width, imageSize.height);
  XCTAssertTrue(CGRectEqualToRect(self.alertView.titleIconImageView.frame, iconFrame));
}

- (void)testTitleIconAlignmentChangesWithTitleAlignment {
  // Given
  self.alert.titleIcon = TestImage(CGSizeMake(24.0f, 24.0f));

  // When
  self.alert.titleAlignment = NSTextAlignmentRight;

  // Then
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentRight);
}

- (void)testTitleIconAlignmentDoesntChangeWithTitleAlignmentAfterAssignment {
  // Given
  self.alert.titleIcon = TestImage(CGSizeMake(24.0f, 24.0f));

  // When
  self.alert.titleIconAlignment = NSTextAlignmentCenter;
  self.alert.titleAlignment = NSTextAlignmentRight;

  // Then
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentCenter);
}

- (void)testTitleIconJustifiedAlignmentFrameIsFullWidth {
  // Given
  CGSize imageSize = CGSizeMake(24.0f, 24.0f);
  self.alert.titleIcon = TestImage(imageSize);
  UIEdgeInsets insets = self.alertView.titleIconInsets;

  // When
  self.alert.titleIconAlignment = NSTextAlignmentJustified;
  [self sizeAlertToFitContent];

  // Then
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentJustified);
  CGFloat fullWidthMinusInsets = self.alertView.bounds.size.width - insets.left - insets.right;
  CGRect iconFrame = CGRectMake(insets.left, insets.top, fullWidthMinusInsets, imageSize.height);
  XCTAssertTrue(CGRectEqualToRect(self.alertView.titleIconImageView.frame, iconFrame));
}

// title icon alignment: Justified. image: extra wide, extra tall
- (void)testTitleIconAlignmentIsJustifiedAndSquareImageResized {
  // Given
  CGSize imageSize = CGSizeMake(320.0f, 190.0f);
  self.alert.titleIcon = TestImage(imageSize);
  UIEdgeInsets insets = self.alertView.titleIconInsets;

  // When
  self.alert.titleIconAlignment = NSTextAlignmentJustified;
  [self sizeAlertToFitContent];

  // Then
  XCTAssertEqual(self.alert.titleIconAlignment, NSTextAlignmentJustified);
  CGFloat fullWidthMinusInsets = self.alertView.bounds.size.width - insets.left - insets.right;
  CGRect iconFrame = CGRectMake(insets.left, insets.top, fullWidthMinusInsets,
                                imageSize.height * (fullWidthMinusInsets / imageSize.width));
  XCTAssertTrue(CGRectEqualToRect(self.alertView.titleIconImageView.frame, iconFrame));
}

// testing vertical alignment of long justified actions
- (void)testLongJustifiedActionsAreVerticallyAligned {
  // Given
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"First Long Action"
                                               emphasis:MDCActionEmphasisMedium
                                                handler:nil]];
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"Cancel"
                                               emphasis:MDCActionEmphasisMedium
                                                handler:nil]];

  // When
  self.alert.actionsHorizontalAlignment = MDCContentHorizontalAlignmentJustified;
  self.alert.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentJustified;
  [self sizeAlertToFitContent];

  // Then
  XCTAssertEqual(self.alertView.isVerticalActionsLayout, true);
}

- (void)testAddActionsMaintainsOrder {
  // Given
  MDCAlertAction *actionOne = [MDCAlertAction actionWithTitle:@"Foo" handler:nil];
  MDCAlertAction *actionTwo = [MDCAlertAction actionWithTitle:@"Bar" handler:nil];
  MDCAlertController *otherAlert = [[MDCAlertController alloc] init];

  // When
  [self.alert addActions:@[ actionOne, actionTwo ]];
  [otherAlert addAction:actionOne];
  [otherAlert addAction:actionTwo];

  // Then
  XCTAssertEqualObjects(self.alert.actions, otherAlert.actions);
}

- (void)testAddActionsCreatesButtonsCorrectly {
  // Given
  MDCAlertAction *actionOne = [MDCAlertAction actionWithTitle:@"Foo" handler:nil];
  MDCAlertAction *actionTwo = [MDCAlertAction actionWithTitle:@"Bar" handler:nil];

  // When
  [self.alert addActions:@[ actionOne, actionTwo ]];

  // Then
  XCTAssertEqualObjects([[self.alert buttonForAction:actionOne] titleForState:UIControlStateNormal],
                        [actionOne.title uppercaseString]);
  XCTAssertEqualObjects([[self.alert buttonForAction:actionTwo] titleForState:UIControlStateNormal],
                        [actionTwo.title uppercaseString]);
}

#pragma mark - Helpers

// Adjust the alert size to match the calculated preferred size.
- (void)sizeAlertToFitContent {
  CGSize bounds = CGSizeMake(300.0f, 300.0f);
  CGSize alertSize = [self.alertView calculatePreferredContentSizeForBounds:bounds];
  self.alertView.bounds = CGRectMake(0.f, 0.f, alertSize.width, alertSize.height);
  [self.alertView layoutIfNeeded];
}

@end
