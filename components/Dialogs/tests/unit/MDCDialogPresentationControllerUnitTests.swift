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

import MaterialComponents.MaterialDialogs

class MDCDialogPresentationControllerTests: XCTestCase {
  func testTraitCollectionDidChangeCalledWithCorrectParameters() {
    // Given
    let presentationController =
        MDCDialogPresentationController(presentedViewController: UIViewController(),
                                        presenting: UIViewController())
    let expectation = XCTestExpectation(description: "traitCollectionDidChange")
    var passedTraitCollection: UITraitCollection!
    var passedPresentationController: MDCDialogPresentationController!
    presentationController.traitCollectionDidChangeBlock = {
      blockPresentationController, previousTraitCollection in
      passedTraitCollection = previousTraitCollection
      passedPresentationController = blockPresentationController
          expectation.fulfill()
    }
    let traitCollection = UITraitCollection(displayScale: 7)

    // When
    presentationController.traitCollectionDidChange(traitCollection)

    // Then
    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(passedTraitCollection, traitCollection)
    XCTAssertEqual(passedPresentationController, presentationController)
  }
}
