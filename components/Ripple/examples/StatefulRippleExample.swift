// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

import Foundation
import UIKit
import MaterialComponents.MaterialRipple

class RippleView : UIView {
  let statefulRippleView = MDCStatefulRippleView()
  var didLongPress = false
  lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(gesture:)))

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonRippleViewInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonRippleViewInit()
  }

  func commonRippleViewInit() {
    statefulRippleView.frame = self.bounds
    statefulRippleView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    addSubview(statefulRippleView)
    longPressGesture.minimumPressDuration = 0.5
    longPressGesture.cancelsTouchesInView = false
    addGestureRecognizer(longPressGesture)
    isUserInteractionEnabled = true
    layer.cornerRadius = 4
    layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
    layer.borderWidth = 0.5
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    statefulRippleView.touchesBegan(touches, with: event)
    super.touchesBegan(touches, with: event)

    statefulRippleView.isRippleHighlighted = true
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    statefulRippleView.touchesMoved(touches, with: event)
    super.touchesMoved(touches, with: event)
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    statefulRippleView.touchesEnded(touches, with: event)
    super.touchesEnded(touches, with: event)

    statefulRippleView.isRippleHighlighted = false
    if (!didLongPress) {
      statefulRippleView.isSelected = !statefulRippleView.isSelected
    }
    didLongPress = false
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    statefulRippleView.touchesCancelled(touches, with: event)
    super.touchesCancelled(touches, with: event)

    statefulRippleView.isRippleHighlighted = false
  }

  @objc func didLongPress(gesture: UILongPressGestureRecognizer) {
    switch(gesture.state) {
    case .began:
      if (!statefulRippleView.allowsSelection) {
        statefulRippleView.allowsSelection = true
        statefulRippleView.isRippleHighlighted = false
        statefulRippleView.isSelected = true
        didLongPress = true
      }
    default:
      break
    }
  }
}

class StatefulRippleExample : UIViewController {
  @IBOutlet weak var interactiveView: RippleView!
  @IBOutlet weak var highlightedView: RippleView!
  @IBOutlet weak var selectedView: RippleView!
  @IBOutlet weak var draggedView: RippleView!

  override func viewDidLoad() {
    let bundle = Bundle(for: StatefulRippleExample.self)
    bundle.loadNibNamed("StatefulRippleExample", owner: self, options: nil)
    view.frame = self.view.bounds
    view.backgroundColor = .white
    highlightedView.isUserInteractionEnabled = false
    selectedView.isUserInteractionEnabled = false
    draggedView.isUserInteractionEnabled = false
  }

  override func viewDidLayoutSubviews() {
    highlightedView.statefulRippleView.isRippleHighlighted = true
    selectedView.statefulRippleView.allowsSelection = true
    selectedView.statefulRippleView.isSelected = true
    draggedView.statefulRippleView.isDragged = true
  }
}

extension StatefulRippleExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Ripple", "Stateful Ripple"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
