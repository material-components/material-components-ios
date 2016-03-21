import UIKit

class ShrineHeaderContentView: UIView, UIScrollViewDelegate {

  var remoteImageService = RemoteImageService()

  private let logoImageView = UIImageView(image: UIImage(named: "ShrineLogo"))
  private var pages = NSMutableArray()
  private var pageControl = MDCPageControl()
  private var scrollView = UIScrollView()
  private var label = UILabel()
  private var labelDesc = UILabel()
  private var label2 = UILabel()
  private var labelDesc2 = UILabel()
  private var label3 = UILabel()
  private var labelDesc3 = UILabel()
  private var cyanBox = UIView()
  private var cyanBox2 = UIView()
  private var cyanBox3 = UIView()
  private var imageView = UIImageView()
  private var imageView2 = UIImageView()
  private var imageView3 = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let boundsWidth = CGRectGetWidth(self.bounds)
    let boundsHeight = CGRectGetHeight(self.bounds)
    scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    scrollView.delegate = self
    scrollView.pagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    self.addSubview(scrollView)
    self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

    for i in 0...2 {
      let boundsLeft = CGFloat(i) * boundsWidth
      let pageFrame = CGRectOffset(self.bounds, boundsLeft, 0)
      let page = UIView(frame:pageFrame)
      page.clipsToBounds = true
      page.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      pages.addObject(page)
      scrollView.addSubview(page)
    }

    pageControl.numberOfPages = 3
    pageControl.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    let pageControlSize = pageControl.sizeThatFits(self.bounds.size)
    pageControl.frame = CGRectMake(0,
      boundsHeight - pageControlSize.height,
      boundsWidth,
      pageControlSize.height)
    self.addSubview(pageControl)

