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
import MaterialComponents.MaterialInk

class ShrineInkOverlay: UIView, MDCInkTouchControllerDelegate {

  fileprivate var inkTouchController: MDCInkTouchController?

  override init(frame: CGRect) {
    super.init(frame: frame)
    let cyan = UIColor(red: 22 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.2)
    self.inkTouchController = MDCInkTouchController(view:self)
    self.inkTouchController!.defaultInkView.inkColor = cyan
    self.inkTouchController!.addInkView()
    self.inkTouchController!.delegate = self
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

}
