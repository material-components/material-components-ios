import UIKit

class ShrineCollectionViewCell: UICollectionViewCell {

  internal var title:String = "Title"
  internal var shopTitle:String = "Shop title"
  internal var price:String = "$100"
  internal var imageView:UIImageView = UIImageView()
  internal var avatar:UIImageView = UIImageView()

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(white: 1, alpha: 1)
  }

  override func applyLayoutAttributes(layoutAttributes : UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let imagePad:CGFloat = 40
    imageView.frame = CGRectMake(imagePad,
      imagePad,
      self.bounds.width - imagePad * 2,
      self.bounds.height - imagePad * 2)
    self.addSubview(imageView)

    let label = UILabel(frame: CGRectMake(10, 10, 0, 0))
    label.font = UIFont(name: "AbrilFatface-Regular", size: 14)
    label.textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.numberOfLines = 2

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    let attrString = NSMutableAttributedString(string: self.title)
    attrString.addAttribute(NSParagraphStyleAttributeName,
      value:paragraphStyle,
      range:NSMakeRange(0, attrString.length))
    label.attributedText = attrString

    label.sizeToFit();
    self.addSubview(label)

    let avatarDim:CGFloat = 24
    avatar.frame = CGRectMake(10,
      self.frame.height - avatarDim - 10,
      avatarDim,
      avatarDim)
    avatar.backgroundColor = UIColor.lightGrayColor()
    avatar.layer.cornerRadius = avatarDim / 2
    avatar.layer.masksToBounds = true
    self.addSubview(avatar)

    let labelAvatar = UILabel(frame: CGRectZero)
    labelAvatar.lineBreakMode = NSLineBreakMode.ByWordWrapping
    labelAvatar.textColor = UIColor.grayColor()
    labelAvatar.numberOfLines = 1
    labelAvatar.font = UIFont(name: "Helvetica", size: 9)
    let avatarParagraphStyle = NSMutableParagraphStyle()
    avatarParagraphStyle.lineHeightMultiple = 1.2
    let avatarAttrString = NSMutableAttributedString(
      string: self.shopTitle)
    avatarAttrString.addAttribute(NSParagraphStyleAttributeName,
      value:avatarParagraphStyle,
      range:NSMakeRange(0, avatarAttrString.length))
    labelAvatar.attributedText = avatarAttrString
    labelAvatar.sizeToFit();
    labelAvatar.frame = CGRectMake(15 + avatarDim,
      self.frame.height - labelAvatar.frame.height - 16,
      labelAvatar.frame.width,
      labelAvatar.frame.height)
    self.addSubview(labelAvatar)

    let labelDesc = UILabel(frame: CGRectZero)
    labelDesc.lineBreakMode = NSLineBreakMode.ByWordWrapping
    labelDesc.numberOfLines = 2
    labelDesc.font = UIFont(name: "Helvetica-Bold", size: 12)
    let descParagraphStyle = NSMutableParagraphStyle()
    descParagraphStyle.lineHeightMultiple = 1.2
    let descAttrString = NSMutableAttributedString(
      string: self.price)
    descAttrString.addAttribute(NSParagraphStyleAttributeName,
      value:descParagraphStyle,
      range:NSMakeRange(0, descAttrString.length))
    labelDesc.attributedText = descAttrString
    labelDesc.sizeToFit();
    labelDesc.frame = CGRectMake(self.frame.width - labelDesc.frame.width - 10,
      self.frame.height - labelDesc.frame.height - 14,
      labelDesc.frame.width,
      labelDesc.frame.height)
    self.addSubview(labelDesc)
  }

}
