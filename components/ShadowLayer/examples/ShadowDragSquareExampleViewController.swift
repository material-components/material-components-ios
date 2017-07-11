/*
Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

// This viewcontroller contains a subview that has an MDCShadowLayer.
// A gesture recognizer allows the user to adjust the elevation of the
// shadowed view by pressing it, and move it by dragging it.

class ShadowDragSquareExampleViewController: UIViewController {

  @IBOutlet weak var blueView: ExampleShadowedView!

  // The elevation of the view affects the size of its shadow.
  // The following elevations indicate to the user if the view
  // is pressed or not.
  let kRestingCardElevation: CGFloat = 2.0
  let kSelectedCardElevation: CGFloat = 8.0

  // A UILongPressGestureRecognizer handles the changing of elevation
  // and location of the shadowedView.
  let longPressRecogniser = UILongPressGestureRecognizer()

  // We store the offset from the initial touch to the center of the
  // view to properly update its location when dragged.
  var movingViewOffset = CGPoint.zero

  override func viewDidLoad() {
    super.viewDidLoad()

    self.blueView.setElevation(kRestingCardElevation)

    longPressRecogniser.addTarget(self, action: #selector(longPressedInView))
    longPressRecogniser.minimumPressDuration = 0.0
    self.blueView.addGestureRecognizer(longPressRecogniser)
  }

  @objc func longPressedInView(_ sender: UILongPressGestureRecognizer) {
    // Elevation of the view is changed to indicate that it has been pressed or released.
    // view.center is changed to follow the touch events.
    if sender.state == .began {
      self.blueView.setElevation(kSelectedCardElevation)

      let selfPoint = sender.location(in: self.view)
      movingViewOffset.x = selfPoint.x - self.blueView.center.x
      movingViewOffset.y = selfPoint.y - self.blueView.center.y
    } else if sender.state == .changed {
      let selfPoint = sender.location(in: self.view)
      let newCenterPoint =
          CGPoint(x: selfPoint.x - movingViewOffset.x, y: selfPoint.y - movingViewOffset.y)
      self.blueView.center = newCenterPoint
    } else if sender.state == .ended {
      self.blueView.setElevation(kRestingCardElevation)

      movingViewOffset = CGPoint.zero
    }
  }

  // MARK: catalog by convention

  class func catalogBreadcrumbs() -> [String] {
    return [ "Shadow", "Shadow Layer"]
  }

  class func catalogStoryboardName() -> String {
    return "ShadowDragSquareExample"
  }

  class func catalogDescription() -> String {
    return "Shadow Layer implements the Material Design specifications for elevation and shadows."
  }

  class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

}
