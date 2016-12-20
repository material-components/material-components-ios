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

import UIKit

import MaterialComponents.MaterialOverlayWindow

/**
 A custom UIWindow that displays the user's touches for recording video or demos.

 Triple tapping anywhere will toggle the visible touches.
 */
class MDCCatalogWindow: MDCOverlayWindow {
  var enabled = false

  fileprivate let fadeDuration: TimeInterval = 0.2
  fileprivate var views = [Int: UIView]()

  override func sendEvent(_ event: UIEvent) {
    if let touches = event.allTouches {
      for touch in touches {
        switch touch.phase {
        case .began:
          if (enabled) {
            beginDisplayingTouch(touch)
          }
          continue
        case .moved:
          updateTouch(touch)
          continue
        case .stationary:
          continue
        case .ended:
          if (touch.tapCount == 3) {
            enabled = !enabled
          }
          fallthrough
        case .cancelled:
          endDisplayingTouch(touch)
          continue
        }
      }
    }

    super.sendEvent(event)
  }

  fileprivate func beginDisplayingTouch(_ touch: UITouch) {
    let view = MDCTouchView()
    view.center = touch.location(in: self)
    views[touch.hash] = view
    self.addSubview(view)
  }

  fileprivate func updateTouch(_ touch: UITouch) {
    views[touch.hash]?.center = touch.location(in: self)
  }

  fileprivate func endDisplayingTouch(_ touch: UITouch) {
    let view = views[touch.hash]
    views[touch.hash] = nil

    UIView.animate(withDuration: fadeDuration,
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
  fileprivate let touchCircleSize: CGFloat = 80
  fileprivate let touchCircleAlpha: CGFloat = 0.25
  fileprivate let touchCircleColor = UIColor.red
  fileprivate let touchCircleBorderColor = UIColor.black
  fileprivate let touchCircleBorderWidth: CGFloat = 1

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonMDCTouchViewInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonMDCTouchViewInit()
  }

  fileprivate func commonMDCTouchViewInit() {
    self.backgroundColor = touchCircleColor
    self.alpha = touchCircleAlpha
    self.frame.size = CGSize(width: touchCircleSize, height: touchCircleSize)
    self.layer.cornerRadius = touchCircleSize / 2
    self.layer.borderColor = touchCircleBorderColor.cgColor
    self.layer.borderWidth = touchCircleBorderWidth
  }
}
