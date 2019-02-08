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
    self.addSubview(statefulRippleView)
    self.translatesAutoresizingMaskIntoConstraints = false
    longPressGesture.minimumPressDuration = 0.5
    longPressGesture.cancelsTouchesInView = false
    self.addGestureRecognizer(longPressGesture)
    self.isUserInteractionEnabled = true
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addSubview(statefulRippleView)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    statefulRippleView.isRippleHighlighted = true
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    statefulRippleView.isRippleHighlighted = false
    if (!didLongPress) {
      statefulRippleView.isSelected = !statefulRippleView.isSelected
    }
    didLongPress = false
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    statefulRippleView.isRippleHighlighted = false
  }

  @objc func didLongPress(gesture: UILongPressGestureRecognizer) {
    switch(gesture.state) {
    case .began:
      if (!statefulRippleView.allowsSelection) {
        statefulRippleView.allowsSelection = true
        statefulRippleView.isSelected = true
        didLongPress = true
      }
    default:
      break
    }
  }
}

class StatefulRippleExample : UIViewController {
  let interactiveView = RippleView()
  let highlightedView = RippleView()
  let selectedView = RippleView()
  let draggedView = RippleView()

  override func viewDidLoad() {
    view.backgroundColor = .white
    view.addSubview(interactiveView)
    view.addSubview(highlightedView)
    view.addSubview(selectedView)
    view.addSubview(draggedView)
    highlightedView.isUserInteractionEnabled = false
    selectedView.isUserInteractionEnabled = false
    draggedView.isUserInteractionEnabled = false
    addConstraints()
  }

  override func viewDidLayoutSubviews() {
    highlightedView.statefulRippleView.isRippleHighlighted = true
    selectedView.statefulRippleView.allowsSelection = true
    selectedView.statefulRippleView.isSelected = true
    draggedView.statefulRippleView.isDragged = true
  }

  private func addConstraints() {
    let views: [String: UIView] = ["interactive": interactiveView,
                                   "highlighted": highlightedView,
                                   "selected": selectedView,
                                   "dragged": draggedView]
    let metrics = ["margin": 10.0]
    // Interactive View
    var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[interactive]-|", options: [.alignAllCenterY], metrics: metrics, views: views)
    constraints.append(NSLayoutConstraint(item: interactiveView, attribute: .height, relatedBy: .equal, toItem: interactiveView, attribute: .width, multiplier: 1, constant: 0))

    // Stateful Views
    constraints += NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-[highlighted]-(margin)-[selected]-(margin)-[dragged]-|",
                                                  options: [.alignAllCenterY],
                                                  metrics: metrics,
                                                  views: views)
    constraints.append(NSLayoutConstraint(item: highlightedView, attribute: .width, relatedBy: .equal, toItem: selectedView, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: selectedView, attribute: .width, relatedBy: .equal, toItem: draggedView, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: highlightedView, attribute: .height, relatedBy: .equal, toItem: highlightedView, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: selectedView, attribute: .height, relatedBy: .equal, toItem: selectedView, attribute: .width, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: draggedView, attribute: .height, relatedBy: .equal, toItem: draggedView, attribute: .width, multiplier: 1, constant: 0))
    constraints += NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-[interactive]-(margin)-[highlighted]",
                                                  options: [],
                                                  metrics: metrics,
                                                  views: views)

    self.view.addConstraints(constraints)
  }
}

extension StatefulRippleExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Ripple", "Stateful Ripple"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
