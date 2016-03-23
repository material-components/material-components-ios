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

class MDCCatalogComponentsController: UICollectionViewController {

  let node: Node
  var headerViewController:MDCFlexibleHeaderViewController!
  let imageNames = NSMutableArray()

  init(collectionViewLayout layout: UICollectionViewLayout, node: Node) {
    self.node = node
    super.init(collectionViewLayout: layout)
    self.collectionView?.registerClass(MDCCatalogCollectionViewCell.self,
      forCellWithReuseIdentifier: "MDCCatalogCollectionViewCell")
    self.collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    collectionView?.collectionViewLayout.invalidateLayout()
    self.navigationController?.navigationBar.hidden = true

    // Sort alphabetically.
    self.node.children = self.node.children.sort {
      $0.title < $1.title
    }
  }

  override func willAnimateRotationToInterfaceOrientation(
    toInterfaceOrientation:UIInterfaceOrientation, duration: NSTimeInterval) {
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  func setupHeader() {
    let headerView = headerViewController.headerView
    headerView.trackingScrollView = self.collectionView
    headerView.maximumHeight = 128;
    headerView.minimumHeight = 72;
    headerView.contentView?.backgroundColor = UIColor.whiteColor()
    headerView.contentView?.layer.masksToBounds = true
    headerView.contentView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let contentView = UIView(frame:(headerView.contentView?.frame)!)
    contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let label = UILabel()
    let title = "Material Design Components"
    label.text = title.uppercaseString
    label.textColor = UIColor(white: 0.46, alpha: 1)
    label.font = MDCTypography.titleFont()
    label.sizeToFit()
    let labelPad = CGFloat(16)
    label.frame = CGRectMake(labelPad, contentView.frame.height - label.frame.height - labelPad,
      label.frame.width, label.frame.height)
    label.autoresizingMask = .FlexibleTopMargin
    contentView.addSubview(label)

    headerView.contentView?.addSubview(contentView)
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return node.children.count
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MDCCatalogCollectionViewCell",
      forIndexPath: indexPath) as! MDCCatalogCollectionViewCell
    cell.backgroundColor = UIColor.whiteColor()

    let imageName = "Misc"
    var image = UIImage(named: imageName)
    let componentName = self.node.children[indexPath.row].title
    let componentImage: UIImage? = UIImage(named: componentName)
    if componentImage != nil {
      image = componentImage
    }
    cell.populateView(componentName, image: image!)

    return cell
  }

  func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      let pad = CGFloat(1)
      let cellWidth = (self.view.frame.size.width - 3 * pad) / 2
      return CGSizeMake(cellWidth, cellWidth * 0.8);
  }

  override func collectionView(collectionView: UICollectionView,
    didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if let vClass = node.viewController {
      vc = ViewControllerFromClass(vClass)
    } else {
      vc = NodeViewController(node: node)
    }
    self.navigationController?.navigationBar.hidden = false
    self.navigationController?.pushViewController(vc, animated: true)
  }

  // MARK: UIScrollViewDelegate

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    headerViewController.scrollViewDidScroll(scrollView);
  }

}
