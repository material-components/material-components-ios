/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

import UIKit

class ActionSheetSwiftExample: UIViewController {

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()
  let tableView = UITableView()
  enum ActionSheetExampleType {
    case typical, missingTitle, missingMessage, missingIcons, missingHeading, dynamicType
  }
  typealias ExamplesTuple = (label: String, type: ActionSheetExampleType)
  let data: [ExamplesTuple] = [
    ("Typical Use", .typical),
    ("No Title", .missingTitle),
    ("No Message", .missingMessage),
    ("No Icons", .missingIcons),
    ("No Heading", .missingHeading),
    ("Dynamic Type Enabled", .dynamicType)
  ]
  let cellIdentifier = "BaseCell"

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.backgroundColor = colorScheme.backgroundColor
    tableView.frame = view.frame
    tableView.frame.origin.y = 0.0
    view.addSubview(tableView)
  }

  func showActionSheet(_ type: ActionSheetExampleType) {
    let actionSheet: MDCActionSheetController
    switch type {
    case .typical:
      actionSheet = MDCActionSheetSwiftSupplemental.typical()
    case .missingTitle:
      actionSheet = MDCActionSheetSwiftSupplemental.missingTitle()
    case .missingMessage:
      actionSheet = MDCActionSheetSwiftSupplemental.missingMessage()
    case .missingIcons:
      actionSheet = MDCActionSheetSwiftSupplemental.missingIcons()
    case .missingHeading:
      actionSheet = MDCActionSheetSwiftSupplemental.missingHeading()
    case .dynamicType:
      actionSheet = MDCActionSheetSwiftSupplemental.typical()//dynamicType()
    }

    present(actionSheet, animated: true, completion: nil)
  }
}

// MARK: Catalog by Convensions
extension ActionSheetSwiftExample {
  class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  class func catalogBreadcrumbs() -> [String] {
    return ["Action Sheet", "Action Sheet (Swift)"]
  }
}

extension ActionSheetSwiftExample : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showActionSheet(data[indexPath.row].type)
  }
}

extension ActionSheetSwiftExample : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = data[indexPath.row].label
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
}
