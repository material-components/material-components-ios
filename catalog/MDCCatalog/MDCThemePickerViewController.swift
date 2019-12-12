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
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialIcons_ic_check
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialThemes
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

class MDCThemePickerViewController: UIViewController, UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  let palettesCollectionView = UICollectionView(frame: .zero,
                                                collectionViewLayout: UICollectionViewFlowLayout())

  private var collectionViewLayout: UICollectionViewFlowLayout {
    return palettesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
  }

  let titleColor = AppTheme.containerScheme.colorScheme.onSurfaceColor.withAlphaComponent(0.5)
  let titleFont = AppTheme.containerScheme.typographyScheme.button
  private let cellReuseIdentifier = "cell"
  private let colorSchemeConfigurations = [
    MDCColorThemeCellConfiguration(name: "Default",
                                   mainColor: AppTheme.containerScheme.colorScheme.primaryColor,
                                   scheme: DefaultContainerScheme()),
    MDCColorThemeCellConfiguration(name: "Blue",
                                   mainColor: MDCPalette.blue.tint500,
                                   scheme: schemeWithPalette(MDCPalette.blue)),
    MDCColorThemeCellConfiguration(name: "Red",
                                   mainColor: MDCPalette.red.tint500,
                                   scheme: schemeWithPalette(MDCPalette.red)),
    MDCColorThemeCellConfiguration(name: "Green",
                                   mainColor: MDCPalette.green.tint500,
                                   scheme: schemeWithPalette(MDCPalette.green)),
    MDCColorThemeCellConfiguration(name: "Amber",
                                   mainColor: MDCPalette.amber.tint500,
                                   scheme: schemeWithPalette(MDCPalette.amber)),
    MDCColorThemeCellConfiguration(name: "Pink",
                                   mainColor: MDCPalette.pink.tint500,
                                   scheme: schemeWithPalette(MDCPalette.pink)),
    MDCColorThemeCellConfiguration(name: "Orange",
                                   mainColor: MDCPalette.orange.tint500,
                                   scheme: schemeWithPalette(MDCPalette.orange)),
  ]
  private let cellSize : CGFloat = 48.0 // minimum touch target
  private let cellSpacing : CGFloat = 8.0

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Material Palette-based themes"
    view.backgroundColor = .white
    setUpCollectionView()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    positionCollectionView()
  }

  func setUpCollectionView() {
    palettesCollectionView.register(PaletteCell.self,
                                    forCellWithReuseIdentifier: cellReuseIdentifier)
    palettesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    palettesCollectionView.delegate = self
    palettesCollectionView.dataSource = self
    palettesCollectionView.backgroundColor = .white
    view.addSubview(palettesCollectionView)
  }

  func positionCollectionView() {
    var originX = view.bounds.origin.x
    var width = view.bounds.size.width
    var height = view.bounds.size.height
    if #available(iOS 11.0, *) {
      originX += view.safeAreaInsets.left;
      width -= (view.safeAreaInsets.left + view.safeAreaInsets.right);
      height -= (view.safeAreaInsets.top + view.safeAreaInsets.bottom);
    }
    let frame = CGRect(x: originX, y: view.bounds.origin.y, width: width, height: height)
    palettesCollectionView.frame = frame
    palettesCollectionView.collectionViewLayout.invalidateLayout()
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier,
                                                  for: indexPath) as! PaletteCell
    cell.contentView.backgroundColor = colorSchemeConfigurations[indexPath.item].mainColor
    cell.contentView.layer.cornerRadius = cellSize / 2
    cell.contentView.layer.borderWidth = 1
    cell.contentView.layer.borderColor =
      AppTheme.containerScheme.colorScheme.onSurfaceColor.withAlphaComponent(0.05).cgColor
    if AppTheme.containerScheme.colorScheme.primaryColor
      == colorSchemeConfigurations[indexPath.item].mainColor {
      cell.imageView.isHidden = false
      cell.isSelected = true
    } else {
      cell.imageView.isHidden = true
      cell.isSelected = false
    }
    cell.isAccessibilityElement = true
    cell.accessibilityLabel = colorSchemeConfigurations[indexPath.row].name
    cell.accessibilityHint = "Changes the catalog color theme."
    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: cellSize, height: cellSize)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: cellSpacing,
                        left: cellSpacing,
                        bottom: cellSpacing,
                        right: cellSpacing)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return cellSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return cellSpacing
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return colorSchemeConfigurations.count
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    navigationController?.popViewController(animated: true)
    let scheme = colorSchemeConfigurations[indexPath.item].scheme
    AppTheme.containerScheme = scheme
  }

}

class PaletteCell : UICollectionViewCell {
  let imageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    imageView.image = MDCIcons.imageFor_ic_check()?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .white
    imageView.contentMode = .center
    self.contentView.addSubview(imageView)
  }

  override func layoutSubviews() {
    imageView.frame = self.contentView.frame
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
