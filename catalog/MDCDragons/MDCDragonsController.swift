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

import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialIcons_ic_arrow_back
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography

import UIKit

class MDCDragonsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 50
    static let inset: CGFloat = 16
    static let logoTitleVerticalSpacing: CGFloat = 32
    static let logoWidthHeight: CGFloat = 40
    static let spacing: CGFloat = 1
  }
  
  private let node: CBCNode
  
  static let colors: [UIColor] = [UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0),
                                  UIColor(red: 0.957, green: 0.263, blue: 0.212, alpha: 1.0),
                                  UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.0),
                                  UIColor(red: 1.0, green: 0.922, blue: 0.231, alpha: 1.0)]
  
  fileprivate lazy var headerViewController = MDCFlexibleHeaderViewController()
  var headerView: HeaderView!
  var searched: [CBCNode] = []
  
  init(collectionViewLayout layout: UICollectionViewFlowLayout, node: CBCNode) {
    self.node = node
    searched = node.children
    let sectionInset: CGFloat = 10
    layout.sectionInset = UIEdgeInsets(top: 10,
                                       left: 5,
                                       bottom: 10,
                                       right: 5)
    layout.minimumInteritemSpacing = sectionInset
    layout.minimumLineSpacing = sectionInset
    
    super.init(collectionViewLayout: layout)
    title = "Material Dragons"
    addChildViewController(headerViewController)
    headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    headerViewController.headerView.maximumHeight = 113
    headerViewController.headerView.minimumHeight = 53
    
    collectionView?.register(MDCDragonsCollectionViewCell.self,
                             forCellWithReuseIdentifier: "MDCDragonCollectionViewCell")
    collectionView?.backgroundColor = UIColor(white: 0.97, alpha: 1)
  }
  
  convenience init(node: CBCNode) {
    self.init(collectionViewLayout: UICollectionViewFlowLayout(), node: node)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHeaderView()
    let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapgesture.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapgesture)
    
    if #available(iOS 11.0, *) {
      collectionView?.contentInsetAdjustmentBehavior = .always
    }
  }
  
  func setupHeaderView() {
    headerView = HeaderView(frame: headerViewController.headerView.bounds)
    headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    headerView.title.text = title!
    headerView.searchBar.delegate = self
    
    headerViewController.headerView.addSubview(headerView)
    headerViewController.headerView.forwardTouchEvents(for: headerView)
    headerViewController.headerView.backgroundColor = MDCDragonsController.colors[2]
    headerViewController.headerView.trackingScrollView = collectionView
    view.addSubview(headerViewController.view)
    headerViewController.didMove(toParentViewController: self)
  }
  
  func adjustLogoForScrollView(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let inset = scrollView.contentInset.top
    let relativeOffset = inset + offset
    
    headerView.imageView.alpha = 1 - (relativeOffset / Constants.headerScrollThreshold)
    headerView.title.alpha = 1 - (relativeOffset / Constants.headerScrollThreshold)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView?.collectionViewLayout.invalidateLayout()
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func willAnimateRotation(
    to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    collectionView?.collectionViewLayout.invalidateLayout()
  }
  
  override var childViewControllerForStatusBarStyle: UIViewController? {
    return headerViewController
  }
  
  override var childViewControllerForStatusBarHidden: UIViewController? {
    return headerViewController
  }
  
  // MARK: UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return searched.count
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "MDCDragonCollectionViewCell",
                                         for: indexPath)
    cell.backgroundColor = UIColor.white
    
    let componentName = searched[indexPath.item].title
    if let catalogCell = cell as? MDCDragonsCollectionViewCell {
      catalogCell.populateView(componentName,
                               color: MDCDragonsController.colors[indexPath.item % MDCDragonsController.colors.count])
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let dividerWidth: CGFloat = 10
    var safeInsets: CGFloat = 0
    if #available(iOS 11, *) {
      safeInsets = view.safeAreaInsets.left + view.safeAreaInsets.right
    }
    var cellWidthHeight: CGFloat
    // iPhones have 3 columns in portrait and 4 in landscape
    if UI_USER_INTERFACE_IDIOM() == .phone {
      cellWidthHeight = (view.frame.size.width - 4 * dividerWidth - safeInsets) / 3
      if view.frame.size.width > view.frame.size.height {
        cellWidthHeight = (view.frame.size.width - 5 * dividerWidth - safeInsets) / 4
      }
    } else {
      // iPads have 5 columns
      cellWidthHeight = (view.frame.size.width - 6 * dividerWidth - safeInsets) / 5
    }
    return CGSize(width: cellWidthHeight, height: cellWidthHeight)
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let node = searched[indexPath.item]
    var vc: UIViewController
    vc = node.createExampleViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

// UIScrollViewDelegate
extension MDCDragonsController {
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidScroll()
      self.adjustLogoForScrollView(scrollView)
    }
  }
  
  override func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity,
                                               targetContentOffset: targetContentOffset)
    }
  }

}

// UISearchBarDelegate
extension MDCDragonsController {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      searched = node.children
    } else {
      searched = node.children.filter ({ (node) -> Bool in
        return node.title.range(of: searchText, options: .caseInsensitive) != nil
      })
    }
    self.collectionView?.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searched = node.children
    self.collectionView?.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }

  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
}

