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
import MaterialComponents.MaterialAnimationTiming
import MaterialComponents.MaterialTypography

struct Constants {
  struct AnimationTime {
    static let interval: Double = 1.0
    static let delay: Double = 0.5
  }
  struct Sizes {
    static let topMargin: CGFloat = 16.0
    static let leftGutter: CGFloat = 16.0
    static let textOffset: CGFloat = 16.0
    static let circleSize: CGSize = CGSize(width: 48.0, height: 48.0)
  }
}

class AnimationTimingSwiftExampleViewController: UIViewController {

  fileprivate let scrollView: UIScrollView = UIScrollView()
  fileprivate let linearView: UIView = UIView()
  fileprivate let materialStandardView: UIView = UIView()
  fileprivate let materialDecelerationView: UIView = UIView()
  fileprivate let materialAccelerationView: UIView = UIView()
  fileprivate let materialSharpView: UIView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    title = "Animation Timing"
    setupExampleViews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let timeInterval: TimeInterval =
      2 * (Constants.AnimationTime.interval + Constants.AnimationTime.delay)
    var _: Timer = Timer.scheduledTimer(
      timeInterval: timeInterval, target: self, selector: #selector(self.playAnimations),
      userInfo: nil, repeats: true)
    playAnimations()

  }

  @objc func playAnimations() {
    let linearCurve: CAMediaTimingFunction = CAMediaTimingFunction(
      name: CAMediaTimingFunctionName.linear)
    applyAnimation(toView: linearView, withTimingFunction: linearCurve)

    if let materialStandard = CAMediaTimingFunction.mdc_function(withType: .standard) {
      applyAnimation(toView: materialStandardView, withTimingFunction: materialStandard)
    } else {
      materialStandardView.removeFromSuperview()
    }

    if let materialDeceleration = CAMediaTimingFunction.mdc_function(withType: .deceleration) {
      applyAnimation(toView: materialDecelerationView, withTimingFunction: materialDeceleration)
    } else {
      materialDecelerationView.removeFromSuperview()
    }

    if let materialAcceleration = CAMediaTimingFunction.mdc_function(withType: .acceleration) {
      applyAnimation(toView: materialAccelerationView, withTimingFunction: materialAcceleration)
    } else {
      materialAccelerationView.removeFromSuperview()
    }

    if let materialSharp = CAMediaTimingFunction.mdc_function(withType: .sharp) {
      applyAnimation(toView: materialSharpView, withTimingFunction: materialSharp)
    } else {
      materialSharpView.removeFromSuperview()
    }
  }

  func applyAnimation(toView view: UIView, withTimingFunction timingFunction: CAMediaTimingFunction)
  {
    let animWidth: CGFloat = self.view.frame.size.width - view.frame.size.width - 32.0
    let transform: CGAffineTransform = CGAffineTransform.init(translationX: animWidth, y: 0)
    UIView.mdc_animate(
      with: timingFunction, duration: Constants.AnimationTime.interval,
      delay: Constants.AnimationTime.delay, options: [],
      animations: {
        view.transform = transform
      },
      completion: { Bool in
        UIView.mdc_animate(
          with: timingFunction, duration: Constants.AnimationTime.interval,
          delay: Constants.AnimationTime.delay, options: [],
          animations: {
            view.transform = CGAffineTransform.identity
          }, completion: nil)
      })
  }
}

