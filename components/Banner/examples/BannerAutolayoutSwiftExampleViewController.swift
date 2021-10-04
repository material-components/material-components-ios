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
import MaterialComponents.MaterialBanner
import MaterialComponents.MaterialBanner_Theming 
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme

class BannerAutoLayoutSwiftExampleViewController: UIViewController {
  lazy var containerScheme: MDCContainerScheming = MDCContainerScheme()
  var bannerView = MDCBannerView()
  var showBannerButton = MDCButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    showBannerButton.translatesAutoresizingMaskIntoConstraints = false
    showBannerButton.applyTextTheme(withScheme: containerScheme)
    showBannerButton.setTitle("Material Banner", for: .normal)
    showBannerButton.addTarget(
      self, action: #selector(self.didTapShowBannerButton), for: .touchUpInside)
    view.addSubview(showBannerButton)
    showBannerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    showBannerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    bannerView.translatesAutoresizingMaskIntoConstraints = false
    bannerView.textView.text = "Lorem ipsum dolor"
    bannerView.trailingButton.isHidden = true
    bannerView.showsDivider = true
    bannerView.layoutMargins = .zero
    let actionButton = bannerView.leadingButton
    actionButton.setTitle("Dismiss", for: .normal)
    actionButton.addTarget(
      self, action: #selector(self.didTapDismissOnBannerView), for: .touchUpInside)
    bannerView.applyTheme(withScheme: containerScheme)
    view.addSubview(bannerView)
    bannerView.isHidden = true
    bannerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    bannerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    bannerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  }

  @objc func didTapShowBannerButton() {
    bannerView.isHidden = false
    bannerView.setNeedsLayout()
    UIAccessibility.post(notification: .layoutChanged, argument: bannerView)
  }

  @objc func didTapDismissOnBannerView() {
    bannerView.isHidden = true
  }

}

// MARK: Catalog by Convention
extension BannerAutoLayoutSwiftExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Banner", "Banner (Swift)"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}

// MARK: Snapshot Testing by Convention
extension BannerAutoLayoutSwiftExampleViewController {

  @objc func testDidTapShowBannerButton() {
    self.didTapShowBannerButton()
  }

}
