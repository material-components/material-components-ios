/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
 
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

import MaterialComponents.MaterialTypography

class MDCDragonsCollectionViewCell: UICollectionViewCell {
  
  fileprivate struct Constants {
    static let imageWidthHeight: CGFloat = 80
    static let xPadding: CGFloat = 14
    static let yPadding: CGFloat = 16
  }
  
  private lazy var label: UILabel = {
    let label = UILabel()
    label.textColor = UIColor(white: 0, alpha: MDCTypography.buttonFontOpacity())
    label.font = UIFont.systemFont(ofSize: 10)
    
    return label
  }()
  private lazy var imageView = UIImageView()
  private let imageCache = NSCache<AnyObject, UIImage>()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(label)
    contentView.clipsToBounds = true
    contentView.addSubview(imageView)
    self.layer.cornerRadius = self.bounds.size.width / 2
    self.clipsToBounds = true
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    label.sizeToFit()
    label.frame = CGRect(
      x: Constants.xPadding,
      y: frame.height - label.frame.height - Constants.yPadding,
      width: frame.width - Constants.xPadding * 2,
      height: label.frame.height
    )
    label.textAlignment = .center
    imageView.bounds = CGRect(x: 0,
                         y: 0,
                         width: Constants.imageWidthHeight,
                         height: Constants.imageWidthHeight)
    imageView.center = CGPoint(x: contentView.bounds.width / 2,
                          y: label.frame.minY / 2 )
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = ""
  }
  
  func populateView(_ componentName: String, color: UIColor) {
    label.text = componentName
    imageView.image = getImage("tile", color: color)
    accessibilityIdentifier = componentName
  }
  
  func getImage(_ key: String, color: UIColor) -> UIImage {
    if let cachedImage = imageCache.object(forKey: key as AnyObject) {
      let scale = UIScreen.main.scale
      let pixelSize = CGSize(width: frame.width * scale, height: frame.height * scale)
      let cachedPixelSize = CGSize(width: cachedImage.size.width * cachedImage.scale,
                                   height: cachedImage.size.height * cachedImage.scale)
      if cachedPixelSize != pixelSize {
        return createImage(key: key, color: color)
      }
      return cachedImage
    } else {
      return createImage(key: key, color: color)
    }
  }
  
  func createImage(key: String, color: UIColor) -> UIImage {
    var newImage: UIImage?
    newImage = MDCDrawDragons.image(with: MDCDrawDragons.drawTile,
                                    size: CGSize(width: Constants.imageWidthHeight,
                                                 height: Constants.imageWidthHeight),
                                    fillColor: color)
    
    guard let unwrappedImage = newImage else {
      let emptyImage = UIImage()
      imageCache.setObject(emptyImage, forKey: key as AnyObject)
      return emptyImage
    }
    
    imageCache.setObject(unwrappedImage, forKey: key as AnyObject)
    return unwrappedImage
  }
}
