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

import UIKit

import CatalogByConvention

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialCollections
import MaterialComponents.MDCFlexibleHeaderColorThemer
import MaterialComponents.MaterialTypography

class NodeViewTableViewDemoCell: UITableViewCell {

  let label = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    textLabel!.font = MDCTypography.subheadFont()
    imageView!.image = UIImage(named: "Demo")

    // Ensure subtitile text is proportionally less pronounced than the title label
    let textLabelFont = textLabel!.font
    detailTextLabel?.alpha = CGFloat(0.5)
    detailTextLabel?.font = textLabelFont?.withSize(CGFloat((textLabelFont?.pointSize)! * 0.5))
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel!.textColor = UIColor.black
    imageView!.image = UIImage(named: "Demo")
  }
}

class MDCNodeListViewController: CBCNodeListViewController {
  let appBar = MDCAppBar()
  let sectionNames = ["Description", "Additional Examples"]
  let descriptionSectionHeight = CGFloat(100)
  let additionalExamplesSectionHeight = CGFloat(50)
  let rowHeight = CGFloat(50)
  let padding = CGFloat(20)
  var componentDescription = ""

  enum Section: Int {
    case description = 0
    case additionalExamples = 1
  }

  override init(node: CBCNode) {
    super.init(node: node)

    var childrenNodes = node.children.filter { $0.isExample() }

    // Make sure that primary demo appears first
    if let primaryDemoNodeIndex = childrenNodes.index(where: { $0.isPrimaryDemo() }),
        primaryDemoNodeIndex != 0 {
      let primaryDemoNode = childrenNodes[primaryDemoNodeIndex]
      childrenNodes.remove(at: primaryDemoNodeIndex)
      childrenNodes.insert(primaryDemoNode, at: 0)
    }

    node.children = childrenNodes

    componentDescription = childrenNodes.first?.exampleDescription() ?? ""

    self.addChildViewController(appBar.headerViewController)
    let appBarFont: UIFont
    if #available(iOS 9.0, *) {
        appBarFont = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFontWeightRegular)
    } else {
      let attribute: [String: UIFontDescriptorSymbolicTraits] =
         [UIFontSymbolicTrait: UIFontDescriptorSymbolicTraits.traitMonoSpace]
      let descriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attribute)
      appBarFont = UIFont(descriptor: descriptor, size: 16)
    }

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let colorScheme = appDelegate.colorScheme
    MDCFlexibleHeaderColorThemer.apply(colorScheme!, to: MDCFlexibleHeaderView.appearance())

    appBar.navigationBar.tintColor = UIColor.white
    appBar.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName: UIColor.white,
      NSFontAttributeName: appBarFont ]
    appBar.navigationBar.titleAlignment = .center
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.backgroundColor = UIColor.white
    self.tableView.separatorStyle = .none

    var charactersCount = 0
    #if swift(>=3.2)
      charactersCount = node.title.count
    #else
      charactersCount = node.title.characters.count
    #endif
    if charactersCount > 0 {
      self.tableView.accessibilityIdentifier = "Table" + node.title
    } else {
      self.tableView.accessibilityIdentifier = "DemoTableList"
    }

    appBar.headerViewController.headerView.trackingScrollView = self.tableView

    appBar.addSubviewsToParent()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBar.headerViewController
  }

  override var childViewControllerForStatusBarHidden: UIViewController? {
    return appBar.headerViewController
  }
}

// MARK: UIScrollViewDelegate
extension MDCNodeListViewController {

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollDidScroll()
    }
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      let headerView = appBar.headerViewController.headerView
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      let headerView = appBar.headerViewController.headerView
      headerView.trackingScrollWillEndDragging(
        withVelocity: velocity,
        targetContentOffset: targetContentOffset
      )
    }
  }
}

// MARK: UITableViewDataSource
extension MDCNodeListViewController {

  override func numberOfSections(in tableView: UITableView) -> Int {
    if node.children.count == 1 {
      return 1
    }
    return sectionNames.count
  }

