/*
Copyright 2015-present Google Inc. All Rights Reserved.

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
  let kMDCRestingCardElevation: CGFloat = 2.0
  let kMDCSelectedCardElevation: CGFloat = 8.0

  // A UILongPressGestureRecognizer handles the changing of elevation
  // and location of the shadowedView.
  let longPressRecogniser = UILongPressGestureRecognizer()

  // We store the offset from the initial touch to the center of the
  // view to properly update its location when dragged.
  var movingViewOffset = CGPointZero

  override func viewDidLoad() {
    super.viewDidLoad()

    self.blueView.setElevation(kMDCRestingCardElevation)

    longPressRecogniser.addTarget(self, action: "longPressedInView:")
    longPressRecogniser.minimumPressDuration = 0.0
    self.blueView.addGestureRecognizer(longPressRecogniser)
  }

  func longPressedInView(sender:UILongPressGestureRecognizer) {
    // Elevation of the view is changed to indicate that it has been pressed or released.
    // view.center is changed to follow the touch events.
    if (sender.state == .Began) {
      self.blueView.setElevation(kMDCSelectedCardElevation)

      let selfPoint = sender.locationInView(self.view)
      movingViewOffset.x = selfPoint.x - self.blueView.center.x
      movingViewOffset.y = selfPoint.y - self.blueView.center.y
    } else if (sender.state == .Changed) {
      let selfPoint = sender.locationInView(self.view)
      let newCenterPoint =
          CGPoint(x: selfPoint.x - movingViewOffset.x, y: selfPoint.y - movingViewOffset.y)
      self.blueView.center = newCenterPoint
    } else if (sender.state == .Ended) {
      self.blueView.setElevation(kMDCRestingCardElevation)

      movingViewOffset = CGPointZero
    }
  }

  // MARK: catalog by convention

  class func catalogBreadcrumbs() -> Array<String> {
    return [ "Shadows", "Drag square"]
  }

  class func catalogStoryboardName() -> String {
    return "ShadowDragSquareExample"
  }

}
