/*

 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

*/

import UIKit
import MaterialComponents.MaterialAnimationTiming

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

class AnimationTimingExample: UIViewController {

   fileprivate let scrollView: UIScrollView = UIScrollView()
   fileprivate let linearView: UIView = UIView()
   fileprivate let materialEaseInOutView: UIView = UIView()
   fileprivate let materialEaseOutView: UIView = UIView()
   fileprivate let materialEaseInView: UIView = UIView()

   override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
      title = "Animation Timing"
      setupExampleViews()
   }


   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      let timeInterval: TimeInterval = 2 * (Constants.AnimationTime.interval + Constants.AnimationTime.delay)
      var _: Timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.playAnimations), userInfo: nil, repeats: true)
      playAnimations()

   }

   func playAnimations() {
      let linearCurve: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
      applyAnimation(toView: linearView, withTimingFunction: linearCurve)

      if let materialEaseInOut = CAMediaTimingFunction.mdc_function(withType: .easeInOut) {
         applyAnimation(toView: materialEaseInOutView, withTimingFunction: materialEaseInOut)
      } else {
         materialEaseInOutView.removeFromSuperview()
      }

      if let materialEaseOut = CAMediaTimingFunction.mdc_function(withType: .easeOut) {
         applyAnimation(toView: materialEaseOutView, withTimingFunction: materialEaseOut)
      } else {
         materialEaseOutView.removeFromSuperview()
      }

      if let materialEaseIn = CAMediaTimingFunction.mdc_function(withType: .easeIn) {
         applyAnimation(toView: materialEaseInView, withTimingFunction: materialEaseIn)
      } else {
         materialEaseInView.removeFromSuperview()
      }

   }

   func applyAnimation(toView view: UIView, withTimingFunction timingFunction : CAMediaTimingFunction) {
      let animWidth: CGFloat = self.view.frame.size.width - view.frame.size.width - 32.0
      let transform: CGAffineTransform = CGAffineTransform.init(translationX: animWidth, y: 0)
      UIView.mdc_animate(with: timingFunction, duration: Constants.AnimationTime.interval, delay: Constants.AnimationTime.delay, options: [], animations: {
         view.transform = transform
      }, completion: { Bool in
         UIView.mdc_animate(with: timingFunction, duration: Constants.AnimationTime.interval, delay: Constants.AnimationTime.delay, options: [], animations: {
            view.transform = CGAffineTransform.identity
         }, completion: nil)
      })
   }
}

extension AnimationTimingExample {
   fileprivate func setupExampleViews() {

      let curveLabel: (String) -> UILabel = { labelTitle in
         let label: UILabel = UILabel()
         label.text = labelTitle
         label.font = MDCTypography.captionFont()
         label.textColor = UIColor(white: 0, alpha: MDCTypography.captionFontOpacity())
         label.sizeToFit()
         return label
      }

      let defaultColors: [UIColor] = [UIColor.darkGray.withAlphaComponent(0.8),
                                      UIColor.darkGray.withAlphaComponent(0.6),
                                      UIColor.darkGray.withAlphaComponent(0.4),
                                      UIColor.darkGray.withAlphaComponent(0.2)]

      scrollView.frame = view.bounds
      scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      scrollView.contentSize = view.frame.size
      scrollView.clipsToBounds = true
      view.addSubview(scrollView)

      let lineSpace: CGFloat = (view.frame.size.height - 50.0) / 4.0
      let linearLabel: UILabel = curveLabel("Linear")
      linearLabel.frame = CGRect(x: Constants.Sizes.leftGutter, y: Constants.Sizes.topMargin, width: linearLabel.frame.size.width, height: linearLabel.frame.size.height)
      scrollView.addSubview(linearLabel)

      let linearViewFrame: CGRect = CGRect(x: Constants.Sizes.leftGutter, y: Constants.Sizes.leftGutter + Constants.Sizes.topMargin, width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
      linearView.frame = linearViewFrame
      linearView.backgroundColor = defaultColors[0]
      linearView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
      scrollView.addSubview(linearView)

      let materialEaseInOutLabel: UILabel = curveLabel("MDCAnimationTimingFunctionEaseInOut")
      materialEaseInOutLabel.frame = CGRect(x: Constants.Sizes.leftGutter, y: lineSpace, width: materialEaseInOutLabel.frame.size.width, height: materialEaseInOutLabel.frame.size.height)
      scrollView.addSubview(materialEaseInOutLabel)

      let materialEaseInOutViewFrame: CGRect = CGRect(x: Constants.Sizes.leftGutter, y: lineSpace + Constants.Sizes.textOffset, width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
      materialEaseInOutView.frame = materialEaseInOutViewFrame
      materialEaseInOutView.backgroundColor = defaultColors[1]
      materialEaseInOutView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
      scrollView.addSubview(materialEaseInOutView)

      let materialEaseOutLabel: UILabel = curveLabel("MDCAnimationTimingFunctionEaseOut")
      materialEaseOutLabel.frame = CGRect(x: Constants.Sizes.leftGutter, y: lineSpace * 2.0, width: materialEaseOutLabel.frame.size.width, height: materialEaseOutLabel.frame.size.height)
      scrollView.addSubview(materialEaseOutLabel)

      let materialEaseOutViewFrame: CGRect = CGRect(x: Constants.Sizes.leftGutter, y: lineSpace * 2.0 + Constants.Sizes.textOffset, width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
      materialEaseOutView.frame = materialEaseOutViewFrame
      materialEaseOutView.backgroundColor = defaultColors[2]
      materialEaseOutView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0
      scrollView.addSubview(materialEaseOutView)

      let materialEaseInLabel: UILabel = curveLabel("MDCAnimationTimingFunctionEaseIn")
      materialEaseInLabel.frame = CGRect(x: Constants.Sizes.leftGutter, y: lineSpace * 3.0, width: materialEaseInLabel.frame.size.width, height: materialEaseInLabel.frame.size.height)
      scrollView.addSubview(materialEaseInLabel)

      let materialEaseInViewFrame: CGRect = CGRect(x: Constants.Sizes.leftGutter, y: lineSpace * 3.0 + Constants.Sizes.textOffset, width: Constants.Sizes.circleSize.width, height: Constants.Sizes.circleSize.height)
      materialEaseInView.frame = materialEaseInViewFrame
      materialEaseInView.backgroundColor = defaultColors[3]
      materialEaseInView.layer.cornerRadius = Constants.Sizes.circleSize.width / 2.0

      scrollView.addSubview(materialEaseInView)
   }

   @objc class func catalogBreadcrumbs() -> [String] {
      return ["Animation Timing", "Animation Timing (Swift)"]
   }

   @objc class func catalogIsPrimaryDemo() -> Bool {
      return false
   }

}