extension AnimationTimingSwiftExampleViewController {
  fileprivate func setupExampleViews() {

    let curveLabel: (String) -> UILabel = { labelTitle in
      let label: UILabel = UILabel()
      label.text = labelTitle
      label.font = MDCTypography.captionFont()
      label.sizeToFit()
      return label
    }

    let defaultColors: [UIColor] = [
      UIColor.darkGray.withAlphaComponent(0.95),
      UIColor.darkGray.withAlphaComponent(0.90),
      UIColor.darkGray.withAlphaComponent(0.85),
      UIColor.darkGray.withAlphaComponent(0.80),
      UIColor.darkGray.withAlphaComponent(0.75),
    ]

    scrollView.frame = view.bounds
    scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    scrollView.contentSize = CGSize(
      width: view.frame.width,
      height: view.frame.height + Constants.Sizes.topMargin)
    scrollView.clipsToBounds = true
    view.addSubview(scrollView)

    let lineSpace: CGFloat = (view.frame.size.height - 50.0) / 5.0
    let linearLabel: UILabel = curveLabel("Linear")
    linearLabel.frame = CGRect(
      x: Constants.Sizes.leftGutter, y: Constants.Sizes.topMargin,
      width: linearLabel.frame.size.width, height: linearLabel.frame.size.height)
    scrollView.addSubview(linearLabel)

    let linearViewFrame: CGRect = CGRect(
      x: Constants.Sizes.leftGutter, y: Constants.Sizes.leftGutter + Constants.Sizes.topMargin,
      width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
    linearView.frame = linearViewFrame
    linearView.backgroundColor = defaultColors[0]
    linearView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
    scrollView.addSubview(linearView)

    let materialEaseInOutLabel: UILabel = curveLabel("MDCAnimationTimingFunctionStandard")
    materialEaseInOutLabel.frame = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace, width: materialEaseInOutLabel.frame.size.width,
      height: materialEaseInOutLabel.frame.size.height)
    scrollView.addSubview(materialEaseInOutLabel)

    let materialEaseInOutViewFrame: CGRect = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace + Constants.Sizes.textOffset,
      width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
    materialStandardView.frame = materialEaseInOutViewFrame
    materialStandardView.backgroundColor = defaultColors[1]
    materialStandardView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
    scrollView.addSubview(materialStandardView)

    let materialEaseOutLabel: UILabel = curveLabel("MDCAnimationTimingFunctionDeceleration")
    materialEaseOutLabel.frame = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace * 2.0,
      width: materialEaseOutLabel.frame.size.width, height: materialEaseOutLabel.frame.size.height)
    scrollView.addSubview(materialEaseOutLabel)

    let materialEaseOutViewFrame: CGRect = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace * 2.0 + Constants.Sizes.textOffset,
      width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
    materialDecelerationView.frame = materialEaseOutViewFrame
    materialDecelerationView.backgroundColor = defaultColors[2]
    materialDecelerationView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
    scrollView.addSubview(materialDecelerationView)

    let materialEaseInLabel: UILabel = curveLabel("MDCAnimationTimingFunctionAcceleration")
    materialEaseInLabel.frame = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace * 3.0,
      width: materialEaseInLabel.frame.size.width, height: materialEaseInLabel.frame.size.height)
    scrollView.addSubview(materialEaseInLabel)

    let materialEaseInViewFrame: CGRect = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace * 3.0 + Constants.Sizes.textOffset,
      width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
    materialAccelerationView.frame = materialEaseInViewFrame
    materialAccelerationView.backgroundColor = defaultColors[3]
    materialAccelerationView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
    scrollView.addSubview(materialAccelerationView)

    let materialSharpLabel: UILabel = curveLabel("MDCAnimationTimingSharp")
    materialSharpLabel.frame = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace * 4.0, width: materialSharpLabel.frame.size.width,
      height: materialSharpLabel.frame.size.height)
    scrollView.addSubview(materialSharpLabel)

    let materialSharpViewFrame: CGRect = CGRect(
      x: Constants.Sizes.leftGutter, y: lineSpace * 4.0 + Constants.Sizes.textOffset,
      width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
    materialSharpView.frame = materialSharpViewFrame
    materialSharpView.backgroundColor = defaultColors[4]
    materialSharpView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
    scrollView.addSubview(materialSharpView)
  }

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Animation Timing", "Animation Timing (Swift)"],
      "primaryDemo": false,
      "presentable": false,
      "skip_snapshots": true,  // The automatic animations cause the snapshot tests to hang.
    ]
  }

}
