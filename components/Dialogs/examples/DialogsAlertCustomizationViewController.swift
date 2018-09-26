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

import Foundation
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialCollections

class CustomAlertViewController: UIViewController {

  let bodyLabel = UILabel()
  let dismissButton = MDCFlatButton()

  var cornerRadius: CGFloat {
    set { view.layer.cornerRadius = newValue }
    get { return view.layer.cornerRadius }
  }

  override var preferredContentSize: CGSize {
    get { return CGSize(width:200.0, height:140.0); }
    set { super.preferredContentSize = newValue }
  }

  override func viewDidLoad() {

    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    bodyLabel.text = "This is a view controller."
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyLabel.numberOfLines = 0
    bodyLabel.sizeToFit()
    self.view.addSubview(bodyLabel)

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(withVisualFormat: "H:|-[body]-|", options: [],
                                     metrics: nil, views: ["body": bodyLabel]))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(withVisualFormat: "V:|-[body]-|", options: [],
                                     metrics: nil, views: ["body": bodyLabel]))
  }
}

class DialogsAlertCustomizationViewController: MDCCollectionViewController {

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()
  var alertScheme: MDCAlertScheme {
    let scheme = MDCAlertScheme()
    scheme.colorScheme = self.colorScheme
    scheme.typographyScheme = self.typographyScheme
    return scheme
  }

  let kReusableIdentifierItem = "customCell"

  var menu: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white

    loadCollectionView(menu: ["Dialog with Centered Title"])
  }

  func loadCollectionView(menu: [String]) {
    self.collectionView?.register(MDCCollectionViewTextCell.self, forCellWithReuseIdentifier: kReusableIdentifierItem)
    self.menu = menu
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      didTapCenteredTitle()
    default:
      print("No row is selected")
    }
  }

  func didTapCenteredTitle() {
    let alert = createMDCAlertController(title: "Dialog Title")
    alert.titleAlignment = .center // todo: theme with themer when available
    MDCAlertControllerThemer.applyScheme(alertScheme, to: alert)
    self.present(alert, animated: true, completion: nil)
  }

  private func createMDCAlertController(title: String) -> MDCAlertController {
    let alertController = MDCAlertController(title: title, message: """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua.
      """)
    alertController.addAction(MDCAlertAction(title:"OK") { _ in print("OK") })
    alertController.addAction(MDCAlertAction(title:"Cancel") { _ in print("Cancel") })
    return alertController
  }

}

// MDCCollectionViewController Data Source
extension DialogsAlertCustomizationViewController {

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

    customCell.textLabel?.text = menu[indexPath.row]

    return customCell
  }
}

// MARK: Catalog by convention
extension DialogsAlertCustomizationViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Alert Customization"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
