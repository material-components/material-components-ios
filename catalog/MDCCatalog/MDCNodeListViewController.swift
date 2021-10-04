// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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
import CatalogByConvention
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_ColorThemer 
import MaterialComponents.MaterialAppBar_TypographyThemer 
import MaterialComponents.MaterialButtons_ButtonThemer 
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming 
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialTypography

class NodeViewTableViewDemoCell: UITableViewCell {

  private let detailOpacity: CGFloat = 0.54

  let label = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    textLabel!.font = MDCTypography.subheadFont()
    imageView!.image = UIImage(named: "Demo")

    // Ensure subtitle text is proportionally less pronounced than the title label
    detailTextLabel?.alpha = detailOpacity
    detailTextLabel?.font = MDCTypography.body2Font()

    let lineDivider = UIView()
    lineDivider.backgroundColor = UIColor(white: 0.85, alpha: 1)
    lineDivider.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(lineDivider)

    NSLayoutConstraint(
      item: lineDivider,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: 1
    ).isActive = true

    // Line divider to section view
    NSLayoutConstraint(
      item: textLabel!,
      attribute: .leading,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: self,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: self,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
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

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    containedButton.accessibilityIdentifier = "start.demo"
    contentView.addSubview(containedButton)

    // constraints
    NSLayoutConstraint(
      item: contentView,
      attribute: .left,
      relatedBy: .equal,
      toItem: containedButton,
      attribute: .left,
      multiplier: 1,
      constant: -16
    ).isActive = true
    NSLayoutConstraint(
      item: contentView,
      attribute: .right,
      relatedBy: .equal,
      toItem: containedButton,
      attribute: .right,
      multiplier: 1,
      constant: 16
    ).isActive = true
    NSLayoutConstraint(
      item: contentView,
      attribute: .top,
      relatedBy: .equal,
      toItem: containedButton,
      attribute: .top,
      multiplier: 1,
      constant: -10
    ).isActive = true
    NSLayoutConstraint(
      item: contentView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: containedButton,
      attribute: .bottom,
      multiplier: 1,
      constant: 6
    ).isActive = true
  }

}

class MDCNodeListViewController: CBCNodeListViewController {
  var mainSectionHeader: UIView?
  var mainSectionHeaderTitleLabel: UILabel?
  var mainSectionHeaderDescriptionLabel: UILabel?
  var additionalExamplesSectionHeader: UIView?
  let sectionNames = ["Description", "Additional Examples"]
  let estimadedDescriptionSectionHeight = CGFloat(100)
  let estimadedAdditionalExamplesSectionHeight = CGFloat(50)
  let padding = CGFloat(16)
  var componentDescription = ""
  var selectedNode: CBCNode? = nil
  var titleMaxY = CGFloat(36)
  var titleDescriptionMargin = CGFloat(34)
  var descriptionLineHeight = CGFloat(24)
  var demoButtonRowHeight = CGFloat(54)
  var additionalDemoRowHeight = CGFloat(64)
  private let descriptionOpacity: CGFloat = 0.87

  enum Section: Int {
    case description = 0
    case additionalExamples = 1
  }

  deinit {
    NotificationCenter.default.removeObserver(
      self,
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)
  }

