import UIKit

class ShrineCollectionViewCell: UICollectionViewCell {

  var title = ""
  var shopTitle = ""
  var price = ""
  var imageView = UIImageView()
  var avatar = UIImageView()

  private var label = UILabel()
  private var labelAvatar = UILabel()
  private var labelPrice = UILabel()
  private var shrineInkOverlay = ShrineInkOverlay()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(white: 1, alpha: 1)

    let imagePad:CGFloat = 40
    imageView.frame = CGRectMake(imagePad,
      imagePad,
      self.bounds.width - imagePad * 2,
      self.bounds.height - imagePad * 2)

    label.font = UIFont(name: "AbrilFatface-Regular", size: 14)
    label.textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    label.lineBreakMode = .ByWordWrapping
    label.numberOfLines = 2

    avatar.backgroundColor = UIColor.lightGrayColor()
    avatar.clipsToBounds = true

    labelAvatar.lineBreakMode = .ByWordWrapping
    labelAvatar.textColor = UIColor.grayColor()
    labelAvatar.numberOfLines = 1
    labelAvatar.font = UIFont(name: "Helvetica", size: 9)

    labelPrice.lineBreakMode = .ByWordWrapping
    labelPrice.font = UIFont(name: "Helvetica-Bold", size: 12)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func applyLayoutAttributes(layoutAttributes : UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.addSubview(imageView)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    let attrString = NSMutableAttributedString(string: self.title)
    attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle,
      range:NSMakeRange(0, attrString.length))
    label.attributedText = attrString
    label.frame = CGRectMake(10, 10, 0, 0)
    label.sizeToFit();
    self.addSubview(label)

    let avatarDim:CGFloat = 24
    avatar.layer.cornerRadius = avatarDim / 2
    avatar.frame = CGRectMake(10,
      self.frame.height - avatarDim - 10,
      avatarDim,
      avatarDim)
    self.addSubview(avatar)

    let avatarParagraphStyle = NSMutableParagraphStyle()
    avatarParagraphStyle.lineHeightMultiple = 1.2
    let avatarAttrString = NSMutableAttributedString(string: self.shopTitle)
    avatarAttrString.addAttribute(NSParagraphStyleAttributeName, value:avatarParagraphStyle,
      range:NSMakeRange(0, avatarAttrString.length))
    labelAvatar.attributedText = avatarAttrString
    labelAvatar.sizeToFit();
    labelAvatar.frame = CGRectMake(15 + avatarDim,
      self.frame.height - labelAvatar.frame.height - 16,
      labelAvatar.frame.width,
      labelAvatar.frame.height)
    self.addSubview(labelAvatar)

    let descParagraphStyle = NSMutableParagraphStyle()
    descParagraphStyle.lineHeightMultiple = 1.2
    let descAttrString = NSMutableAttributedString(string: self.price)
    descAttrString.addAttribute(NSParagraphStyleAttributeName, value:descParagraphStyle,
      range:NSMakeRange(0, descAttrString.length))
    labelPrice.attributedText = descAttrString
    labelPrice.sizeToFit();
    labelPrice.frame = CGRectMake(self.frame.width - labelPrice.frame.width - 10,
      self.frame.height - labelPrice.frame.height - 14,
      labelPrice.frame.width,
      labelPrice.frame.height)
    self.addSubview(labelPrice)

    shrineInkOverlay.frame = self.bounds
    self.addSubview(shrineInkOverlay)
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    for view:UIView in self.subviews {
      view.removeFromSuperview()
    }

    title = ""
    shopTitle = ""
    price = ""
    imageView.image = nil
    avatar.image = nil
  }

}
