/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
 
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

import XCTest
import MaterialComponents

class SnackbarMessageViewTests: XCTestCase {
  
  let message = MDCSnackbarMessage.init(attributedText: NSAttributedString.init(string: "This is a simple message"))
  let defaultBackgroundColor = UIColor.init(red:0x32/255, green:0x32/255, blue:0x32/255, alpha:1)
  let defaultShadowColor = UIColor.init(red:0x00/255, green:0x00/255, blue:0x00/255, alpha:1)
  let defaultTextColor = UIColor.init(red:0xFF/255, green:0xFF/255, blue:0xFF/255, alpha:1)
  var view:MDCSnackbarMessageView!
  
  override func setUp() {
    super.setUp()
    view = MDCSnackbarMessageView.init(message: message, dismissHandler:nil)
  }
  
  func testNonNil() {
    XCTAssertNotNil(view)
    XCTAssertNotNil(view.snackbarMessageViewBackgroundColor)
    XCTAssertNotNil(view.snackbarMessageViewShadowColor)
    XCTAssertNotNil(view.snackbarMessageViewTextColor)
  }
  
  func testSnackbarMessageViewBackgroundColor() {
    let components = CGColorGetComponents(view.snackbarMessageViewBackgroundColor!.CGColor)
    let defaultComponents = CGColorGetComponents(defaultBackgroundColor.CGColor)
    
    XCTAssert(CGColorGetNumberOfComponents(view.snackbarMessageViewBackgroundColor!.CGColor) == 4)
    checkThatColorComponentsAreEqual(components, expectedComponents: defaultComponents)
  }
  
  func testSnackbarMessageViewShadowColor() {
    let components = CGColorGetComponents(view.snackbarMessageViewShadowColor!.CGColor)
    let defaultComponents = CGColorGetComponents(defaultShadowColor.CGColor)
    
    XCTAssert(CGColorGetNumberOfComponents(view.snackbarMessageViewBackgroundColor!.CGColor) == 4)
    checkThatColorComponentsAreEqual(components, expectedComponents: defaultComponents)
  }
  
  func testSnackbarMessageViewTextColor() {
    let components = CGColorGetComponents(view.snackbarMessageViewTextColor!.CGColor)
    let defaultComponents = CGColorGetComponents(defaultTextColor.CGColor)
    
    XCTAssert(CGColorGetNumberOfComponents(view.snackbarMessageViewTextColor!.CGColor) == 4)
    checkThatColorComponentsAreEqual(components, expectedComponents: defaultComponents)
  }
  
  func checkThatColorComponentsAreEqual(components:UnsafePointer<CGFloat>, expectedComponents:UnsafePointer<CGFloat>) {
    for index in 0...3 {
      XCTAssertEqualWithAccuracy(components[index], expectedComponents[index], accuracy:0.0001)
    }
  }
}

