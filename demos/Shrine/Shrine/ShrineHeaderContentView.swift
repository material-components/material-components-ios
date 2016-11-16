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
import MaterialComponents.MaterialPageControl
import RemoteImageService

class ShrineHeaderContentView: UIView, UIScrollViewDelegate {

  var remoteImageService = RemoteImageService()

  var pageControl = MDCPageControl()
  var scrollView = UIScrollView()
  var logoImageView = UIImageView(image: UIImage(named: "ShrineLogo"))
  var logoTextImageView = UIImageView(image: UIImage(named: "ShrineTextLogo"))
  fileprivate var pages = NSMutableArray()
  fileprivate var label = UILabel()
  fileprivate var labelDesc = UILabel()
  fileprivate var label2 = UILabel()
  fileprivate var labelDesc2 = UILabel()
  fileprivate var label3 = UILabel()
  fileprivate var labelDesc3 = UILabel()
  fileprivate var cyanBox = UIView()
  fileprivate var cyanBox2 = UIView()
  fileprivate var cyanBox3 = UIView()
  fileprivate var imageView = UIImageView()
  fileprivate var imageView2 = UIImageView()
  fileprivate var imageView3 = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  func commonInit() {
    let boundsWidth = self.bounds.width
    let boundsHeight = self.bounds.height
    scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    scrollView.delegate = self
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    self.addSubview(scrollView)
    self.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    for i in 0...2 {
      let boundsLeft = CGFloat(i) * boundsWidth
      let pageFrame = self.bounds.offsetBy(dx: boundsLeft, dy: 0)
      let page = UIView(frame:pageFrame)
      page.clipsToBounds = true
      page.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      pages.add(page)
      scrollView.addSubview(page)
    }

    pageControl.numberOfPages = 3
    pageControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    let pageControlSize = pageControl.sizeThatFits(self.bounds.size)
    pageControl.frame = CGRect(x: 0,
      y: boundsHeight - pageControlSize.height,
      width: boundsWidth,
      height: pageControlSize.height)
    pageControl.addTarget(self, action: #selector(didChangePage),
                          for: UIControlEvents.valueChanged)
    self.addSubview(pageControl)

    addPageContent()
    self.addSubview(logoImageView)
    self.addSubview(logoTextImageView)
  }

