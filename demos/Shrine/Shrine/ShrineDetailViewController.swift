/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

class ShrineDetailView: UIScrollView {

  var title = ""
  var desc = ""
  var imageName = "popsicle.png"
  private var remoteImageService = RemoteImageService()
  private var label = UILabel()
  private var labelDesc = UILabel()
  private var floatingButton = MDCFloatingButton()
  private var imageView = UIImageView()

  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = UIColor.whiteColor()
    let minContentHeight = CGFloat(640)
    self.contentSize = CGSizeMake(self.frame.width, minContentHeight)

    let labelPadding:CGFloat = 50
    imageView.frame = CGRectMake(labelPadding, labelPadding,
      self.frame.size.width - 2 * labelPadding, 220)
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    imageView.autoresizingMask = .FlexibleHeight
    self.addSubview(imageView)
    let urlString:String = ShrineData.baseURL + imageName
    let url = NSURL(string: urlString)
    remoteImageService.fetchImageAndThumbnailFromURL(url) { (image:UIImage!,
      thumbnailImage:UIImage!) -> Void in
      dispatch_async(dispatch_get_main_queue(), {
        self.imageView.image = image
        self.imageView.setNeedsDisplay()
      })
    }

    label.font = UIFont(name: "AbrilFatface-Regular", size: 36)
    label.textColor = UIColor(red: 0.039, green: 0.192, blue: 0.259, alpha: 1)
    label.lineBreakMode = .ByWordWrapping
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
    label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.addSubview(label)

    labelDesc.lineBreakMode = .ByWordWrapping
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
    labelDesc.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.addSubview(labelDesc)

    floatingButton.setTitle("+", forState: UIControlState.Normal)
    floatingButton.backgroundColor =
      UIColor(red: 0.086, green: 0.941, blue: 0.941, alpha: 1)
    floatingButton.sizeToFit()
    floatingButton.frame = CGRectMake(self.frame.width - floatingButton.frame.width - labelPadding,
      500, floatingButton.frame.width, floatingButton.frame.height)
    self.addSubview(floatingButton)
  }

}

class ShrineDetailViewController: UIViewController {

  var productTitle = ""
  var desc = ""
  var imageName = "popsicle.png"

  override func viewDidLoad() {
    let detailView = ShrineDetailView(frame: self.view.frame)
    detailView.title = productTitle
    detailView.desc = desc
    detailView.imageName = imageName
    detailView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.view.addSubview(detailView)

    let dismissBtn = MDCFlatButton()
    dismissBtn.setTitle("Back", forState: UIControlState.Normal)
    dismissBtn.customTitleColor = UIColor.grayColor()
    dismissBtn.sizeToFit()
    dismissBtn.frame = CGRectMake(8, 28, dismissBtn.frame.width, dismissBtn.frame.height)
    dismissBtn.addTarget(self, action: #selector(dismissDetails),
                         forControlEvents: .TouchUpInside)
    self.view.addSubview(dismissBtn)
  }

  func dismissDetails() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

}
