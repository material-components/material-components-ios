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

import MaterialComponents.MaterialCollections

class CollectionsSimpleSwiftDemo: MDCCollectionViewController {

  let reusableIdentifierItem = "itemCellIdentifier"
  let colors = [ "red", "blue", "green", "black", "yellow", "purple" ]

  override func viewDidLoad() {
    super.viewDidLoad()

    // Register cell class.
    self.collectionView?.register(MDCCollectionViewTextCell.self,
                                       forCellWithReuseIdentifier: reusableIdentifierItem)

    // Customize collection view settings.
    self.styler.cellStyle = .card
  }

  // MARK: UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return colors.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifierItem,
                                                                     for: indexPath)
    if let cell = cell as? MDCCollectionViewTextCell {
      cell.textLabel?.text = colors[indexPath.item]
    }

    return cell
  }
}

// MARK: Catalog by convention
extension CollectionsSimpleSwiftDemo {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": [ "Collections", "Simple Swift Demo"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
