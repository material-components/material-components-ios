// Copyright 2022-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialCarousel

@available(iOS 13.0, *)
class ImmersiveFeedTypicalUse_Component: UIViewController, ImmersiveFeedViewControllerDataSource {
  private let cellID = "cell"
  private var verticalCarousel = ImmersiveFeedViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    verticalCarousel.register(TestImmersiveFeedCell.self, forCellWithReuseIdentifier: cellID)
    verticalCarousel.dataSource = self
    self.view?.addSubview(verticalCarousel.view)
    self.addChild(verticalCarousel)
  }

  @objc func numberOfItems() -> Int {
    return 3
  }

  @objc func immersiveFeedViewController(
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = verticalCarousel.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    switch indexPath.row {
    case 1:
      cell.backgroundColor = .blue
    case 2:
      cell.backgroundColor = .red
    default:
      cell.backgroundColor = .yellow
    }
    return cell
  }
}

@available(iOS 13.0, *)
extension ImmersiveFeedTypicalUse_Component {
  /// Provides a testing cell for the example.
  private class TestImmersiveFeedCell: UICollectionViewCell {
    private let defaultCornerRadius = 32.0

    override init(frame: CGRect) {
      super.init(frame: frame)
      clipsToBounds = true
      layer.cornerRadius = defaultCornerRadius
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
}

@available(iOS 13.0, *)
extension ImmersiveFeedTypicalUse_Component {
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": [
        "gm3/v0.4",
        "Vertical Carousel (Immersive Feed)",
        "Typical use",
      ],
      "description": "Immersive Feed",
      "isScrollable": true,
      "primaryDemo": false,
      "presentable": false,
      "debug": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return false
  }
}
