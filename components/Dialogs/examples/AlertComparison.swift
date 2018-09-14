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

/// This interface allows a user to present a UIKit Alert Controller and a Material Alert
/// Controller.
class DialogsAlertComparison: UIViewController {

  private let materialButton = MDCFlatButton()
  private let themedButton = MDCFlatButton()
  private let uikitButton = MDCFlatButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white

    materialButton.translatesAutoresizingMaskIntoConstraints = false
    materialButton.setTitle("Material Alert", for: .normal)
    materialButton.setTitleColor(UIColor(white: 0.1, alpha:1), for: .normal)
    materialButton.sizeToFit()
    materialButton.addTarget(self, action: #selector(tapMaterial), for: .touchUpInside)
    self.view.addSubview(materialButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item:materialButton,
                       attribute: .centerX,
                       relatedBy: .equal,
                       toItem: self.view,
                       attribute: .centerX,
                       multiplier: 1.0,
                       constant: 0.0),
      NSLayoutConstraint(item: materialButton,
                       attribute: .centerY,
                       relatedBy: .equal,
                       toItem: self.view,
                       attribute: .centerY,
                       multiplier: 1.0,
                       constant: 0.0)
      ])

    themedButton.translatesAutoresizingMaskIntoConstraints = false
    themedButton.setTitle("Material Alert (Themed)", for: .normal)
    themedButton.setTitleColor(UIColor(white: 0.1, alpha:1), for: .normal)
    themedButton.sizeToFit()
    themedButton.addTarget(self, action: #selector(tapThemed), for: .touchUpInside)
    self.view.addSubview(themedButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: themedButton,
                         attribute: .centerX,
                         relatedBy: .equal,
                         toItem: self.view,
                         attribute: .centerX,
                         multiplier: 1.0,
                         constant: 0.0),
      NSLayoutConstraint(item:themedButton,
                         attribute: .top,
                         relatedBy: .equal,
                         toItem: materialButton,
                         attribute: .bottom,
                         multiplier: 1.0,
                         constant: 8.0)
      ])

      uikitButton.translatesAutoresizingMaskIntoConstraints = false
      uikitButton.setTitle("UIKit Alert", for: UIControlState())
      uikitButton.setTitleColor(UIColor(white: 0.1, alpha:1), for: .normal)
      uikitButton.sizeToFit()
      uikitButton.addTarget(self, action: #selector(tapUIKit), for: .touchUpInside)
      self.view.addSubview(uikitButton)

      NSLayoutConstraint.activate([
        NSLayoutConstraint(item: uikitButton,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0.0),
        NSLayoutConstraint(item: uikitButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: themedButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 8.0)
        ])
  }

  @objc func tapMaterial(_ sender: Any) {
    let alertController = createMDCAlertController()
    self.present(alertController, animated: true, completion: nil)
  }

  @objc func tapThemed(_ sender: Any) {
    let alertController = createMDCAlertController()
    let scheme = MDCAlertScheme()
    MDCAlertThemer.applyScheme(scheme, to: alertController)
    self.present(alertController, animated: true, completion: nil)
  }

  @objc func tapUIKit(_ sender: Any) {
    let alertController = createUIAlertController()
    self.present(alertController, animated: true, completion: nil)
  }

  private func createMDCAlertController() -> MDCAlertController {
    let titleString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur"
    let messageString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "

    let alertController = MDCAlertController(title: titleString, message: messageString)

    let acceptAction = MDCAlertAction(title:"Accept") { (_) in print("Accept") }
    alertController.addAction(acceptAction)

    let considerAction = MDCAlertAction(title:"Consider") { (_) in print("Consider") }
    alertController.addAction(considerAction)

    let rejectAction = MDCAlertAction(title:"Reject") { (_) in print("Reject") }
    alertController.addAction(rejectAction)

    return alertController
  }

  private func createUIAlertController() -> UIAlertController {

    let titleString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur"
    let messageString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
      "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
      "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
      "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "

    let alertController = UIAlertController(title: titleString,
                                            message: messageString,
                                            preferredStyle:.alert)

    let acceptAction = UIAlertAction(title:"Accept", style:.default) { (_) in print("Accept") }
    alertController.addAction(acceptAction)

    let considerAction = UIAlertAction(title:"Consider", style:.default)
      { (_) in print("Consider") }
    alertController.addAction(considerAction)

    let rejectAction = UIAlertAction(title:"Reject", style:.default) { (_) in print("Reject") }
    alertController.addAction(rejectAction)

    return alertController
  }
}

// MARK: Catalog by convention
extension DialogsAlertComparison {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Alert Comparison"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
