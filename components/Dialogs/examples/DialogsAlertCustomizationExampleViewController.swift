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
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialDialogs_DialogThemer
import MaterialComponents.MaterialTypographyScheme
import MaterialComponentsBeta.MaterialContainerScheme
import MaterialComponentsBeta.MaterialDialogs_Theming

class DialogsAlertCustomizationExampleViewController: MDCCollectionViewController {

  var containerScheme: MDCContainerScheme = MDCContainerScheme()

  let kReusableIdentifierItem = "customCell"

  var menu: [String] = []

  var handler: MDCActionHandler = { action in
    print(action.title ?? "Some Action")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white

    loadCollectionView(menu: [
      "Centered Title",
      "Centered Title With a Title Icon",
      "Naturally Aligned Title with an Icon",
      "Right Aligned Title with a Large Icon",
      "Tinted Title Icon, No Title",
      "Darker Scrim",
      "Low Elevation Alert",
      "Emphasis-based Button Theming",
      "Text Button Theming (will be deprecated)",
      "Text Button Theming (the right way)",
      "Custom Button Theming",
      "Unthemed Alert",
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
      return performCenteredTitle()
    case 1:
      return performCenteredTitleWithIcon()
    case 2:
      return performNaturalTitleWithIcon()
    case 3:
      return performRightTitleWithResizedIcon()
    case 4:
      return performTintedTitleIconNoTitle()
    case 5:
      return performScrimColor()
    case 6:
      return performLowElevationAlert()
    case 7:
      return performEmphasisButtonTheming()
    case 8:
      return performDeprecatedTextButtonTheming()   // b/117717380: Will be deprecated
    case 9:
      return performTextButtonThemingTheRightWay()
    case 10:
      return performCustomButtonTheming()
    case 11:
      return performUnthemed()
    default:
      print("No row is selected")
      return nil
    }
  }

  func sampleIcon(isStandardSize: Bool = true) -> UIImage? {
    let bundle = Bundle(for: DialogsAlertCustomizationExampleViewController.self)
    return UIImage(
      named: isStandardSize ? "outline_lock_black_24pt" : "baseline_alarm_on_black_48pt",
      in: bundle, compatibleWith: nil)
  }

  func performCenteredTitle() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Center Aligned Title")
    alert.titleAlignment = .center
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performCenteredTitleWithIcon() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Center Aligned Title")
    alert.titleIcon = sampleIcon()
    alert.titleAlignment = .center
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performNaturalTitleWithIcon() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Default (Natural) Title Alignment")
    alert.titleIcon = sampleIcon()
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performRightTitleWithResizedIcon() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Right Aligned Title")
    alert.titleIcon = sampleIcon(isStandardSize: false)
    alert.titleAlignment = .right
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performTintedTitleIconNoTitle() -> MDCAlertController {
    let alert = createMDCAlertController(title: nil)
    alert.titleIcon = sampleIcon()
    alert.applyTheme(withScheme: containerScheme)

    // Theming override: set the titleIconTintColor after the color scheme has been applied
    alert.titleIconTintColor = .red

    return alert
  }

  func performScrimColor() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Darker Scrim")
    alert.applyTheme(withScheme: containerScheme)
    alert.scrimColor = UIColor.black.withAlphaComponent(0.6)
    return alert
  }

  func performLowElevationAlert() -> MDCAlertController {
    let titleString = "Using Material alert controller?"
    let messageString = "This is an alert controller with a low elevation."

    let alertController = MDCAlertController(title: titleString, message: messageString)
    alertController.addAction(MDCAlertAction(title:"OK", handler: handler))

    alertController.applyTheme(withScheme: containerScheme)
    alertController.elevation = ShadowElevation.alertExampleDialog

    return alertController
  }

  func performEmphasisButtonTheming() -> MDCAlertController {
    let alert = MDCAlertController(title: "Button Theming", message: "High, Medium & Low Emphasis")
    alert.addAction(MDCAlertAction(title:"High", emphasis: .high, handler: handler))
    alert.addAction(MDCAlertAction(title:"Medium", emphasis: .medium, handler: handler))
    alert.addAction(MDCAlertAction(title:"Low", emphasis: .low, handler: handler))
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performDeprecatedTextButtonTheming() -> MDCAlertController {
    let alert = MDCAlertController(title: "Button Theming",
                                   message: "This method of button theming will be deprecated")
    // When not specified, the action is low emphasis by default
    alert.addAction(MDCAlertAction(title:"Text", handler: handler))
    alert.addAction(MDCAlertAction(title:"Text", handler: handler))
    alert.addAction(MDCAlertAction(title:"Text", handler: handler))
    alert.applyTheme(withScheme: containerScheme)
    alert.buttonTitleColor = .orange   // b/117717380: will be deprecated
    return alert
  }

  // The right way to select the type of buttons is by setting empahsis for actions
  func performTextButtonThemingTheRightWay() -> MDCAlertController {
    let alert = MDCAlertController(title: "Button Theming",
                                   message: "Use low emphasis to present buttons as text")
    // Use .low emphasis to style buttons as text buttons.
    alert.addAction(MDCAlertAction(title:"Text", emphasis: .low, handler: handler))
    alert.addAction(MDCAlertAction(title:"Text", emphasis: .low, handler: handler))
    alert.addAction(MDCAlertAction(title:"Text", emphasis: .low, handler: handler))
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performCustomButtonTheming() -> MDCAlertController {
    let alert = MDCAlertController(title: "Custom Button Theming",
                                   message: "Custom styling of High, Medium & Low Emphasis")
    alert.titleIcon = sampleIcon()

    // Use .low emphasis for styling buttons as text buttons
    alert.addAction(MDCAlertAction(title:"High", emphasis: .high, handler: handler))
    alert.addAction(MDCAlertAction(title:"Medium", emphasis: .medium, handler: handler))
    alert.addAction(MDCAlertAction(title:"Low", emphasis: .low, handler: handler))

    let containerScheme = MDCContainerScheme()
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor = .blue
    containerScheme.colorScheme = colorScheme
    alert.applyTheme(withScheme: containerScheme)
    return alert
  }

  func performUnthemed() -> MDCAlertController {
    let alert = MDCAlertController(title: "Unthemed Alert",
                                   message: "Lorem ipsum dolor sit amet, consectetur adipiscing...")
    alert.addAction(MDCAlertAction(title:"High", emphasis: .high, handler: handler))
    alert.addAction(MDCAlertAction(title:"Medium", emphasis: .medium, handler: handler))
    alert.addAction(MDCAlertAction(title:"Low", emphasis: .low, handler: handler))
    return alert
  }

  private func createMDCAlertController(title: String?) -> MDCAlertController {
    let alertController = MDCAlertController(title: title, message: """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua.
      """)
    alertController.addAction(MDCAlertAction(title:"OK", handler: handler))
    alertController.addAction(MDCAlertAction(title:"Cancel", handler: handler))
    return alertController
  }

}

// app specific elevation constants
extension ShadowElevation {
  static var alertExampleDialog: ShadowElevation {
    return ShadowElevation(2.0)
  }
}

// MDCCollectionViewController Data Source
extension DialogsAlertCustomizationExampleViewController {

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
extension DialogsAlertCustomizationExampleViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Alert Customization"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
