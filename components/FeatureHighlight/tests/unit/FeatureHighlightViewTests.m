// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialFeatureHighlight.h"

@interface FeatureHighlightNoopTest : XCTestCase

@end

@implementation FeatureHighlightNoopTest

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCFeatureHighlightView *view = [[MDCFeatureHighlightView alloc] init];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCFeatureHighlightView *passedFeatureHighlightView = nil;
  view.traitCollectionDidChangeBlock = ^(MDCFeatureHighlightView *_Nonnull featureHighlight,
                                         UITraitCollection *_Nullable previousTraitCollection) {
    passedTraitCollection = previousTraitCollection;
    passedFeatureHighlightView = featureHighlight;
    [expectation fulfill];
  };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [view traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedFeatureHighlightView, view);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

@end
