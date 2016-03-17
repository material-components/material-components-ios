import UIKit

class ShrineCollectionViewController: UICollectionViewController {

  var headerViewController:MDCFlexibleHeaderViewController!
  var remoteImageService = RemoteImageService()
  private let shrineData:ShrineData

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

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.shrineData.titles.count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShrineCollectionViewCell", forIndexPath: indexPath) as! ShrineCollectionViewCell
    let itemNum:NSInteger = indexPath.row;
    cell.title = self.shrineData.titles[itemNum] as! String
    cell.shopTitle = self.shrineData.shopTitles[itemNum] as! String
    cell.price = self.shrineData.prices[itemNum] as! String

    let imageName = self.shrineData.imageNames[itemNum] as! String
    let urlString:String = ShrineData.baseURL + imageName
    let url = NSURL(string: urlString)
    remoteImageService.fetchImageAndThumbnailFromURL(url) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        cell.imageView.image = thumbnailImage
        cell.imageView.setNeedsDisplay()
      })
    }

    let avatarName = self.shrineData.avatars[itemNum] as! String
    let avatarURLString:String = ShrineData.baseURL + avatarName
    let avatarURL = NSURL(string: avatarURLString)
    remoteImageService.fetchImageAndThumbnailFromURL(avatarURL) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        cell.avatar.image = image
        cell.avatar.setNeedsDisplay()
      })
    }

    return cell
  }

  func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      let cellDim = floor((self.view.frame.size.width - (2 * 5)) / 2) - (2 * 5);
      return CGSizeMake(cellDim, cellDim);
  }

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let itemNum:NSInteger = indexPath.row;

    let detailVC = ShrineDetailViewController()
    detailVC.productTitle = self.shrineData.titles[itemNum] as! String
    detailVC.desc = self.shrineData.descriptions[itemNum] as! String
    detailVC.imageName = self.shrineData.imageNames[itemNum] as! String

    self.presentViewController(detailVC, animated: true, completion: nil)
  }

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    headerViewController.scrollViewDidScroll(scrollView);
  }

  func setupHeaderView() {
    let headerView = headerViewController.headerView
    headerView.trackingScrollView = collectionView
    headerView.maximumHeight = 280;
    headerView.minimumHeight = 240;
    headerView.contentView?.backgroundColor = UIColor.whiteColor()
    headerView.contentView?.layer.masksToBounds = true
    headerView.contentView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let contentView = ShrineHeaderContentView(frame:(headerView.contentView?.frame)!)
    contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    headerView.contentView?.addSubview(contentView)
  }

}
