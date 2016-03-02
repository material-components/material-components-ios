import UIKit

class ShrineDetailView: UIView {

  internal var title:String = "Title"
  internal var desc:String = "Description"
  internal var imageName:String = "popsicle.png"
  private var remoteImageService = RemoteImageService()

  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = UIColor.whiteColor()

    let labelPadding:CGFloat = 50
    let imageView = UIImageView(frame: CGRectMake(labelPadding, labelPadding,
      self.frame.size.width - 2 * labelPadding, 220))
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    imageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
    self.addSubview(imageView)
    let urlString:String = ShrineData.baseURL + imageName
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

    let label = UILabel(frame: CGRectZero)
    label.font = UIFont(name: "AbrilFatface-Regular", size: 36)
    label.textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.numberOfLines = 2

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 0.8
    let attrString = NSMutableAttributedString(string: title)
    attrString.addAttribute(NSParagraphStyleAttributeName,
      value:paragraphStyle,
      range:NSMakeRange(0, attrString.length))
    label.attributedText = attrString
    label.sizeToFit();
    label.frame = CGRectMake(labelPadding,
      280, label.frame.size.width, label.frame.size.height)
    self.addSubview(label)

    let labelDesc = UILabel(frame: CGRectZero)
    labelDesc.lineBreakMode = NSLineBreakMode.ByWordWrapping
    labelDesc.numberOfLines = 5
    labelDesc.font = UIFont(name: "Helvetica", size: 14)
    labelDesc.textColor = UIColor(white: 0.54, alpha: 1)
    let descParagraphStyle = NSMutableParagraphStyle()
    descParagraphStyle.lineHeightMultiple = 1.5
    let descAttrString = NSMutableAttributedString(string: desc)
    descAttrString.addAttribute(NSParagraphStyleAttributeName,
      value:descParagraphStyle,
      range:NSMakeRange(0, descAttrString.length))
    labelDesc.attributedText = descAttrString
    labelDesc.frame = CGRectMake(labelPadding,
      360, self.frame.size.width - 2 * labelPadding, 160)
    labelDesc.sizeToFit()
    self.addSubview(labelDesc)
  }

}

class ShrineDetailViewController: UIViewController {

  internal var productTitle:String = "Title"
  internal var desc:String = "Description"
  internal var imageName:String = "popsicle.png"

  override func viewDidLoad() {
    let detailView = ShrineDetailView(frame: self.view.frame)
    detailView.title = productTitle
    detailView.desc = desc
    detailView.imageName = imageName
    self.view.addSubview(detailView)

    let dismissBtn = UIButton(frame: CGRectMake(10,30,50,30))
    dismissBtn.setTitle("Back", forState: UIControlState.Normal)
    dismissBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    dismissBtn.addTarget(self, action: "dismissDetails", forControlEvents: .TouchUpInside)
    self.view.addSubview(dismissBtn)
  }

  func dismissDetails() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

}
