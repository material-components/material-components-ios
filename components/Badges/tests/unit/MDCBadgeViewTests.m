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

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "MDCBadgeView.h"

@interface MDCBadgeViewTests : XCTestCase
@property(nonatomic, strong) MDCBadgeView *badge;
@end

@implementation MDCBadgeViewTests

- (void)setUp {
  [super setUp];

  self.badge = [[MDCBadgeView alloc] init];
}

- (void)tearDown {
  self.badge = nil;

  [super tearDown];
}

- (void)testSizeThatFitsWontResize {
  // Given
  self.badge.text = @"1234";
  CGRect originalFrame = CGRectMake(0, 0, 1, 1);
  self.badge.frame = originalFrame;

  // When
  [self.badge sizeThatFits:CGSizeMake(10, 10)];

  // Then
  CGRect finalFrame = CGRectStandardize(self.badge.frame);
  XCTAssertTrue(CGRectEqualToRect(finalFrame, originalFrame), @"(%@) is not equal to (%@)",
                NSStringFromCGRect(finalFrame), NSStringFromCGRect(originalFrame));
}

- (void)testSizeThatFitsAffectedByLabel {
  // Given
  CGSize fitSizeWithoutLabel = [self.badge sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];

  // When
  self.badge.text = @"1234567890";

  // Then
  CGSize fitsSizeWithLabel = [self.badge sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  XCTAssertFalse(CGSizeEqualToSize(fitSizeWithoutLabel, fitsSizeWithLabel),
                 @"(%@) should not equal (%@) when a non-nil label is set",
                 NSStringFromCGSize(fitSizeWithoutLabel), NSStringFromCGSize(fitsSizeWithLabel));
  XCTAssertLessThan(fitSizeWithoutLabel.width, fitsSizeWithLabel.width);
  XCTAssertLessThan(fitSizeWithoutLabel.height, fitsSizeWithLabel.height);
}

- (void)testSizeToFitNilLabel {
  // Given
  self.badge.text = nil;

  // When
  [self.badge sizeToFit];

  // Then
  CGRect badgeBounds = CGRectStandardize(self.badge.bounds);
  XCTAssertTrue(CGRectEqualToRect(badgeBounds, CGRectZero), @"(%@) is not equal to (%@)",
                NSStringFromCGRect(badgeBounds), NSStringFromCGRect(CGRectZero));
}

- (void)testSizeToFitEmptyLabel {
  // Given
  self.badge.text = @"";

  // When
  [self.badge sizeToFit];

  // Then
  CGRect badgeBounds = CGRectStandardize(self.badge.bounds);
  XCTAssertGreaterThan(badgeBounds.size.width, 1);
  XCTAssertGreaterThan(badgeBounds.size.height, 1);
  XCTAssertEqualWithAccuracy(badgeBounds.size.width, badgeBounds.size.height, 0.001);
}

- (void)testLayoutSubviewsWontAdjustFrame {
  // Given
  self.badge.text = @"1234";
  CGRect originalFrame = CGRectMake(0, 0, 10, 10);
  self.badge.frame = originalFrame;

  // When
  [self.badge layoutSubviews];

  // Then
  CGRect finalFrame = CGRectStandardize(self.badge.frame);
  XCTAssertTrue(CGRectEqualToRect(finalFrame, originalFrame), @"(%@) is not equal to (%@)",
                NSStringFromCGRect(finalFrame), NSStringFromCGRect(originalFrame));
}

@end
