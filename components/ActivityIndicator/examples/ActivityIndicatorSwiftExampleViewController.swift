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
import MaterialComponents.MaterialActivityIndicator

class ActivityIndicatorSwiftExampleViewController: UIViewController {

   struct MDCPalette {
      static let blue: UIColor = UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0)
      static let red: UIColor = UIColor(red: 0.957, green: 0.263, blue: 0.212, alpha: 1.0)
      static let green: UIColor = UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.0)
      static let yellow: UIColor = UIColor(red: 1.0, green: 0.922, blue: 0.231, alpha: 1.0)
   }

   override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .white
      let width: CGFloat = view.bounds.width / 2
      let height: CGFloat = view.bounds.height / 2

      //Initialize single color progress indicator
      let frame1: CGRect = CGRect(x: width - 16, y: height - 116, width: 32, height: 32)
      let activityIndicator1 = MDCActivityIndicator(frame: frame1)
      view.addSubview(activityIndicator1)
      activityIndicator1.delegate = self
      // Set the progress of the indicator
      activityIndicator1.progress = 0.6
      // Set the progress indicator to determinate
      activityIndicator1.indicatorMode = .determinate
      activityIndicator1.sizeToFit()
      activityIndicator1.startAnimating()

      // Initialize indeterminate indicator
      let frame2: CGRect = CGRect(x: width - 16, y: height - 16, width: 32, height: 32)
      let activityIndicator2 = MDCActivityIndicator(frame: frame2)
      view.addSubview(activityIndicator2)
      activityIndicator2.delegate = self
      activityIndicator2.indicatorMode = .indeterminate
      activityIndicator2.sizeToFit()
      activityIndicator2.startAnimating()

      // Initialize multiple color indicator
      let frame3: CGRect = CGRect(x: width - 16, y: height + 84, width: 32, height: 32)
      let activityIndicator3 = MDCActivityIndicator(frame: frame3)
      view.addSubview(activityIndicator3)
      // Pass colors you want to indicator to cycle through
      activityIndicator3.cycleColors = [MDCPalette.blue, MDCPalette.red, MDCPalette.green, MDCPalette.yellow]
      activityIndicator3.delegate = self
      activityIndicator3.indicatorMode = .indeterminate
      activityIndicator3.sizeToFit()
      activityIndicator3.startAnimating()

      // Initialize with different radius and stroke with
      let frame4: CGRect = CGRect(x: width - 24, y: height + 176, width: 48, height: 48)
      let activityIndicator4 = MDCActivityIndicator(frame: frame4)
      view.addSubview(activityIndicator4)
      activityIndicator4.delegate = self
      // Set the radius of the circle
      activityIndicator4.radius = 18.0
      activityIndicator4.indicatorMode = .indeterminate
      // Set the width of the ring
      activityIndicator4.strokeWidth = 4.0
      activityIndicator4.sizeToFit()
      activityIndicator4.startAnimating()
   }
}

extension ActivityIndicatorSwiftExampleViewController : MDCActivityIndicatorDelegate {
   func activityIndicatorAnimationDidFinish(_ activityIndicator: MDCActivityIndicator) {
      return
   }

  // MARK: Catalog by convention
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Activity Indicator", "Activity Indicator (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

}
