// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

import MDFTextAccessibility
import MaterialComponents.MaterialIcons_ic_check
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialThemes
import MaterialComponentsBeta.MaterialContainerScheme
import MaterialComponents.MaterialList
import UIKit

private func schemeWithPalette(_ palette: MDCPalette) -> MDCContainerScheming {
  let containerScheme = DefaultContainerScheme()

  let scheme = MDCSemanticColorScheme()
  scheme.primaryColor = palette.tint500
  scheme.primaryColorVariant = palette.tint900
  scheme.secondaryColor = scheme.primaryColor
  if let onPrimaryColor = MDFTextAccessibility.textColor(fromChoices: [MDCPalette.grey.tint100,
                                                                       MDCPalette.grey.tint900,
                                                                       UIColor.black,
                                                                       UIColor.white],
                                                         onBackgroundColor: scheme.primaryColor,
                                                         options: .preferLighter) {
    scheme.onPrimaryColor = onPrimaryColor
  }
  if let onSecondaryColor = MDFTextAccessibility.textColor(fromChoices: [MDCPalette.grey.tint100,
                                                                         MDCPalette.grey.tint900,
                                                                         UIColor.black,
                                                                         UIColor.white],
                                                           onBackgroundColor: scheme.secondaryColor,
                                                           options: .preferLighter) {
    scheme.onSecondaryColor = onSecondaryColor
  }
  containerScheme.colorScheme = scheme

  return containerScheme
}

private struct MDCColorThemeCellConfiguration {
  let name: String
  let mainColor: UIColor
  let scheme: MDCContainerScheming

  init(name: String, mainColor: UIColor, scheme: MDCContainerScheming) {
    self.name = name
    self.mainColor = mainColor
    self.scheme = scheme
  }
}

class MDCThemePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let titleColor = AppTheme.globalTheme.colorScheme.onSurfaceColor.withAlphaComponent(0.5)
  let titleFont = AppTheme.globalTheme.typographyScheme.button

  private let tableView = UITableView()

  private let cellReuseIdentifier = "cell"
  private let cellHeight: CGFloat = 48 // Minimum touch target

  private let properties: [String] = [
    "primaryColor",
    "primaryColorVariant",
    "secondaryColor",
    "errorColor",
    "surfaceColor",
    "backgroundColor",
    "onPrimaryColor",
    "onSecondaryColor",
    "onSurfaceColor",
    "onBackgroundColor",
    ]


  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Material Color scheme picker"

    view.backgroundColor = AppTheme.globalTheme.colorScheme.backgroundColor
    tableView.register(SchemeCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorColor = .clear
    view.addSubview(tableView)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    positionTableView()
  }

  func positionTableView() {
    var originX = view.bounds.origin.x
    var width = view.bounds.size.width
    var height = view.bounds.size.height
    if #available(iOS 11.0, *) {
      originX += view.safeAreaInsets.left;
      width -= (view.safeAreaInsets.left + view.safeAreaInsets.right);
      height -= (view.safeAreaInsets.top + view.safeAreaInsets.bottom);
    }
    let frame = CGRect(x: originX, y: view.bounds.origin.y, width: width, height: height)
    tableView.frame = frame
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return properties.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SchemeCell =
      tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? SchemeCell ??
        SchemeCell(frame: .zero)
    cell.title = properties[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showDialog(for: indexPath.row)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }

  private func showDialog(for propertyIndex: Int) {
    print("Change \(properties[propertyIndex])")
  }

}

class SchemeCell : UITableViewCell {

  public var title: String {
    willSet {
      set(title: newValue)
    }
  }

  private let label = UILabel()

  lazy var leadingConstraint = NSLayoutConstraint(item: self.label,
                                             attribute: .leading,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .leading,
                                             multiplier: 1,
                                             constant: 16)

  lazy var trailingContraint = NSLayoutConstraint(item: self.label,
                                                  attribute: .trailing,
                                                  relatedBy: .equal,
                                                  toItem: self.contentView,
                                                  attribute: .trailing,
                                                  multiplier: 1,
                                                  constant: -16)

  lazy var topContraint = NSLayoutConstraint(item: self.label,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: 0)

  lazy var bottomContraint = NSLayoutConstraint(item: self.label,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: 0)


  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    title = ""
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    self.accessibilityHint = "Changes the catalog color scheme."
    self.accessibilityLabel = title
    self.contentView.addSubview(label)
    self.label.translatesAutoresizingMaskIntoConstraints = false
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    leadingConstraint.isActive = true
    trailingContraint.isActive = true
    topContraint.isActive = true
    bottomContraint.isActive = true
  }

  private func set(title newTitle: String) {
    label.text = newTitle
    self.accessibilityLabel = newTitle
  }
}

class ColorSchemeDialog : UIViewController {
  
}
