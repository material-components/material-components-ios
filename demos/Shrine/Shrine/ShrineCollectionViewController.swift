import UIKit

class ShrineHeaderContentView: UIView {

  private var logo = UIImage(named: "ShrineLogo")
  private var logoImageView = UIImageView()
  private var label = UILabel()
  private var labelDesc = UILabel()

  override func layoutSubviews() {
    super.layoutSubviews()

    self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    logoImageView.image = logo
    logoImageView.center = CGPointMake(self.frame.size.width / 2, 48)
    self.addSubview(logoImageView)

    label.font = UIFont(name: "AbrilFatface-Regular", size: 36)
    label.textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.numberOfLines = 2

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 0.75
    let attrString = NSMutableAttributedString(string: "Green \ncomfort chair")
    attrString.addAttribute(NSParagraphStyleAttributeName,
      value:paragraphStyle,
      range:NSMakeRange(0, attrString.length))
    label.attributedText = attrString
    label.sizeToFit();
    label.frame = CGRectMake(self.frame.width - label.frame.size.width - 20,
      100, label.frame.size.width, label.frame.size.height)
    label.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    self.addSubview(label)

    labelDesc.lineBreakMode = NSLineBreakMode.ByWordWrapping
    labelDesc.numberOfLines = 2
    labelDesc.font = UIFont(name: "Helvetica", size: 10)
    labelDesc.textColor = UIColor(white: 0.54, alpha: 1)
    let descParagraphStyle = NSMutableParagraphStyle()
    descParagraphStyle.lineHeightMultiple = 1.2
    let descAttrString = NSMutableAttributedString(
      string: "Leave the tunnel and the rain is fallin \namazing things happen when you wait")
    descAttrString.addAttribute(NSParagraphStyleAttributeName,
      value:descParagraphStyle,
      range:NSMakeRange(0, descAttrString.length))
    labelDesc.attributedText = descAttrString
    labelDesc.sizeToFit();
    labelDesc.frame = CGRectMake(self.frame.width - labelDesc.frame.size.width - 20,
      190, labelDesc.frame.size.width, labelDesc.frame.size.height)
    labelDesc.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    self.addSubview(labelDesc)
  }
}

class ShrineCollectionViewController: UICollectionViewController {

  internal var headerViewController:MDCFlexibleHeaderViewController!
  internal var remoteImageService = RemoteImageService()
  private var shrineData:ShrineData

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

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
    remoteImageService.fetchImageDataFromURL(url, completion: {(imageData:NSData!) in
      if (imageData == nil) {
        return;
      }
      dispatch_async(dispatch_get_main_queue(), {
        let image = UIImage(data: imageData)
        cell.imageView.image = image;
        cell.imageView.setNeedsDisplay()
      })
    })
    let avatarName = self.shrineData.avatars[itemNum] as! String
    let avatarURLString:String = ShrineData.baseURL + avatarName
    let avatarURL = NSURL(string: avatarURLString)
    remoteImageService.fetchImageDataFromURL(avatarURL, completion: {(imageData:NSData!) in
      if (imageData == nil) {
        return;
      }
      dispatch_async(dispatch_get_main_queue(), {
        let image = UIImage(data: imageData)
        cell.avatar.image = image;
        cell.avatar.setNeedsDisplay()
      })
    })
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

  internal func setupHeaderView() {
    let headerView = headerViewController.headerView
    headerView.trackingScrollView = collectionView
    headerView.maximumHeight = 280;
    headerView.minimumHeight = 240;
    headerView.contentView?.backgroundColor = UIColor.whiteColor()
    headerView.contentView?.layer.masksToBounds = true
    headerView.contentView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    let contentViewFrame = headerView.contentView?.frame
    let adjustedFrame = CGRectMake(-160,
      120,
      contentViewFrame!.size.width,
      contentViewFrame!.size.height)
    let imageView = UIImageView(frame: adjustedFrame)
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
    headerView.contentView?.addSubview(imageView)

    let urlString = "https://www.gstatic.com/angular/material-adaptive/shrine/chair.png"
    let url = NSURL(string: urlString)
    remoteImageService.fetchImageDataFromURL(url, completion: {(imageData:NSData!) in
      if (imageData == nil) {
        return;
      }
      dispatch_async(dispatch_get_main_queue(), {
        let image = UIImage(data: imageData)
        imageView.image = image;
        imageView.setNeedsDisplay()
      })
    })

    let contentView = ShrineHeaderContentView(frame:(headerView.contentView?.frame)!)
    headerView.contentView?.addSubview(contentView)
  }

}
