// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

class ShadowedView: UIView {
  private var shadowLayer: MDCShadowLayer?

  override init(frame: CGRect) {
    super.init(frame: frame)
    shadowLayer = MDCShadowLayer()
    shadowLayer?.elevation = ShadowElevation.dialog
    commonInit()
  }

  init(frame: CGRect, shadowLayer: MDCShadowLayer?) {
    super.init(frame: frame)
    if let shadowLayer = shadowLayer {
      // Testing-only use of initializer that should only be used for presentationLayer.
      self.shadowLayer = MDCShadowLayer(layer: shadowLayer)
    }
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.shadowLayer = MDCShadowLayer()
    shadowLayer?.elevation = ShadowElevation.dialog
    commonInit()
  }

  func commonInit() {
    backgroundColor = .blue
    layer.masksToBounds = false
    commonSetupShadowLayer()
  }

  func commonSetupShadowLayer() {
    guard let shadowLayer = shadowLayer else {
      return
    }
    layer.addSublayer(shadowLayer)
    shadowLayer.frame = layer.bounds
    shadowLayer.layoutSublayers()
  }

  override func layoutSublayers(of layer: CALayer) {
    if layer == self.layer, let shadowLayer = shadowLayer {
      shadowLayer.frame = layer.bounds
      shadowLayer.layoutSublayers()
    }
  }
}

class ShadowCopyController: UIViewController {
  var customView: ShadowedView!
  var copiedView: ShadowedView!
  var duplicated = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .lightGray

    customView = ShadowedView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    customView.center = CGPoint(x: self.view.center.x - 80, y: 200)
    self.view.addSubview(customView)

    copiedView = ShadowedView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                              shadowLayer: customView.shadowLayer)
    copiedView.center = CGPoint(x: self.view.center.x + 80, y: 200)
    self.view.addSubview(copiedView)
  }
}

extension ShadowCopyController {
  
  // MARK: Catalog by convention

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow", "Copy Shadow Layer"],
      "primaryDemo": false,
      "presentable": false,
      "debug" : true,  //KM Before Merge
    ]
  }
}