    addPageContent()
    self.addSubview(logoImageView)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  func addPageContent() {
    let firstPage = pages[0]
    let secondPage = pages[1]
    let thirdPage = pages[2]
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.autoresizingMask = .FlexibleHeight
    firstPage.addSubview(imageView)
    let url = NSURL(string: ShrineData.baseURL + "chair.png")
    remoteImageService.fetchImageAndThumbnailFromURL(url) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        self.imageView.image = image;
        self.imageView.setNeedsDisplay()
      })
    }

    let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
    let fontHelvetica = UIFont(name: "Helvetica", size: 10)
    let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    let cyanBoxColor = UIColor(red: 0.19, green: 0.94, blue: 0.94, alpha: 1)
    let descColor = UIColor(white: 0.54, alpha: 1)
    let descString = "Leave the tunnel and the rain is fallin amazing things happen when you wait"

    label.font = fontAbril
    label.textColor = textColor
    label.lineBreakMode = .ByWordWrapping
    label.numberOfLines = 2
    label.attributedText = attributedString("Green \ncomfort chair", lineHeightMultiple: 0.8)
    label.sizeToFit();
    firstPage.addSubview(label)

    labelDesc.lineBreakMode = .ByWordWrapping
    labelDesc.numberOfLines = 3
    labelDesc.font = fontHelvetica
    labelDesc.textColor = descColor
    labelDesc.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    labelDesc.autoresizingMask = .FlexibleWidth
    firstPage.addSubview(labelDesc)

    cyanBox.backgroundColor = cyanBoxColor
    firstPage.addSubview(cyanBox)

    let inkOverlay = ShrineInkOverlay(frame: firstPage.bounds)
    inkOverlay.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    firstPage.addSubview(inkOverlay)

    imageView2.contentMode = UIViewContentMode.ScaleAspectFill
    imageView2.autoresizingMask = .FlexibleHeight
    secondPage.addSubview(imageView2)
    let url2 = NSURL(string: ShrineData.baseURL + "backpack.png")
    remoteImageService.fetchImageAndThumbnailFromURL(url2) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        self.imageView2.image = image;
        self.imageView2.setNeedsDisplay()
      })
    }

    label2.font = fontAbril
    label2.textColor = textColor
    label2.lineBreakMode = .ByWordWrapping
    label2.numberOfLines = 2
    label2.attributedText = attributedString("Best gift for \nthe traveler",
      lineHeightMultiple: 0.8)
    secondPage.addSubview(label2)

    labelDesc2.lineBreakMode = .ByWordWrapping
    labelDesc2.numberOfLines = 2
    labelDesc2.font = fontHelvetica
    labelDesc2.textColor = descColor
    labelDesc2.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    secondPage.addSubview(labelDesc2)

    cyanBox2.backgroundColor = cyanBoxColor
    secondPage.addSubview(cyanBox2)

    let inkOverlay2 = ShrineInkOverlay(frame: secondPage.bounds)
    inkOverlay2.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    secondPage.addSubview(inkOverlay2)

    imageView3.contentMode = UIViewContentMode.ScaleAspectFill
    imageView3.autoresizingMask = .FlexibleHeight
    thirdPage.addSubview(imageView3)
    let url3 = NSURL(string: ShrineData.baseURL + "heels.png")
    remoteImageService.fetchImageAndThumbnailFromURL(url3) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        self.imageView3.image = image;
        self.imageView3.setNeedsDisplay()
      })
    }

    label3.font = fontAbril
    label3.textColor = textColor
    label3.lineBreakMode = .ByWordWrapping
    label3.numberOfLines = 2
    label3.attributedText = attributedString("Better \nwearing heels", lineHeightMultiple: 0.8)
    thirdPage.addSubview(label3)

    labelDesc3.lineBreakMode = .ByWordWrapping
    labelDesc3.numberOfLines = 2
    labelDesc3.font = fontHelvetica
    labelDesc3.textColor = descColor
    labelDesc3.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    thirdPage.addSubview(labelDesc3)

    cyanBox3.backgroundColor = cyanBoxColor
    thirdPage.addSubview(cyanBox3)

    let inkOverlay3 = ShrineInkOverlay(frame: thirdPage.bounds)
    inkOverlay3.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    thirdPage.addSubview(inkOverlay3)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let boundsWidth = CGRectGetWidth(self.bounds)
    let boundsHeight = CGRectGetHeight(self.bounds)
    for i in 0...pages.count - 1 {
      let boundsLeft = CGFloat(i) * boundsWidth
      let pageFrame = CGRectOffset(self.bounds, boundsLeft, 0)
      let page = pages[i] as! UIView
      page.frame = pageFrame
    }
    let pageControlSize = pageControl.sizeThatFits(self.bounds.size)
    pageControl.frame = CGRectMake(0, boundsHeight - pageControlSize.height, boundsWidth,
      pageControlSize.height)
    let scrollWidth:CGFloat = boundsWidth * CGFloat(pages.count)
    scrollView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight)
    scrollView.contentSize = CGSizeMake(scrollWidth, boundsHeight)

    let scrollViewOffsetX = CGFloat(pageControl.currentPage) * boundsWidth
    scrollView.setContentOffset(CGPointMake(scrollViewOffsetX, 0), animated: false)
    logoImageView.center = CGPointMake((self.frame.size.width) / 2, 44)

    let labelWidth = CGFloat(250)
    let labelWidthFrame = CGRectMake(self.frame.size.width - labelWidth,
      70, labelWidth, label.frame.size.height)

    let labelDescWidth = CGFloat(200)
    let labelDescWidthFrame = CGRectMake(self.frame.size.width - labelDescWidth,
      170, labelDescWidth, 40)

    label.frame = labelWidthFrame
    labelDesc.frame = labelDescWidthFrame
    label2.frame = labelWidthFrame
    labelDesc2.frame = labelDescWidthFrame
    label3.frame = labelWidthFrame
    labelDesc3.frame = labelDescWidthFrame

    let cyanBoxFrame = CGRectMake(self.frame.size.width - 200, 160, 100, 8)
    cyanBox.frame = cyanBoxFrame
    cyanBox2.frame = cyanBoxFrame
    cyanBox3.frame = cyanBoxFrame

    imageView.frame = CGRectMake(-180, 120, 420, self.frame.size.height)
    imageView2.frame = CGRectMake(-220, 110, 420, self.frame.size.height)
    imageView3.frame = CGRectMake(-180, 40, 420, self.frame.size.height)
  }

  func attributedString(string: String, lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    let attrString = NSMutableAttributedString(string: string)
    attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle,
      range:NSMakeRange(0, attrString.length))
    return attrString
  }

  func scrollViewDidScroll(scrollView: UIScrollView) {
    pageControl.scrollViewDidScroll(scrollView)
  }

  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    pageControl.scrollViewDidEndDecelerating(scrollView)
  }

  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    pageControl.scrollViewDidEndScrollingAnimation(scrollView)
  }

}
