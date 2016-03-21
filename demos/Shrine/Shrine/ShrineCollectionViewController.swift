import UIKit

class ShrineCollectionViewController: UICollectionViewController {

  var headerViewController:MDCFlexibleHeaderViewController!
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

  func sizeHeaderView() {
    let headerView = headerViewController.headerView
    let bounds = UIScreen.mainScreen().bounds
    if (bounds.size.width < bounds.size.height) {
      headerView.maximumHeight = 360;
      headerView.minimumHeight = 240;
    } else {
      headerView.maximumHeight = 240;
      headerView.minimumHeight = 240;
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
    headerView.maximumHeight = 360;
    headerView.minimumHeight = 240;
    headerView.contentView?.backgroundColor = UIColor.whiteColor()
    headerView.contentView?.layer.masksToBounds = true
    headerView.contentView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let contentView = ShrineHeaderContentView(frame:(headerView.contentView?.frame)!)
    contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    headerView.contentView?.addSubview(contentView)
  }

}
