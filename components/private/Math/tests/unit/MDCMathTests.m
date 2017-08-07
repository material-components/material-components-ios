/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>
#import "MDCMath.h"

@interface MDCMathTests : XCTestCase

@end

@implementation MDCMathTests

- (void)testMDCRectAlignScale {
  // Given
  CGRect misalignedRect = CGRectMake(0.45, 0.78, 1.01, 5.98);
  CGRect alignedScale1Rect = CGRectMake(0, 0, 2, 7);
  CGRect alignedScale2Rect = CGRectMake(0, 0.5, 1.5, 6.5);
  CGRect alignedScale3Rect = CGRectMake(1.0 / 3.0, 2.0 / 3.0, 4.0 / 3.0, 19.0 / 3.0);

  // Then
  XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, MDCRectAlignToScale(misalignedRect, 1)));
  XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, MDCRectAlignToScale(misalignedRect, 2)));
  XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, MDCRectAlignToScale(misalignedRect, 3)));
}

- (void)testMDCRectAlignScaleNegativeRectangle {
  // Given
  CGRect misalignedRect = CGRectMake(-5.01, -0.399, 8.35, 2.65);
  CGRect alignedScale1Rect = CGRectMake(-6, -1, 10, 4);
  CGRect alignedScale2Rect = CGRectMake(-5.5, -0.5, 9, 3);
  CGRect alignedScale3Rect = CGRectMake(-16.0 / 3.0, -2.0 / 3.0, 9, 3);

  // Then
  XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, MDCRectAlignToScale(misalignedRect, 1)));
  XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, MDCRectAlignToScale(misalignedRect, 2)));
  XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, MDCRectAlignToScale(misalignedRect, 3)));
}

@end
