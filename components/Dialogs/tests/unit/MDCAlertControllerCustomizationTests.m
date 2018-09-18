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

@interface MDCAlertControllerCustomizationTests : XCTestCase

@end

@implementation MDCAlertControllerCustomizationTests

MDCAlertController *alert;
MDCAlertControllerView *alertView;

- (void)setUp {
  [super setUp];
  alert = [MDCAlertController alertControllerWithTitle:@"Title" message:@"Message"];
  alertView = (MDCAlertControllerView *)alert.view;
}

- (void)testApplyingTitleAlignment {
  // Given
  NSTextAlignment titleAlignment = NSTextAlignmentCenter;

  // When
  alert.titleAlignment = titleAlignment;

  // Then
  XCTAssertEqual(alertView.titleAlignment, titleAlignment);
  XCTAssertEqual(alertView.titleLabel.textAlignment, titleAlignment);
}

- (void)testAddingTitleIconToAlert {
  // Given
  UIImage *icon = TestImage(CGSizeMake(24, 24));

  // When
  alert.titleIcon = icon;

  // Then
  XCTAssertNotNil(alert.titleIcon);
  XCTAssertEqual(alertView.titleIcon, icon);
  XCTAssertEqual(alertView.titleIconImageView.image, icon);
}

- (void)testApplyingTintToTitleIcon {
  // Given
  UIImage *icon = TestImage(CGSizeMake(24, 24));
  UIColor *tintColor = UIColor.orangeColor;

  // When
  alert.titleIcon = icon;
  alert.titleIconTintColor = tintColor;

  // Then
  XCTAssertNotNil(alert.titleIcon);
  XCTAssertEqualObjects(alertView.titleIcon, icon);
  XCTAssertEqualObjects(alertView.titleIconTintColor, tintColor);
  XCTAssertEqualObjects(alertView.titleIconImageView.tintColor, tintColor);
}

- (void)testApplyingTintToTitleIconInAnyOrder {
  // Given
  UIImage *icon = TestImage(CGSizeMake(24, 24));
  UIColor *tintColor = UIColor.orangeColor;

  // When
  alert.titleIconTintColor = tintColor;
  alert.titleIcon = icon;

  // Then
  XCTAssertNotNil(alert.titleIcon);
  XCTAssertEqualObjects(alertView.titleIcon, icon);
  XCTAssertEqualObjects(alertView.titleIconTintColor, tintColor);
  XCTAssertEqualObjects(alertView.titleIconImageView.tintColor, tintColor);
}

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
