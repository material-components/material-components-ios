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
import MaterialComponentsAlpha.MaterialActionSheet

class ActionSheetSwiftExample: UIViewController {

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()
  let tableView = UITableView()
  enum ActionSheetExampleType {
    case typical, title, message, noIcons, titleAndMessage, dynamicType, delayed, thirtyOptions
  }
  typealias ExamplesTuple = (label: String, type: ActionSheetExampleType)
  let data: [ExamplesTuple] = [
    ("Typical Use", .typical),
    ("Title only", .title),
    ("Message only", .message),
    ("No Icons", .noIcons),
    ("With Title and Message", .titleAndMessage),
    ("Dynamic Type Enabled", .dynamicType),
    ("Delayed", .delayed),
    ("Thirty Options", .thirtyOptions)
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
      actionSheet = ActionSheetSwiftExample.typical()
    case .title:
      actionSheet = ActionSheetSwiftExample.title()
    case .message:
      actionSheet = ActionSheetSwiftExample.message()
    case .noIcons:
      actionSheet = ActionSheetSwiftExample.noIcons()
    case .titleAndMessage:
      actionSheet = ActionSheetSwiftExample.titleAndMessage()
    case .dynamicType:
      actionSheet = ActionSheetSwiftExample.dynamic()
    case .delayed:
      actionSheet = ActionSheetSwiftExample.titleAndMessage()
      let action = MDCActionSheetAction(title: "Home", image: UIImage(named: "Home")) { _ in
        print("Second home action")
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        actionSheet.title = "New title"
        actionSheet.message = "New Message"
        actionSheet.addAction(action)
        actionSheet.addAction(action)
        actionSheet.addAction(action)
        actionSheet.backgroundColor = .green
      }
    case .thirtyOptions:
      actionSheet = ActionSheetSwiftExample.thirtyOptions()
    }
    MDCActionSheetTypographyThemer.applyTypographyScheme(typographyScheme, to: actionSheet)
    present(actionSheet, animated: true, completion: nil)
  }
}

// MARK: Catalog by Convensions
extension ActionSheetSwiftExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Action Sheet", "Action Sheet (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
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

extension ActionSheetSwiftExample {
  static var actionOne: MDCActionSheetAction {
    return MDCActionSheetAction(title: "Home",
                                image: UIImage(named: "Home")!) { (_) in
                                  print("Home action") }
  }

  static var actionTwo: MDCActionSheetAction {
    return MDCActionSheetAction(title: "Favorite",
                                image: UIImage(named: "Favorite")!) { (_) in
                                  print("Favorite action") }
  }

  static var actionThree: MDCActionSheetAction {
    return MDCActionSheetAction(title: "Email",
                                image: UIImage(named: "Email")!) { (_) in
                                  print("Email action") }
  }

  static var messageString: String {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies diam " +
      "libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risusnmaximus tempus. " +
      "Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, quis eleifend nisi " +
    "eros dictum mi. In finibus vulputate eros, in luctus diam auctor in."
  }

  static func typical() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController()
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func title() -> MDCActionSheetController {
    let actionSheet: MDCActionSheetController = MDCActionSheetController(title: "Action Sheet")
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func message() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: nil,
                                               message: messageString)
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func titleAndMessage() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action Sheet",
                                               message: messageString)
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func noIcons() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action Sheet", message: messageString)
    let action1 = MDCActionSheetAction(title: "Home", image: nil, handler: { _ in
      print("Home action")
    })
    let action2 = MDCActionSheetAction(title: "Favorite", image: nil, handler: { _ in
      print("Favorite action")
    })
    let action3 = MDCActionSheetAction(title: "Email", image: nil, handler: { _ in
      print("Email action")
    })
    actionSheet.addAction(action1)
    actionSheet.addAction(action2)
    actionSheet.addAction(action3)
    return actionSheet
  }

  static func dynamic() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action sheet", message: messageString)
    actionSheet.mdc_adjustsFontForContentSizeCategory = true
    let actionThree = MDCActionSheetAction(title: "Email",
                                           image: UIImage(named: "Email")!,
                                           handler: nil)
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func thirtyOptions() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action sheet", message: messageString)
    for i in 1...30 {
      let action = MDCActionSheetAction(title: "Action \(i)",
                                        image: UIImage(named: "Home"),
                                        handler: nil)
      actionSheet.addAction(action)
    }
    return actionSheet
  }

}
