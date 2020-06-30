// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialDialogs_Theming 
import MaterialComponents.MaterialTextControls_FilledTextFields 
import MaterialComponents.MaterialTextControls_FilledTextFieldsTheming 
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

class DialogsAlignmentExampleViewController: MDCCollectionViewController {

  @objc lazy var containerScheme: MDCContainerScheming = {
    let scheme = MDCContainerScheme()
    scheme.colorScheme = MDCSemanticColorScheme(defaults: .material201907)
    scheme.typographyScheme = MDCTypographyScheme(defaults: .material201902)
    return scheme
  }()

  let kReusableIdentifierItem = "customCell"

  var menu: [String] = []

  var handler: MDCActionHandler = { action in
    print(action.title ?? "Some Action")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    loadCollectionView(menu: [
      "Centered",
      "Justified Action",
      "Justified Actions",
      "Vertical Justified Actions",
      "Vertical Actions In Reversed Order",
      "Custom Insets",
    ])
  }

  func loadCollectionView(menu: [String]) {
    self.collectionView?.register(
      MDCCollectionViewTextCell.self, forCellWithReuseIdentifier: kReusableIdentifierItem)
    self.menu = menu
  }

  override func collectionView(
    _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
  ) {
    guard let alert = alertController(for: indexPath.row) else { return }
    self.present(alert, animated: true, completion: nil)
  }

  private func alertController(for row: Int) -> MDCAlertController? {
    switch row {
    case 0:
      return alertWithCenteredContent()
    case 1:
      return alertWithJustifiedAction()
    case 2:
      return alertWithJustifiedActions()
    case 3:
      return alertWithVerticallyJustifiedActions()
    case 4:
      return alertWithVerticalActionsInReverseOrder()
    case 5:
      return alertWithCustomInsets()
    default:
      print("No row is selected")
      return nil
    }
  }

  func alertWithCenteredContent() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Centered Title")
    let bundle = Bundle(for: DialogsAlignmentExampleViewController.self)
    alert.titleIcon = UIImage(named: "outline_lock_black_24pt", in: bundle, compatibleWith: nil)
    alert.titleAlignment = .center
    alert.titleIconAlignment = .center
    alert.messageAlignment = .center
    alert.actionsHorizontalAlignment = .center
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func alertWithJustifiedAction() -> MDCAlertController {
    let alert = MDCAlertController(
      title: "Justified Action", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    )
    alert.addAction(MDCAlertAction(title: "Got It", emphasis: .high, handler: handler))
    alert.actionsHorizontalAlignment = .justified
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func alertWithJustifiedActions() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Justified Actions")
    alert.actionsHorizontalAlignment = .justified
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func alertWithVerticallyJustifiedActions() -> MDCAlertController {
    let alert = MDCAlertController(
      title: "Vertical Actions", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    )
    alert.addAction(MDCAlertAction(title: "Sed do eiusmod", emphasis: .high, handler: handler))
    alert.addAction(MDCAlertAction(title: "Tempor incididunt", emphasis: .medium, handler: handler))
    alert.actionsHorizontalAlignmentInVerticalLayout = .justified
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func alertWithVerticalActionsInReverseOrder() -> MDCAlertController {
    let alert = MDCAlertController(
      title: "Reversed Vertical Order",
      message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
    alert.addAction(MDCAlertAction(title: "Sed do eiusmod", handler: handler))
    alert.addAction(MDCAlertAction(title: "Tempor incididunt", handler: handler))
    alert.actionsHorizontalAlignmentInVerticalLayout = .trailing
    alert.orderVerticalActionsByEmphasis = true
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func alertWithCustomInsets() -> MDCAlertController {
    let alert = MDCAlertController(
      title: "Custom Insets",
      message: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """)
    alert.addAction(MDCAlertAction(title: "Accept", emphasis: .medium, handler: handler))
    alert.addAction(MDCAlertAction(title: "Cancel", emphasis: .medium, handler: handler))
    alert.actionsHorizontalAlignment = .justified
    if let alertView = alert.view as? MDCAlertControllerView {
      alertView.titleInsets = UIEdgeInsets(top: 30, left: 30, bottom: 20, right: 30)
      alertView.contentInsets = UIEdgeInsets(top: 0, left: 30, bottom: 20, right: 30)
      alertView.actionsInsets = UIEdgeInsets(top: 8, left: 30, bottom: 30, right: 30)
      alertView.actionsHorizontalMargin = 16
    }
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  private func createMDCAlertController(title: String?) -> MDCAlertController {
    let alertController = MDCAlertController(
      title: title,
      message: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        """)
    alertController.addAction(MDCAlertAction(title: "OK", emphasis: .high, handler: handler))
    alertController.addAction(MDCAlertAction(title: "Cancel", emphasis: .medium, handler: handler))
    return alertController
  }
}

// MDCCollectionViewController Data Source
extension DialogsAlignmentExampleViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(
    _ collectionView: UICollectionView, numberOfItemsInSection section: Int
  ) -> Int {
    return menu.count
  }

  override func collectionView(
    _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: kReusableIdentifierItem,
      for: indexPath)
    guard let customCell = cell as? MDCCollectionViewTextCell else { return cell }

    customCell.isAccessibilityElement = true
    customCell.accessibilityTraits = .button

    let cellTitle = menu[indexPath.row]
    customCell.accessibilityLabel = cellTitle
    customCell.textLabel?.text = cellTitle

    return customCell
  }
}

// MARK: Catalog by convention
extension DialogsAlignmentExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Alignment and Insets"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

// MARK: Snapshot Testing by Convention
extension DialogsAlignmentExampleViewController {

  func resetTests() {
    if presentedViewController != nil {
      dismiss(animated: false)
    }
  }

  @objc func testCentered() {
    resetTests()
    self.present(alertWithCenteredContent(), animated: false, completion: nil)
  }

  @objc func testJustifiedAction() {
    resetTests()
    self.present(alertWithJustifiedAction(), animated: false, completion: nil)
  }

  @objc func testJustifiedActions() {
    resetTests()
    self.present(alertWithJustifiedActions(), animated: false, completion: nil)
  }

  @objc func testVerticalJustified() {
    resetTests()
    self.present(alertWithVerticallyJustifiedActions(), animated: false, completion: nil)
  }

  @objc func testReverseVerticalOrder() {
    resetTests()
    self.present(alertWithVerticalActionsInReverseOrder(), animated: false, completion: nil)
  }

  @objc func testCustomInsets() {
    resetTests()
    self.present(alertWithCustomInsets(), animated: false, completion: nil)
  }

}
