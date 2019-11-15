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

import UIKit

import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialDialogs_Theming
import MaterialComponents.MaterialTypographyScheme

class DialogsAccessoryExampleViewController: MDCCollectionViewController {

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  let kReusableIdentifierItem = "customCell"

  var menu: [String] = []

  var handler: MDCActionHandler = { action in
    print(action.title ?? "Some Action")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    loadCollectionView(menu: [
      "Text View",
      "Title + Message + Text Field",
    ])
  }

  func loadCollectionView(menu: [String]) {
    self.collectionView?.register(MDCCollectionViewTextCell.self, forCellWithReuseIdentifier: kReusableIdentifierItem)
    self.menu = menu
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let alert = performActionFor(row: indexPath.row) else { return }
    self.present(alert, animated: true, completion: nil)
  }

  private func performActionFor(row: Int) -> MDCAlertController? {
    switch row {
    case 0:
      return performTextView()
    case 1:
      return performTextField()
    default:
      print("No row is selected")
      return nil
    }
  }

  func performTextView() -> MDCAlertController {
    let alert = MDCAlertController()
    let textView = UITextView()
    let attributedText = NSMutableAttributedString(string: """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua.
      """)
    attributedText.addAttributes(
      [ .link: URL(string: "https://www.google.com/search?q=lorem+ipsum")! ],
      range: NSRange(location: 0, length: 11)
    )
    textView.attributedText = attributedText
    textView.font = MDCTypographyScheme().body1
    textView.isEditable = false
    textView.isScrollEnabled = false
    alert.accessoryView = textView
    alert.addAction(MDCAlertAction(title:"Dismiss", handler: handler))
    return alert
  }

  func performTextField() -> MDCAlertController {
    let alert = MDCAlertController(title: "This is a title", message: "This is a message")
    let textField = UITextField()
    textField.placeholder = "This is a text field"
    alert.accessoryView = textField
    alert.addAction(MDCAlertAction(title:"Dismiss", handler: handler))
    return alert
  }
}

// MDCCollectionViewController Data Source
extension DialogsAccessoryExampleViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return menu.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kReusableIdentifierItem,
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
extension DialogsAccessoryExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Dialog With Accessory View"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
