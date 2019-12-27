// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialShadowStandards
import UIKit

class MDCShadowStandardsExampleViewController: UIViewController {
  @objc var containerScheme: MDCContainerScheming = MDCContainerScheme()

  private let slider = UISlider()

  private let label = UILabel()

  private let exampleView = MDCExampleShadowView()

  private let exampleLegacyView = MDCLegacyExampleShadowView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    exampleView.backgroundColor = containerScheme.colorScheme.primaryColor
    view.addSubview(exampleView)
    exampleLegacyView.backgroundColor = containerScheme.colorScheme.primaryColor
    view.addSubview(exampleLegacyView)
    slider.minimumValue = 0
    slider.maximumValue = 24
    view.addSubview(slider)
    slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    label.text = "Elevation: \(Int(slider.value))"
    label.textAlignment = .center
    view.addSubview(label)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    var safeArea: UIEdgeInsets = .zero
    if #available(iOS 11.0, *) {
      safeArea = view.safeAreaInsets
    }
    exampleView.frame = CGRect(
      x: (view.bounds.width / 2) - 50,
      y: 100 + safeArea.top,
      width: 100,
      height: 100
    )
    exampleLegacyView.frame = CGRect(
      x: (view.bounds.width / 2) - 50,
      y: 250 + safeArea.top,
      width: 100,
      height: 100
    )
    slider.frame = CGRect(
      x: 20 + safeArea.left,
      y: 20 + safeArea.top,
      width: view.bounds.width - (40 + safeArea.left + safeArea.right),
      height: 48
    )
    label.frame = CGRect(
      x: 20 + safeArea.left,
      y: 68 + safeArea.top,
      width: view.bounds.width - (40 + safeArea.left + safeArea.right),
      height: 24
    )
  }

  @objc func sliderValueChanged() {
    exampleView.elevation = CGFloat(Int(slider.value))
    exampleLegacyView.elevation = CGFloat(Int(slider.value))
    label.text = "Elevation: \(Int(slider.value))"
  }
}

class MDCLegacyExampleShadowView: UIView {
  override class var layerClass: AnyClass {
    return MDCShadowLayer.self
  }

  func shadowLayer() -> MDCShadowLayer {
    return self.layer as! MDCShadowLayer
  }

  var elevation: CGFloat {
    didSet {
      (self.layer as! MDCShadowLayer).elevation = ShadowElevation(rawValue: elevation)
    }
  }

  override init(frame: CGRect) {
    elevation = 8
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class MDCExampleShadowView: UIView {
  var elevation: CGFloat {
    didSet {
      let shadowStandards = MDCShadowStandards(elevation: elevation)
      layer.shadowOpacity = shadowStandards.shadowOpacity
      layer.shadowOffset = shadowStandards.shadowOffset
      layer.shadowRadius = shadowStandards.shadowRadius
    }
  }

  override init(frame: CGRect) {
    elevation = 8
    super.init(frame: frame)
    layer.shadowColor = UIColor.black.cgColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: Catalog by conventions
extension MDCShadowStandardsExampleViewController {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Shadow Standards", "Shadow Standards"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
