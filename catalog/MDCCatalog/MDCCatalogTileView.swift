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

  private var componentNameString = "Misc"
  var componentName: String {
    get {
      return componentNameString
    }
    set {
      componentNameString = newValue
      imageView.image = getImage(componentNameString)
    }
  }
  private lazy var imageView = UIImageView()
  private let imageCache = NSCache<AnyObject, UIImage>()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    self.addSubview(imageView)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard !bounds.isEmpty else {
      return
    }
    imageView.image = getImage(componentNameString)
    imageView.frame = bounds
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
    var newImage: UIImage?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let colorScheme = appDelegate.colorScheme

    switch componentNameString {
    case "Activity Indicator":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawActivityIndicatorTile, colorScheme)
    case "Animation Timing":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawAnimationTimingTile, colorScheme)
    case "App Bar":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawAppBarTile, colorScheme)
    case "Bottom App Bar":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawBottomAppBarTile, colorScheme)
    case "Bottom Navigation":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawBottomNavTile, colorScheme)
    case "Bottom Sheet":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawBottomSheetTile, colorScheme)
    case "Button Bar":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawButtonBarTile, colorScheme)
    case "Buttons":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawButtonsTile, colorScheme)
    case "Collection Cells":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawCollectionCellsTile, colorScheme)
    case "Collections":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawCollectionsTile, colorScheme)
    case "Dialogs":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawDialogsTile, colorScheme)
    case "Feature Highlight":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawFeatureHighlightTile, colorScheme)
    case "Flexible Header":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawFlexibleHeaderTile, colorScheme)
    case "Ink":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawInkTile, colorScheme)
    case "Masked Transition":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawMaskedTransitionTile, colorScheme)
    case "Misc":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawMiscTile, colorScheme)
    case "Page Control":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawPageControlTile, colorScheme)
    case "Palettes":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawPalettesTile, colorScheme)
    case "Shadow":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawShadowLayerTile, colorScheme)
    case "Slider":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawSliderTile, colorScheme)
    case "Snackbar":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawSnackbarTile, colorScheme)
    case "Tab Bar":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawTabsTile, colorScheme)
    case "Text Field":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawTextFieldTile, colorScheme)
    case "Themes":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawThemesTile, colorScheme)
    case "Typography Custom Fonts":
      newImage = MDCDrawImage(bounds, MDCCatalogDrawTypographyCustomFontsTile, colorScheme)
    default:
      newImage = MDCDrawImage(bounds, MDCCatalogDrawMiscTile, colorScheme)
    }

    guard let unwrappedImage = newImage else {
      let emptyImage = UIImage()
      imageCache.setObject(emptyImage, forKey: componentNameString as AnyObject)
      return emptyImage
    }

    imageCache.setObject(unwrappedImage, forKey: componentNameString as AnyObject)
    return unwrappedImage
  }
  // swiftlint:enable function_body_length
}
