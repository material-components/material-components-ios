// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

// This viewcontroller contains a subview that has an MDCShadowLayer.
// A gesture recognizer allows the user to adjust the elevation of the
// shadowed view by pressing it, and move it by dragging it.

class ShadowDragSquareExampleViewController: UIViewController {

  @IBOutlet weak var blueView: ExampleShadowedView!

  // A UILongPressGestureRecognizer handles the changing of elevation
  // and location of the shadowedView.
  let longPressRecogniser = UILongPressGestureRecognizer()

  // We store the offset from the initial touch to the center of the
  // view to properly update its location when dragged.
  var movingViewOffset = CGPoint.zero

  override func viewDidLoad() {
    super.viewDidLoad()

    // MDCShadowLayer's elevation will implicitly animate when changed, so to disable that behavior
    // we need to disable Core Animation actions inside of a transaction:
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    self.blueView.shadowLayer.elevation = .cardResting
    CATransaction.commit()

    longPressRecogniser.addTarget(self, action: #selector(longPressedInView))
    longPressRecogniser.minimumPressDuration = 0.0
    self.blueView.addGestureRecognizer(longPressRecogniser)
  }

  @objc func longPressedInView(_ sender: UILongPressGestureRecognizer) {
    // Elevation of the view is changed to indicate that it has been pressed or released.
    // view.center is changed to follow the touch events.
    if sender.state == .began {
      self.blueView.shadowLayer.elevation = .cardPickedUp

      let selfPoint = sender.location(in: self.view)
      movingViewOffset.x = selfPoint.x - self.blueView.center.x
      movingViewOffset.y = selfPoint.y - self.blueView.center.y

    } else if sender.state == .changed {
      let selfPoint = sender.location(in: self.view)
      let newCenterPoint =
        CGPoint(x: selfPoint.x - movingViewOffset.x, y: selfPoint.y - movingViewOffset.y)
      self.blueView.center = newCenterPoint

    } else if sender.state == .ended {
      self.blueView.shadowLayer.elevation = .cardResting

      movingViewOffset = CGPoint.zero
    }
  }

  // MARK: - CatalogByConvention

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", "Shadow Layer"],
      "description": "Shadow Layer implements the Material Design specifications for "
        + "elevation and shadows.",
      "primaryDemo": true,
      "presentable": true,
      "storyboardName": "ShadowDragSquareExample",
    ]
  }
}
