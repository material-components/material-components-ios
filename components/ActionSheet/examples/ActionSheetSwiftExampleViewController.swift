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

import UIKit

import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

import MaterialComponents.MaterialActionSheet
import MaterialComponents.MaterialActionSheet_Theming

class ActionSheetSwiftExampleViewController: UIViewController {

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()
  
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
    
    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    tableView.frame = view.frame
    tableView.frame.origin.y = 0.0
    view.addSubview(tableView)
  }

  func showActionSheet(_ type: ActionSheetExampleType) {
    let actionSheet: MDCActionSheetController
    switch type {
    case .typical:
      actionSheet = ActionSheetSwiftExampleViewController.typical()
    case .title:
      actionSheet = ActionSheetSwiftExampleViewController.title()
    case .message:
      actionSheet = ActionSheetSwiftExampleViewController.message()
    case .noIcons:
      actionSheet = ActionSheetSwiftExampleViewController.noIcons()
    case .titleAndMessage:
      actionSheet = ActionSheetSwiftExampleViewController.titleAndMessage()
    case .dynamicType:
      actionSheet = ActionSheetSwiftExampleViewController.dynamic()
    case .delayed:
      actionSheet = ActionSheetSwiftExampleViewController.titleAndMessage()
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
      actionSheet = ActionSheetSwiftExampleViewController.thirtyOptions()
    }
    actionSheet.applyTheme(withScheme: containerScheme)
    present(actionSheet, animated: true, completion: nil)
  }
}

// MARK: Catalog by Convensions
extension ActionSheetSwiftExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Action Sheet", "Action Sheet (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

}

extension ActionSheetSwiftExampleViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showActionSheet(data[indexPath.row].type)
  }
}

extension ActionSheetSwiftExampleViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = data[indexPath.row].label
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
}

extension ActionSheetSwiftExampleViewController {
  static var actionOne: MDCActionSheetAction {
    let image = UIImage(named: "Home") ?? UIImage()
    return MDCActionSheetAction(title: "Home",
                                image: image) { (_) in
                                  print("Home action") }
  }

  static var actionTwo: MDCActionSheetAction {
    let image = UIImage(named: "Favorite") ?? UIImage()
    return MDCActionSheetAction(title: "Favorite",
                                image: image) { (_) in
                                  print("Favorite action") }
  }

  static var actionThree: MDCActionSheetAction {
    let image = UIImage(named: "Email") ?? UIImage()
    return MDCActionSheetAction(title: "Email",
                                image: image) { (_) in
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
    let image = UIImage(named: "Email") ?? UIImage()
    let actionThree = MDCActionSheetAction(title: "Email",
                                           image: image,
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
