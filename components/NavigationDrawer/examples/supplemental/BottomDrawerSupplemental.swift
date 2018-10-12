// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponentsAlpha.MaterialNavigationDrawer
import MaterialComponents.MaterialColorScheme

class DrawerContentViewController: UIViewController {
  var colorScheme = MDCSemanticColorScheme()
  let preferredHeight: CGFloat = 2000

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: preferredHeight)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.primaryColor
  }
}

class DrawerHeaderViewController: UIViewController {
  var colorScheme = MDCSemanticColorScheme()
  let preferredHeight: CGFloat = 80

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: preferredHeight)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.secondaryColor
  }
}
