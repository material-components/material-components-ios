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
import MaterialComponents

open class FlexibleHeaderTypicalUseViewControllerSwift: FlexibleHeaderTypicalUseViewController {

  let fhvc = MDCFlexibleHeaderViewController()
  override open var childViewControllerForStatusBarHidden: UIViewController? {
    return fhvc
  }
  override open var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override open func viewDidLoad() {

    super.viewDidLoad()

    scrollView = UIScrollView.init(frame: view.bounds)
    scrollView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(scrollView!)

    // If a tableView was being used instead of a scrollView, you would set the trackingScrollView
    // to be that tableView and either set the MDCFlexibleHeaderViewController to be the
    // UITableViewDelegate or forward the UIScrollViewDelegate methods to
    // MDCFlexibleHeaderViewController from the UITableViewDelegate.
    scrollView!.delegate = fhvc
    fhvc.headerView.trackingScrollView = scrollView
    self.addChildViewController(fhvc)
    fhvc.view.frame = view.bounds
    view.addSubview(fhvc.view)
    fhvc.didMove(toParentViewController: self)

    fhvc.headerView.backgroundColor = UIColor(white: 0.1, alpha: 1.0);

    self.setupExampleViews()
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
    // comment this line:
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

}