  override func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int) -> String? {
    return sectionNames[section]
  }

  // swiftlint:disable function_body_length
  override func tableView(_ tableView: UITableView,
                          viewForHeaderInSection section: Int) -> UIView? {
    var sectionViewFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
    let sectionView = UIView(frame: sectionViewFrame)
    sectionView.backgroundColor = UIColor.white

    if section == 1 {
      let lineDivider =
        UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
      lineDivider.backgroundColor = UIColor(white: 0.85, alpha: 1)
      lineDivider.autoresizingMask = .flexibleWidth
      sectionView.addSubview(lineDivider)
    }

    let label = UILabel()
    label.text = sectionNames[section]
    label.frame =  CGRect(x: 0,
                          y: 0,
                          width: tableView.frame.size.width,
                          height: additionalExamplesSectionHeight)
    label.font = MDCTypography.body2Font()
    label.translatesAutoresizingMaskIntoConstraints = false
    sectionView.addSubview(label)
    constrainView(view: label,
                 containerView: sectionView,
                 height: additionalExamplesSectionHeight,
                 top: 0)

    if section == 0 {
      let textView = UITextView()
      textView.text = componentDescription
      textView.font = MDCTypography.captionFont()
      textView.alpha = MDCTypography.captionFontOpacity()

      if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
        textView.contentInset = UIEdgeInsets(top: -8, left: -5, bottom: -8, right: 5)
      } else {
        textView.contentInset = UIEdgeInsets(top: -8, left: 5, bottom: -8, right: -5)
      }

      textView.isEditable = false
      textView.translatesAutoresizingMaskIntoConstraints = false
      sectionViewFrame =
        CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: descriptionSectionHeight)
      sectionView.frame = sectionViewFrame
      sectionView.addSubview(textView)
      let textViewHeight = ceil(MDCTypography.captionFont().lineHeight * 3)
      constrainView(view: textView, containerView: sectionView, height: textViewHeight, top: 40)
    }
    return sectionView
  }
  // swiftlint:enable function_body_length

  override func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
    if section == Section.description.rawValue {
      return descriptionSectionHeight
    }
    return additionalExamplesSectionHeight
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == Section.description.rawValue {
      return 1
    }
    return node.children.count - 1
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "NodeViewTableViewDemoCell")
    if cell == nil {
      cell = NodeViewTableViewDemoCell.init(style: .subtitle,
                                            reuseIdentifier: "NodeViewTableViewDemoCell")
    }

    var subtitleText: String?
    if indexPath.section == Section.description.rawValue {
      subtitleText = node.children[indexPath.row].exampleViewControllerName()
      cell!.textLabel!.text = "Demo"
    } else {
      subtitleText = node.children[indexPath.row + 1].exampleViewControllerName()
      cell!.textLabel!.text = node.children[indexPath.row + 1].title
    }
    if subtitleText != nil {
      if let swiftModuleRange = subtitleText?.range(of: ".") {
        subtitleText = subtitleText!.substring(from: swiftModuleRange.upperBound)
      }
      cell!.detailTextLabel?.text = subtitleText!
    }
    cell!.accessoryType = .disclosureIndicator

    cell!.accessibilityIdentifier = "Cell" + cell!.textLabel!.text!
    return cell!
  }

  override func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }

  // MARK: Private
  func constrainView(view: UIView, containerView: UIView, height: CGFloat, top: CGFloat) {
#if swift(>=3.2)
    if #available(iOS 11.0, *) {
      let safeAreaLayoutGuide = containerView.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                      constant: padding),
        view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                       constant: -padding),
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: top),
        view.heightAnchor.constraint(equalToConstant: height)
      ])
    return
  }
#endif
    if #available(iOS 9.0, *) {
      NSLayoutConstraint.activate([
        view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
        view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top),
        view.heightAnchor.constraint(equalToConstant: height)
      ])
    } else {
      _ = NSLayoutConstraint(
        item: view,
        attribute: .leading,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .leading,
        multiplier: 1.0,
        constant: padding).isActive = true
      _ = NSLayoutConstraint(
        item: view,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .trailing,
        multiplier: 1.0,
        constant: -padding).isActive = true
      _ = NSLayoutConstraint(
        item: view,
        attribute: .top,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .top,
        multiplier: 1.0,
        constant: top).isActive = true
      _ = NSLayoutConstraint(
        item: view,
        attribute: .height,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1.0,
        constant: height).isActive = true
    }
  }
}

// MARK: UITableViewDelegate
extension MDCNodeListViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var node = self.node.children[0]
    if indexPath.section == Section.additionalExamples.rawValue {
      node = self.node.children[indexPath.row + 1]
    }

    var vc: UIViewController
    if node.isExample() {
      let contentVC = node.createExampleViewController()
      if contentVC.responds(to: NSSelectorFromString("catalogShouldHideNavigation")) {
        vc = contentVC
      } else {
        let appBarFont: UIFont
        if #available(iOS 9.0, *) {
            appBarFont = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFontWeightRegular)
        } else {
            let attribute: [String: UIFontDescriptorSymbolicTraits] =
                [UIFontSymbolicTrait: UIFontDescriptorSymbolicTraits.traitMonoSpace]
            let descriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attribute)
            appBarFont = UIFont(descriptor: descriptor, size: 16)
        }
        let container = MDCAppBarContainerViewController(contentViewController: contentVC)
        container.appBar.navigationBar.titleAlignment = .center
        container.appBar.navigationBar.tintColor = UIColor.white
        container.appBar.navigationBar.titleTextAttributes =
            [ NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: appBarFont ]

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let colorScheme = appDelegate.colorScheme
        MDCFlexibleHeaderColorThemer.apply(colorScheme!, to: MDCFlexibleHeaderView.appearance())
        let textColor = UIColor.white
        UIBarButtonItem.appearance().setTitleTextAttributes(
          [NSForegroundColorAttributeName: textColor],
          for: UIControlState())

        // TODO(featherless): Remove once
        // https://github.com/material-components/material-components-ios/issues/367 is resolved.
        contentVC.title = node.title

        let headerView = container.appBar.headerViewController.headerView
        if let collectionVC = contentVC as? MDCCollectionViewController {
          headerView.trackingScrollView = collectionVC.collectionView
        } else if let scrollView = contentVC.view as? UIScrollView {
          headerView.trackingScrollView = scrollView
        } else {
          // TODO(chuga): This is bad. We should be adjusting for Safe Area changes.
          var contentFrame = container.contentViewController.view.frame
          let headerSize = headerView.sizeThatFits(container.contentViewController.view.frame.size)
          contentFrame.origin.y = headerSize.height
          contentFrame.size.height = self.view.bounds.height - headerSize.height
          container.contentViewController.view.frame = contentFrame
        }

        vc = container
      }
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
