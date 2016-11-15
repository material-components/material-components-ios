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
    case "Activity Indicator":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawActivityIndicatorTile)
    case "App Bar":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawAppBarTile)
    case "Button Bar":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawButtonBarTile)
    case "Buttons":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawButtonsTile)
    case "Collections":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawCollectionsTile)
    case "Feature Highlight":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawFeatureHighlight)
    case "Flexible Header":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawFlexibleHeaderTile)
    case "Header Stack View":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawHeaderStackViewTile)
    case "Ink":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawInkTile)
    case "Navigation Bar":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawNavigationBarTile)
    case "Misc":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawMiscTile)
    case "Page Control":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawPageControlTile)
    case "Shadow":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawShadowLayerTile)
    case "Slider":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawSliderTile)
    case "Snackbar":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawSnackbarTile)
    case "Sprited Animation View":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawSpritedAnimationViewTile)
    case "Switch":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawSwitchTile)
    case "Typography and Fonts":
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawTypographyTile)
    default:
      newImage = MDCDrawImage(centeredFrame, MDCCatalogDrawMiscTile)
    }
    imageCache.setObject(newImage, forKey: componentNameString)
    return newImage
  }

}
