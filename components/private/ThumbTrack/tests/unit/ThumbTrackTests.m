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

#import <XCTest/XCTest.h>
#import "../../src/private/MDCThumbTrack+Private.h"
#import "MaterialInk.h"
#import "MaterialTypography.h"
#import "MDCNumericValueLabel.h"
#import "MaterialThumbTrack.h"
#import "MDCDiscreteDotView.h"

@interface ThumbTrackTests : XCTestCase

@end

@implementation ThumbTrackTests

#pragma mark - primaryColor

- (void)testPrimaryColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.primaryColor, UIColor.blueColor);
}

- (void)testPrimaryColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.primaryColor = UIColor.magentaColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnColor, thumbTrack.primaryColor);
  XCTAssertEqualObjects(thumbTrack.thumbEnabledColor, thumbTrack.primaryColor);
  XCTAssertEqualObjects(thumbTrack.inkColor,
                        [thumbTrack.primaryColor colorWithAlphaComponent:(CGFloat)0.5]);
  XCTAssertEqualObjects(thumbTrack.valueLabelBackgroundColor, thumbTrack.primaryColor);
}

#pragma mark - thumbEnabledColor

- (void)testThumbEnabledColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.thumbEnabledColor, UIColor.blueColor);
}

- (void)testSetThumbEnabledColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.thumbEnabledColor = UIColor.magentaColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.thumbEnabledColor, UIColor.magentaColor);
}

- (void)testThumbEnabledColorNullResettable {
  // Given
  MDCThumbTrack *defaultThumbTrack = [[MDCThumbTrack alloc] init];
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.thumbEnabledColor = UIColor.magentaColor;
  thumbTrack.thumbEnabledColor = nil;

  // Then
  XCTAssertEqualObjects(thumbTrack.thumbEnabledColor, defaultThumbTrack.thumbEnabledColor);
}

#pragma mark - thumbDisabledColor

- (void)testThumbDisabledColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertNil(thumbTrack.thumbDisabledColor);
}

- (void)testSetThumbDisabledColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.thumbDisabledColor = UIColor.magentaColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.thumbDisabledColor, UIColor.magentaColor);
}

#pragma mark - trackOnColor

- (void)testTrackOnColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnColor, UIColor.blueColor);
}

- (void)testSetTrackOnColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.trackOnColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnColor, UIColor.orangeColor);
}

- (void)testTrackOnColorNullResettable {
  // Given
  MDCThumbTrack *defaultThumbTrack = [[MDCThumbTrack alloc] init];
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.trackOnColor = UIColor.cyanColor;
  thumbTrack.trackOnColor = nil;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnColor, defaultThumbTrack.trackOnColor);
}

#pragma mark - trackOffColor

- (void)testTrackOffColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertNil(thumbTrack.trackOffColor);
}

- (void)testSetTrackOffColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.trackOffColor = UIColor.yellowColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOffColor, UIColor.yellowColor);
}

#pragma mark - trackOnTickColor

- (void)testTrackOnTickColorDefaults {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnTickColor, UIColor.blackColor);
}

- (void)testSetTrackOnTickColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.discreteDotVisibility = MDCThumbDiscreteDotVisibilityWhenDragging;
  thumbTrack.trackOnTickColor = UIColor.cyanColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnTickColor, UIColor.cyanColor);
  XCTAssertEqualObjects(thumbTrack.discreteDotView.activeDotColor, thumbTrack.trackOnTickColor);
}

- (void)testTrackOnTickColorWorksBeforeEnablingDiscreteDots {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.discreteDotVisibility = MDCThumbDiscreteDotVisibilityNever;
  thumbTrack.trackOnTickColor = UIColor.cyanColor;
  thumbTrack.discreteDotVisibility = MDCThumbDiscreteDotVisibilityWhenDragging;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOnTickColor, UIColor.cyanColor);
  XCTAssertEqualObjects(thumbTrack.discreteDotView.activeDotColor, thumbTrack.trackOnTickColor);
}

#pragma mark - trackOffTickColor

- (void)testTrackOffTickColorDefaults {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOffTickColor, UIColor.blackColor);
}

- (void)testSetTrackOffTickColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.discreteDotVisibility = MDCThumbDiscreteDotVisibilityWhenDragging;
  thumbTrack.trackOffTickColor = UIColor.cyanColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOffTickColor, UIColor.cyanColor);
  XCTAssertEqualObjects(thumbTrack.discreteDotView.inactiveDotColor, thumbTrack.trackOffTickColor);
}

