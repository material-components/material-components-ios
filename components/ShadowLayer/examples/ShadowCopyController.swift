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

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  override class var layerClass: AnyClass {
    get {
      return MDCShadowLayer.self
    }
  }

  func commonInit() {
    guard let layer = layer as? MDCShadowLayer else {
      return
    }
    self.backgroundColor = .blue
    layer.elevation = ShadowElevation.dialog
    layer.delegate = self
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

    copiedView = ShadowedView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    copiedView.center = CGPoint(x: self.view.center.x + 80, y: 200)
    self.view.addSubview(copiedView)

    let button = UIButton(type: .custom)
    button.setTitle("Duplicate", for: .normal)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    button.sizeToFit()
    self.view.addSubview(button)
    button.center = CGPoint(x:self.view.center.x, y: self.view.bounds.height - 80)
  }

  func buttonTapped() {
    duplicated = !duplicated

    print("TODO: Test initWithLayer:")
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

