/*
Copyright 2016-present Google Inc. All Rights Reserved.

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
import MaterialComponents

class MDCCatalogTypicalExampleViewController: UIViewController {
  let appBar = MDCAppBar()
  var contentViewController = UIViewController()

  init(contentViewController: UIViewController, title: String) {
    super.init(nibName: nil, bundle: nil)
    assert(contentViewController.view != nil, "expecting a valid contentViewController")
    self.contentViewController = contentViewController
    self.addChildViewController(contentViewController)
    self.title = title

    self.addChildViewController(appBar.headerViewController)
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()

    let headerContentView = appBar.headerViewController.headerView
    let lineFrame = CGRectMake(0, headerContentView.frame.height, headerContentView.frame.width, 1)
    let line = UIView(frame: lineFrame)
    line.backgroundColor = UIColor(white: 0.72, alpha: 1)
    line.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth]
    headerContentView.addSubview(line)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    let headerHeight = appBar.headerViewController.headerView.minimumHeight
    self.view.addSubview(contentViewController.view)
    contentViewController.didMoveToParentViewController(self)
    contentViewController.view.frame =
      CGRectMake(0,
        headerHeight,
        self.view.bounds.size.width,
        self.view.bounds.size.height - headerHeight)
    contentViewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    appBar.addSubviewsToParent()
  }

}
