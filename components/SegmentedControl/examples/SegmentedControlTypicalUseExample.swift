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

import Foundation
import UIKit
import MaterialComponents.MaterialContainerScheme

class SegmentedControlTypicalUseExample: UIViewController {

  var containerScheme = MDCContainerScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    let segmentedControl = UISegmentedControl(items: ["Item 1", "Item 2"])
    segmentedControl.sizeToFit()
    segmentedControl.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    segmentedControl.autoresizingMask = [
      .flexibleLeftMargin,
      .flexibleTopMargin,
      .flexibleRightMargin,
      .flexibleBottomMargin,
    ]
    segmentedControl.selectedSegmentIndex = 0
    view.addSubview(segmentedControl)
  }
}

extension SegmentedControlTypicalUseExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Segmented Control", "Typical use"],
      "primaryDemo": true,
      "presentable": false,
    ]
  }
}