  func addPageContent() {
    let firstPage = pages[0]
    let secondPage = pages[1]
    let thirdPage = pages[2]
    imageView.contentMode = UIViewContentMode.scaleAspectFill
    imageView.autoresizingMask = .flexibleHeight
    (firstPage as AnyObject).addSubview(imageView)
    let url = URL(string: ShrineData.baseURL + "chair.png")
    remoteImageService.fetchImageAndThumbnail(from: url) { (image:UIImage?,
      thumbnailImage:UIImage?) -> Void in
      DispatchQueue.main.async(execute: {
        self.imageView.image = image;
        self.imageView.setNeedsDisplay()
      })
    }

    let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
    let fontHelvetica = UIFont(name: "Helvetica", size: 14)
    let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    let cyanBoxColor = UIColor(red: 0.19, green: 0.94, blue: 0.94, alpha: 1)
    let descColor = UIColor(white: 0.54, alpha: 1)
    let descString = "Leave the tunnel and the rain is fallin amazing things happen when you wait"

    label.font = fontAbril
    label.textColor = textColor
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 2
    label.attributedText = attributedString("Green \ncomfort chair", lineHeightMultiple: 0.8)
    label.sizeToFit();
    (firstPage as AnyObject).addSubview(label)

    labelDesc.lineBreakMode = .byWordWrapping
    labelDesc.numberOfLines = 3
    labelDesc.font = fontHelvetica
    labelDesc.textColor = descColor
    labelDesc.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    labelDesc.autoresizingMask = .flexibleWidth
    (firstPage as AnyObject).addSubview(labelDesc)

    cyanBox.backgroundColor = cyanBoxColor
    (firstPage as AnyObject).addSubview(cyanBox)

    let inkOverlay = ShrineInkOverlay(frame: (firstPage as AnyObject).bounds)
    inkOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    (firstPage as AnyObject).addSubview(inkOverlay)

    imageView2.contentMode = UIViewContentMode.scaleAspectFill
    imageView2.autoresizingMask = .flexibleHeight
    (secondPage as AnyObject).addSubview(imageView2)
    let url2 = URL(string: ShrineData.baseURL + "backpack.png")
    remoteImageService.fetchImageAndThumbnail(from: url2) { (image:UIImage?,
      thumbnailImage:UIImage?) -> Void in
      DispatchQueue.main.async(execute: {
        self.imageView2.image = image;
        self.imageView2.setNeedsDisplay()
      })
    }

    label2.font = fontAbril
    label2.textColor = textColor
    label2.lineBreakMode = .byWordWrapping
    label2.numberOfLines = 2
    label2.attributedText = attributedString("Best gift for \nthe traveler",
      lineHeightMultiple: 0.8)
    (secondPage as AnyObject).addSubview(label2)

    labelDesc2.lineBreakMode = .byWordWrapping
    labelDesc2.numberOfLines = 2
    labelDesc2.font = fontHelvetica
    labelDesc2.textColor = descColor
    labelDesc2.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    (secondPage as AnyObject).addSubview(labelDesc2)

    cyanBox2.backgroundColor = cyanBoxColor
    (secondPage as AnyObject).addSubview(cyanBox2)

    let inkOverlay2 = ShrineInkOverlay(frame: (secondPage as AnyObject).bounds)
    inkOverlay2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    (secondPage as AnyObject).addSubview(inkOverlay2)

    imageView3.contentMode = UIViewContentMode.scaleAspectFill
    imageView3.autoresizingMask = .flexibleHeight
    (thirdPage as AnyObject).addSubview(imageView3)
    let url3 = URL(string: ShrineData.baseURL + "heels.png")
    remoteImageService.fetchImageAndThumbnail(from: url3) { (image:UIImage?,
      thumbnailImage:UIImage?) -> Void in
      DispatchQueue.main.async(execute: {
        self.imageView3.image = image;
        self.imageView3.setNeedsDisplay()
      })
    }

    label3.font = fontAbril
    label3.textColor = textColor
    label3.lineBreakMode = .byWordWrapping
    label3.numberOfLines = 2
    label3.attributedText = attributedString("Better \nwearing heels", lineHeightMultiple: 0.8)
    (thirdPage as AnyObject).addSubview(label3)

    labelDesc3.lineBreakMode = .byWordWrapping
    labelDesc3.numberOfLines = 2
    labelDesc3.font = fontHelvetica
    labelDesc3.textColor = descColor
    labelDesc3.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    (thirdPage as AnyObject).addSubview(labelDesc3)

    cyanBox3.backgroundColor = cyanBoxColor
    (thirdPage as AnyObject).addSubview(cyanBox3)

    let inkOverlay3 = ShrineInkOverlay(frame: (thirdPage as AnyObject).bounds)
    inkOverlay3.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    (thirdPage as AnyObject).addSubview(inkOverlay3)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let boundsWidth = self.bounds.width
    let boundsHeight = self.bounds.height
    for i in 0...pages.count - 1 {
      let boundsLeft = CGFloat(i) * boundsWidth
      let pageFrame = self.bounds.offsetBy(dx: boundsLeft, dy: 0)
      let page = pages[i] as! UIView
      page.frame = pageFrame
    }
    let pageControlSize = pageControl.sizeThatFits(self.bounds.size)
    pageControl.frame = CGRect(x: 0, y: boundsHeight - pageControlSize.height, width: boundsWidth,
      height: pageControlSize.height)
    let scrollWidth:CGFloat = boundsWidth * CGFloat(pages.count)
    scrollView.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight)
    scrollView.contentSize = CGSize(width: scrollWidth, height: boundsHeight)

    let scrollViewOffsetX = CGFloat(pageControl.currentPage) * boundsWidth
    scrollView.setContentOffset(CGPoint(x: scrollViewOffsetX, y: 0), animated: false)
    logoImageView.center = CGPoint(x: (self.frame.size.width) / 2, y: 44)
    logoTextImageView.center = CGPoint(x: (self.frame.size.width) / 2, y: 44)

    let labelWidth = CGFloat(250)
    let labelWidthFrame = CGRect(x: self.frame.size.width - labelWidth,
      y: 90, width: labelWidth, height: label.frame.size.height)

    let labelDescWidth = CGFloat(200)
    let labelDescWidthFrame = CGRect(x: self.frame.size.width - labelDescWidth - 10,
      y: 190, width: labelDescWidth, height: 40)

    label.frame = labelWidthFrame
    labelDesc.frame = labelDescWidthFrame
    label2.frame = labelWidthFrame
    labelDesc2.frame = labelDescWidthFrame
    label3.frame = labelWidthFrame
    labelDesc3.frame = labelDescWidthFrame

    let cyanBoxFrame = CGRect(x: self.frame.size.width - 210, y: 180, width: 100, height: 8)
    cyanBox.frame = cyanBoxFrame
    cyanBox2.frame = cyanBoxFrame
    cyanBox3.frame = cyanBoxFrame

    imageView.frame = CGRect(x: -180, y: 120, width: 420, height: self.frame.size.height)
    imageView2.frame = CGRect(x: -220, y: 110, width: 420, height: self.frame.size.height)
    imageView3.frame = CGRect(x: -180, y: 40, width: 420, height: self.frame.size.height)
  }

  func attributedString(_ string: String, lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    let attrString = NSMutableAttributedString(string: string)
    attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle,
      range:NSMakeRange(0, attrString.length))
    return attrString
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    pageControl.scrollViewDidScroll(scrollView)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    pageControl.scrollViewDidEndDecelerating(scrollView)
  }

  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    pageControl.scrollViewDidEndScrollingAnimation(scrollView)
  }

  func didChangePage(_ sender: MDCPageControl) {
    var offset = scrollView.contentOffset
    offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width
    scrollView.setContentOffset(offset, animated: true)
  }

}
