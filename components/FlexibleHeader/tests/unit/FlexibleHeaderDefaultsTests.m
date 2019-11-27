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

#import <XCTest/XCTest.h>

#import "MaterialFlexibleHeader.h"

@interface FlexibleHeaderDefaultsTests : XCTestCase
@end

@implementation FlexibleHeaderDefaultsTests

- (void)testAll {
  // Given
  MDCFlexibleHeaderView *fhv = [[MDCFlexibleHeaderView alloc] init];

  // Then
  XCTAssertNil(fhv.animationDelegate);
  XCTAssertTrue(fhv.canOverExtend);
  XCTAssertFalse(fhv.contentIsTranslucent);
  XCTAssertNil(fhv.delegate);
  if (@available(iOS 11.0, *)) {
    XCTAssertFalse(fhv.disableContentInsetAdjustmentWhenContentInsetAdjustmentBehaviorIsNever);
  }
  XCTAssertEqualWithAccuracy(fhv.elevation, 0, 0.001);
  XCTAssertEqual(fhv.headerContentImportance, MDCFlexibleHeaderContentImportanceDefault);
  XCTAssertFalse(fhv.inFrontOfInfiniteContent);
  XCTAssertTrue(fhv.minMaxHeightIncludesSafeArea);
  XCTAssertFalse(fhv.observesTrackingScrollViewScrollEvents);
  XCTAssertFalse(fhv.prefersStatusBarHidden);
  XCTAssertFalse(fhv.resetShadowAfterTrackingScrollViewIsReset);
  XCTAssertEqual(fhv.scrollPhase, MDCFlexibleHeaderScrollPhaseShifting);
  XCTAssertEqualWithAccuracy(fhv.scrollPhaseValue, 0, 0.001);
  XCTAssertEqualWithAccuracy(fhv.scrollPhasePercentage, 0, 0.00001);
  XCTAssertFalse(fhv.sharedWithManyScrollViews);
  XCTAssertEqual(fhv.shiftBehavior, MDCFlexibleHeaderShiftBehaviorDisabled);
  XCTAssertNotNil(fhv.topSafeAreaGuide);
  XCTAssertNil(fhv.trackingScrollView);
  XCTAssertFalse(fhv.trackingScrollViewIsBeingScrubbed);
}

@end
