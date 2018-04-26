/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialThemes
import UIKit

private func createSchemeWithPalette(_ palette: MDCPalette) -> MDCSemanticColorScheme {
  let scheme = MDCSemanticColorScheme()
  scheme.primaryColor = palette.tint500
  scheme.primaryColorVariant = palette.tint900
  scheme.secondaryColor = scheme.primaryColor
  return scheme
}

class MDCThemePickerViewController: UIViewController, UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  let paletteTitle = UILabel()
  let palettesCollectionView = UICollectionView(frame: .zero,
                                                collectionViewLayout: UICollectionViewFlowLayout())
  let titleColor = AppTheme.globalTheme.colorScheme.onSurfaceColor.withAlphaComponent(0.5)
  let titleFont = AppTheme.globalTheme.typographyScheme.button
  private let cellReuseIdentifier = "cell"
  private let colorSchemeCells = [
    (
      mainColor: AppTheme.defaultTheme.colorScheme.primaryColor,
      colorScheme: { return AppTheme.defaultTheme.colorScheme }
    ),
    (
      mainColor: MDCPalette.blue.tint500,
      colorScheme: { return createSchemeWithPalette(MDCPalette.blue) }
    ),
    (
      mainColor: MDCPalette.red.tint500,
      colorScheme: { return createSchemeWithPalette(MDCPalette.red) }
    ),
    (
      mainColor: MDCPalette.green.tint500,
      colorScheme: { return createSchemeWithPalette(MDCPalette.green) }
    ),
    (
      mainColor: MDCPalette.amber.tint500,
      colorScheme: { return createSchemeWithPalette(MDCPalette.amber) }
    ),
    (
      mainColor: MDCPalette.pink.tint500,
      colorScheme: { return createSchemeWithPalette(MDCPalette.pink) }
    ),
    (
      mainColor: MDCPalette.orange.tint500,
      colorScheme: { return createSchemeWithPalette(MDCPalette.orange) }
    )
  ]
  private let cellSize : CGFloat = 33.0
  private let cellSpacing : CGFloat = 8.0

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    paletteTitle.text = "Material Palette"
    paletteTitle.font = titleFont
    paletteTitle.textColor = titleColor
    paletteTitle.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(paletteTitle)
    view.addConstraint(NSLayoutConstraint(item: paletteTitle,
                                          attribute: .bottom,
                                          relatedBy: .equal,
                                          toItem: self.view,
                                          attribute: .top,
                                          multiplier: 1.0,
                                          constant: 36))
    view.addConstraint(NSLayoutConstraint(item: paletteTitle,
                                          attribute: .left,
                                          relatedBy: .equal,
                                          toItem: self.view,
                                          attribute: .left,
                                          multiplier: 1.0,
                                          constant: 16))

    palettesCollectionView.register(PaletteCell.self,
                                    forCellWithReuseIdentifier: cellReuseIdentifier)
    palettesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    palettesCollectionView.delegate = self
    palettesCollectionView.dataSource = self
    palettesCollectionView.backgroundColor = .white
    palettesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    view.addSubview(palettesCollectionView)
    view.addConstraint(NSLayoutConstraint(item: palettesCollectionView,
                                          attribute: .left,
                                          relatedBy: .equal,
                                          toItem: self.view,
                                          attribute: .left,
                                          multiplier: 1,
                                          constant: 0))
    view.addConstraint(NSLayoutConstraint(item: palettesCollectionView,
                                          attribute: .right,
                                          relatedBy: .equal,
                                          toItem: self.view,
                                          attribute: .right,
                                          multiplier: 1,
                                          constant: 0))
    view.addConstraint(NSLayoutConstraint(item: palettesCollectionView,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: self.paletteTitle,
                                          attribute: .bottom,
                                          multiplier: 1,
                                          constant: 10))
    view.addConstraint(NSLayoutConstraint(item: palettesCollectionView,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .notAnAttribute,
                                          multiplier: 1,
                                          constant: cellSize + (cellSpacing * 2)))
    view.backgroundColor = .white
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier,
                                                  for: indexPath) as! PaletteCell
    cell.contentView.backgroundColor = colorSchemeCells[indexPath.item].mainColor
    cell.contentView.layer.cornerRadius = cellSize / 2
    cell.contentView.layer.borderWidth = 1
    cell.contentView.layer.borderColor =
      AppTheme.globalTheme.colorScheme.onSurfaceColor.withAlphaComponent(0.05).cgColor
    if AppTheme.globalTheme.colorScheme.primaryColor
      == colorSchemeCells[indexPath.item].mainColor {
      cell.imageView.isHidden = false
    } else {
      cell.imageView.isHidden = true
    }
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
    return colorSchemeCells.count
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let colorScheme = colorSchemeCells[indexPath.item].colorScheme
    navigationController?.popViewController(animated: true)
    AppTheme.globalTheme = AppTheme(colorScheme: colorScheme(),
                                    typographyScheme: AppTheme.globalTheme.typographyScheme)
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
