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

class DialogsTitleImageExampleViewController: MDCCollectionViewController {

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
      "Title Icon",
      "Custom Title Icon",
      "Title Image - Scaled Down to Fit",
      "Title Image - Bleeding Edge",
      "Custom Title View",
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
      return alertWithTitleIcon()
    case 1:
      return alertWithCustomTitleIcon()
    case 2:
      return alertWithScaledToFitImage()
    case 3:
      return alertWithScaledBleedingImage()
    case 4:
      presentAlertWithCustomTitleView()
      return nil
    default:
      print("No row is selected")
      return nil
    }
  }

  func alertWithTitleIcon() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Title Icon")
    alert.titleIcon = image(named: "outline_lock_black_24pt")
    alert.applyTheme(withScheme: self.containerScheme)
    return alert
  }

  func alertWithCustomTitleIcon() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Custom Title Icon")
    // Custom size.
    alert.titleIcon = image(named: "baseline_alarm_on_black_48pt")
    // Custom alignment.
    alert.titleIconAlignment = .center
    // Custom insets.
    if let alertView = alert.view as? MDCAlertControllerView {
      alertView.titleIconInsets.bottom = 20
    }
    alert.applyTheme(withScheme: self.containerScheme)
    // Custom color (overriding the theme's title icon color).
    alert.titleIconTintColor = .orange
    return alert
  }

  func alertWithScaledToFitImage() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Scaled Title Icon")
    alert.titleIcon = image(named: "STAY_AMSTERDAM")
    // Justified alignment size the image to fit the top space of the dialog. Images are scaled down
    // if needed, but never scaled up.
    alert.titleIconAlignment = .justified
    alert.applyTheme(withScheme: self.containerScheme)
    return alert
  }

  func alertWithScaledBleedingImage() -> MDCAlertController {
    let alert = createMDCAlertController(title: "Scaled to fill Title Icon")
    alert.titleIcon = image(named: "STAY_AMSTERDAM-WIDE")
    // Justified alignment size the image to fit the top space of the dialog.
    alert.titleIconAlignment = .justified
    if let alertView = alert.view as? MDCAlertControllerView {
      alertView.titleIconInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    alert.applyTheme(withScheme: self.containerScheme)
    return alert
  }

  func presentAlertWithCustomTitleView(animated: Bool = true) {
    let alert = createMDCAlertController(title: "Custom Title View")

    // Create a custom view with a centered image and a light background.
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 86))
    let alarmView = UIImageView()
    view.addSubview(alarmView)

    // Apply theme colors.
    view.backgroundColor = containerScheme.colorScheme.primaryColor.withAlphaComponent(0.2)
    alarmView.tintColor = containerScheme.colorScheme.primaryColor

    // Resize the imageView to fit to the size of the new loaded image.
    if let alarm = image(named: "baseline_alarm_on_black_48pt") {
      alarmView.image = alarm
      alarmView.sizeToFit()
    }

    // Sets the customView as the titleIconView.
    alert.titleIconView = view

    // Set .justified alignment with 0 insets to ensure the view's color bleeds through to the edge.
    alert.titleIconAlignment = .justified
    if let alertView = alert.view as? MDCAlertControllerView {
      alertView.titleIconInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }

    alert.applyTheme(withScheme: self.containerScheme)

    if animated {
      alarmView.alpha = 0
    }
    self.present(
      alert, animated: animated,
      completion: {
        // The view is centered correctly after the alert is presented.
        alarmView.center = view.center
        if animated {
          // Start the image animation after the alert is presetned.
          alarmView.animateIn()
        }
      })
  }

  private func image(named: String) -> UIImage? {
    let bundle = Bundle(for: DialogsTitleImageExampleViewController.self)
    return UIImage(named: named, in: bundle, compatibleWith: nil)
  }

  private func createMDCAlertController(title: String?) -> MDCAlertController {
    let alert = MDCAlertController(
      title: title,
      message: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        """)
    alert.addAction(MDCAlertAction(title: "OK", emphasis: .high, handler: handler))
    alert.addAction(MDCAlertAction(title: "Cancel", handler: handler))

    // Enable dynamic type.
    alert.adjustsFontForContentSizeCategory = true

    return alert
  }
}

// MDCCollectionViewController Data Source
extension DialogsTitleImageExampleViewController {

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
extension DialogsTitleImageExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Title Icon, Image & View"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

// MARK: Snapshot Testing by Convention
extension DialogsTitleImageExampleViewController {

  func resetTests() {
    if presentedViewController != nil {
      dismiss(animated: false)
    }
  }

  @objc func testTitleIcon() {
    resetTests()
    self.present(
      alertWithTitleIcon(), animated: false, completion: nil)
  }

  @objc func testCustomTitleIcon() {
    resetTests()
    self.present(
      alertWithCustomTitleIcon(), animated: false, completion: nil)
  }

  @objc func testScaledToFit() {
    resetTests()
    self.present(
      alertWithScaledToFitImage(), animated: false, completion: nil)
  }

  @objc func testScaledBleeding() {
    resetTests()
    self.present(
      alertWithScaledBleedingImage(), animated: false, completion: nil)
  }

  @objc func testCustomTitleView() {
    resetTests()
    presentAlertWithCustomTitleView(animated: false)
  }
}

extension UIView {
  fileprivate func animateIn(
    duration: TimeInterval = 4,
    repeating: Bool = true,
    options: UIView.AnimationOptions = [.curveEaseOut]
  ) {
    self.alpha = 1
    let initialTransform = self.transform.translatedBy(x: -150, y: 0)
    self.transform = initialTransform
    let transform1 =
      initialTransform
      .concatenating(CGAffineTransform(translationX: 80, y: 0))
      .rotated(by: CGFloat.pi * 0.8)
    let transform2 =
      initialTransform
      .concatenating(CGAffineTransform(translationX: 160, y: 0))
      .rotated(by: CGFloat.pi * 1.5)
    let transform3 =
      initialTransform
      .concatenating(CGAffineTransform(translationX: 240, y: 0))
    let transform4 =
      initialTransform
      .concatenating(CGAffineTransform(translationX: 360, y: 0))
      .rotated(by: CGFloat.pi * 0.75)

    let animationOptions: UInt
    if repeating {
      animationOptions =
        UIView.AnimationOptions.curveLinear.rawValue | UIView.AnimationOptions.repeat.rawValue
    } else {
      animationOptions = UIView.AnimationOptions.curveLinear.rawValue
    }

    let keyFrameAnimationOptions = UIView.KeyframeAnimationOptions(rawValue: animationOptions)

    UIView.animateKeyframes(
      withDuration: duration, delay: 0,
      options: [keyFrameAnimationOptions, .calculationModeLinear],
      animations: {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.14) {  // 0.375
          self.transform = transform1
        }
        UIView.addKeyframe(withRelativeStartTime: 0.14, relativeDuration: 0.14) {  // 0.375
          self.transform = transform2
        }
        UIView.addKeyframe(withRelativeStartTime: 0.28, relativeDuration: 0.15) {  //0.25) {
          self.transform = transform3
        }
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.15) {  //0.25) {
          self.transform = transform4
        }
      }, completion: nil)
  }
}
