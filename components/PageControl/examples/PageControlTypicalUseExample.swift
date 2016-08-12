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

import Foundation

import MaterialComponents

class PageControlSwiftExampleViewController: UIViewController, UIScrollViewDelegate {

  let pageControl = MDCPageControl()
  let scrollView = UIScrollView()
  let pages = NSMutableArray()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.whiteColor()

    let pageColors = [
      self.dynamicType.ColorFromRGB(0x55C4f5),
      self.dynamicType.ColorFromRGB(0x35B7F3),
      self.dynamicType.ColorFromRGB(0x1EAAF1),
      self.dynamicType.ColorFromRGB(0x55C4f5),
      self.dynamicType.ColorFromRGB(0x35B7F3),
      self.dynamicType.ColorFromRGB(0x1EAAF1),
    ];

    scrollView.frame = self.view.bounds
    scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    scrollView.delegate = self
    scrollView.pagingEnabled = true
    scrollView.contentSize = CGSizeMake(view.bounds.width * CGFloat(pageColors.count), view.bounds.height)
    scrollView.showsHorizontalScrollIndicator = false;
    view.addSubview(scrollView)

    // Add pages to scrollView.
    for (i, pageColor) in pageColors.enumerate() {
      let pageFrame:CGRect = CGRectOffset(self.view.bounds, CGFloat(i) * view.bounds.width, 0);
      let page = UILabel.init(frame:pageFrame)
      page.text = String(format: "Page %zd", i + 1)
      page.font = page.font.fontWithSize(50)
      page.textColor = UIColor.init(white: 0, alpha: 0.8)
      page.backgroundColor = pageColor;
      page.textAlignment = NSTextAlignment.Center;
      page.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin]
      scrollView.addSubview(page)
      pages.addObject(page)
    }

    pageControl.numberOfPages = pageColors.count

    let pageControlSize = pageControl.sizeThatFits(view.bounds.size)
    pageControl.frame = CGRectMake(0, view.bounds.height - pageControlSize.height, view.bounds.width, pageControlSize.height);
    pageControl.addTarget(self, action: #selector(didChangePage), forControlEvents: .ValueChanged)
    pageControl.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth];
    view.addSubview(pageControl)
  }

  // MARK: - Frame changes

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let pageBeforeFrameChange = pageControl.currentPage;
    for (i, page) in pages.enumerate() {
      let pageLabel:UILabel = page as! UILabel
      pageLabel.frame = CGRectOffset(view.bounds, CGFloat(i) * view.bounds.width, 0);
    }
    scrollView.contentSize = CGSizeMake(view.bounds.width * CGFloat(pages.count), view.bounds.height);
    var offset = scrollView.contentOffset;
    offset.x = CGFloat(pageBeforeFrameChange) * view.bounds.width;
    // This non-anmiated change of offset ensures we keep the same page
    scrollView.contentOffset = offset;
  }

  // MARK: - UIScrollViewDelegate

  func scrollViewDidScroll(scrollView: UIScrollView) {
    pageControl.scrollViewDidScroll(scrollView)
  }

  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    pageControl.scrollViewDidEndDecelerating(scrollView)
  }

  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    pageControl.scrollViewDidEndScrollingAnimation(scrollView)
  }

  // MARK: - User events

  func didChangePage(sender: MDCPageControl){
    var offset = scrollView.contentOffset
    offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
    scrollView.setContentOffset(offset, animated: true)
  }

  // MARK: CatalogByConvention

  class func catalogBreadcrumbs() -> [String] {
    return [ "Page Control", "Swift example"]
  }

  // Creates a UIColor from a 24-bit RGB color encoded as an integer.
  // Pass in hex color values like so: ColorFromRGB(0x1EAAF1).
  class func ColorFromRGB(rgbValue: UInt32) -> UIColor {
    return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255,
        green: ((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255,
        blue: ((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255,
        alpha: 1)
  }
}
