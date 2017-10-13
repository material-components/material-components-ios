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
import MaterialComponents.MaterialDialogs

/**
 A custom UIWindow that displays the user's touches for recording video or demos.

 Triple tapping anywhere will toggle the visible touches.
 */
class MDCCatalogWindow: MDCOverlayWindow {
  var debugUIEnabled = true
  var showTouches = false

  fileprivate let fadeDuration: TimeInterval = 0.2
  fileprivate var touchViews = [Int: UIView]()
  fileprivate var edgeViews = [UIView]()

  var showSafeAreaEdgeInsets:Bool {
    set {
      removeEdgeInsetViews()
      if newValue {
        showEdgeInsetViews()
      }
    }
    get {
      return edgeViews.count == 4
    }
  }

  override func sendEvent(_ event: UIEvent) {
    if let touches = event.allTouches {
      for touch in touches {
        switch touch.phase {
        case .began:
          if showTouches {
            beginDisplayingTouch(touch)
          }
          continue
        case .moved:
          updateTouch(touch)
          continue
        case .stationary:
          continue
        case .ended:
          if touch.tapCount == 3 && debugUIEnabled {
            showDebugSettings()
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

  fileprivate func showDebugSettings() {
    let touches = MDCCatalogDebugSetting(title: "Show touches")
    touches.getter = { self.showTouches }
    touches.setter = { newValue in self.showTouches = newValue }

    let safeAreaInsets = MDCCatalogDebugSetting(title: "Show safeAreaInsets")
    safeAreaInsets.getter = { self.showSafeAreaEdgeInsets }
    safeAreaInsets.setter = { newValue in self.showSafeAreaEdgeInsets = newValue }

    let dontShow = MDCCatalogDebugSetting(title: "Don't show this again")
    dontShow.getter = { !self.debugUIEnabled }
    dontShow.setter = { newValue in self.debugUIEnabled = !newValue }

    let debugUI = MDCCatalogDebugAlert(settings: [touches, safeAreaInsets, dontShow])
    self.rootViewController?.present(debugUI, animated: true, completion: nil)
  }

  override open func safeAreaInsetsDidChange() {
    if #available(iOS 11, *) {
      super.safeAreaInsetsDidChange()
    }
    if showTouches {
      layoutEdgeInsetViews()
    }
  }

  fileprivate func showEdgeInsetViews() {
    removeEdgeInsetViews()

    for _ in 0...4 {
      let view = UIView()
      view.backgroundColor = UIColor.red.withAlphaComponent(0.15)
      view.isUserInteractionEnabled = false
      edgeViews.append(view)
      self.addSubview(view)
    }

    layoutEdgeInsetViews()
  }

  fileprivate func removeEdgeInsetViews() {
    for view in edgeViews {
      view.removeFromSuperview()
    }
    edgeViews.removeAll()
  }

  fileprivate func layoutEdgeInsetViews() {
    var safeAreaInsets = UIEdgeInsets.zero
    if #available(iOS 11, *) {
      safeAreaInsets = self.safeAreaInsets
    }

    let width = self.frame.width
    let height = self.frame.height
    let insetHeight = height - safeAreaInsets.top - safeAreaInsets.bottom

    if edgeViews.count < 4 {
      return
    }

    // top
    edgeViews[0].frame = CGRect.init(x: 0, y: 0, width: width, height: safeAreaInsets.top)

    // left
    edgeViews[1].frame = CGRect.init(x: 0,
                                     y: safeAreaInsets.top,
                                     width: safeAreaInsets.left,
                                     height: insetHeight)

    // bottom
    edgeViews[2].frame = CGRect.init(x: 0,
                                     y: height - safeAreaInsets.bottom,
                                     width: width,
                                     height: safeAreaInsets.bottom)

    // right
    edgeViews[3].frame = CGRect.init(x: width - safeAreaInsets.right,
                                     y: safeAreaInsets.top,
                                     width: safeAreaInsets.right,
                                     height: insetHeight)
  }

  fileprivate func beginDisplayingTouch(_ touch: UITouch) {
    let view = MDCTouchView()
    view.center = touch.location(in: self)
    touchViews[touch.hash] = view
    self.addSubview(view)
  }

  fileprivate func updateTouch(_ touch: UITouch) {
    touchViews[touch.hash]?.center = touch.location(in: self)
  }

  fileprivate func endDisplayingTouch(_ touch: UITouch) {
    let view = touchViews[touch.hash]
    touchViews[touch.hash] = nil

    UIView.animate(withDuration: fadeDuration,
                   animations: { view?.alpha = 0 },
                   completion: { _ in view?.removeFromSuperview() })
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
    self.isUserInteractionEnabled = false
  }
}
