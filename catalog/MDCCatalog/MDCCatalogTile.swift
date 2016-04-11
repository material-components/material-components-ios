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

class MDCCatalogTile: UIView {

  internal var componentNameString = "Buttons"
  internal var componentName:String {
    get {
      return componentNameString
    }
    set {
      componentNameString = newValue
      self.setNeedsDisplay()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    self.setNeedsDisplay()
  }

  override func drawRect(rect: CGRect) {

    let defaultSize = CGRectMake(0, 0, 188, 155)
    let left = (rect.width - defaultSize.width) / 2
    let top = (rect.height - defaultSize.height) / 2
    let centeredFrame = CGRectMake(left, top, defaultSize.width, defaultSize.height)

    switch componentNameString {
    case "App Bar":
      MDCCatalogTileDataAppBar.drawTile(centeredFrame)
    case "Button Bar":
      MDCCatalogTileDataButtonBar.drawTile(centeredFrame)
    case "Buttons":
      MDCCatalogTileDataButtons.drawTile(centeredFrame)
    case "Flexible Header":
      MDCCatalogTileDataFlexibleHeader.drawTile(centeredFrame)
    case "Header Stack View":
      MDCCatalogTileDataHeaderStackView.drawTile(centeredFrame)
    case "Ink":
      MDCCatalogTileDataInk.drawTile(centeredFrame)
    case "Navigation Bar":
      MDCCatalogTileDataNavigationBar.drawTile(centeredFrame)
    case "Page Control":
      MDCCatalogTileDataPageControl.drawTile(centeredFrame)
    case "Shadow Layer":
      MDCCatalogTileDataShadowLayer.drawTile(centeredFrame)
    case "Slider":
      MDCCatalogTileDataSlider.drawTile(centeredFrame)
    case "Sprited Animation View":
      MDCCatalogTileDataSpritedAnimationView.drawTile(centeredFrame)
    case "Switch":
      MDCCatalogTileDataSwitch.drawTile(centeredFrame)
    case "Typography":
      MDCCatalogTileDataTypography.drawTile(centeredFrame)
    default:
      MDCCatalogTileDataMisc.drawTile(centeredFrame)
    }
  }

}
