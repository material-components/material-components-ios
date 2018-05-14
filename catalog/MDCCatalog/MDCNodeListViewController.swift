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
import MaterialComponents.MaterialAppBar_ColorThemer
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialTypography
import MaterialComponents.MaterialFlexibleHeader_ColorThemer

class NodeViewTableViewDemoCell: UITableViewCell {

  let label = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
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

class NodeViewTableViewPrimaryDemoCell: UITableViewCell {

  let containedButton = MDCButton()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupContainedButton()
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
    setupContainedButton()
  }

  func setupContainedButton() {
    containedButton.setTitle("Start Demo", for: .normal)
    containedButton.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(containedButton)

    // constraints
    NSLayoutConstraint(item: contentView,
                       attribute: .left,
                       relatedBy: .equal,
                       toItem: containedButton,
                       attribute: .left,
                       multiplier: 1,
                       constant: -16).isActive = true
    NSLayoutConstraint(item: contentView,
                       attribute: .right,
                       relatedBy: .equal,
                       toItem: containedButton,
                       attribute: .right,
                       multiplier: 1,
                       constant: 16).isActive = true
    NSLayoutConstraint(item: contentView,
                       attribute: .top,
                       relatedBy: .equal,
                       toItem: containedButton,
                       attribute: .top,
                       multiplier: 1,
                       constant: -8).isActive = true
    NSLayoutConstraint(item: contentView,
                       attribute: .bottom,
                       relatedBy: .equal,
                       toItem: containedButton,
                       attribute: .bottom,
                       multiplier: 1,
                       constant: 8).isActive = true
  }

}



class MDCNodeListViewController: CBCNodeListViewController {
  let appBar = MDCAppBar()
  var mainSectionHeader : UIView?
  var additionalExamplesSectionHeader : UIView?
  let sectionNames = ["Description", "Additional Examples"]
  let estimadedDescriptionSectionHeight = CGFloat(100)
  let estimadedAdditionalExamplesSectionHeight = CGFloat(50)
  let estimadedDemoRowHeight = CGFloat(60)
  let estimadedRowHeight = CGFloat(50)
  let padding = CGFloat(16)
  var componentDescription = ""
  var selectedNode: CBCNode? = nil

