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

class MDCDragonsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 50
    static let inset: CGFloat = 16
    static let logoTitleVerticalSpacing: CGFloat = 32
    static let logoWidthHeight: CGFloat = 40
    static let spacing: CGFloat = 1
  }
  
  static let colors: [UIColor] = [UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0),
                                  UIColor(red: 0.957, green: 0.263, blue: 0.212, alpha: 1.0),
                                  UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.0),
                                  UIColor(red: 1.0, green: 0.922, blue: 0.231, alpha: 1.0)]
  
  fileprivate lazy var headerViewController = MDCFlexibleHeaderViewController()
  
  private lazy var logo: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let node: CBCNode
  private lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()

  init(collectionViewLayout layout: UICollectionViewFlowLayout, node: CBCNode) {
    self.node = node
    
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
    headerViewController.headerView.maximumHeight = 100
    headerViewController.headerView.minimumHeight = 56
    
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
    
    let containerView = UIView(frame: headerViewController.headerView.bounds)
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    titleLabel.text = title!
    titleLabel.textColor = UIColor(white: 1, alpha: 1)
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    titleLabel.sizeToFit()

    let titleInsets = UIEdgeInsets(top: 0,
                                   left: Constants.inset,
                                   bottom: Constants.inset,
                                   right: Constants.inset)
    let titleSize = titleLabel.sizeThatFits(containerView.bounds.size)
    
    containerView.addSubview(titleLabel)
    constrainLabel(label: titleLabel,
                   containerView: containerView,
                   insets: titleInsets,
                   height: titleSize.height)
    
    headerViewController.headerView.addSubview(containerView)
    headerViewController.headerView.forwardTouchEvents(for: containerView)
    
    headerViewController.headerView.addSubview(logo)
    let image = MDCDrawDragons.image(with: MDCDrawDragons.drawDragon,
                                     size: CGSize(width: Constants.logoWidthHeight,
                                                  height: Constants.logoWidthHeight),
                                     fillColor: .white)
    logo.image = image
    constrainLogo(logo: logo,
                  label: titleLabel)
    
    headerViewController.headerView.backgroundColor = MDCDragonsController.colors[2]
    headerViewController.headerView.trackingScrollView = collectionView
    view.addSubview(headerViewController.view)
    headerViewController.didMove(toParentViewController: self)
    
    if #available(iOS 11.0, *) {
      collectionView?.contentInsetAdjustmentBehavior = .always
    }
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
  
  @available(iOS 11, *)
  override func viewSafeAreaInsetsDidChange() {
    // Re-constraint the title label to account for changes in safeAreaInsets's left and right.
    let titleInsets = UIEdgeInsets(top: 0,
                                   left: Constants.inset + view.safeAreaInsets.left,
                                   bottom: Constants.inset,
                                   right: Constants.inset + view.safeAreaInsets.right)
    titleLabel.superview!.removeConstraints(titleLabel.superview!.constraints)
    constrainLabel(label: titleLabel,
                   containerView: titleLabel.superview!,
                   insets: titleInsets,
                   height: titleLabel.bounds.height)
  }
  
  // MARK: UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return 100//node.children.count
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "MDCDragonCollectionViewCell",
                                         for: indexPath)
    cell.backgroundColor = UIColor.white
    
    let componentName = node.children[0].title
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
    cellWidthHeight = 100
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
    let node = self.node.children[0]
    var vc: UIViewController
    vc = node.createExampleViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: Private
  func constrainLogo(logo: UIImageView,
                     label: UILabel) {
    
    NSLayoutConstraint(item: logo,
                       attribute: .bottom,
                       relatedBy: .equal,
                       toItem: label,
                       attribute: .top,
                       multiplier: 1,
                       constant: -1 * Constants.logoTitleVerticalSpacing).isActive = true
    NSLayoutConstraint(item: logo,
                       attribute: .leading,
                       relatedBy: .equal,
                       toItem: label,
                       attribute: .leading,
                       multiplier: 1,
                       constant: 0).isActive = true
    
    NSLayoutConstraint(item: logo,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: logo,
                       attribute: .height,
                       multiplier: 1,
                       constant: 0).isActive = true
    NSLayoutConstraint(item: logo,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: nil,
                       attribute: .notAnAttribute,
                       multiplier: 1,
                       constant: Constants.logoWidthHeight).isActive = true
    
  }
  
  func constrainLabel(label: UILabel,
                      containerView: UIView,
                      insets: UIEdgeInsets,
                      height: CGFloat) {
    
    NSLayoutConstraint(item: label,
                       attribute: .leading,
                       relatedBy: .equal,
                       toItem: containerView,
                       attribute: .leading,
                       multiplier: 1.0,
                       constant: insets.left).isActive = true
    
    NSLayoutConstraint(item: label,
                       attribute: .trailing,
                       relatedBy: .equal,
                       toItem: containerView,
                       attribute: .trailing,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    
    NSLayoutConstraint(item: label,
                       attribute: .bottom,
                       relatedBy: .equal,
                       toItem: containerView,
                       attribute: .bottom,
                       multiplier: 1.0,
                       constant: -insets.bottom).isActive = true
    
    NSLayoutConstraint(item: label,
                       attribute: .height,
                       relatedBy: .equal,
                       toItem: nil,
                       attribute: .notAnAttribute,
                       multiplier: 1.0,
                       constant: height).isActive = true
  }
  
  func adjustLogoForScrollView(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let inset = scrollView.contentInset.top
    let relativeOffset = inset + offset
    
    logo.alpha = 1 - (relativeOffset / Constants.headerScrollThreshold)
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

