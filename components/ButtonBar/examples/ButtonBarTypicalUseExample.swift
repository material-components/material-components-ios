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

class ButtonBarTypicalUseSwiftExample: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let buttonBar = MDCButtonBar()
    buttonBar.backgroundColor = self.buttonBarBackgroundColor()

    // MDCButtonBar ignores the style of UIBarButtonItem.
    let ignored: UIBarButtonItemStyle = .Done

    let actionItem = UIBarButtonItem(
      title: "Action",
      style: ignored,
      target: self,
      action: #selector(didTapActionButton)
    )

    let secondActionItem = UIBarButtonItem(
      title: "Second action",
      style: ignored,
      target: self,
      action: #selector(didTapActionButton)
    )

    let items = [actionItem, secondActionItem]

    // Set the title text attributes before assigning to buttonBar.items
    // because of https://github.com/material-components/material-components-ios/issues/277
    for item in items {
      item.setTitleTextAttributes(self.itemTitleTextAttributes(), forState: .Normal)
    }

    buttonBar.items = items

    // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
    let size = buttonBar.sizeThatFits(self.view.bounds.size)
    let x = (self.view.bounds.size.width - size.width) / 2;
    let y = self.view.bounds.size.height / 2 - size.height;
    buttonBar.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    buttonBar.autoresizingMask =
      [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
    self.view.addSubview(buttonBar)

    // Ensure that the controller's view isn't transparent.
    self.view.backgroundColor = UIColor.whiteColor()
  }

  func didTapActionButton(sender: AnyObject) {
    print("Did tap action item: \(sender)")
  }

  // MARK: Typical application code (not Material-specific)
  init() {
    super.init(nibName: nil, bundle: nil)

    self.title = "Button Bar"
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: Catalog by convention
extension ButtonBarTypicalUseSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Button Bar", "Button Bar (Swift)"]
  }
}

// MARK: - Typical application code (not Material-specific)

extension ButtonBarTypicalUseSwiftExample {
  func buttonBarBackgroundColor() -> UIColor {
    return UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.2)
  }

  func itemTitleTextAttributes () -> [String:AnyObject] {
    let textColor = UIColor(white: 0, alpha: 0.8)
    return [NSForegroundColorAttributeName:textColor]
  }
}
