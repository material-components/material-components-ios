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

#import "MaterialButtonBar.h"

/// Unit tests for MDCButtonBar.
@interface MDCButtonBarTests : XCTestCase

@property(nonatomic, strong, nullable) MDCButtonBar *buttonBar;

@end

@implementation MDCButtonBarTests

- (void)setUp {
  [super setUp];

  self.buttonBar = [[MDCButtonBar alloc] init];
  self.buttonBar.items = @[ [[UIBarButtonItem alloc] initWithTitle:@"Test"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil] ];
}

- (void)tearDown {
  self.buttonBar = nil;

  [super tearDown];
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollectionDidChange"];
  __block UITraitCollection *passedTraitCollection;
  __block MDCButtonBar *passedButtonBar;
  self.buttonBar.traitCollectionDidChangeBlock =
      ^(MDCButtonBar *_Nonnull buttonBar, UITraitCollection *_Nullable previousTraitCollection) {
        [expectation fulfill];
        passedTraitCollection = previousTraitCollection;
        passedButtonBar = buttonBar;
      };
  UITraitCollection *testTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.buttonBar traitCollectionDidChange:testTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedTraitCollection, testTraitCollection);
  XCTAssertEqual(passedButtonBar, self.buttonBar);
}

@end
