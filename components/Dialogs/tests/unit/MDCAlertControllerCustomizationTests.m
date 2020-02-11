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

#import "MaterialDialogs+TypographyThemer.h"
#import "MaterialDialogs.h"

#import "MDCAlertControllerView+Private.h"

#import <XCTest/XCTest.h>

@interface MDCAlertControllerView (Testing)
@property(nonatomic, nullable, strong) UIImageView *titleIconImageView;
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

  // Then
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

#pragma mark - helpers

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

@end
