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
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialIcons_ic_arrow_back
import RemoteImageServiceForMDCDemos

class ShrineDetailView: UIScrollView {

  var title = ""
  var desc = ""
  var imageName = "popsicle.png"
  fileprivate var remoteImageService = RemoteImageService()
  fileprivate var label = UILabel()
  fileprivate var labelDesc = UILabel()
  fileprivate var imageView = UIImageView()

  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundColor = .white
    let minContentHeight = CGFloat(640)
    contentSize = CGSize(width: frame.width, height: minContentHeight)

    let labelPadding: CGFloat = 50
    imageView.frame = CGRect(x: labelPadding, y: labelPadding,
      width: frame.size.width - 2 * labelPadding, height: 220)
    imageView.contentMode = UIView.ContentMode.scaleAspectFit
    imageView.autoresizingMask = .flexibleHeight
    addSubview(imageView)
    let urlString: String = ShrineData.baseURL + imageName
    let url = URL(string: urlString)
    remoteImageService.fetchImageAndThumbnail(from: url) { (image: UIImage?, _) -> Void in
      DispatchQueue.main.async(execute: {
        self.imageView.image = image
        self.imageView.setNeedsDisplay()
      })
    }

    configureTitleLabel(label: label, labelPadding: labelPadding)
    self.addSubview(label)

    configureDescriptionLabel(label: labelDesc, labelPadding: labelPadding)
    self.addSubview(labelDesc)
  }

  // MARK: Private

  func configureTitleLabel(label: UILabel, labelPadding: CGFloat) {
    label.font = UIFont(name: "AbrilFatface-Regular", size: 36)
    label.textColor = UIColor(red: 0.039, green: 0.192, blue: 0.259, alpha: 1)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 2

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 0.8
    let attrString = NSMutableAttributedString(string: title)
    attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                            value:paragraphStyle,
                            range: NSRange(location: 0, length:attrString.length))
    label.attributedText = attrString
    label.sizeToFit()
    label.frame = CGRect(x: labelPadding,
                         y: 280, width: label.frame.size.width, height: label.frame.size.height)
    label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  func configureDescriptionLabel(label: UILabel, labelPadding: CGFloat) {
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 5
    label.font = UIFont(name: "Helvetica", size: 14)
    label.textColor = UIColor(white: 0.54, alpha: 1)
    let descParagraphStyle = NSMutableParagraphStyle()
    descParagraphStyle.lineHeightMultiple = 1.5
    let descAttrString = NSMutableAttributedString(string: desc)
    descAttrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value:descParagraphStyle,
                                range:NSRange(location: 0, length: descAttrString.length))
    label.attributedText = descAttrString
    label.frame = CGRect(x: labelPadding,
                             y: 360, width: self.frame.size.width - 2 * labelPadding, height: 160)
    label.sizeToFit()
    label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
}

class ShrineDetailViewController: UIViewController {

  let fabPadding: CGFloat = 25
  var productTitle = ""
  var desc = ""
  var imageName = "popsicle.png"
  fileprivate let appBar = MDCAppBar()
  fileprivate let floatingButton = MDCFloatingButton()

  init() {
    super.init(nibName: nil, bundle: nil)

    addChild(appBar.headerViewController)
    appBar.headerViewController.headerView.backgroundColor = .clear
    appBar.navigationBar.tintColor = .black
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    let detailView = ShrineDetailView(frame: view.frame)
    detailView.title = productTitle
    detailView.desc = desc
    detailView.imageName = imageName
    detailView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(detailView)

    appBar.addSubviewsToParent()
    let backButton = UIBarButtonItem(title:"",
                                     style:.done,
                                     target:self,
                                     action:#selector(dismissDetails))
    let backImage = UIImage(named:MDCIcons.pathFor_ic_arrow_back())
    backButton.image = backImage
    appBar.navigationBar.leftBarButtonItem = backButton

    floatingButton.setTitle("+", for: UIControl.State())
    floatingButton.backgroundColor =
      UIColor(red: 0.086, green: 0.941, blue: 0.941, alpha: 1)
    floatingButton.sizeToFit()
    view.addSubview(floatingButton)
  }

  override func viewWillLayoutSubviews() {
    var safeAreaInset: CGFloat = 0
    #if swift(>=3.2)
      if #available(iOS 11.0, *) {
        safeAreaInset = self.view.safeAreaInsets.bottom
      }
    #endif
    let updatedFabPadding = max(fabPadding, safeAreaInset)
    floatingButton.frame = CGRect(x: view.frame.width - floatingButton.frame.width - updatedFabPadding,
                                  y: view.frame.height - floatingButton.frame.height - updatedFabPadding,
                                  width: floatingButton.frame.width,
                                  height: floatingButton.frame.height)
  }

  @objc func dismissDetails() {
    dismiss(animated: true, completion: nil)
  }

}
