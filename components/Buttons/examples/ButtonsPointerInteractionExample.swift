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

import Foundation
import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialContainerScheme

class ButtonsPointerInteractionExample: UIViewController {
  let floatingButtonPlusDimension = CGFloat(24)
  let kMinimumAccessibleButtonSize = CGSize(width: 64, height: 48)

  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  lazy var containedButton: MDCButton = {
    let containedButton = MDCButton()
    containedButton.applyContainedTheme(withScheme: containerScheme)
    containedButton.setTitle("Tap Me Too", for: UIControl.State())
    containedButton.sizeToFit()
    let containedButtonVerticalInset =
      min(0, -(kMinimumAccessibleButtonSize.height - containedButton.bounds.height) / 2)
    let containedButtonHorizontalInset =
      min(0, -(kMinimumAccessibleButtonSize.width - containedButton.bounds.width) / 2)
    containedButton.hitAreaInsets =
      UIEdgeInsets(
        top: containedButtonVerticalInset, left: containedButtonHorizontalInset,
        bottom: containedButtonVerticalInset, right: containedButtonHorizontalInset)
    containedButton.translatesAutoresizingMaskIntoConstraints = false
    containedButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    #if compiler(>=5.2)
      if #available(iOS 13.4, *) {
        containedButton.isPointerInteractionEnabled = true
      }
    #endif
    return containedButton
  }()

  lazy var textButton: MDCButton = {
    let textButton = MDCButton()
    textButton.applyTextTheme(withScheme: MDCContainerScheme())
    textButton.setTitle("Touch me", for: UIControl.State())
    textButton.sizeToFit()
    let textButtonVerticalInset =
      min(0, -(kMinimumAccessibleButtonSize.height - textButton.bounds.height) / 2)
    let textButtonHorizontalInset =
      min(0, -(kMinimumAccessibleButtonSize.width - textButton.bounds.width) / 2)
    textButton.hitAreaInsets =
      UIEdgeInsets(
        top: textButtonVerticalInset, left: textButtonHorizontalInset,
        bottom: textButtonVerticalInset, right: textButtonHorizontalInset)
    textButton.translatesAutoresizingMaskIntoConstraints = false
    textButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    #if compiler(>=5.2)
      if #available(iOS 13.4, *) {
        textButton.isPointerInteractionEnabled = true
      }
    #endif
    return textButton
  }()

  lazy var floatingButton: MDCFloatingButton = {
    let floatingButton = MDCFloatingButton()
    floatingButton.backgroundColor = containerScheme.colorScheme.backgroundColor
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: #selector(floatingButtonTapped(_:)), for: .touchUpInside)

    let plusShapeLayer = ButtonsTypicalUseSupplemental.createPlusShapeLayer(floatingButton)
    floatingButton.layer.addSublayer(plusShapeLayer)
    floatingButton.accessibilityLabel = "Create"
    floatingButton.applySecondaryTheme(withScheme: self.containerScheme)
    #if compiler(>=5.2)
      if #available(iOS 13.4, *) {
        floatingButton.isPointerInteractionEnabled = true
      }
    #endif
    return floatingButton
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.alignment = .center
    stackView.addArrangedSubview(containedButton)
    stackView.addArrangedSubview(textButton)
    stackView.addArrangedSubview(floatingButton)

    view.addSubview(stackView)
    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  @objc func tap(_ sender: Any) {
    print("\(type(of: sender)) was tapped.")
  }

  @objc func floatingButtonTapped(_ sender: MDCFloatingButton) {
    print("\(type(of: sender)) was tapped.")
    guard !UIAccessibility.isVoiceOverRunning else {
      return
    }

    sender.collapse(true) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        sender.expand(true, completion: nil)
      }
    }
  }
}

extension ButtonsPointerInteractionExample {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Buttons", "Pointer Interactions"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
