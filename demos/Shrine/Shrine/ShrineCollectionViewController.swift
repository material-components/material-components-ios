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
import MaterialComponents.MaterialFlexibleHeader

class ShrineCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  var headerViewController: MDCFlexibleHeaderViewController!
  fileprivate let shrineData: ShrineData
  fileprivate var headerContentView = ShrineHeaderContentView(frame: CGRect.zero)

  override init(collectionViewLayout layout: UICollectionViewLayout) {
    self.shrineData = ShrineData()
    self.shrineData.readJSON()
    super.init(collectionViewLayout: layout)
    self.collectionView?.register(ShrineCollectionViewCell.self,
                                  forCellWithReuseIdentifier: "ShrineCollectionViewCell")
    self.collectionView?.backgroundColor = UIColor(white: 0.97, alpha: 1)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return self.shrineData.titles.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShrineCollectionViewCell",
                                                  for: indexPath) as! ShrineCollectionViewCell
    let itemNum: NSInteger = (indexPath as NSIndexPath).row

    let title = self.shrineData.titles[itemNum] as! String
    let imageName = self.shrineData.imageNames[itemNum] as! String
    let avatar = self.shrineData.avatars[itemNum] as! String
    let shopTitle = self.shrineData.shopTitles[itemNum] as! String
    let price = self.shrineData.prices[itemNum] as! String
    cell.populateCell(title, imageName:imageName, avatar:avatar, shopTitle:shopTitle, price:price)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    var safeAreaInset: CGFloat = 20
    if #available(iOS 11.0, *) {
      safeAreaInset += self.view.safeAreaInsets.left + self.view.safeAreaInsets.right
    }
    let cellWidth = floor((self.view.frame.size.width - 10 - safeAreaInset) / 2)
    let cellHeight = cellWidth * 1.2
    return CGSize(width: cellWidth, height: cellHeight)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let itemNum: NSInteger = (indexPath as NSIndexPath).row

    let detailVC = ShrineDetailViewController()
    detailVC.productTitle = self.shrineData.titles[itemNum] as! String
    detailVC.desc = self.shrineData.descriptions[itemNum] as! String
    detailVC.imageName = self.shrineData.imageNames[itemNum] as! String

    self.present(detailVC, animated: true, completion: nil)
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerViewController.scrollViewDidScroll(scrollView)
    let scrollOffsetY = scrollView.contentOffset.y
    let duration = 0.5
    var opacity: CGFloat = 1.0
    var logoTextImageViewOpacity: CGFloat = 0
    if scrollOffsetY > -240 {
      opacity = 0
      logoTextImageViewOpacity = 1
    }
    UIView.animate(withDuration: duration, animations: {
        self.headerContentView.scrollView.alpha = opacity
        self.headerContentView.pageControl.alpha = opacity
        self.headerContentView.logoImageView.alpha = opacity
        self.headerContentView.logoTextImageView.alpha = logoTextImageViewOpacity
    })

  }

  func sizeHeaderView() {
    let headerView = headerViewController.headerView
    let bounds = UIScreen.main.bounds
    if bounds.size.width < bounds.size.height {
      headerView.maximumHeight = 440
    } else {
      headerView.maximumHeight = 72
    }
    headerView.minimumHeight = 72
  }

  override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation,
                                    duration: TimeInterval) {
    sizeHeaderView()
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override func viewWillAppear(_ animated: Bool) {
    sizeHeaderView()
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  func setupHeaderView() {
    let headerView = headerViewController.headerView
    headerView.trackingScrollView = collectionView
    headerView.maximumHeight = 440
    headerView.minimumHeight = 72
    headerView.minMaxHeightIncludesSafeArea = false
    headerView.backgroundColor = UIColor.white
    headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    headerContentView.frame = (headerView.bounds)
    headerContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    headerView.addSubview(headerContentView)
  }

}
