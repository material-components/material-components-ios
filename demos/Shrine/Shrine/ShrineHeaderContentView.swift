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
import RemoteImageServiceForMDCDemos

class ShrineHeaderContentView: UIView, UIScrollViewDelegate {

  let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
  let fontHelvetica = UIFont(name: "Helvetica", size: 14)
  let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
  let cyanBoxColor = UIColor(red: 0.19, green: 0.94, blue: 0.94, alpha: 1)
  let descColor = UIColor(white: 0.54, alpha: 1)
  let descString = "Leave the tunnel and the rain is fallin amazing things happen when you wait"

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

  func addPage(page: UIView, imageView: UIImageView, label: UILabel, labelDesc: UILabel,
               cyanBox: UIView, imageName: String, description: String) {
    imageView.contentMode = UIViewContentMode.scaleAspectFill
    imageView.autoresizingMask = .flexibleHeight
    (page as AnyObject).addSubview(imageView)
    let url = URL(string: ShrineData.baseURL + imageName)
    remoteImageService.fetchImageAndThumbnail(from: url) { (image: UIImage?, _) -> Void in
      DispatchQueue.main.async(execute: {
        imageView.image = image
        imageView.setNeedsDisplay()
      })
    }

    label.font = fontAbril
    label.textColor = textColor
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 2
    label.attributedText = attributedString(description, lineHeightMultiple: 0.8)
    label.sizeToFit()
    (page as AnyObject).addSubview(label)

    labelDesc.lineBreakMode = .byWordWrapping
    labelDesc.numberOfLines = 3
    labelDesc.font = fontHelvetica
    labelDesc.textColor = descColor
    labelDesc.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
    labelDesc.autoresizingMask = .flexibleWidth
    (page as AnyObject).addSubview(labelDesc)

    cyanBox.backgroundColor = cyanBoxColor
    (page as AnyObject).addSubview(cyanBox)

    let inkOverlay = ShrineInkOverlay(frame: (page as AnyObject).bounds)
    inkOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    (page as AnyObject).addSubview(inkOverlay)

  }

  func addPageContent() {
    let firstPage = pages[0]
    let secondPage = pages[1]
    let thirdPage = pages[2]

    addPage(page: firstPage as! UIView, imageView: imageView, label: label, labelDesc: labelDesc,
            cyanBox: cyanBox, imageName: "chair.png", description: "Green \ncomfort chair")
    addPage(page: secondPage as! UIView, imageView: imageView2, label: label2, labelDesc: labelDesc2,
            cyanBox: cyanBox2, imageName: "backpack.png", description: "Best gift for \nthe traveler")
    addPage(page: thirdPage as! UIView, imageView: imageView3, label: label3, labelDesc: labelDesc3,
            cyanBox: cyanBox3, imageName: "heels.png", description: "Better \nwearing heels")
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
    let scrollWidth: CGFloat = boundsWidth * CGFloat(pages.count)
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
