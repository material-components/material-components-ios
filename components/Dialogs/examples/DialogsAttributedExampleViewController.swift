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
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialDialogs
import MaterialComponents.MaterialDialogs_Theming 
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

/// This interface allows a user to present a UIKit Alert Controller and a Material Alert
/// Controller.
class DialogsAttributedExampleViewController: UIViewController {

  @objc lazy var containerScheme: MDCContainerScheming = {
    let scheme = MDCContainerScheme()
    scheme.colorScheme = MDCSemanticColorScheme(defaults: .material201907)
    scheme.typographyScheme = MDCTypographyScheme(defaults: .material201902)
    return scheme
  }()

  lazy var handler: MDCActionHandler = { action in
    print(action.title ?? "Some Action")
  }

  var attributedText: NSAttributedString {
    typealias AttrDict = [NSAttributedString.Key: Any]
    let orangeAttr: AttrDict = [.foregroundColor: UIColor.orange]
    let urlAttr: AttrDict = [.link: "https://www.google.com/search?q=lorem+ipsum"]
    let customLinkAttr: AttrDict = [.link: "mdccatalog://"]  // A custom link.

    let attributedText = NSMutableAttributedString()
    attributedText.append(NSAttributedString(string: "Lorem ipsum", attributes: urlAttr))
    attributedText.append(NSAttributedString(string: " dolor sit amet, ", attributes: nil))
    attributedText.append(
      NSAttributedString(
        string: "consectetur adipiscing elit, sed do eiusmod",
        attributes: nil))
    attributedText.append(NSAttributedString(string: " tempor ", attributes: customLinkAttr))
    attributedText.append(NSAttributedString(string: "incididunt ut ", attributes: nil))
    attributedText.append(NSAttributedString(string: "labore magna ", attributes: orangeAttr))
    attributedText.append(NSAttributedString(string: "aliqua.", attributes: nil))
    return attributedText
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let tappableLinksButton = MDCButton()
    tappableLinksButton.setTitle("Tappable Links in Attributed Message", for: .normal)
    tappableLinksButton.addTarget(
      self, action: #selector(tapTappableLinksAlert), for: .touchUpInside)
    tappableLinksButton.applyTextTheme(withScheme: containerScheme)
    tappableLinksButton.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(tappableLinksButton)

    view.centerXAnchor.constraint(equalTo: tappableLinksButton.centerXAnchor).isActive = true
    view.centerYAnchor.constraint(equalTo: tappableLinksButton.centerYAnchor).isActive = true
  }

  // Demonstrate Material Dialog's attributed message text with tappable links, used in conjunction
  // with a custom accessory view.
  @objc func tapTappableLinksAlert(_ sender: UIButton) {
    // Set an attributed text as the message, with both internal and external URLs as tappable links.
    let alert = MDCAlertController(title: "Title", attributedMessage: attributedText)
    alert.addAction(MDCAlertAction(title: "Dismiss", emphasis: .medium, handler: handler))

    // Setup a custom accessory view.
    let button = MDCButton()
    button.setTitle("Learn More", for: UIControl.State.normal)
    button.contentEdgeInsets = .zero
    button.applyTextTheme(withScheme: containerScheme)
    button.sizeToFit()

    let size = button.bounds.size
    let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    view.addSubview(button)

    alert.accessoryView = view
    if let alertView = alert.view as? MDCAlertControllerView {
      alertView.accessoryViewVerticalInset = 0
      alertView.contentInsets = UIEdgeInsets(top: 24, left: 24, bottom: 10, right: 24)
    }

    // Enable dynamic type.
    alert.adjustsFontForContentSizeCategory = true

    // Respond to a link-tap event:
    alert.attributedMessageAction = { url, range, interaction in
      // Defer to the UITextView's default URL interaction for non-custom links.
      guard url.absoluteString == "mdccatalog://" else { return true }

      print("A custom action for link:", url.absoluteString, " in range:", range)

      // Dismiss the alert for short-tap interactions.
      if interaction == .invokeDefaultAction {
        alert.dismiss(animated: true)
      }

      // Disable UITextView's default URL interaction.
      return false
    }

    // Note: Theming updates the message's text color, potentially overridding foreground text
    //       attributes (if were set in the attributed message).
    alert.applyTheme(withScheme: self.containerScheme)
    self.present(alert, animated: true, completion: nil)
  }
}

// MARK: Catalog by convention
extension DialogsAttributedExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Dialogs", "Attributed Message"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

// MARK: Snapshot Testing by Convention
extension DialogsAttributedExampleViewController {

  func resetTests() {
    if presentedViewController != nil {
      dismiss(animated: false)
    }
  }

  @objc func testTappableLinks() {
    resetTests()
    tapTappableLinksAlert(UIButton())
  }
}
