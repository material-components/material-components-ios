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

class MDCCatalogComponentsController: UICollectionViewController {

  let node: Node
  var headerViewController:MDCFlexibleHeaderViewController!
  var colorCyan = UIColor.init(red: 0 / 255, green: 167 / 255, blue: 247 / 255, alpha: 1)
  var colorDeepPurple = UIColor.init(red: 103 / 255, green: 52 / 255, blue: 186 / 255, alpha: 1)
  var colorGreen = UIColor.init(red: 0 / 255, green: 158 / 255, blue: 85 / 255, alpha: 1)
  var colorPink = UIColor.init(red: 236 / 255, green: 21 / 255, blue: 97 / 255, alpha: 1)
  var colorIndigo = UIColor.init(red: 62 / 255, green: 78 / 255, blue: 184 / 255, alpha: 1)
  var colorTeal = UIColor.init(red: 0 / 255, green: 151 / 255, blue: 136 / 255, alpha: 1)
  var colorPurple = UIColor.init(red: 157 / 255, green: 28 / 255, blue: 178 / 255, alpha: 1)
  var colorGray = UIColor.init(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1)
  var colorOrange = UIColor.init(red: 255 / 255, green: 153 / 255, blue: 0 / 255, alpha: 1)
  let colors = NSMutableArray()
  let imageNames = NSMutableArray()

  init(collectionViewLayout layout: UICollectionViewLayout, node: Node) {
    self.node = node
    super.init(collectionViewLayout: layout)
    self.collectionView?.registerClass(MDCCatalogCollectionViewCell.self,
      forCellWithReuseIdentifier: "MDCCatalogCollectionViewCell")
    self.collectionView?.backgroundColor = UIColor.whiteColor()
    colors.addObjectsFromArray([ colorDeepPurple, colorGreen, colorPink, colorIndigo, colorTeal,
      colorPurple, colorGray, colorOrange ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.hidden = true

    // Sort alphabetically.
    self.node.children = self.node.children.sort {
      $0.title < $1.title
    }
  }

  func setupHeader() {
    let headerView = headerViewController.headerView
    headerView.trackingScrollView = self.collectionView
    headerView.maximumHeight = 200;
    headerView.minimumHeight = 72;
    headerView.contentView?.backgroundColor = colorCyan
    headerView.contentView?.layer.masksToBounds = true
    headerView.contentView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let contentView = UIView(frame:(headerView.contentView?.frame)!)
    contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let label = UILabel()
    label.text = "Material Design Components"
    label.textColor = UIColor.whiteColor()
    label.font = MDCTypography.titleFont()
    label.sizeToFit()
    let labelPad = CGFloat(16)
    label.frame = CGRectMake(labelPad, contentView.frame.height - label.frame.height - labelPad,
      label.frame.width, label.frame.height)
    label.autoresizingMask = .FlexibleTopMargin
    contentView.addSubview(label)

    headerView.contentView?.addSubview(contentView)
  }

  func getColorNumber(n: CGFloat) -> Int {
    let colorLength = CGFloat(colors.count)
    let colorN = (n / colorLength - floor(n / colorLength)) * colorLength
    return Int(colorN)
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
    let itemNum = CGFloat(indexPath.row);
    let colorNumber = getColorNumber(itemNum)
    let backgroundColor = colors[colorNumber] as! UIColor
    cell.backgroundColor = backgroundColor

    // Use button star icon for default image.
    let imageName = "Button"
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
      let pad = CGFloat(2)
      let cellDim = (self.view.frame.size.width - 3 * pad) / 2
      return CGSizeMake(cellDim, cellDim);
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
