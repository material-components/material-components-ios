/*
Copyright 2015-present Google Inc. All Rights Reserved.

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

class MDCCatalogComponentsController: UICollectionViewController, MDCInkTouchControllerDelegate {

  let spacing = CGFloat(1)
  let inset = CGFloat(16)
  let node: CBCNode
  var headerViewController: MDCFlexibleHeaderViewController
  let imageNames = NSMutableArray()

  var inkController: MDCInkTouchController?

  init(collectionViewLayout ignoredLayout: UICollectionViewLayout, node: CBCNode) {
    self.node = node

    let layout = UICollectionViewFlowLayout()
    let sectionInset:CGFloat = spacing
    layout.sectionInset = UIEdgeInsetsMake(sectionInset, sectionInset, sectionInset, sectionInset)
    layout.minimumInteritemSpacing = spacing
    layout.minimumLineSpacing = spacing

    self.headerViewController = MDCFlexibleHeaderViewController()

    super.init(collectionViewLayout: layout)

    self.title = "Material Design Components"

    self.addChildViewController(self.headerViewController)

    self.headerViewController.headerView.maximumHeight = 128
    self.headerViewController.headerView.minimumHeight = 72

    self.collectionView?.registerClass(MDCCatalogCollectionViewCell.self,
      forCellWithReuseIdentifier: "MDCCatalogCollectionViewCell")
    self.collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
  }

  convenience init(node: CBCNode) {
    self.init(collectionViewLayout: UICollectionViewLayout(), node: node)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    inkController = MDCInkTouchController(view: self.collectionView!)!
    inkController!.addInkView()
    inkController!.delaysInkSpread = true
    inkController!.delegate = self

    let containerView = UIView(frame: self.headerViewController.headerView.bounds)
    containerView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let titleLabel = UILabel()
    titleLabel.text = self.title!.uppercaseString
    titleLabel.textColor = UIColor(white: 0.46, alpha: 1)
    titleLabel.font = MDCTypography.titleFont()
    titleLabel.sizeToFit()
    if (inset + titleLabel.frame.size.width > containerView.frame.size.width) {
      titleLabel.font = MDCTypography.body2Font()
    }

    let titleInsets = UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
    let titleSize = titleLabel.sizeThatFits(containerView.bounds.size)
    titleLabel.frame = CGRect(
      x: titleInsets.left,
      y: containerView.bounds.size.height - titleSize.height - titleInsets.bottom,
      width: containerView.bounds.size.width,
      height: titleSize.height)
    titleLabel.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth]

    containerView.addSubview(titleLabel)

    self.headerViewController.headerView.addSubview(containerView)

    self.headerViewController.headerView.forwardTouchEventsForView(containerView)

    self.headerViewController.headerView.backgroundColor = UIColor.whiteColor()
    self.headerViewController.headerView.trackingScrollView = self.collectionView

    self.headerViewController.headerView.setShadowLayer(MDCShadowLayer()) { (layer, intensity) in
      let shadowLayer = layer as? MDCShadowLayer
      shadowLayer!.elevation = intensity * MDCShadowElevationAppBar
    }

    self.view.addSubview(self.headerViewController.view)
    self.headerViewController.didMoveToParentViewController(self)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.collectionView?.collectionViewLayout.invalidateLayout()
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func willAnimateRotationToInterfaceOrientation(
    toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
    self.collectionView?.collectionViewLayout.invalidateLayout()
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return node.children.count
  }

  func inkViewForView(view: UIView) -> MDCInkView {
    let foundInkView = MDCInkTouchController.injectedInkViewForView(view)
    foundInkView.inkStyle = .Unbounded
    foundInkView.inkColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.2)
    return foundInkView
  }

  // MARK: MDCInkTouchControllerDelegate

  func inkTouchController(inkTouchController: MDCInkTouchController, shouldProcessInkTouchesAtTouchLocation location: CGPoint) -> Bool {
    return self.collectionView!.indexPathForItemAtPoint(location) != nil
  }

  func inkTouchController(inkTouchController: MDCInkTouchController, inkViewAtTouchLocation location: CGPoint) -> MDCInkView {
    if let indexPath = self.collectionView!.indexPathForItemAtPoint(location) {
      let cell = self.collectionView!.cellForItemAtIndexPath(indexPath)
      return self.inkViewForView(cell!)
    }
    return MDCInkView()
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MDCCatalogCollectionViewCell",
      forIndexPath: indexPath)
    cell.backgroundColor = UIColor.whiteColor()

    let componentName = self.node.children[indexPath.row].title
    if let catalogCell = cell as? MDCCatalogCollectionViewCell {
      catalogCell.populateView(componentName)
    }

    // Ensure that ink animations aren't recycled.
    MDCInkTouchController.injectedInkViewForView(view).cancelAllAnimationsAnimated(false)

    return cell
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let pad = CGFloat(1)
    var cellWidth = (self.view.frame.size.width - 3 * pad) / 2
    if (self.view.frame.size.width > self.view.frame.size.height) {
      cellWidth = (self.view.frame.size.width - 4 * pad) / 3
    }
    return CGSize(width: cellWidth, height: cellWidth * 0.825)
  }

  override func collectionView(collectionView: UICollectionView,
    didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if node.isExample() {
      vc = node.createExampleViewController()
    } else {
      vc = MDCNodeListViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }

}

// UIScrollViewDelegate
extension MDCCatalogComponentsController {

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    if scrollView == self.headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollViewDidScroll()
    }
  }

  override func scrollViewDidEndDragging(
      scrollView: UIScrollView,
      willDecelerate decelerate: Bool) {
    let headerView = self.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollViewDidEndDraggingWillDecelerate(decelerate)
    }
  }

  override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if scrollView == self.headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollViewDidEndDecelerating()
    }
  }

  override func scrollViewWillEndDragging(
      scrollView: UIScrollView,
      withVelocity velocity: CGPoint,
      targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = self.headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollViewWillEndDraggingWithVelocity(
        velocity,
        targetContentOffset: targetContentOffset)
    }
  }

}
