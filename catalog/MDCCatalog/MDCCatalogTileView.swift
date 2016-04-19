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
import MaterialComponents

class MDCCatalogTileView: UIView {

  private var componentNameString = "Misc"
  var componentName:String {
    get {
      return componentNameString
    }
    set {
      componentNameString = newValue
      imageView.image = getImage(componentNameString)
    }
  }
  let imageView = UIImageView()
  let imageCache = NSCache()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    self.addSubview(imageView)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    imageView.image = getImage(componentNameString)
  }

  func getImage(key: String) -> UIImage {
    if let cachedImage = imageCache.objectForKey(key) as? UIImage {
      let scale = UIScreen.mainScreen().scale
      let pixelSize = CGSizeMake(frame.width * scale, frame.height * scale)
      let cachedPixelSize = CGSizeMake(cachedImage.size.width * cachedImage.scale,
                                       cachedImage.size.height * cachedImage.scale)
      if (cachedPixelSize != pixelSize) {
        return createImage()
      }
      return cachedImage
    } else {
      return createImage()
    }
  }

  func createImage() -> UIImage {
    var newImage = UIImage()

    let defaultSize = CGRectMake(0, 0, 188, 155)
    let left = (self.frame.width - defaultSize.width) / 2
    let top = (self.frame.height - defaultSize.height) / 2
    let centeredFrame = CGRectMake(left, top, defaultSize.width, defaultSize.height)
    imageView.frame = centeredFrame

    switch componentNameString {
    case "App Bar":
      newImage = MDCCatalogTileDataAppBar.drawTileImage(centeredFrame)
    case "Button Bar":
      newImage = MDCCatalogTileDataButtonBar.drawTileImage(centeredFrame)
    case "Buttons":
      newImage = MDCCatalogTileDataButtons.drawTileImage(centeredFrame)
    case "Flexible Header":
      newImage = MDCCatalogTileDataFlexibleHeader.drawTileImage(centeredFrame)
    case "Header Stack View":
      newImage = MDCCatalogTileDataHeaderStackView.drawTileImage(centeredFrame)
    case "Ink":
      newImage = MDCCatalogTileDataInk.drawTileImage(centeredFrame)
    case "Navigation Bar":
      newImage = MDCCatalogTileDataNavigationBar.drawTileImage(centeredFrame)
    case "Misc":
      newImage = MDCCatalogTileDataMisc.drawTileImage(centeredFrame)
    case "Page Control":
      newImage = MDCCatalogTileDataPageControl.drawTileImage(centeredFrame)
    case "Shadow Layer":
      newImage = MDCCatalogTileDataShadowLayer.drawTileImage(centeredFrame)
    case "Slider":
      newImage = MDCCatalogTileDataSlider.drawTileImage(centeredFrame)
    case "Sprited Animation View":
      newImage = MDCCatalogTileDataSpritedAnimationView.drawTileImage(centeredFrame)
    case "Switch":
      newImage = MDCCatalogTileDataSwitch.drawTileImage(centeredFrame)
    case "Typography and Fonts":
      newImage = MDCCatalogTileDataTypography.drawTileImage(centeredFrame)
    default:
      newImage = MDCCatalogTileDataMisc.drawTileImage(centeredFrame)
    }
    imageCache.setObject(newImage, forKey: componentNameString)
    return newImage
  }

}
