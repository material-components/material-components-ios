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

import MaterialCatalog

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

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let colorScheme = appDelegate.colorScheme

    switch componentNameString {
    case "Activity Indicator":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawActivityIndicatorTile($0, $1) }, colorScheme)
    case "Animation Timing":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawAnimationTimingTile($0, $1) }, colorScheme)
    case "App Bar":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawAppBarTile($0, $1) }, colorScheme)
    case "Button Bar":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawButtonBarTile($0, $1) }, colorScheme)
    case "Buttons":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawButtonsTile($0, $1) }, colorScheme)
    case "Collection Cells":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawCollectionCellsTile($0, $1) }, colorScheme)
    case "Collections":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawCollectionsTile($0, $1) }, colorScheme)
    case "Dialogs":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawDialogsTile($0, $1) }, colorScheme)
    case "Feature Highlight":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawFeatureHighlightTile($0, $1) }, colorScheme)
    case "Flexible Header":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawFlexibleHeaderTile($0, $1) }, colorScheme)
    case "Header Stack View":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawHeaderStackViewTile($0, $1) }, colorScheme)
    case "Ink":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawInkTile($0, $1) }, colorScheme)
    case "Navigation Bar":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawNavigationBarTile($0, $1) }, colorScheme)
    case "Misc":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawMiscTile($0, $1) }, colorScheme)
    case "Overlay Window":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawOverlayWindow($0, $1) }, colorScheme)
    case "Page Control":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawPageControlTile($0, $1) }, colorScheme)
    case "Palettes":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawPalettesTile($0, $1) }, colorScheme)
    case "Progress View":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawProgressViewTile($0, $1) }, colorScheme)
    case "Shadow":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawShadowLayerTile($0, $1) }, colorScheme)
    case "Slider":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawSliderTile($0, $1) }, colorScheme)
    case "Snackbar":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawSnackbarTile($0, $1) }, colorScheme)
    case "Switch":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawSwitchTile($0, $1) }, colorScheme)
    case "Tab Bar":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawTabsTile($0, $1) }, colorScheme)
    case "Text Field":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawTextFieldTile($0, $1) }, colorScheme)
    case "Typography and Fonts":
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawTypographyTile($0, $1) }, colorScheme)
    default:
      newImage = MDCDrawImage(defaultSize, { MDCCatalogDrawMiscTile($0, $1) }, colorScheme)
    }
    imageCache.setObject(newImage, forKey: componentNameString as AnyObject)
    return newImage
  }
  // swiftlint:enable function_body_length

}
