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

#import "MaterialElevation.h"

#import <XCTest/XCTest.h>

/** Test class for testing @c UIViews that conform to @c MDCElevation */
@interface FakeMDCElevationConformingView : UIView <MDCElevation>
@property(nonatomic, assign, readonly) CGFloat mdc_currentElevation;
@property(nonatomic, assign) CGFloat elevation;
@end

@implementation FakeMDCElevationConformingView

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (void)setElevation:(CGFloat)elevation {
  _elevation = elevation;
}

@end

@interface MDCElevationTests : XCTestCase

@end

@implementation MDCElevationTests

- (void)testViewElevationDidChangeCallsBlock {
  // Given
  FakeMDCElevationConformingView *view = [[FakeMDCElevationConformingView alloc] init];
  CGFloat fakeElevation = 10;

  // When
  view.elevation = 10;

  // Then
  XCTAssertEqual(view.mdc_currentElevation, fakeElevation);
}

@end
