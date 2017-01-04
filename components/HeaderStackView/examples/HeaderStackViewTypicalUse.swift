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

import Foundation
import MaterialComponents

open class HeaderStackViewTypicalUseSwiftExample: HeaderStackViewTypicalUse {

  override open func viewDidLoad() {

    super.viewDidLoad()
    self.setupExampleViews()

    stackView = MDCHeaderStackView.init()
    stackView!.autoresizingMask = .flexibleWidth
    stackView!.topBar = topView
    stackView!.bottomBar = navBar

    let frame = self.view.bounds
    stackView!.frame = frame
    stackView!.sizeToFit()

    view.addSubview(stackView!)
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override open var prefersStatusBarHidden : Bool {
    return true
  }
}
