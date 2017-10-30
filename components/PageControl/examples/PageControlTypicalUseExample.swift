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

import MaterialComponents.MaterialPageControl

class PageControlSwiftExampleViewController: UIViewController, UIScrollViewDelegate {

  static let pageColors = [
    MDCPalette.cyan.tint300,
    MDCPalette.cyan.tint500,
    MDCPalette.cyan.tint700,
    MDCPalette.cyan.tint300,
    MDCPalette.cyan.tint500,
    MDCPalette.cyan.tint700
  ]

  let pageControl = MDCPageControl()
  let scrollView = UIScrollView()
  let pageLabels: [UILabel] = PageControlSwiftExampleViewController.pageColors.enumerated().map {
      enumeration in
    let (i, pageColor) = enumeration
    let pageLabel = UILabel()
    pageLabel.text = "Page \(i + 1)"
    pageLabel.font = pageLabel.font.withSize(50)
    pageLabel.textColor = UIColor(white: 0, alpha: 0.8)
    pageLabel.backgroundColor = pageColor
    pageLabel.textAlignment = NSTextAlignment.center
    pageLabel.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
    return pageLabel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    scrollView.frame = self.view.bounds
    scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    scrollView.delegate = self
    scrollView.isPagingEnabled = true
    scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(pageLabels.count),
                                    height: view.bounds.height)
    scrollView.showsHorizontalScrollIndicator = false
    view.addSubview(scrollView)

    // Add pages to scrollView.
    for (i, pageLabel) in pageLabels.enumerated() {
      let pageFrame = view.bounds.offsetBy(dx: CGFloat(i) * view.bounds.width, dy: 0)
      pageLabel.frame = pageFrame
      scrollView.addSubview(pageLabel)
    }

    pageControl.numberOfPages = pageLabels.count

    pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
    pageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
    view.addSubview(pageControl)
  }

  // MARK: - Frame changes

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let pageBeforeFrameChange = pageControl.currentPage
    for (i, pageLabel) in pageLabels.enumerated() {
      pageLabel.frame = view.bounds.offsetBy(dx: CGFloat(i) * view.bounds.width, dy: 0)
    }
    scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(pageLabels.count),
                                    height: view.bounds.height)
    var offset = scrollView.contentOffset
    offset.x = CGFloat(pageBeforeFrameChange) * view.bounds.width
    // This non-anmiated change of offset ensures we keep the same page
    scrollView.contentOffset = offset

    var edgeInsets = UIEdgeInsets.zero;
    #if swift(>=3.2)
      if #available(iOS 11, *) {
        edgeInsets = self.view.safeAreaInsets
      }
    #endif
    let pageControlSize = pageControl.sizeThatFits(view.bounds.size)
    let yOffset = self.view.bounds.height - pageControlSize.height - 8 - edgeInsets.bottom;
    pageControl.frame =
        CGRect(x: 0, y: yOffset, width: view.bounds.width, height: pageControlSize.height)
  }

  // MARK: - UIScrollViewDelegate

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    pageControl.scrollViewDidScroll(scrollView)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    pageControl.scrollViewDidEndDecelerating(scrollView)
  }

  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    pageControl.scrollViewDidEndScrollingAnimation(scrollView)
  }

  // MARK: - User events

  @objc func didChangePage(_ sender: MDCPageControl) {
    var offset = scrollView.contentOffset
    offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width
    scrollView.setContentOffset(offset, animated: true)
  }

  // Creates a UIColor from a 24-bit RGB color encoded as an integer.
  // Pass in hex color values like so: ColorFromRGB(0x1EAAF1).
  class func ColorFromRGB(_ rgbValue: UInt32) -> UIColor {
    return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255,
        green: ((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255,
        blue: ((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255,
        alpha: 1)
  }

  // MARK: - CatalogByConvention

  @objc class func catalogBreadcrumbs() -> [String] {
    return [ "Page Control", "Swift example"]
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }
}