  override init(node: CBCNode) {
    super.init(node: node)

    var childrenNodes = node.children.filter { $0.isExample() }

    // Make sure that primary demo appears first
    if let primaryDemoNodeIndex = childrenNodes.index(where: { $0.isPrimaryDemo() }),
      primaryDemoNodeIndex != 0
    {
      let primaryDemoNode = childrenNodes[primaryDemoNodeIndex]
      childrenNodes.remove(at: primaryDemoNodeIndex)
      childrenNodes.insert(primaryDemoNode, at: 0)
    }

    node.children = childrenNodes

    componentDescription = childrenNodes.first?.exampleDescription() ?? ""

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
    self.tableView.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor
    self.tableView.separatorStyle = .none
    self.tableView.sectionHeaderHeight = UITableView.automaticDimension

    var charactersCount = 0
    charactersCount = node.title.count
    if charactersCount > 0 {
      self.tableView.accessibilityIdentifier = "Table" + node.title
    } else {
      self.tableView.accessibilityIdentifier = "DemoTableList"
    }

    self.tableView.register(
      NodeViewTableViewPrimaryDemoCell.self,
      forCellReuseIdentifier: "NodeViewTableViewPrimaryDemoCell")
    self.tableView.register(
      NodeViewTableViewDemoCell.self,
      forCellReuseIdentifier: "NodeViewTableViewDemoCell")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  @objc func themeDidChange(notification: NSNotification) {
    setNeedsStatusBarAppearanceUpdate()
    self.tableView.reloadData()
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

  override func tableView(
    _ tableView: UITableView,
    titleForHeaderInSection section: Int
  ) -> String? {
    return sectionNames[section]
  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    if indexPath.section == Section.description.rawValue {
      return demoButtonRowHeight
    }
    return additionalDemoRowHeight
  }

  override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int)
    -> CGFloat
  {
    if let mainSectionHeader = mainSectionHeader, section == Section.description.rawValue {
      let labelPreferredMaxLayoutWidth = tableView.frame.size.width - (2 * padding)
      mainSectionHeaderDescriptionLabel?.preferredMaxLayoutWidth = labelPreferredMaxLayoutWidth
      mainSectionHeaderTitleLabel?.preferredMaxLayoutWidth = labelPreferredMaxLayoutWidth
      let targetSize = CGSize(
        width: tableView.frame.size.width,
        height: estimadedDescriptionSectionHeight)
      return mainSectionHeader.systemLayoutSizeFitting(targetSize).height
    }
    return estimadedAdditionalExamplesSectionHeight
  }
  // swiftlint:disable function_body_length
  override func tableView(
    _ tableView: UITableView,
    viewForHeaderInSection section: Int
  ) -> UIView? {
    if section == 0 {
      return mainSectionHeader
    }
    return additionalExamplesSectionHeader
  }

  func createAdditionalExamplesSectionHeader() -> UIView {
    let sectionView = UIView()
    sectionView.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor
    let lineDivider = UIView()
    lineDivider.backgroundColor = UIColor(white: 0.85, alpha: 1)
    lineDivider.translatesAutoresizingMaskIntoConstraints = false

    let sectionTitleLabel = UILabel()
    sectionTitleLabel.font = MDCTypography.body2Font()
    sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    sectionTitleLabel.text = sectionNames[1]
    sectionTitleLabel.numberOfLines = 0
    sectionTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

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
      constant: 1
    ).isActive = true

    // Line divider to section view
    NSLayoutConstraint(
      item: sectionView,
      attribute: .leading,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: sectionView,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: sectionView,
      attribute: .top,
      relatedBy: .equal,
      toItem: lineDivider,
      attribute: .top,
      multiplier: 1.0,
      constant: 0
    ).isActive = true

    // Line divider to Title Label
    NSLayoutConstraint(
      item: lineDivider,
      attribute: .top,
      relatedBy: .equal,
      toItem: sectionTitleLabel,
      attribute: .top,
      multiplier: 1.0,
      constant: -padding
    ).isActive = true

    let preiOS11Behavior = {
      NSLayoutConstraint(
        item: sectionView,
        attribute: .leading,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .leading,
        multiplier: 1.0,
        constant: -self.padding
      ).isActive = true
      NSLayoutConstraint(
        item: sectionView,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .trailing,
        multiplier: 1.0,
        constant: self.padding
      ).isActive = true
    }
    // Title Label to Section View
    // Align to the safe area insets.
    sectionTitleLabel.leadingAnchor
      .constraint(
        equalTo: sectionView.safeAreaLayoutGuide.leadingAnchor,
        constant: padding
      ).isActive = true
    sectionTitleLabel.trailingAnchor
      .constraint(
        equalTo: sectionView.safeAreaLayoutGuide.trailingAnchor,
        constant: -padding
      ).isActive = true

    NSLayoutConstraint(
      item: sectionView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: sectionTitleLabel,
      attribute: .bottom,
      multiplier: 1.0,
      constant: padding
    ).isActive = true

    return sectionView
  }

