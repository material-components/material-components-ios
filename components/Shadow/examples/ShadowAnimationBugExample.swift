// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialShadow
import MaterialComponents.MaterialContainerScheme

/// Typical use-case for a view with Material Shadows at a fixed elevation.
private final class ShadowedView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.cornerRadius = 4
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) is unavailable")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    MDCConfigureShadow(
      for: self, shadow: MDCShadowsCollectionDefault().shadow(forElevation: 12),
      color: .black)
  }
}

@available(iOS 12.0, *)
final class ShadowAnimationBugExample: UIViewController {

  private lazy var typicalView: UIView = {
    let result = ShadowedView()
    result.translatesAutoresizingMaskIntoConstraints = false
    result.backgroundColor = .red
    return result
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(typicalView)
    view.backgroundColor = .white
    typicalView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    typicalView.center = view.center
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateView()
  }

  func animateView() {
    UIView.animate(withDuration: 0.5) {
      self.typicalView.frame.size = CGSize(width: 200, height: 100)
      self.typicalView.center = self.view.center
      UIView.animate(
        withDuration: 0.5, delay: 0.25, options: [],
        animations: {
          self.typicalView.frame.size = CGSize(width: 100, height: 100)
          self.typicalView.center = self.view.center
        }, completion: { _ in self.animateView() })
    }
  }
}

// MARK: Catalog by Convensions
@available(iOS 12.0, *)
extension ShadowAnimationBugExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", "New Shadow animation bug"],
      "primaryDemo": true,
      "presentable": false,
      "debug": false,
      "skip_snapshots": true,  // There are continuous running animations in this bug.
    ]
  }

  @objc class func minimumOSVersion() -> OperatingSystemVersion {
    return OperatingSystemVersion(majorVersion: 12, minorVersion: 0, patchVersion: 0)
  }
}
