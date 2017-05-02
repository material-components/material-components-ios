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
import MaterialComponents.MaterialInk
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialTypography

import UIKit

class MDCCatalogComponentsController: UICollectionViewController, MDCInkTouchControllerDelegate {

  let spacing = CGFloat(1)
  let inset = CGFloat(16)
  let node: CBCNode
  var headerViewController: MDCFlexibleHeaderViewController
  let imageNames = NSMutableArray()

  private lazy var inkController: MDCInkTouchController = {
    let controller = MDCInkTouchController(view: self.collectionView!)
    controller.delaysInkSpread = true
    controller.delegate = self

    return controller
  }()

  init(collectionViewLayout ignoredLayout: UICollectionViewLayout, node: CBCNode) {
    self.node = node

    let layout = UICollectionViewFlowLayout()
    let sectionInset: CGFloat = spacing
    layout.sectionInset = UIEdgeInsets(top: sectionInset,
                                       left: sectionInset,
                                       bottom: sectionInset,
                                       right: sectionInset)
    layout.minimumInteritemSpacing = spacing
    layout.minimumLineSpacing = spacing

    self.headerViewController = MDCFlexibleHeaderViewController()

    super.init(collectionViewLayout: layout)

    self.title = "Material Design Components"

    self.addChildViewController(self.headerViewController)

    self.headerViewController.headerView.maximumHeight = 128
    self.headerViewController.headerView.minimumHeight = 72

    self.collectionView?.register(MDCCatalogCollectionViewCell.self,
      forCellWithReuseIdentifier: "MDCCatalogCollectionViewCell")
    self.collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)

    MDCIcons.ic_arrow_backUseNewStyle(true)
  }

  convenience init(node: CBCNode) {
    self.init(collectionViewLayout: UICollectionViewLayout(), node: node)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    inkController.addInkView()

    let containerView = UIView(frame: self.headerViewController.headerView.bounds)
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    let titleLabel = UILabel()
    titleLabel.text = self.title!.uppercased()
    titleLabel.textColor = UIColor.white
    titleLabel.font = MDCTypography.titleFont()
    titleLabel.sizeToFit()
    if inset + titleLabel.frame.size.width > containerView.frame.size.width {
      titleLabel.font = MDCTypography.body2Font()
    }

    let titleInsets = UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
    let titleSize = titleLabel.sizeThatFits(containerView.bounds.size)
    titleLabel.frame = CGRect(
      x: titleInsets.left,
      y: containerView.bounds.size.height - titleSize.height - titleInsets.bottom,
      width: containerView.bounds.size.width,
      height: titleSize.height)
    titleLabel.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    containerView.addSubview(titleLabel)
    constrainLabel(label: titleLabel,
                   containerView: containerView,
                   insets: titleInsets,
                   height: titleSize.height)

    self.headerViewController.headerView.addSubview(containerView)
    self.headerViewController.headerView.forwardTouchEvents(for: containerView)

    self.headerViewController.headerView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    self.headerViewController.headerView.trackingScrollView = self.collectionView

    self.headerViewController.headerView.setShadowLayer(MDCShadowLayer()) { (layer, intensity) in
      let shadowLayer = layer as? MDCShadowLayer
      shadowLayer!.elevation = intensity * MDCShadowElevationAppBar
    }

    self.view.addSubview(self.headerViewController.view)
    self.headerViewController.didMove(toParentViewController: self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.collectionView?.collectionViewLayout.invalidateLayout()
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func willAnimateRotation(
    to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    self.collectionView?.collectionViewLayout.invalidateLayout()
  }

  override var childViewControllerForStatusBarStyle: UIViewController? {
    return self.headerViewController
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
    let foundInkView = MDCInkTouchController.injectedInkView(for: view)
    foundInkView.inkStyle = .unbounded
    foundInkView.inkColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.2)
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
      return self.inkViewForView(cell!)
    }
    return MDCInkView()
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "MDCCatalogCollectionViewCell",
                                           for: indexPath)
    cell.backgroundColor = UIColor.white

    let componentName = self.node.children[indexPath.row].title
    if let catalogCell = cell as? MDCCatalogCollectionViewCell {
      catalogCell.populateView(componentName)
    }

    // Ensure that ink animations aren't recycled.
    MDCInkTouchController.injectedInkView(for: view).cancelAllAnimations(animated: false)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    let pad = CGFloat(1)
    var cellWidth = (self.view.frame.size.width - 3 * pad) / 2
    if self.view.frame.size.width > self.view.frame.size.height {
      cellWidth = (self.view.frame.size.width - 4 * pad) / 3
    }
    return CGSize(width: cellWidth, height: cellWidth * 0.825)
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
    self.navigationController?.pushViewController(vc, animated: true)
  }

  // MARK: Private
  func constrainLabel(label: UILabel,
                      containerView: UIView,
                      insets: UIEdgeInsets,
                      height: CGFloat) {
    _ = NSLayoutConstraint(
      item: label,
      attribute: .leading,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .leading,
      multiplier: 1.0,
      constant: insets.left).isActive = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0).isActive = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: containerView,
      attribute: .bottom,
      multiplier: 1.0,
      constant: -insets.bottom).isActive = true

    _ = NSLayoutConstraint(
      item: label,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: height).isActive = true
  }
}

// UIScrollViewDelegate
extension MDCCatalogComponentsController {

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == self.headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidScroll()
    }
  }

  override func scrollViewDidEndDragging(
      _ scrollView: UIScrollView,
      willDecelerate decelerate: Bool) {
    let headerView = self.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == self.headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  override func scrollViewWillEndDragging(
      _ scrollView: UIScrollView,
      withVelocity velocity: CGPoint,
      targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = self.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(
        withVelocity: velocity,
        targetContentOffset: targetContentOffset)
    }
  }

}
