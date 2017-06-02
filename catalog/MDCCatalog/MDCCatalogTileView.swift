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
    
    let colorScheme = MDCColorSchemeView.appearance().colorScheme

    switch componentNameString {
    case "Activity Indicator":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawActivityIndicatorTile, colorScheme)
    case "Animation Timing":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawAnimationTimingTile, colorScheme)
    case "App Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawAppBarTile, colorScheme)
    case "Button Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawButtonBarTile, colorScheme)
    case "Buttons":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawButtonsTile, colorScheme)
    case "Collection Cells":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawCollectionCellsTile, colorScheme)
    case "Collections":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawCollectionsTile, colorScheme)
    case "Dialogs":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawDialogsTile, colorScheme)
    case "Feature Highlight":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawFeatureHighlightTile, colorScheme)
    case "Flexible Header":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawFlexibleHeaderTile, colorScheme)
    case "Header Stack View":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawHeaderStackViewTile, colorScheme)
    case "Ink":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawInkTile, colorScheme)
    case "Navigation Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawNavigationBarTile, colorScheme)
    case "Misc":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawMiscTile, colorScheme)
    case "Overlay Window":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawOverlayWindow, colorScheme)
    case "Page Control":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawPageControlTile, colorScheme)
    case "Palettes":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawPalettesTile, colorScheme)
    case "Progress View":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawProgressViewTile, colorScheme)
    case "Shadow":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawShadowLayerTile, colorScheme)
    case "Slider":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawSliderTile, colorScheme)
    case "Snackbar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawSnackbarTile, colorScheme)
    case "Switch":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawSwitchTile, colorScheme)
    case "Tab Bar":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawTabsTile, colorScheme)
    case "Text Field":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawTextFieldTile, colorScheme)
    case "Typography and Fonts":
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawTypographyTile, colorScheme)
    default:
      newImage = MDCDrawImage(defaultSize, MDCCatalogDrawMiscTile, colorScheme)
    }
    imageCache.setObject(newImage, forKey: componentNameString as AnyObject)
    return newImage
  }
  // swiftlint:enable function_body_length

}
