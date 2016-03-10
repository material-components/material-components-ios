import UIKit

class ShrineHeaderContentView: UIView, UIScrollViewDelegate {

  var remoteImageService = RemoteImageService()

  private let logoImageView = UIImageView(image: UIImage(named: "ShrineLogo"))
  private var pages = NSMutableArray()
  private var pageControl = MDCPageControl()
  private var scrollView = UIScrollView()

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
    let contentViewFrame = firstPage.frame
    let adjustedFrame = CGRectMake(-160, 120, contentViewFrame!.size.width,
      contentViewFrame!.size.height)
    let imageView = UIImageView(frame: adjustedFrame)
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.autoresizingMask = .FlexibleHeight
    firstPage.addSubview(imageView)
    let url = NSURL(string: ShrineData.baseURL + "chair.png")
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

    let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
    let fontHelvetica = UIFont(name: "Helvetica", size: 10)
    let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    let descColor = UIColor(white: 0.54, alpha: 1)

    let label = UILabel()
    label.font = fontAbril
    label.textColor = textColor
    label.lineBreakMode = .ByWordWrapping
    label.numberOfLines = 2
    label.attributedText = attributedString("Green \ncomfort chair", lineHeightMultiple: 0.8)
    label.sizeToFit();
    label.frame = CGRectMake(self.frame.width - label.frame.size.width - 20,
      80, label.frame.size.width, label.frame.size.height)
    label.autoresizingMask = .FlexibleWidth
    firstPage.addSubview(label)

    let labelDesc = UILabel()
    labelDesc.lineBreakMode = .ByWordWrapping
    labelDesc.numberOfLines = 2
    labelDesc.font = fontHelvetica
    labelDesc.textColor = descColor
    labelDesc.attributedText =
      attributedString("Leave the tunnel and the rain is fallin \namazing things happen when you wait",
        lineHeightMultiple: 1.2)
    labelDesc.sizeToFit();
    labelDesc.frame = CGRectMake(self.frame.width - labelDesc.frame.size.width - 20,
      170, labelDesc.frame.size.width, labelDesc.frame.size.height)
    labelDesc.autoresizingMask = .FlexibleWidth
    firstPage.addSubview(labelDesc)
    let inkOverlay = ShrineInkOverlay(frame: firstPage.bounds)
    inkOverlay.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    firstPage.addSubview(inkOverlay)

    let contentViewFrame2 = secondPage.frame
    let adjustedFrame2 = CGRectMake(-190, 60, contentViewFrame2!.size.width,
      contentViewFrame2!.size.height)

    let imageView2 = UIImageView(frame: adjustedFrame2)
    imageView2.contentMode = UIViewContentMode.ScaleAspectFill
    imageView2.autoresizingMask = .FlexibleHeight
    secondPage.addSubview(imageView2)
    let url2 = NSURL(string: ShrineData.baseURL + "backpack.png")
    remoteImageService.fetchImageDataFromURL(url2, completion: {(imageData:NSData!) in
      if (imageData == nil) {
        return;
      }
      dispatch_async(dispatch_get_main_queue(), {
        let image = UIImage(data: imageData)
        imageView2.image = image;
        imageView2.setNeedsDisplay()
      })
    })

    let label2 = UILabel()
    label2.font = fontAbril
    label2.textColor = textColor
    label2.lineBreakMode = .ByWordWrapping
    label2.numberOfLines = 2
    label2.attributedText = attributedString("Best gift for \nthe traveler",
      lineHeightMultiple: 0.8)
    label2.sizeToFit();
    label2.frame = CGRectMake(self.frame.width - label2.frame.size.width - 20,
      90, label2.frame.size.width, label2.frame.size.height)
    label2.autoresizingMask = .FlexibleWidth
    secondPage.addSubview(label2)

    let labelDesc2 = UILabel()
    labelDesc2.lineBreakMode = .ByWordWrapping
    labelDesc2.numberOfLines = 2
    labelDesc2.font = fontHelvetica
    labelDesc2.textColor = descColor
    labelDesc2.attributedText =
      attributedString("Leave the tunnel and the rain is fallin \namazing things happen when you wait",
        lineHeightMultiple: 1.2)
    labelDesc2.sizeToFit();
    labelDesc2.frame = CGRectMake(self.frame.width - labelDesc2.frame.size.width - 20,
      180, labelDesc2.frame.size.width, labelDesc2.frame.size.height)
    labelDesc2.autoresizingMask = .FlexibleWidth
    secondPage.addSubview(labelDesc2)
    let inkOverlay2 = ShrineInkOverlay(frame: secondPage.bounds)
    inkOverlay2.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    secondPage.addSubview(inkOverlay2)

    let contentViewFrame3 = thirdPage.frame
    let adjustedFrame3 = CGRectMake(-150, 65, contentViewFrame3!.size.width,
      contentViewFrame3!.size.height)

    let imageView3 = UIImageView(frame: adjustedFrame3)
    imageView3.contentMode = UIViewContentMode.ScaleAspectFill
    imageView3.autoresizingMask = .FlexibleHeight
    thirdPage.addSubview(imageView3)
    let url3 = NSURL(string: ShrineData.baseURL + "heels.png")
    remoteImageService.fetchImageDataFromURL(url3, completion: {(imageData:NSData!) in
      if (imageData == nil) {
        return;
      }
      dispatch_async(dispatch_get_main_queue(), {
        let image = UIImage(data: imageData)
        imageView3.image = image;
        imageView3.setNeedsDisplay()
      })
    })

    let label3 = UILabel()
    label3.font = fontAbril
    label3.textColor = textColor
    label3.lineBreakMode = .ByWordWrapping
    label3.numberOfLines = 2
    label3.attributedText = attributedString("Better \nwearing heels", lineHeightMultiple: 0.8)
    label3.sizeToFit();
    label3.frame = CGRectMake(self.frame.width - label3.frame.size.width - 20,
      80, label3.frame.size.width, label3.frame.size.height)
    label3.autoresizingMask = .FlexibleWidth
    thirdPage.addSubview(label3)

    let labelDesc3 = UILabel()
    labelDesc3.lineBreakMode = .ByWordWrapping
    labelDesc3.numberOfLines = 2
    labelDesc3.font = fontHelvetica
    labelDesc3.textColor = descColor
    labelDesc3.attributedText =
      attributedString("Leave the tunnel and the rain is fallin \namazing things happen when you wait",
        lineHeightMultiple: 1.2)
    labelDesc3.sizeToFit();
    labelDesc3.frame = CGRectMake(self.frame.width - labelDesc3.frame.size.width - 20,
      170, labelDesc3.frame.size.width, labelDesc3.frame.size.height)
    labelDesc3.autoresizingMask = .FlexibleWidth
    thirdPage.addSubview(labelDesc3)
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
  }

  func attributedString(string: String, lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    paragraphStyle.alignment = .Right
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
