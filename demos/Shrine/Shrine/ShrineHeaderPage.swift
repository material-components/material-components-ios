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
import RemoteImageServiceForMDCDemos

struct ShrineHeaderPage {

  let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
  let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
  let fontHelvetica = UIFont(name: "Helvetica", size: 14)
  let cyanBoxColor = UIColor(red: 0.19, green: 0.94, blue: 0.94, alpha: 1)
  let descColor = UIColor(white: 0.54, alpha: 1)
  let descString = "Leave the tunnel and the rain is fallin amazing things happen when you wait"

  var remoteImageService = RemoteImageService()

  var page: UIView
  var imageView: UIView
  var label: UILabel
  var labelDesc: UILabel
  var cyanBox: UIView
  var imageName: String
  var description: String

  init(page: UIView, imageView: UIImageView, label: UILabel, labelDesc: UILabel,
       cyanBox: UIView, imageName: String, description: String) {
    self.page = page
    self.imageView = imageView
    self.label = label
    self.labelDesc = labelDesc
    self.cyanBox = cyanBox
    self.imageName = imageName
    self.description = description

    imageView.contentMode = UIView.ContentMode.scaleAspectFill
    imageView.autoresizingMask = .flexibleHeight
    (page as AnyObject).addSubview(imageView)
    let url = URL(string: ShrineData.baseURL + imageName)
    remoteImageService.fetchImageAndThumbnail(from: url) { (image: UIImage?, _: UIImage?) -> Void in
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

  func attributedString(_ string: String,
                        lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    let attrString = NSMutableAttributedString(string: string)
    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle,
                            range:NSRange(location: 0, length: attrString.length))
    return attrString
  }

}