  func MainSectionHeader() -> UIView {
    let sectionView = UIView()
    sectionView.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor

    let sectionTitleLabel = UILabel()
    sectionTitleLabel.font = MDCTypography.body2Font()
    sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    sectionTitleLabel.text = sectionNames[0]
    sectionTitleLabel.numberOfLines = 0
    sectionTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    mainSectionHeaderTitleLabel = sectionTitleLabel

    let descriptionLabel = UILabel()
    descriptionLabel.font = MDCTypography.body1Font()

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = descriptionLineHeight - descriptionLabel.font.lineHeight
    let attrs = [NSAttributedString.Key.paragraphStyle: paragraphStyle]

    descriptionLabel.attributedText =
      NSAttributedString(string: componentDescription, attributes: attrs)
    descriptionLabel.alpha = descriptionOpacity
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.numberOfLines = 0
    descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    mainSectionHeaderDescriptionLabel = descriptionLabel

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
        constant: -self.padding
      ).isActive = true
      NSLayoutConstraint(
        item: sectionView,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: sectionTitleLabel,
        attribute: .trailing,
        multiplier: 1.0,
        constant: self.padding
      ).isActive = true
    }
    // Align to the safe area insets.
    sectionTitleLabel.leadingAnchor
      .constraint(
        equalTo: sectionView.safeAreaLayoutGuide.leadingAnchor,
        constant: padding
      ).isActive = true
    sectionTitleLabel.trailingAnchor
      .constraint(
        equalTo: sectionView.safeAreaLayoutGuide.trailingAnchor,
        constant: -padding
      ).isActive = true

    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .lastBaseline,
      relatedBy: .equal,
      toItem: sectionView,
      attribute: .top,
      multiplier: 1.0,
      constant: titleMaxY
    ).isActive = true

    // descriptionLabel to sectionTitleLabel
    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .leading,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: sectionTitleLabel,
      attribute: .lastBaseline,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .firstBaseline,
      multiplier: 1.0,
      constant: -titleDescriptionMargin
    ).isActive = true

    // descriptionLabel to SectionView
    NSLayoutConstraint(
      item: sectionView,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: descriptionLabel,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 10
    ).isActive = true

    return sectionView
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == Section.description.rawValue {
      return 1
    }
    return node.children.count - 1
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    var cell: UITableViewCell?
    if indexPath.section == Section.description.rawValue {
      cell = tableView.dequeueReusableCell(withIdentifier: "NodeViewTableViewPrimaryDemoCell")
      cell?.selectionStyle = .none
      let primaryDemoCell = cell as! NodeViewTableViewPrimaryDemoCell
      let button = primaryDemoCell.containedButton
      button.applyContainedTheme(withScheme: AppTheme.containerScheme)
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
    cell?.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor
    return cell!
  }

  override func accessibilityPerformMagicTap() -> Bool {
    primaryDemoButtonClicked()
    return true
  }

  @objc func primaryDemoButtonClicked() {
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
      vc.title = node.title
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }

  func createViewController(from node: CBCNode) -> UIViewController {
    let contentVC = node.createExampleViewController()
    themeExample(vc: contentVC)
    self.navigationController?.setMenuBarButton(for: contentVC)
    return contentVC
  }

  func themeExample(vc: UIViewController) {
    let colorSel = NSSelectorFromString("setColorScheme:")
    if vc.responds(to: colorSel) {
      vc.perform(colorSel, with: AppTheme.containerScheme.colorScheme)
    }
    let typoSel = NSSelectorFromString("setTypographyScheme:")
    if vc.responds(to: typoSel) {
      vc.perform(typoSel, with: AppTheme.containerScheme.typographyScheme)
    }
    let containerSel = NSSelectorFromString("setContainerScheme:")
    if vc.responds(to: containerSel) {
      vc.perform(containerSel, with: AppTheme.containerScheme)
    }
  }
}
