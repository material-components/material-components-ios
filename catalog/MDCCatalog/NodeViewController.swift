/*
Copyright 2015-present Google Inc. All Rights Reserved.

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

class NodeViewController: CBCNodeListViewController {
  let appBar = MDCAppBar()

  override init(node: CBCNode) {
    super.init(node: node)

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
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    appBar.headerViewController.headerView.trackingScrollView = self.tableView

    appBar.addSubviewsToParent()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: UIScrollViewDelegate

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    if (scrollView == appBar.headerViewController.headerView.trackingScrollView) {
      appBar.headerViewController.headerView.trackingScrollViewDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if (scrollView == appBar.headerViewController.headerView.trackingScrollView) {
      appBar.headerViewController.headerView.trackingScrollViewDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
    if (scrollView == appBar.headerViewController.headerView.trackingScrollView) {
      let headerView = appBar.headerViewController.headerView
      headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if (scrollView == appBar.headerViewController.headerView.trackingScrollView) {
      let headerView = appBar.headerViewController.headerView
      headerView.trackingScrollViewWillEndDraggingWithVelocity(velocity,
          targetContentOffset: targetContentOffset)
      }
  }

  // MARK: UITableViewDelegate

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if node.isExample() {
      let contentVC = node.createExampleViewController()
      if (contentVC.respondsToSelector((Selector("catalogShouldHideNavigation")))) {
        vc = contentVC
      } else {
        vc = MDCCatalogTypicalExampleViewController(contentViewController: contentVC,
          title: node.title)
      }
    } else {
      vc = NodeViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
