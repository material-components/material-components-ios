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

class ShrineCollectionViewCell: UICollectionViewCell {

  var imageView = UIImageView()
  var avatar = UIImageView()
  var remoteImageService = RemoteImageService()

  fileprivate var label = UILabel()
  fileprivate var labelAvatar = UILabel()
  fileprivate var labelPrice = UILabel()
  fileprivate var shrineInkOverlay = ShrineInkOverlay()
  fileprivate var cellContent = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    cellContent.frame = bounds
    cellContent.backgroundColor = UIColor.white
    cellContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    cellContent.clipsToBounds = true

    imageView.contentMode = .scaleAspectFill
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    cellContent.addSubview(imageView)

    avatar.layer.cornerRadius = 12
    avatar.backgroundColor = UIColor.lightGray
    avatar.clipsToBounds = true
    cellContent.addSubview(avatar)

    labelAvatar.lineBreakMode = .byWordWrapping
    labelAvatar.textColor = UIColor.gray
    labelAvatar.numberOfLines = 1
    labelAvatar.font = UIFont(name: "Helvetica", size: 14)
    cellContent.addSubview(labelAvatar)

    labelPrice.lineBreakMode = .byWordWrapping
    labelPrice.font = UIFont(name: "Helvetica-Bold", size: 16)
    cellContent.addSubview(labelPrice)

    shrineInkOverlay.frame = self.bounds
    shrineInkOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    cellContent.addSubview(shrineInkOverlay)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.addSubview(cellContent)

    let imagePad: CGFloat = 40
    imageView.frame = CGRect(x: imagePad,
      y: imagePad,
      width: self.frame.size.width - imagePad * 2,
      height: self.frame.size.height - 10 - imagePad * 2)
    let avatarDim: CGFloat = 24
    avatar.frame = CGRect(x: 10,
      y: self.frame.size.height - avatarDim - 10,
      width: avatarDim,
      height: avatarDim)
    labelAvatar.frame = CGRect(x: 15 + avatarDim,
      y: self.frame.size.height - 30,
      width: self.frame.size.width,
      height: 16)
    labelPrice.sizeToFit()
    labelPrice.frame = CGRect(x: self.frame.size.width - labelPrice.frame.size.width - 10,
      y: 10,
      width: labelPrice.frame.size.width,
      height: labelPrice.frame.size.height)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    avatar.image = nil
  }

  func populateCell(_ title: String,
                    imageName: String,
                    avatar: String,
                    shopTitle: String,
                    price: String) {
    labelAvatar.text = shopTitle
    labelPrice.text = price
    let urlString = ShrineData.baseURL + imageName
    let url = URL(string: urlString)
    remoteImageService.fetchImageAndThumbnail(from: url) { image, thumbnailImage in
      DispatchQueue.main.sync(execute: {
        self.imageView.image = thumbnailImage
      })
    }
    let avatarURLString = ShrineData.baseURL + avatar
    let avatarURL = URL(string: avatarURLString)
    remoteImageService.fetchImageAndThumbnail(from: avatarURL) { image, thumbnailImage in
      DispatchQueue.main.sync(execute: {
        self.avatar.image = thumbnailImage
      })
    }
  }

}
