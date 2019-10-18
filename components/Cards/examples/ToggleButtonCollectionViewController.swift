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

import MaterialComponents.MaterialContainerScheme
import UIKit

private let reuseIdentifier = "Cell"

/// This example uses a custom toggle button in Cards. It uses a custom class (ToggleButtonCell),
/// which is a subclass of MDCCardCollectionCell (a UICollectionCell subclass). ToggleButtonCell
/// sets the card's image, its selected and unselecte icons, and the tint color of the selected and
/// unselected icon. This ToggleButtonCollectionViewController class customizes the collection cells
/// and enables the toggle button in [collectionView:cellForItemAt:].

class ToggleButtonCollectionViewController: UICollectionViewController,
  UICollectionViewDelegateFlowLayout
{

  fileprivate let layout = UICollectionViewFlowLayout()
  @objc var containerScheme: MDCContainerScheming
  let padding: CGFloat = 8

  var dataSource = [
    (image: "toggle-button-image1", accessibilityLabel: "Creek", selected: false),
    (image: "toggle-button-image4", accessibilityLabel: "Bridge", selected: true),
    (image: "toggle-button-image2", accessibilityLabel: "Street", selected: false),
    (image: "toggle-button-image3", accessibilityLabel: "Vine", selected: false),
    (image: "toggle-button-image1", accessibilityLabel: "Creek", selected: false),
    (image: "toggle-button-image4", accessibilityLabel: "Bridge", selected: false),
    (image: "toggle-button-image2", accessibilityLabel: "Street", selected: false),
    (image: "toggle-button-image3", accessibilityLabel: "Vine", selected: false),
  ]

  init() {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = padding
    layout.minimumInteritemSpacing = padding
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

    containerScheme = MDCContainerScheme()

    super.init(collectionViewLayout: layout)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(
      ToggleButtonCell.self, forCellWithReuseIdentifier: String(describing: ToggleButtonCell.self))
    collectionView.allowsMultipleSelection = true
    collectionView.backgroundColor = containerScheme.colorScheme.surfaceColor

    self.title = "Cards Toggle Button"
  }

  override func viewWillTransition(
    to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
  ) {
    super.viewWillTransition(to: size, with: coordinator)
    // Recalculate cell size when orientation changes
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

// MARK: UICollectionViewDataSource

extension ToggleButtonCollectionViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(
    _ collectionView: UICollectionView, numberOfItemsInSection section: Int
  ) -> Int {
    return dataSource.count
  }

  override func collectionView(
    _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    // Get our custom ToggleButtonCell with a custom toggle icon and the toggle mode enabled.
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: ToggleButtonCell.self), for: indexPath)
    guard let cardCell = cell as? ToggleButtonCell else { return cell }

    let imagedata = dataSource[indexPath.item]
    cardCell.setCardImage(named: imagedata.image)    // set the card's image based on the datasource

    cardCell.applyTheme(withScheme: containerScheme) // apply the Material theme to the cards
    cardCell.setImageTintColor(.white, for: .normal) // override the default toggle button color

    cardCell.isSelected = imagedata.selected         // set the default selected state of the card
    if imagedata.selected {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }

    cardCell.isAccessibilityElement = true            // make sure the card is accessible
    cardCell.accessibilityLabel = imagedata.accessibilityLabel
    return cardCell
  }
}

// MARK: UICollectionViewDelegate

extension ToggleButtonCollectionViewController {

  override func collectionView(
    _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
  ) {
    dataSource[indexPath.item].selected = true
  }

  override func collectionView(
    _ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath
  ) {
    dataSource[indexPath.item].selected = false
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let cardWidth = (collectionView.bounds.size.width - padding * 3) / 2
    let cardHeight = cardWidth * 1.3
    return CGSize(width: cardWidth, height: cardHeight)
  }
}

// MARK: Catalog By convention

extension ToggleButtonCollectionViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Cards", "Toggle Button in Cards"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
