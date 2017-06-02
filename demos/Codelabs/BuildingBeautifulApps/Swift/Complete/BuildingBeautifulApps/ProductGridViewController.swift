/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

final class ProductGridViewController : MDCCollectionViewController {

  var isHome = false
  var products = [Product]()
  let appBar = MDCAppBar()

  @IBOutlet weak var headerContentView: HomeHeaderView?
  @IBOutlet weak var shrineLogo: UIImageView?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.contentInset = UIEdgeInsetsMake(0, 0, self.tabBarController!.tabBar.bounds.size.height, 0)

    addChildViewController(appBar.headerViewController)
    appBar.addSubviewsToParent()
    appBar.headerViewController.headerView.trackingScrollView = collectionView
    appBar.headerViewController.headerView.backgroundColor = .white
    appBar.headerViewController.headerView.maximumHeight = 440
    appBar.headerViewController.headerView.minimumHeight = 72

    if isHome {
      setupHeaderContentView()
      setupHeaderLogo()
    }

    title = tabBarItem.title

    styler.cellStyle = .card
    styler.cellLayoutType = .grid
    styler.gridPadding = 8

    updateLayout()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateLayout()
  }

  // MARK: Rotation and Screen size
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    updateLayout()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    updateLayout()
  }

  func updateLayout() {
    sizeHeaderView()

    if UIDevice.current.userInterfaceIdiom == .pad {
      styler.gridColumnCount = 5
    } else {
      switch traitCollection.horizontalSizeClass {
      case .compact:
        styler.gridColumnCount = 2
      case .unspecified:
        fallthrough
      case .regular:
        styler.gridColumnCount = 4
      }
    }

    collectionView?.collectionViewLayout.invalidateLayout()
  }

  // MARK: Header
  func setupHeaderContentView() {
    appBar.headerViewController.headerView.addSubview(headerContentView!)
    headerContentView?.frame = appBar.headerViewController.headerView.frame
    headerContentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  func sizeHeaderView() {
    let headerView = appBar.headerViewController.headerView
    let bounds = UIScreen.main.bounds

    if isHome && bounds.size.width < bounds.size.height {
      headerView.maximumHeight = 440
    } else {
      headerView.maximumHeight = 72
    }
    headerView.minimumHeight = 72
  }

  func setupHeaderLogo() {
    guard let logo = shrineLogo else { return }
    appBar.headerViewController.headerView.addSubview(logo)
    logo.topAnchor.constraint(equalTo: logo.superview!.topAnchor, constant: 24).isActive = true
    logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logo.translatesAutoresizingMaskIntoConstraints = false
    logo.alpha = 0;
  }

  // MARK: Target / Action
  func favoriteButtonDidTouch(_ sender: UIButton) {
    let product = self.products[sender.tag]
    product.isFavorite = !product.isFavorite
    collectionView?.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])

    if product.isFavorite {
      MDCSnackbarManager.show(MDCSnackbarMessage(text: "Added to Favorites!"))
    }
  }
}

// MARK: UIScrollViewDelegate

extension ProductGridViewController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    appBar.headerViewController.scrollViewDidScroll(scrollView)
    let scrollOffsetY = scrollView.contentOffset.y
    var opacity: CGFloat = 1.0
    var logoOpacity: CGFloat = 0.0

    if scrollOffsetY > -240 {
      opacity = 0.0
      logoOpacity = 1.0
    }

    UIView.animate(withDuration: 0.2, animations: {
      self.headerContentView?.backgroundImage?.alpha = opacity
      self.headerContentView?.descLabel?.alpha = opacity
      self.headerContentView?.titleLabel?.alpha = opacity

      self.shrineLogo?.alpha = logoOpacity
    })
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == appBar.headerViewController.headerView.trackingScrollView {
      appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = appBar.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
  }
}

// MARK: Collection View delegate
extension ProductGridViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCollectionViewCell else {
      return UICollectionViewCell(frame: .zero)
    }

    let product = self.products[indexPath.item]
    cell.set(product: product)

    cell.favoriteButton?.tag = indexPath.item
    if !cell.favoriteButton!.allTargets.contains(self) {
      cell.favoriteButton?.addTarget(self, action: #selector(favoriteButtonDidTouch(_:)), for: .touchUpInside)
    }

    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, cellHeightAt indexPath: IndexPath) -> CGFloat {
    let base = (collectionView.bounds.size.width - CGFloat((styler.gridColumnCount + 1) * styler.gridColumnCount))
    let adjustment = CGFloat(5.0/4.0) / CGFloat(styler.gridColumnCount)
    let height = base * adjustment
    return height
  }
}

