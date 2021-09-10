// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialShapes

class ShapesShadows: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  override class var layerClass: AnyClass {
    return MDCShapedShadowLayer.self
  }

  func commonInit() {
    guard let layer = layer as? MDCShapedShadowLayer else {
      return
    }
    let shapeGenerator = MDCRectangleShapeGenerator()
    shapeGenerator.topLeftCorner = MDCCutCornerTreatment(cut: 20)
    layer.shapeGenerator = shapeGenerator
    layer.shapedBackgroundColor = .red
    layer.shadowOffset = CGSize(width: 0, height: -3)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.4
  }
}

class ShapesShadowsController: UIViewController {
  var customView: ShapesShadows!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    customView = ShapesShadows(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    customView.center = CGPoint(x: self.view.center.x, y: 50)
    self.view.addSubview(customView)
    UIView.animate(
      withDuration: 8.0, delay: 0, options: [.autoreverse, .repeat],
      animations: {
        self.customView.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height - 50)
      }, completion: nil)
  }

}

extension ShapesShadowsController {

  // MARK: Catalog by convention

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", "Shape & Shadow"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
