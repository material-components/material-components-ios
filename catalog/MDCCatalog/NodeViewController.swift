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

class NodeViewTableViewDemoCell: UITableViewCell {

  let label = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    textLabel!.font = MDCTypography.subheadFont()
    imageView!.image = UIImage(named: "Demo")
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

}

class NodeViewController: CBCNodeListViewController {
  let appBar = MDCAppBar()
  let sectionNames = ["Description", "Additional Examples"]
  let descriptionSectionHeight = CGFloat(100)
  let additionalExamplesSectionHeight = CGFloat(50)
  let rowHeight = CGFloat(50)
  let footerHeight = CGFloat(20)
  var componentDescription = ""

  enum Section: Int {
    case Description = 0
    case AdditionalExamples = 1
  }

  override init(node: CBCNode) {
    super.init(node: node)

    // Make sure that primary demo appears first
    let orderedNodes = NSMutableArray()
    for childNode in node.children {
      if childNode.isExample() {
        let contentVC = childNode.createExampleViewController()
        if contentVC.respondsToSelector("catalogIsPrimaryDemo") {
          orderedNodes.insertObject(childNode, atIndex: 0)
          componentDescription = childNode.createExampleDescription()
        } else {
          orderedNodes.addObject(childNode)
        }
      }
    }
    node.children =  orderedNodes as NSArray as! [CBCNode]

    self.addChildViewController(appBar.headerViewController)
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()

    let headerContentView = appBar.headerViewController.headerView
    let lineFrame = CGRectMake(0, headerContentView.frame.height, headerContentView.frame.width, 1)
    let line = UIView(frame: lineFrame)
    line.backgroundColor = UIColor(white: 0.72, alpha: 1)
    line.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth]
    headerContentView.addSubview(line)
    self.tableView.backgroundColor = UIColor.whiteColor()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorColor = UIColor.clearColor()
    appBar.headerViewController.headerView.trackingScrollView = self.tableView

    appBar.addSubviewsToParent()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: UIScrollViewDelegate

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollViewDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollViewDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      let headerView = appBar.headerViewController.headerView
      headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      let headerView = appBar.headerViewController.headerView
      headerView.trackingScrollViewWillEndDraggingWithVelocity(
        velocity,
        targetContentOffset: targetContentOffset
      )
    }
  }

  // MARK: UITableViewDataSource

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if (node.children.count == 1) {
      return 1
    }
    return sectionNames.count
  }

  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionNames[section]
  }

  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    var sectionViewFrame = CGRectMake(0, 0, tableView.frame.size.width, 50)
    let sectionView = UIView(frame: sectionViewFrame)
    sectionView.backgroundColor = UIColor.whiteColor()

    let lineDivider = UIView(frame: CGRectMake(0,0,tableView.frame.size.width, 1))
    lineDivider.backgroundColor = UIColor(white: 0.85, alpha: 1)
    lineDivider.autoresizingMask = .FlexibleWidth
    sectionView.addSubview(lineDivider)

    let label = UILabel()
    label.text = sectionNames[section]
    label.frame =
      CGRectMake(20, 0, tableView.frame.size.width - 20, additionalExamplesSectionHeight)
    label.font = MDCTypography.body2Font()
    sectionView.addSubview(label)

    if (section == 0) {
      let textView = UITextView()
      textView.text = componentDescription
      textView.font = MDCTypography.captionFont()
      textView.alpha = MDCTypography.captionFontOpacity()
      textView.frame = CGRectMake(20,
        40,
        tableView.frame.size.width - 40,
        (MDCTypography.captionFont().lineHeight) * 3)
      textView.autoresizingMask = .FlexibleWidth
      textView.contentInset = UIEdgeInsetsMake(-8, -5, -8, -5);
      sectionViewFrame = CGRectMake(0, 0, tableView.frame.size.width, descriptionSectionHeight)
      sectionView.frame = sectionViewFrame
      sectionView.addSubview(textView)
    }

    return sectionView
  }

  override func tableView(tableView: UITableView,
    heightForHeaderInSection section: Int) -> CGFloat {
      if (section == Section.Description.rawValue) {
        return descriptionSectionHeight
      }
      return additionalExamplesSectionHeight
  }

  override func tableView(tableView: UITableView,
    willDisplayFooterView view: UIView, forSection section: Int) {
    let footerView = view as! UITableViewHeaderFooterView
    footerView.contentView.backgroundColor = UIColor.whiteColor()
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == Section.Description.rawValue) {
      return 1
    }
    return node.children.count - 1
  }

  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("NodeViewTableViewDemoCell")
    if ((cell == nil)) {
      cell = NodeViewTableViewDemoCell.init(style: .Default,
        reuseIdentifier: "NodeViewTableViewDemoCell")
    }
    if (indexPath.section == Section.Description.rawValue) {
      cell!.textLabel!.text = "Demo"
      cell!.textLabel!.textColor = UIColor(red: 0.01, green: 0.66, blue: 0.96, alpha: 1)
      cell!.imageView?.image = UIImage(named: "Demo Main")
    } else {
      cell!.textLabel!.text = node.children[indexPath.row + 1].title
    }

    return cell!
  }

  override func tableView(tableView: UITableView,
    heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return rowHeight
  }

  override func tableView(tableView: UITableView,
    heightForFooterInSection section: Int) -> CGFloat {
    return footerHeight
  }

  // MARK: UITableViewDelegate

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var node = self.node.children[0]
    if (indexPath.section == Section.AdditionalExamples.rawValue) {
      node = self.node.children[indexPath.row + 1]
    }

    var vc: UIViewController
    if node.isExample() {
      let contentVC = node.createExampleViewController()
      if contentVC.respondsToSelector("catalogShouldHideNavigation") {
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
