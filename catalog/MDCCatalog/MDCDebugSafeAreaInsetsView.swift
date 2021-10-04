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

class MDCDebugSafeAreaInsetsView: UIView {
  fileprivate var edgeViews = [UIView]()

  override init(frame: CGRect) {
    super.init(frame: frame)

    isUserInteractionEnabled = false
    backgroundColor = .clear

    for _ in 0...3 {
      let view = UIView()
      view.backgroundColor = UIColor.red.withAlphaComponent(0.15)
      view.isUserInteractionEnabled = false
      edgeViews.append(view)
      addSubview(view)
    }
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override open func safeAreaInsetsDidChange() {
    setNeedsLayout()
    layoutIfNeeded()
  }

  override func layoutSubviews() {
    var safeAreaInsets = UIEdgeInsets.zero
    safeAreaInsets = self.safeAreaInsets

    let width = frame.width
    let height = frame.height
    let insetHeight = height - safeAreaInsets.top - safeAreaInsets.bottom

    // top
    edgeViews[0].frame = CGRect(x: 0, y: 0, width: width, height: safeAreaInsets.top)

    // left
    edgeViews[1].frame = CGRect(
      x: 0,
      y: safeAreaInsets.top,
      width: safeAreaInsets.left,
      height: insetHeight)

    // bottom
    edgeViews[2].frame = CGRect(
      x: 0,
      y: height - safeAreaInsets.bottom,
      width: width,
      height: safeAreaInsets.bottom)

    // right
    edgeViews[3].frame = CGRect(
      x: width - safeAreaInsets.right,
      y: safeAreaInsets.top,
      width: safeAreaInsets.right,
      height: insetHeight)
  }
}
