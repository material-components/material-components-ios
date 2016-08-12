/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

class ShrineCollectionViewController: UICollectionViewController {

  var headerViewController:MDCFlexibleHeaderViewController!
  private let shrineData:ShrineData
  private var headerContentView = ShrineHeaderContentView(frame: CGRectZero)

  override init(collectionViewLayout layout: UICollectionViewLayout) {
    self.shrineData = ShrineData()
    self.shrineData.readJSON()
    super.init(collectionViewLayout: layout)
    self.collectionView?.registerClass(ShrineCollectionViewCell.self, forCellWithReuseIdentifier: "ShrineCollectionViewCell")
    self.collectionView?.backgroundColor = UIColor(white: 0.97, alpha: 1)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return self.shrineData.titles.count
  }

  override func collectionView(collectionView: UICollectionView,
                               cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShrineCollectionViewCell", forIndexPath: indexPath) as! ShrineCollectionViewCell
    let itemNum:NSInteger = indexPath.row;

    let title = self.shrineData.titles[itemNum] as! String
    let imageName = self.shrineData.imageNames[itemNum] as! String
    let avatar = self.shrineData.avatars[itemNum] as! String
    let shopTitle = self.shrineData.shopTitles[itemNum] as! String
    let price = self.shrineData.prices[itemNum] as! String
    cell.populateCell(title, imageName:imageName, avatar:avatar, shopTitle:shopTitle, price:price)

    return cell
  }

  func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      let cellWidth = floor((self.view.frame.size.width - (2 * 5)) / 2) - (2 * 5);
      let cellHeight = cellWidth * 1.2
      return CGSizeMake(cellWidth, cellHeight);
  }

  override func collectionView(collectionView: UICollectionView,
                               didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let itemNum:NSInteger = indexPath.row;

    let detailVC = ShrineDetailViewController()
    detailVC.productTitle = self.shrineData.titles[itemNum] as! String
    detailVC.desc = self.shrineData.descriptions[itemNum] as! String
    detailVC.imageName = self.shrineData.imageNames[itemNum] as! String

    self.presentViewController(detailVC, animated: true, completion: nil)
  }

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    headerViewController.scrollViewDidScroll(scrollView);
    let scrollOffsetY = scrollView.contentOffset.y;
    let duration = 0.5
    if (scrollOffsetY > -240) {
      UIView.animateWithDuration(duration, animations: {
        self.headerContentView.scrollView.alpha = 0
        self.headerContentView.pageControl.alpha = 0
        self.headerContentView.logoImageView.alpha = 0
        self.headerContentView.logoTextImageView.alpha = 1
      })
    } else {
      UIView.animateWithDuration(duration, animations: {
        self.headerContentView.scrollView.alpha = 1
        self.headerContentView.pageControl.alpha = 1
        self.headerContentView.logoImageView.alpha = 1
        self.headerContentView.logoTextImageView.alpha = 0
      })
    }
  }

  func sizeHeaderView() {
    let headerView = headerViewController.headerView
    let bounds = UIScreen.mainScreen().bounds
    if (bounds.size.width < bounds.size.height) {
      headerView.maximumHeight = 440;
      headerView.minimumHeight = 72;
    } else {
      headerView.maximumHeight = 72;
      headerView.minimumHeight = 72;
    }
  }

  override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation:UIInterfaceOrientation, duration: NSTimeInterval) {
    sizeHeaderView()
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override func viewWillAppear(animated: Bool) {
    sizeHeaderView()
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  func setupHeaderView() {
    let headerView = headerViewController.headerView
    headerView.trackingScrollView = collectionView
    headerView.maximumHeight = 440;
    headerView.minimumHeight = 72;
    headerView.backgroundColor = UIColor.whiteColor()
    headerView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    headerContentView.frame = (headerView.frame)
    headerContentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    headerView.addSubview(headerContentView)
  }

}
