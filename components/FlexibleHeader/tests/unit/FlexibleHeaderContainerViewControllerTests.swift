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

import XCTest
import MaterialComponents.MaterialFlexibleHeader

class FlexibleHeaderContainerViewControllerTests: XCTestCase {
  func testTraitCollectionDidChangeBlockCalledWhenTraitCollectionChanges() {
    // Given
    let flexibleHeader = MDCFlexibleHeaderContainerViewController()
    let expectation = XCTestExpectation(description: "traitCollectionDidChange")
    flexibleHeader.traitCollectionDidChangeBlock = { (_, _) in
      expectation.fulfill()
    }

    // When
    flexibleHeader.traitCollectionDidChange(nil)

    // Then
    self.wait(for: [expectation], timeout: 1)
  }

  func testTraitCollectionDidChangeBlockCalledWithExpectedParameters() {
  // Given
  let flexibleHeader = MDCFlexibleHeaderContainerViewController()
  let expectation = XCTestExpectation(description: "traitCollectionDidChange")
  var passedTraitCollection: UITraitCollection? = nil
  var passedFlexibleHeader: MDCFlexibleHeaderContainerViewController? = nil
  flexibleHeader.traitCollectionDidChangeBlock = { (flexibleHeader, traitCollection) in
    passedTraitCollection = traitCollection
    passedFlexibleHeader = flexibleHeader
    expectation.fulfill()
  }
  let fakeTraitCollection = UITraitCollection(displayScale: 77)

  // When
  flexibleHeader.traitCollectionDidChange(fakeTraitCollection)

  // Then
  self.wait(for: [expectation], timeout: 1)
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
  XCTAssertEqual(passedFlexibleHeader, flexibleHeader);
  }
}
