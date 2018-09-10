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

import XCTest

import MaterialComponents.MaterialBottomSheet

class BottomSheetPresentationTest: XCTestCase {
  var presentationController: MDCBottomSheetPresentationController!

  override func setUp() {
    super.setUp()

    let mockPresented = UIViewController()
    let mockPresenting = UIViewController()
    presentationController =
        MDCBottomSheetPresentationController(presentedViewController: mockPresented,
                                             presenting: mockPresenting)
  }

  func testSetPreferredSheetHeight() {
    // Given
    let preferredSheetHeight: CGFloat = 150.0

    // When
    presentationController.preferredSheetHeight = preferredSheetHeight

    // Then
    let sheetView = getSheetView()
    XCTAssertEqual(sheetView.frame.height, preferredSheetHeight)
  }

  func testSetPreferredContentSizeThenSheetHeight() {
    // Given
    let preferredContentSize: CGSize = CGSize(width: 100, height: 100)
    let preferredSheetHeight: CGFloat = 150.0

    // When
    presentationController.presentingViewController.preferredContentSize = preferredContentSize
    presentationController.preferredSheetHeight = preferredSheetHeight

    // Then
    let sheetView = getSheetView()
    XCTAssertEqual(sheetView.frame.height, preferredSheetHeight)
  }

  private func getSheetView() -> UIView {
    if let sheetView = presentationController.presentedView {
      return sheetView
    } else {
      XCTFail("No sheet view was created")
      return UIView()
    }
  }
}
