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

import CatalogByConvention
import MaterialCatalog

import MaterialComponents.MaterialIcons_ic_arrow_back
import MaterialComponents.MaterialInk
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography

import UIKit

private let inset: CGFloat = 16
private let logoWidthHeight: CGFloat = 30
private let spacing: CGFloat = 1

class MDCCatalogComponentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MDCInkTouchControllerDelegate {

  private let node: CBCNode

  private lazy var inkController: MDCInkTouchController = {
    let controller = MDCInkTouchController(view: self.collectionView!)
    controller.delaysInkSpread = true
    controller.delegate = self
    return controller
  }()

  @objc func themeDidChange(notification: NSNotification) {
    collectionView?.collectionViewLayout.invalidateLayout()
    collectionView?.reloadData()
  }

  init(node: CBCNode) {
    self.node = node

    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: spacing,
                                       left: spacing,
                                       bottom: spacing,
                                       right: spacing)
    layout.minimumInteritemSpacing = spacing
    layout.minimumLineSpacing = spacing

    super.init(collectionViewLayout: layout)

    self.title = "Material Components for iOS"

    collectionView?.register(MDCCatalogCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView?.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor

    let logo = MDCDrawImage(CGRect(x:0, y:0, width: logoWidthHeight, height: logoWidthHeight), {
      MDCCatalogDrawMDCLogoLight($0, $1)
    }, AppTheme.containerScheme.colorScheme)
    let logoImageView = UIImageView(image: logo)
    let logoItem = UIBarButtonItem(customView: logoImageView)
    logoItem.isEnabled = false
    navigationItem.leftBarButtonItem = logoItem

    navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .action,
                      target: self.navigationController,
                      action: #selector(navigationController?.presentMenu))

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.themeDidChange),
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    inkController.addInkView()

    collectionView?.accessibilityIdentifier = "collectionView"
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let dividerWidth: CGFloat = 1
    var safeInsets: CGFloat = 0
    if #available(iOS 11, *) {
      safeInsets = view.safeAreaInsets.left + view.safeAreaInsets.right
    }
    var cellWidthHeight: CGFloat

    // iPhones have 2 columns in portrait and 3 in landscape
    if UI_USER_INTERFACE_IDIOM() == .phone {
      cellWidthHeight = (view.frame.size.width - 3 * dividerWidth - safeInsets) / 2
      if view.frame.size.width > view.frame.size.height {
        cellWidthHeight = (view.frame.size.width - 4 * dividerWidth - safeInsets) / 3
      }
    } else {
      // iPads have 4 columns
      cellWidthHeight = (view.frame.size.width - 5 * dividerWidth - safeInsets) / 4
    }
    layout.itemSize = CGSize(width: cellWidthHeight, height: cellWidthHeight)
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return node.children.count
  }

  func inkViewForView(_ view: UIView) -> MDCInkView {
    let foundInkView = MDCInkView.injectedInkView(for: view)
    foundInkView.inkStyle = .bounded
    foundInkView.inkColor = UIColor(white:0.957, alpha: 0.2)
    return foundInkView
  }

  // MARK: MDCInkTouchControllerDelegate

  func inkTouchController(_ inkTouchController: MDCInkTouchController,
                          shouldProcessInkTouchesAtTouchLocation location: CGPoint) -> Bool {
    return self.collectionView!.indexPathForItem(at: location) != nil
  }

  func inkTouchController(_ inkTouchController: MDCInkTouchController,
                          inkViewAtTouchLocation location: CGPoint) -> MDCInkView? {
    if let indexPath = self.collectionView!.indexPathForItem(at: location) {
      let cell = self.collectionView!.cellForItem(at: indexPath)
      return inkViewForView(cell!)
    }
    return MDCInkView()
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                           for: indexPath)
    cell.backgroundColor = AppTheme.containerScheme.colorScheme.backgroundColor

    let componentName = node.children[indexPath.row].title
    if let catalogCell = cell as? MDCCatalogCollectionViewCell {
      catalogCell.populateView(componentName)
    }

    // Ensure that ink animations aren't recycled.
    MDCInkView.injectedInkView(for: view).cancelAllAnimations(animated: false)

    return cell
  }

  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if node.isExample() {
      vc = node.createExampleViewController()
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.setMenuBarButton(for: vc)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
