// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialContainerScheme

class FloatingButtonTypicalUseSwiftExample: UIViewController {

  let miniFloatingButton = MDCFloatingButton(frame: .zero, shape: .mini)
  let defaultFloatingButton = MDCFloatingButton()
  let largeIconFloatingButton = MDCFloatingButton()

  var containerScheme = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(white: 0.9, alpha: 1)

    let plusImage = UIImage(named: "system_icons/add")
    let plusImage36 = UIImage(named: "system_icons/add_36pt")

    miniFloatingButton.sizeToFit()
    miniFloatingButton.translatesAutoresizingMaskIntoConstraints = false
    miniFloatingButton.setMinimumSize(CGSize(width: 96, height: 40), for: .mini, in: .expanded)
    miniFloatingButton.setImage(plusImage, for: .normal)
    miniFloatingButton.accessibilityLabel = "Create"
    miniFloatingButton.applySecondaryTheme(withScheme: containerScheme)

    defaultFloatingButton.sizeToFit()
    defaultFloatingButton.translatesAutoresizingMaskIntoConstraints = false
    defaultFloatingButton.setImage(plusImage, for: .normal)
    defaultFloatingButton.accessibilityLabel = "Create"
    defaultFloatingButton.applySecondaryTheme(withScheme: containerScheme)

    largeIconFloatingButton.sizeToFit()
    largeIconFloatingButton.translatesAutoresizingMaskIntoConstraints = false
    largeIconFloatingButton.setImage(plusImage36, for: .normal)
    largeIconFloatingButton.accessibilityLabel = "Create"
    largeIconFloatingButton.setContentEdgeInsets(
      UIEdgeInsets(top: -6, left: -6, bottom: -6, right: 0), for: .default,
      in: .expanded)
    largeIconFloatingButton.applySecondaryTheme(withScheme: containerScheme)

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Try me on an iPad!"

    view.addSubview(label)
    view.addSubview(miniFloatingButton)
    view.addSubview(defaultFloatingButton)
    view.addSubview(largeIconFloatingButton)

    let totalHeight =
      miniFloatingButton.bounds.standardized.height
      + defaultFloatingButton.bounds.standardized.height
      + largeIconFloatingButton.bounds.standardized.height + 20  // 10 points between buttons

    let miniDefaultDifference =
      defaultFloatingButton.bounds.standardized.width - miniFloatingButton.bounds.standardized.width

    leadingAlignView(
      view: miniFloatingButton, onView: self.view,
      horizontalOffset: 10 + miniDefaultDifference / 2,
      verticalOffset: -totalHeight / 2)
    leadingAlignView(
      view: defaultFloatingButton, onView: miniFloatingButton,
      horizontalOffset: -miniDefaultDifference / 2,
      verticalOffset: defaultFloatingButton.bounds.standardized.height + 10)
    leadingAlignView(
      view: largeIconFloatingButton, onView: defaultFloatingButton,
      horizontalOffset: 0,
      verticalOffset: defaultFloatingButton.bounds.standardized.height + 10)
    self.view.addConstraint(
      NSLayoutConstraint(
        item: label, attribute: .centerX, relatedBy: .equal,
        toItem: view, attribute: .centerX, multiplier: 1,
        constant: 0))
    self.view.addConstraint(
      NSLayoutConstraint(
        item: label, attribute: .bottom, relatedBy: .equal,
        toItem: miniFloatingButton, attribute: .top,
        multiplier: 1, constant: -20))
  }

  // MARK: Private

  private func leadingAlignView(
    view: UIView, onView: UIView, horizontalOffset: CGFloat,
    verticalOffset: CGFloat
  ) {
    self.view.addConstraint(
      NSLayoutConstraint(
        item: view,
        attribute: .leading,
        relatedBy: .equal,
        toItem: onView,
        attribute: .leading,
        multiplier: 1.0,
        constant: horizontalOffset))

    self.view.addConstraint(
      NSLayoutConstraint(
        item: view,
        attribute: .centerY,
        relatedBy: .equal,
        toItem: onView,
        attribute: .centerY,
        multiplier: 1.0,
        constant: verticalOffset))
  }
}

extension FloatingButtonTypicalUseSwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Floating Action Button (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}

extension FloatingButtonTypicalUseSwiftExample {
  func updateFloatingButtons(to mode: MDCFloatingButtonMode) {
    if miniFloatingButton.mode != mode {
      miniFloatingButton.mode = mode
    }
    if defaultFloatingButton.mode != mode {
      defaultFloatingButton.mode = mode
    }
    if largeIconFloatingButton.mode != mode {
      largeIconFloatingButton.mode = mode
    }
  }

  func updateFloatingButtons(whenSizeClass isRegularRegular: Bool) {
    if isRegularRegular {
      updateFloatingButtons(to: .expanded)
      miniFloatingButton.setTitle("Add", for: .normal)
      defaultFloatingButton.setTitle("Create", for: .normal)
      largeIconFloatingButton.setTitle("Create", for: .normal)
    } else {
      updateFloatingButtons(to: .normal)
      miniFloatingButton.setTitle(nil, for: .normal)
      defaultFloatingButton.setTitle(nil, for: .normal)
      largeIconFloatingButton.setTitle(nil, for: .normal)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let horizontalSizeClass = traitCollection.horizontalSizeClass
    let verticalSizeClass = traitCollection.verticalSizeClass
    let isRegularRegular = horizontalSizeClass == .regular && verticalSizeClass == .regular
    updateFloatingButtons(whenSizeClass: isRegularRegular)
  }

  override func willTransition(
    to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator
  ) {
    super.willTransition(to: newCollection, with: coordinator)
    let currentTraits = traitCollection
    let sizeClassChanged =
      newCollection.horizontalSizeClass != currentTraits.horizontalSizeClass
      || newCollection.verticalSizeClass != currentTraits.verticalSizeClass
    if sizeClassChanged {
      let willBeRegularRegular =
        newCollection.horizontalSizeClass == .regular && newCollection.verticalSizeClass == .regular

      coordinator.animate(
        alongsideTransition: { (_) in
          self.updateFloatingButtons(whenSizeClass: willBeRegularRegular)
        }, completion: nil)
    }
  }
}
