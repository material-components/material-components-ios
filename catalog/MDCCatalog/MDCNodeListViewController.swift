/*
Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import CatalogByConvention
import MaterialComponents
import UIKit

class NodeViewTableViewDemoCell: UITableViewCell {

  let label = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    textLabel!.font = MDCTypography.subheadFont()
    imageView!.image = UIImage(named: "Demo")

    // Ensure subtitile text is proportionally less pronounced than the title label
    let textLabelFont = textLabel!.font
    detailTextLabel?.alpha = CGFloat(0.5)
    detailTextLabel?.font = textLabelFont.fontWithSize(CGFloat(textLabelFont.pointSize * 0.5))
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel!.textColor = UIColor.blackColor()
    imageView!.image = UIImage(named: "Demo")
  }
}

class MDCNodeListViewController: CBCNodeListViewController {
  let appBar = MDCAppBar()
  let sectionNames = ["Description", "Additional Examples"]
  let descriptionSectionHeight = CGFloat(100)
  let additionalExamplesSectionHeight = CGFloat(50)
  let rowHeight = CGFloat(50)
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
        let isPrimaryDemo = childNode.isPrimaryDemo()
        if isPrimaryDemo {
          orderedNodes.insertObject(childNode, atIndex: 0)
          componentDescription = childNode.exampleDescription()
        } else {
          orderedNodes.addObject(childNode)
        }
      }
    }
    node.children =  orderedNodes as NSArray as! [CBCNode]

    self.addChildViewController(appBar.headerViewController)
    appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor()
    appBar.navigationBar.titleAlignment = .Center
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.backgroundColor = UIColor.whiteColor()
    self.tableView.separatorStyle = .None

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

    if section == 1 {
      let lineDivider = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 1))
      lineDivider.backgroundColor = UIColor(white: 0.85, alpha: 1)
      lineDivider.autoresizingMask = .FlexibleWidth
      sectionView.addSubview(lineDivider)
    }

    let label = UILabel()
    label.text = sectionNames[section]
    label.frame =
      CGRectMake(20, 0, tableView.frame.size.width - 20, additionalExamplesSectionHeight)
    label.font = MDCTypography.body2Font()
    label.translatesAutoresizingMaskIntoConstraints = false
    sectionView.addSubview(label)

    _ = NSLayoutConstraint(
      item: label,
      attribute: .Leading,
      relatedBy: .Equal,
      toItem: sectionView,
      attribute: .Leading,
      multiplier: 1.0,
      constant: 20).active = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .Trailing,
      relatedBy: .Equal,
      toItem: sectionView,
      attribute: .Trailing,
      multiplier: 1.0,
      constant: 0).active = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .Top,
      relatedBy: .Equal,
      toItem: sectionView,
      attribute: .Top,
      multiplier: 1.0,
      constant: 0).active = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .Height,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 1.0,
      constant: additionalExamplesSectionHeight).active = true

    if (section == 0) {
      let textView = UITextView()
      textView.text = componentDescription
      textView.font = MDCTypography.captionFont()
      textView.alpha = MDCTypography.captionFontOpacity()

      if (UIApplication.sharedApplication().userInterfaceLayoutDirection == .LeftToRight) {
          textView.contentInset = UIEdgeInsetsMake(-8, -5, -8, 5)
      } else {
          textView.contentInset = UIEdgeInsetsMake(-8, 5, -8, -5)
      }

      textView.editable = false
      textView.translatesAutoresizingMaskIntoConstraints = false
      sectionViewFrame = CGRectMake(0, 0, tableView.frame.size.width, descriptionSectionHeight)
      sectionView.frame = sectionViewFrame
      sectionView.addSubview(textView)
      let textViewHeight = ceil(MDCTypography.captionFont().lineHeight * 3)
      // Use AutoLayout to workaround http://www.openradar.me/25505644.
      if #available(iOS 9.0, *) {
        NSLayoutConstraint.activateConstraints([
          textView.leadingAnchor.constraintEqualToAnchor(sectionView.leadingAnchor, constant: 20),
          textView.trailingAnchor.constraintEqualToAnchor(sectionView.trailingAnchor,
              constant: -20),
          textView.topAnchor.constraintEqualToAnchor(sectionView.topAnchor, constant: 40),
          textView.heightAnchor.constraintEqualToConstant(textViewHeight)
        ])
      } else {
        let horizontalConstraints =
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-(20)-[textView]-(20)-|",
                                                           options: [], metrics: nil,
                                                           views: ["textView" : textView])
        let verticalConstraints =
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-(40)-[textView(==h)]",
                                                           options: [],
                                                           metrics: ["h" : textViewHeight],
                                                           views: ["textView" : textView])
        sectionView.addConstraints(horizontalConstraints)
        sectionView.addConstraints(verticalConstraints)
      }
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
      cell = NodeViewTableViewDemoCell.init(style: .Subtitle,
        reuseIdentifier: "NodeViewTableViewDemoCell")
    }

    var subtitleText: String?
    if (indexPath.section == Section.Description.rawValue) {
      subtitleText = node.children[indexPath.row].exampleViewControllerName()
      cell!.textLabel!.text = "Demo"
      cell!.textLabel!.textColor = UIColor(red: 0.01, green: 0.66, blue: 0.96, alpha: 1)
      cell!.imageView?.image = UIImage(named: "DemoMain")
    } else {
      subtitleText = node.children[indexPath.row + 1].exampleViewControllerName()
      cell!.textLabel!.text = node.children[indexPath.row + 1].title
    }
    if subtitleText != nil {
      if let swiftModuleRange = subtitleText?.rangeOfString(".") {
        subtitleText = subtitleText!.substringFromIndex(swiftModuleRange.endIndex)
      }
      cell!.detailTextLabel?.text = subtitleText!
    }
    cell!.accessoryType = .DisclosureIndicator

    return cell!
  }

  override func tableView(tableView: UITableView,
    heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return rowHeight
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
      if contentVC.respondsToSelector(NSSelectorFromString("catalogShouldHideNavigation")) {
        vc = contentVC
      } else {
        let container = MDCAppBarContainerViewController(contentViewController: contentVC)
        container.appBar.navigationBar.titleAlignment = .Center

        // TODO(featherless): Remove once
        // https://github.com/google/material-components-ios/issues/367 is resolved.
        contentVC.title = node.title

        let headerView = container.appBar.headerViewController.headerView

        headerView.backgroundColor = UIColor.whiteColor()

        let textColor = UIColor(white: 0, alpha: 0.8)
        UIBarButtonItem.appearance().setTitleTextAttributes(
          [NSForegroundColorAttributeName:textColor],
          forState: .Normal)

        var contentFrame = container.contentViewController.view.frame
        let headerSize = headerView.sizeThatFits(container.contentViewController.view.frame.size)
        contentFrame.origin.y = headerSize.height
        contentFrame.size.height = self.view.bounds.size.height - headerSize.height
        container.contentViewController.view.frame = contentFrame

        vc = container
      }
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
