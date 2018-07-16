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
import MaterialComponents.MaterialAppBar

class AppBarEncodingTests: XCTestCase {

  let appBar = MDCAppBar()

  func testEncoding() {

    // Given
    appBar.navigationBar.backgroundColor = UIColor.black
    appBar.navigationBar.tintColor = UIColor.white
    appBar.navigationBar.title = "Title"
    appBar.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]
    appBar.navigationBar.titleAlignment = .leading
    appBar.navigationBar.hidesBackButton = true
    appBar.navigationBar.leadingItemsSupplementBackButton = true

    // When
    let data = NSKeyedArchiver.archivedData(withRootObject: appBar)
    let unarchivedAppBar = NSKeyedUnarchiver.unarchiveObject(with: data) as? MDCAppBar

    // Then
    XCTAssertEqual(appBar.navigationBar.backgroundColor,
                   unarchivedAppBar?.navigationBar.backgroundColor)

    XCTAssertEqual(appBar.navigationBar.tintColor,
                   unarchivedAppBar?.navigationBar.tintColor)

    XCTAssertEqual(appBar.navigationBar.title,
                   unarchivedAppBar?.navigationBar.title)

    XCTAssertEqual(appBar.navigationBar.hidesBackButton,
                   unarchivedAppBar?.navigationBar.hidesBackButton)

    XCTAssertEqual(appBar.navigationBar.leadingItemsSupplementBackButton,
                   unarchivedAppBar?.navigationBar.leadingItemsSupplementBackButton)


    let foregroundColor =
        appBar.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName]
    let unarchivedForegroundColor =
        unarchivedAppBar?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName]
    XCTAssertEqual(foregroundColor as? UIColor, unarchivedForegroundColor as? UIColor)

    XCTAssertEqual(appBar.navigationBar.titleAlignment,
                   unarchivedAppBar?.navigationBar.titleAlignment)

  }
}
