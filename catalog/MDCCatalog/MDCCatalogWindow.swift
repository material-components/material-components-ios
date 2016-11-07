/*
Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

import MaterialComponents
import UIKit

/**
 A custom UIWindow that displays the user's touches for recording video or demos.

 Triple tapping anywhere will toggle the visible touches.
 */
class MDCCatalogWindow: MDCOverlayWindow {
  var enabled = false

  private let fadeDuration: NSTimeInterval = 0.2
  private var views = [NSNumber: UIView]()

  override func sendEvent(event: UIEvent) {
    if let touches = event.allTouches() {
      for touch in touches {
        switch touch.phase {
        case .Began:
          if (enabled) {
            beginDisplayingTouch(touch)
          }
          continue
        case .Moved:
          updateTouch(touch)
          continue
        case .Stationary:
          continue
        case .Ended:
          if (touch.tapCount == 3) {
            enabled = !enabled
          }
          fallthrough
        case .Cancelled:
          endDisplayingTouch(touch)
          continue
        }
      }
    }

    super.sendEvent(event)
  }

  private func beginDisplayingTouch(touch: UITouch) {
    let view = MDCTouchView()
    view.center = touch.locationInView(self)
    views[touch.hash] = view
    self.addSubview(view)
  }

  private func updateTouch(touch: UITouch) {
    views[touch.hash]?.center = touch.locationInView(self)
  }

  private func endDisplayingTouch(touch: UITouch) {
    let view = views[touch.hash]
    views[touch.hash] = nil

    UIView.animateWithDuration(fadeDuration,
                               animations: {
                                 view?.alpha = 0
                               },
                               completion: { finished in
                                view?.removeFromSuperview()
                               })
  }
}

/** A circular view that represents a user's touch. */
class MDCTouchView: UIView {
  private let touchCircleSize: CGFloat = 80
  private let touchCircleAlpha: CGFloat = 0.25
  private let touchCircleColor = UIColor.redColor()
  private let touchCircleBorderColor = UIColor.blackColor()
  private let touchCircleBorderWidth: CGFloat = 1

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonMDCTouchViewInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonMDCTouchViewInit()
  }

  private func commonMDCTouchViewInit() {
    self.backgroundColor = touchCircleColor
    self.alpha = touchCircleAlpha
    self.frame.size = CGSizeMake(touchCircleSize, touchCircleSize)
    self.layer.cornerRadius = touchCircleSize / 2
    self.layer.borderColor = touchCircleBorderColor.CGColor
    self.layer.borderWidth = touchCircleBorderWidth
  }
}
