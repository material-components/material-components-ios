import UIKit

class ShrineCollectionViewCellContent: UIView {

}

class ShrineCollectionViewCell: UICollectionViewCell {

  var imageView = UIImageView()
  var avatar = UIImageView()
  var remoteImageService = RemoteImageService()

  private var label = UILabel()
  private var labelAvatar = UILabel()
  private var labelPrice = UILabel()
  private var shrineInkOverlay = ShrineInkOverlay()
  private var cellContent = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    cellContent.frame = bounds
    cellContent.backgroundColor = UIColor.whiteColor()
    cellContent.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    cellContent.clipsToBounds = true

    imageView.contentMode = .ScaleAspectFill;
    imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    cellContent.addSubview(imageView)

    avatar.layer.cornerRadius = 12
    avatar.backgroundColor = UIColor.lightGrayColor()
    avatar.clipsToBounds = true
    cellContent.addSubview(avatar)

    labelAvatar.lineBreakMode = .ByWordWrapping
    labelAvatar.textColor = UIColor.grayColor()
    labelAvatar.numberOfLines = 1
    labelAvatar.font = UIFont(name: "Helvetica", size: 9)
    cellContent.addSubview(labelAvatar)

    labelPrice.lineBreakMode = .ByWordWrapping
    labelPrice.font = UIFont(name: "Helvetica-Bold", size: 12)
    cellContent.addSubview(labelPrice)

    shrineInkOverlay.frame = self.bounds
    shrineInkOverlay.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    cellContent.addSubview(shrineInkOverlay)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func applyLayoutAttributes(layoutAttributes : UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.addSubview(cellContent)

    let imagePad:CGFloat = 40
    imageView.frame = CGRectMake(imagePad,
      imagePad,
      self.frame.size.width - imagePad * 2,
      self.frame.size.height - 10 - imagePad * 2)
    let avatarDim:CGFloat = 24
    avatar.frame = CGRectMake(10,
      self.frame.size.height - avatarDim - 10,
      avatarDim,
      avatarDim)
    labelAvatar.frame = CGRectMake(15 + avatarDim,
      self.frame.size.height - 26,
      self.frame.size.width,
      10)
    labelPrice.sizeToFit()
    labelPrice.frame = CGRectMake(self.frame.size.width - labelPrice.frame.size.width - 10,
      10,
      labelPrice.frame.size.width,
      labelPrice.frame.size.height)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    avatar.image = nil
  }

  func populateCell(title : String, imageName : String, avatar : String, shopTitle : String,
    price : String) {
    labelAvatar.text = shopTitle
    labelPrice.text = price
    let urlString:String = ShrineData.baseURL + imageName
    let url = NSURL(string: urlString)
    remoteImageService.fetchImageAndThumbnailFromURL(url) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_sync(dispatch_get_main_queue(), {
        self.imageView.image = thumbnailImage
      })
    }
    let avatarURLString:String = ShrineData.baseURL + avatar
    let avatarURL = NSURL(string: avatarURLString)
    remoteImageService.fetchImageAndThumbnailFromURL(avatarURL) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_sync(dispatch_get_main_queue(), {
        self.avatar.image = thumbnailImage
      })
    }
  }

}
