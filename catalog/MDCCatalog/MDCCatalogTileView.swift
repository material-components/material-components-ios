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

class MDCCatalogTileView: UIView {

  fileprivate var componentNameString = "Misc"
  var componentName: String {
    get {
      return componentNameString
    }
    set {
      componentNameString = newValue
      imageView.image = getImage(componentNameString)
    }
  }
  let imageView = UIImageView()
  let imageCache = NSCache<AnyObject, UIImage>()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.addSubview(imageView)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    imageView.image = getImage(componentNameString)
  }

  func getImage(_ key: String) -> UIImage {
    if let cachedImage = imageCache.object(forKey: key as AnyObject) {
      let scale = UIScreen.main.scale
      let pixelSize = CGSize(width: frame.width * scale, height: frame.height * scale)
      let cachedPixelSize = CGSize(width: cachedImage.size.width * cachedImage.scale,
                                       height: cachedImage.size.height * cachedImage.scale)
      if cachedPixelSize != pixelSize {
        return createImage()
      }
      return cachedImage
    } else {
      return createImage()
    }
  }

  // This function is long but simple. The name-to-drawing map would be better replaced by a real
  // dictionary, but Swift's dictionaries can't seem to handle C function pointers.
  // swiftlint:disable function_body_length
  func createImage() -> UIImage {
    var newImage = UIImage()

    let defaultSize = CGRect(x: 0, y: 0, width: 188, height: 155)
    let left = (self.frame.width - defaultSize.width) / 2
    let top = (self.frame.height - defaultSize.height) / 2
    imageView.frame = CGRect(x: left, y: top, width: defaultSize.width, height: defaultSize.height)

    switch componentNameString {
    case "Activity Indicator":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawActivityIndicatorTile)
    case "Animation Timing":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawAnimationTimingTile)
    case "App Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawAppBarTile)
    case "Button Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawButtonBarTile)
    case "Buttons":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawButtonsTile)
    case "Collection Cells":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawCollectionCellsTile)
    case "Collections":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawCollectionsTile)
    case "Dialogs":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawDialogsTile)
    case "Feature Highlight":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawFeatureHighlightTile)
    case "Flexible Header":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawFlexibleHeaderTile)
    case "Header Stack View":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawHeaderStackViewTile)
    case "Ink":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawInkTile)
    case "Navigation Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawNavigationBarTile)
    case "Misc":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawMiscTile)
    case "Overlay Window":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawOverlayWindow)
    case "Page Control":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawPageControlTile)
    case "Palettes":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawPalettesTile)
    case "Progress View":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawProgressViewTile)
    case "Shadow":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawShadowLayerTile)
    case "Slider":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawSliderTile)
    case "Snackbar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawSnackbarTile)
    case "Switch":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawSwitchTile)
    case "Tab Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawTabsTile)
    case "Text Field":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawTextFieldTile)
    case "Typography and Fonts":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawTypographyTile)
    default:
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawMiscTile)
    }
    imageCache.setObject(newImage, forKey: componentNameString as AnyObject)
    return newImage
  }
  // swiftlint:enable function_body_length

}