- (void)testTrackOffTickColorWorksBeforeEnablingDiscreteDots {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.discreteDotVisibility = MDCThumbDiscreteDotVisibilityNever;
  thumbTrack.trackOffTickColor = UIColor.cyanColor;
  thumbTrack.discreteDotVisibility = MDCThumbDiscreteDotVisibilityWhenDragging;

  // Then
  XCTAssertEqualObjects(thumbTrack.trackOffTickColor, UIColor.cyanColor);
  XCTAssertEqualObjects(thumbTrack.discreteDotView.inactiveDotColor, thumbTrack.trackOffTickColor);
}

#pragma mark - inkColor

- (void)testInkColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.inkColor,
                        [UIColor.blueColor colorWithAlphaComponent:(CGFloat)0.5]);
}

- (void)testSetInkColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.inkColor = UIColor.magentaColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.inkColor, UIColor.magentaColor);
}

- (void)testSetValueLabelTextColorAppliesToInk {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.inkColor = UIColor.cyanColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.touchController.defaultInkView.inkColor, UIColor.cyanColor);
}

#pragma mark - valueLabelTextColor

- (void)testValueLabelTextColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.valueLabelTextColor, UIColor.whiteColor);
}

- (void)testSetValueLabelTextColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.valueLabelTextColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.valueLabelTextColor, UIColor.orangeColor);
}

- (void)testValueLabelTextColorNullResettable {
  // Given
  MDCThumbTrack *defaultThumbTrack = [[MDCThumbTrack alloc] init];
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.valueLabelTextColor = UIColor.magentaColor;
  thumbTrack.valueLabelTextColor = nil;

  // Then
  XCTAssertEqualObjects(thumbTrack.valueLabelTextColor, defaultThumbTrack.valueLabelTextColor);
}

- (void)testSetValueLabelTextColorAppliesToValueLabel {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];
  thumbTrack.numDiscreteValues = 10;
  thumbTrack.shouldDisplayDiscreteValueLabel = YES;

  // When
  thumbTrack.valueLabelTextColor = UIColor.cyanColor;
  [thumbTrack layoutIfNeeded];

  // Then
  XCTAssertEqualObjects(thumbTrack.numericValueLabel.textColor, UIColor.cyanColor);
}

#pragma mark - valueLabelBackgroundColor

- (void)testValueLabelBackgroundColorDefault {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.valueLabelBackgroundColor, UIColor.blueColor);
}

- (void)testSetValueLabelBackgroundColor {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.valueLabelBackgroundColor = UIColor.orangeColor;

  // Then
  XCTAssertEqualObjects(thumbTrack.valueLabelBackgroundColor, UIColor.orangeColor);
}

- (void)testValueLabelBackgroundColorNullResettable {
  // Given
  MDCThumbTrack *defaultThumbTrack = [[MDCThumbTrack alloc] init];
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // When
  thumbTrack.valueLabelBackgroundColor = UIColor.magentaColor;
  thumbTrack.valueLabelBackgroundColor = nil;

  // Then
  XCTAssertEqualObjects(thumbTrack.valueLabelBackgroundColor,
                        defaultThumbTrack.valueLabelBackgroundColor);
}

- (void)testSetValueLabelBackgroundColorAppliesToValueLabel {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];
  thumbTrack.numDiscreteValues = 10;
  thumbTrack.shouldDisplayDiscreteValueLabel = YES;

  // When
  thumbTrack.valueLabelBackgroundColor = UIColor.cyanColor;
  [thumbTrack layoutIfNeeded];

  // Then
  XCTAssertEqualObjects(thumbTrack.numericValueLabel.backgroundColor, UIColor.cyanColor);
}

- (void)testDiscreteValueLabelFontDefaultValue {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];

  // Then
  XCTAssertEqualObjects(thumbTrack.discreteValueLabelFont,
                        [[MDCTypography fontLoader] regularFontOfSize:12]);
}

- (void)testDiscreteValueLabelFontSettingToNilValue {
  // Given
  MDCThumbTrack *thumbTrack = [[MDCThumbTrack alloc] init];
  thumbTrack.discreteValueLabelFont = [UIFont systemFontOfSize:20];

  // When
  thumbTrack.discreteValueLabelFont = nil;

  // Then
  XCTAssertEqualObjects(thumbTrack.discreteValueLabelFont,
                        [[MDCTypography fontLoader] regularFontOfSize:12]);
}

@end
