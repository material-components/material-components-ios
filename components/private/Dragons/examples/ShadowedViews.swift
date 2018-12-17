// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialShadowLayer

class VanillaShadowedView: UIView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.layer.shadowOffset = CGSize(width: 0, height: 8)
    self.layer.shadowRadius = 8
    self.layer.shadowOpacity = 0.6
  }
}

class MaterialShadowedView: UIView {
  override class var layerClass: AnyClass {
    return MDCShadowLayer.self
  }
  
  func shadowLayer() -> MDCShadowLayer {
    return self.layer as! MDCShadowLayer
  }
  
  func setElevation(points: CGFloat) {
    (self.layer as! MDCShadowLayer).elevation = ShadowElevation(rawValue: points)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setElevation(points: 12)
  }
}