  enum Section: Int {
    case description = 0
    case additionalExamples = 1
  }

  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: AppTheme.didChangeGlobalThemeNotificationName,
                                              object: nil)
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

    appBar.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName: UIColor.white,
      NSFontAttributeName: appBarFont ]
    appBar.navigationBar.titleAlignment = .center
    applyColorScheme(AppTheme.globalTheme.colorScheme)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.themeDidChange),
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    mainSectionHeader = MainSectionHeader()
    additionalExamplesSectionHeader = createAdditionalExamplesSectionHeader()
    self.tableView.backgroundColor = UIColor.white
    self.tableView.separatorStyle = .none
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension

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

    self.tableView.register(NodeViewTableViewPrimaryDemoCell.self,
                            forCellReuseIdentifier: "NodeViewTableViewPrimaryDemoCell")
    self.tableView.register(NodeViewTableViewDemoCell.self,
                            forCellReuseIdentifier: "NodeViewTableViewDemoCell")
    appBar.headerViewController.headerView.trackingScrollView = self.tableView

    appBar.addSubviewsToParent()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)

    applyColorScheme(AppTheme.globalTheme.colorScheme)
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBar.headerViewController
  }

  override var childViewControllerForStatusBarHidden: UIViewController? {
    return appBar.headerViewController
  }

  func themeDidChange(notification: NSNotification) {
    guard let colorScheme = notification.userInfo?[AppTheme.globalThemeNotificationColorSchemeKey]
          as? MDCColorScheming else {
      return
    }
    applyColorScheme(colorScheme)
    applyThemeToCurrentExample()
    self.tableView.reloadData()
  }

  private func applyColorScheme(_ colorScheme: MDCColorScheming) {
    MDCAppBarColorThemer.applySemanticColorScheme(colorScheme, to: appBar)

    appBar.navigationBar.tintColor = UIColor.white
  }

  func applyThemeToCurrentExample() {
    // This is a short term solution of applying the theme instantly on the
    // currently presented example. A better solution would be to re-theme the example's components
    // and not reload the example entirely with a pop-push.
    guard let navigationController = self.navigationController else {
      return
    }
    guard let topVC = navigationController.topViewController,
      topVC is MDCAppBarContainerViewController ||
        topVC.self.responds(to: NSSelectorFromString("catalogBreadcrumbs")) else {
          return
    }
    navigationController.popViewController(animated: false)
    guard let selectedNode = selectedNode else {
      return
    }
    let vc = createViewController(from: selectedNode)
    self.navigationController?.pushViewController(vc, animated: false)
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
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == Section.description.rawValue {
      return estimadedDemoRowHeight
    }
    return estimadedRowHeight
 }

  override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    if section == Section.description.rawValue {
      return estimadedDescriptionSectionHeight
    }
    return estimadedAdditionalExamplesSectionHeight
  }
  // swiftlint:disable function_body_length
  override func tableView(_ tableView: UITableView,
                          viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      return mainSectionHeader
    }
    return additionalExamplesSectionHeader
  }

  func createAdditionalExamplesSectionHeader() -> UIView {
    let sectionView = UIView()
    sectionView.backgroundColor = UIColor.white
    let lineDivider = UIView()
    lineDivider.backgroundColor = UIColor(white: 0.85, alpha: 1)
    lineDivider.translatesAutoresizingMaskIntoConstraints = false

    let sectionTitleLabel = UILabel()
    sectionTitleLabel.font = MDCTypography.body2Font()
    sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    sectionTitleLabel.text = sectionNames[1]
    sectionTitleLabel.numberOfLines = 0
    sectionTitleLabel.setContentCompressionResistancePriority(1000, for: .vertical)

    sectionView.addSubview(lineDivider)
    sectionView.addSubview(sectionTitleLabel)

    // Line divider constraints
    NSLayoutConstraint(
      item: lineDivider,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: 1).isActive = true

    // Line divider to section view
    NSLayoutConstraint(
      item: sectionView,
      attribute: .leading,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0).isActive = true
    NSLayoutConstraint(
      item: sectionView,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0).isActive = true
    NSLayoutConstraint(
      item: sectionView,
      attribute: .top,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .top,
      multiplier: 1.0,
      constant: 0).isActive = true

    // Line divider to Title Label
    NSLayoutConstraint(
      item: lineDivider,
      attribute: .top,
      relatedBy: .equal,
      toItem: sectionTitleLabel,
      attribute: .top,
      multiplier: 1.0,
      constant: -padding).isActive = true

    let preiOS11Behavior = {
      NSLayoutConstraint(
        item: sectionView,
        attribute: .leading,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .leading,
        multiplier: 1.0,
        constant: -self.padding).isActive = true
      NSLayoutConstraint(
        item: sectionView,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .trailing,
        multiplier: 1.0,
        constant: self.padding).isActive = true
    }
    // Title Label to Section View
    #if swift(>=3.2)
    if #available(iOS 11.0, *) {
      // Align to the safe area insets.
      sectionTitleLabel.leadingAnchor
        .constraint(equalTo: sectionView.safeAreaLayoutGuide.leadingAnchor,
                    constant: padding).isActive = true
      sectionTitleLabel.trailingAnchor
        .constraint(equalTo: sectionView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -padding).isActive = true
    } else {
      preiOS11Behavior()
    }
    #else
    preiOS11Behavior()
    #endif

     NSLayoutConstraint(
      item: sectionView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: sectionTitleLabel,
      attribute: .bottom,
      multiplier: 1.0,
      constant: padding).isActive = true

    return sectionView
  }

  func MainSectionHeader() -> UIView {
    let sectionView = UIView()
    sectionView.backgroundColor = UIColor.white

    let sectionTitleLabel = UILabel()
    sectionTitleLabel.font = MDCTypography.body2Font()
    sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    sectionTitleLabel.text = sectionNames[0]
    sectionTitleLabel.numberOfLines = 0
    sectionTitleLabel.setContentCompressionResistancePriority(1000, for: .vertical)

    let descriptionLabel = UILabel()
    descriptionLabel.text = componentDescription
    descriptionLabel.font = MDCTypography.captionFont()
    descriptionLabel.alpha = MDCTypography.captionFontOpacity()
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.numberOfLines = 0
    descriptionLabel.setContentCompressionResistancePriority(1000, for: .vertical)

    sectionView.addSubview(sectionTitleLabel)
    sectionView.addSubview(descriptionLabel)

    // sectionTitleLabel to SectionView
    let preiOS11Behavior = {
      NSLayoutConstraint(
        item: sectionView,
        attribute: .leading,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .leading,
        multiplier: 1.0,
        constant: -self.padding).isActive = true
      NSLayoutConstraint(
        item: sectionView,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .trailing,
        multiplier: 1.0,
        constant: self.padding).isActive = true
    }
    #if swift(>=3.2)
    if #available(iOS 11.0, *) {
      // Align to the safe area insets.
      sectionTitleLabel.leadingAnchor
        .constraint(equalTo: sectionView.safeAreaLayoutGuide.leadingAnchor,
                    constant: padding).isActive = true
      sectionTitleLabel.trailingAnchor
        .constraint(equalTo: sectionView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -padding).isActive = true
    } else {
      preiOS11Behavior()
    }
    #else
    preiOS11Behavior()
    #endif

    NSLayoutConstraint(
      item: sectionView,
      attribute: .top,
      relatedBy: .equal,
      toItem: sectionTitleLabel,
      attribute: .top,
      multiplier: 1.0,
      constant: -padding).isActive = true

    // descriptionLabel to sectionTitleLabel
    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .leading,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0).isActive = true
    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0).isActive = true
    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .top,
      multiplier: 1.0,
      constant: -10).isActive = true

    // descriptionLabel to SectionView
    NSLayoutConstraint(
      item: sectionView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 10).isActive = true

    return sectionView
  }


  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == Section.description.rawValue {
      return 1
    }
    return node.children.count - 1
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell?
    if indexPath.section == Section.description.rawValue {
      cell = tableView.dequeueReusableCell(withIdentifier: "NodeViewTableViewPrimaryDemoCell")
      cell?.selectionStyle = .none
      let primaryDemoCell = cell as! NodeViewTableViewPrimaryDemoCell
      let button = primaryDemoCell.containedButton
      let buttonScheme = AppTheme.globalTheme.buttonScheme
      MDCContainedButtonThemer.applyScheme(buttonScheme, to:button)
      button.addTarget(self, action: #selector(primaryDemoButtonClicked), for: .touchUpInside)
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "NodeViewTableViewDemoCell")
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
      cell!.accessibilityIdentifier = "Cell" + cell!.textLabel!.text!
      cell!.accessoryType = .disclosureIndicator
    }

    return cell!
  }

  func primaryDemoButtonClicked () {
    let indexPath = IndexPath(row: 0, section: Section.description.rawValue)
    self.tableView(self.tableView, didSelectRowAt: indexPath)
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
      selectedNode = node
      vc = createViewController(from: node)
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }

  func createViewController(from node: CBCNode) -> UIViewController {
    var vc: UIViewController
    let contentVC = node.createExampleViewController()
    themeExample(vc: contentVC)
    if contentVC.responds(to: NSSelectorFromString("catalogShouldHideNavigation")) {
      vc = contentVC
    } else {
      self.navigationController?.setMenuBarButton(for: contentVC)
      vc = UINavigationController.embedExampleWithinAppBarContainer(using: contentVC,
                                                                    currentBounds: view.bounds,
                                                                    named: node.title)
    }
    return vc
  }

  func themeExample(vc: UIViewController) {
    let colorSel = NSSelectorFromString("setColorScheme:");
    if vc.responds(to: colorSel) {
      vc.perform(colorSel, with: AppTheme.globalTheme.colorScheme)
    }
    let typoSel = NSSelectorFromString("setTypographyScheme:");
    if vc.responds(to: typoSel) {
      vc.perform(typoSel, with: AppTheme.globalTheme.typographyScheme)
    }
  }
}
