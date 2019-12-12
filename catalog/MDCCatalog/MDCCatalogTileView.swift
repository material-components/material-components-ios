// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: AppTheme.didChangeGlobalThemeNotificationName,
                                              object: nil)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.backgroundColor = UIColor.clear
    self.addSubview(imageView)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.themeDidChange),
      name: AppTheme.didChangeGlobalThemeNotificationName,
      object: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  @objc func themeDidChange(notification: NSNotification) {
    imageCache.removeAllObjects()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard !bounds.isEmpty else {
      return
    }
    imageView.image = getImage(componentNameString)
    imageView.frame = bounds
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    imageCache.removeAllObjects()
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

    let colorScheme = AppTheme.containerScheme.colorScheme

    switch componentNameString {
    case "Activity Indicator":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawActivityIndicatorTile($0, $1) }, colorScheme)
    case "Animation Timing":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawAnimationTimingTile($0, $1) }, colorScheme)
    case "App Bar":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawAppBarTile($0, $1) }, colorScheme)
    case "Bottom App Bar":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawBottomAppBarTile($0, $1) }, colorScheme)
    case "Bottom Navigation":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawBottomNavTile($0, $1) }, colorScheme)
    case "Bottom Sheet":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawBottomSheetTile($0, $1) }, colorScheme)
    case "Button Bar":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawButtonBarTile($0, $1) }, colorScheme)
    case "Buttons":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawButtonsTile($0, $1) }, colorScheme)
    case "Collection Cells":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawCollectionCellsTile($0, $1) }, colorScheme)
    case "Collections":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawCollectionsTile($0, $1) }, colorScheme)
    case "Dialogs":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawDialogsTile($0, $1) }, colorScheme)
    case "Feature Highlight":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawFeatureHighlightTile($0, $1) }, colorScheme)
    case "Flexible Header":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawFlexibleHeaderTile($0, $1) }, colorScheme)
    case "Ink":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawInkTile($0, $1) }, colorScheme)
    case "Masked Transition":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawMaskedTransitionTile($0, $1) }, colorScheme)
    case "Misc":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawMiscTile($0, $1) }, colorScheme)
    case "Page Control":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawPageControlTile($0, $1) }, colorScheme)
    case "Palettes":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawPalettesTile($0, $1) }, colorScheme)
    case "Shadow":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawShadowLayerTile($0, $1) }, colorScheme)
    case "Slider":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawSliderTile($0, $1) }, colorScheme)
    case "Snackbar":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawSnackbarTile($0, $1) }, colorScheme)
    case "Tab Bar":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawTabsTile($0, $1) }, colorScheme)
    case "Text Field":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawTextFieldTile($0, $1) }, colorScheme)
    case "Themes":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawThemesTile($0, $1) }, colorScheme)
    case "Typography Custom Fonts":
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawTypographyCustomFontsTile($0, $1) }, colorScheme)
    default:
      newImage = MDCDrawImage(bounds, { MDCCatalogDrawMiscTile($0, $1) }, colorScheme)
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
