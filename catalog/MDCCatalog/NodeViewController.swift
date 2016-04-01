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

class Node {
  let title: String
  var children = [Node]()
  var map = [String:Node]()

  var viewController: AnyClass?

  init(title: String) {
    self.title = title
  }
}

class NodeViewController: UITableViewController, MDCAppBarParenting {
  var navigationBar: MDCNavigationBar?
  var headerStackView: MDCHeaderStackView?
  var headerViewController: MDCFlexibleHeaderViewController?
  let node: Node

  init(node: Node) {
    self.node = node
    super.init(nibName: nil, bundle: nil)
    self.title = self.node.title
    MDCAppBarPrepareParent(self)
    self.headerViewController!.headerView.backgroundColor = UIColor.whiteColor()

    let headerContentView = self.headerViewController!.headerView.contentView;
    let lineFrame = CGRectMake(0, headerContentView.frame.height, headerContentView.frame.width, 1)
    let line = UIView(frame: lineFrame)
    line.backgroundColor = UIColor(white: 0.72, alpha: 1)
    line.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth]
    headerContentView.addSubview(line)
  }

  required init?(coder aDecoder: NSCoder) {
    self.node = Node(title: "Invalid node")
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    self.headerViewController!.headerView.trackingScrollView = self.tableView
    MDCAppBarAddViews(self);
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)

    // Sort alphabetically.
    self.node.children = self.node.children.sort {
      $0.title < $1.title
    }
  }

  // MARK: UIScrollViewDelegate

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    if (scrollView == self.headerViewController!.headerView.trackingScrollView) {
      self.headerViewController!.headerView.trackingScrollViewDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if (scrollView == self.headerViewController!.headerView.trackingScrollView) {
      self.headerViewController!.headerView.trackingScrollViewDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
    if (scrollView == self.headerViewController!.headerView.trackingScrollView) {
      let headerView = self.headerViewController!.headerView
      headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if (scrollView == self.headerViewController!.headerView.trackingScrollView) {
      let headerView = self.headerViewController!.headerView
      headerView.trackingScrollViewWillEndDraggingWithVelocity(velocity,
          targetContentOffset: targetContentOffset)
    }
  }

  // MARK: UITableViewDataSource

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return node.children.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
    UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell")
    if cell == nil {
      cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
    }
    cell?.textLabel?.text = self.node.children[indexPath.row].title
    return cell!
  }

  // MARK: UITableViewDelegate

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if let vClass = node.viewController {
      let contentVC = ViewControllerFromClass(vClass)
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

  // MARK: MDCCatalogBarDelegate

  func didPressExit() {
    self.navigationController?.popViewControllerAnimated(true)
  }

}
