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

@interface FlexibleHeaderTraitCollectionDidChangeTests : XCTestCase

@end

@implementation FlexibleHeaderTraitCollectionDidChangeTests

- (void)testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChangesForFlexibleHeaderView {
  // Given
  MDCFlexibleHeaderView *flexibleHeader = [[MDCFlexibleHeaderView alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  flexibleHeader.traitCollectionDidChangeBlock =
      ^(MDCFlexibleHeaderView *_Nonnull flexibleHeaderView,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
      };

  // When
  [flexibleHeader traitCollectionDidChange:nil];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParametersForFlexibleHeaderView {
  // Given
  MDCFlexibleHeaderView *flexibleHeader = [[MDCFlexibleHeaderView alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCFlexibleHeaderView *passedFlexibleHeader;
  flexibleHeader.traitCollectionDidChangeBlock =
      ^(MDCFlexibleHeaderView *_Nonnull flexibleHeaderView,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedFlexibleHeader = flexibleHeaderView;
        [expectation fulfill];
      };

  // When
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [flexibleHeader traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedFlexibleHeader, flexibleHeader);
}

- (void)
    testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChangesForFlexibleHeaderViewController {
  // Given
  MDCFlexibleHeaderViewController *flexibleHeaderController =
      [[MDCFlexibleHeaderViewController alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  flexibleHeaderController.traitCollectionDidChangeBlock =
      ^(MDCFlexibleHeaderViewController *_Nonnull flexibleHeaderViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
//        flexibleHeaderViewController.traitCollectionDidChangeBlock = nil;
      };

  // When
  [flexibleHeaderController traitCollectionDidChange:nil];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
}

- (void)
    testTraitCollectionDidChangeBlockCalledWithExpectedParametersForFlexibleHeaderViewController {
  // Given
  MDCFlexibleHeaderViewController *flexibleHeaderController =
      [[MDCFlexibleHeaderViewController alloc] init];
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Called traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCFlexibleHeaderViewController *passedFlexibleHeader;
  flexibleHeaderController.traitCollectionDidChangeBlock =
      ^(MDCFlexibleHeaderViewController *_Nonnull flexibleHeaderViewController,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedFlexibleHeader = flexibleHeaderViewController;
        [expectation fulfill];
//        flexibleHeaderViewController.traitCollectionDidChangeBlock = nil;
      };

  // When
  UITraitCollection *testCollection = [UITraitCollection traitCollectionWithDisplayScale:77];
  [flexibleHeaderController traitCollectionDidChange:testCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testCollection);
  XCTAssertEqual(passedFlexibleHeader, flexibleHeaderController);
}

@end
