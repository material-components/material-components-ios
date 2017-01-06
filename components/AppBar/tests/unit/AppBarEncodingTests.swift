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

class AppBarEncodingTests: XCTestCase {

  let appBar = MDCAppBar()

  func testEncoding() {

    // Given
    appBar.headerViewController.headerView.shiftBehavior = .enabledWithStatusBar
    appBar.headerViewController.headerView.minimumHeight = 46.0
    appBar.headerViewController.headerView.maximumHeight = 112.0
    appBar.headerViewController.headerView.contentIsTranslucent = true
    appBar.headerViewController.headerView.headerContentImportance = .high
    appBar.navigationBar.backgroundColor = UIColor.black
    appBar.navigationBar.tintColor = UIColor.white
    appBar.navigationBar.title = "Title"
    appBar.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]
    appBar.navigationBar.titleAlignment = .leading

    // When
    var data = NSKeyedArchiver.archivedData(withRootObject: appBar)
    var unarchivedAppBar = NSKeyedUnarchiver.unarchiveObject(with: data) as? MDCAppBar

    // Then
    XCTAssertEqual(appBar.headerViewController.headerView.shiftBehavior,
                   unarchivedAppBar?.headerViewController.headerView.shiftBehavior)

    XCTAssertEqual(appBar.headerViewController.headerView.minimumHeight,
                   unarchivedAppBar?.headerViewController.headerView.minimumHeight)

    XCTAssertEqual(appBar.headerViewController.headerView.maximumHeight,
                   unarchivedAppBar?.headerViewController.headerView.maximumHeight)

    XCTAssertEqual(appBar.headerViewController.headerView.contentIsTranslucent,
                   unarchivedAppBar?.headerViewController.headerView.contentIsTranslucent)

    XCTAssertEqual(appBar.headerViewController.headerView.headerContentImportance,
                   unarchivedAppBar?.headerViewController.headerView.headerContentImportance)

    XCTAssertEqual(appBar.navigationBar.backgroundColor,
                   unarchivedAppBar?.navigationBar.backgroundColor)

    XCTAssertEqual(appBar.navigationBar.tintColor,
                   unarchivedAppBar?.navigationBar.tintColor)

    XCTAssertEqual(appBar.navigationBar.title,
                   unarchivedAppBar?.navigationBar.title)

    XCTAssertEqual(appBar.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor,
                   unarchivedAppBar?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor)

    XCTAssertEqual(appBar.navigationBar.titleAlignment,
                   unarchivedAppBar?.navigationBar.titleAlignment)

  }
}
