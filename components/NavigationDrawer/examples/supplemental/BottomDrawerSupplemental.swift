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
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialNavigationDrawer

class DrawerContentViewController: UIViewController {
  var preferredHeight: CGFloat = 2000

  init() {
    super.init(nibName: nil, bundle: nil)

    preferredContentSize = CGSize(width: view.bounds.width, height: preferredHeight)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
}

class DrawerHeaderViewController: UIViewController,MDCBottomDrawerHeader {
  let preferredHeight: CGFloat = 80
  let titleLabel : UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "Example Header"
    return label
  }()

  init() {
    super.init(nibName: nil, bundle: nil)

    preferredContentSize = CGSize(width: view.bounds.width, height: preferredHeight)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(titleLabel)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    titleLabel.sizeToFit()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    titleLabel.center =
      CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
  }
}
