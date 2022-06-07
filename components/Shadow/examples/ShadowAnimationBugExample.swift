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
import MaterialComponents.MaterialShadow_Animations 
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
  private enum Constants {
    static let collapsedCornerRadius: CGFloat = 8.0
    static let expandedCornerRadius: CGFloat = 48.0

    static let collapsedHeight = 100.0
    static let expandedHeight = 200.0

    static let collapsedWidth: CGFloat = 100.0
    static let expandedWidth: CGFloat = 200.0

    static let duration = 0.5
    static let timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
  }

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
    typicalView.frame = CGRect(
      x: 0, y: 0, width: Constants.collapsedWidth, height: Constants.collapsedHeight)
    typicalView.center = view.center
    typicalView.layer.cornerRadius = Constants.collapsedCornerRadius
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    repeatingViewAnimationWithCenterAndCornerRadius(
      view: typicalView, startFrame: typicalView.frame, startRadius: typicalView.layer.cornerRadius,
      duration: Constants.duration, timingFunction: Constants.timingFunction)
  }

  /// Expansion and contraction of width
  func repeatingViewAnimationWithCenter(
    view: UIView, startFrame: CGRect, duration: CGFloat, timingFunction: CAMediaTimingFunction
  ) {
    let endWidth = targetWidth(for: startFrame.size.width)
    let endRect = CGRect(
      origin: view.frame.origin, size: CGSize(width: endWidth, height: startFrame.height))

    view.mdc_animateBoundsWithCenter(
      to: startFrame, center: view.center, duration: duration, timingFunction: timingFunction
    ) { [weak self] didComplete in
      if didComplete {
        self?.repeatingViewAnimationWithCenter(
          view: view, startFrame: endRect, duration: duration, timingFunction: timingFunction)
      }
    }
  }

  /// Expansion and contraction of width and corner radius
  func repeatingViewAnimationWithCenterAndCornerRadius(
    view: UIView, startFrame: CGRect, startRadius: CGFloat, duration: CGFloat,
    timingFunction: CAMediaTimingFunction
  ) {
    let endWidth = targetWidth(for: startFrame.size.width)
    let endRadius = targetCornerRadius(for: view.layer.cornerRadius)
    let endRect = CGRect(
      origin: view.frame.origin, size: CGSize(width: endWidth, height: startFrame.height))

    view.mdc_animateBoundsWithCenterAndCornerRadius(
      to: endRect, center: view.center, cornerRadius: endRadius, duration: duration,
      timingFunction: timingFunction
    ) { [weak self] didComplete in
      if didComplete {
        self?.repeatingViewAnimationWithCenterAndCornerRadius(
          view: view, startFrame: endRect, startRadius: endRadius, duration: duration,
          timingFunction: timingFunction)
      }
    }
  }

  /// Expansion and contraction of corner radius only
  func repeatingCornerRadiusAnimation(
    view: UIView, startRadius: CGFloat, duration: CGFloat, timingFunction: CAMediaTimingFunction
  ) {
    let endRadius = targetCornerRadius(for: view.layer.cornerRadius)

    view.mdc_animateCornerRadius(
      toValue: endRadius, duration: duration, timingFunction: timingFunction
    ) { [weak self] didComplete in
      self?.repeatingCornerRadiusAnimation(
        view: view, startRadius: endRadius, duration: duration, timingFunction: timingFunction)
    }
  }

  /// Expansion and contraction of height, width, and corner radius
  func repeatingCenterRadiusHeightWidthAnimation(
    view: UIView, startFrame: CGRect, startRadius: CGFloat, duration: CGFloat,
    timingFunction: CAMediaTimingFunction
  ) {
    let endWidth = targetWidth(for: startFrame.size.width)
    let endHeight = targetHeight(for: startFrame.size.height)
    let endRadius = targetCornerRadius(for: view.layer.cornerRadius)
    let endRect = CGRect(
      origin: view.frame.origin, size: CGSize(width: endWidth, height: endHeight))

    view.mdc_animateBoundsWithCenterAndCornerRadius(
      to: endRect, center: view.center, cornerRadius: endRadius, duration: duration,
      timingFunction: timingFunction
    ) { [weak self] didComplete in
      if didComplete {
        self?.repeatingCenterRadiusHeightWidthAnimation(
          view: view, startFrame: endRect, startRadius: endRadius, duration: duration,
          timingFunction: timingFunction)
      }
    }
  }
}

// MARK: Target Value Helpers
extension ShadowAnimationBugExample {
  private func targetCornerRadius(for startCornerRadius: CGFloat) -> CGFloat {
    return startCornerRadius == Constants.expandedCornerRadius
      ? Constants.collapsedCornerRadius : Constants.expandedCornerRadius
  }

  private func targetHeight(for startHeight: CGFloat) -> CGFloat {
    return startHeight == Constants.expandedHeight
      ? Constants.collapsedHeight : Constants.expandedHeight
  }

  private func targetWidth(for startWidth: CGFloat) -> CGFloat {
    return startWidth == Constants.expandedWidth
      ? Constants.collapsedWidth : Constants.expandedWidth
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
