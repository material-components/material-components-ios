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
    (image: "toggle-button-image1", accessibilityLabel: "Teapot", selected: false),
    (image: "toggle-button-image4", accessibilityLabel: "Vases", selected: true),
    (image: "toggle-button-image3", accessibilityLabel: "Tape", selected: true),
    (image: "toggle-button-image2", accessibilityLabel: "Cup", selected: false),
    (image: "toggle-button-image1", accessibilityLabel: "Teapot", selected: false),
    (image: "toggle-button-image4", accessibilityLabel: "Vases", selected: false),
    (image: "toggle-button-image3", accessibilityLabel: "Tape", selected: false),
    (image: "toggle-button-image2", accessibilityLabel: "Cup", selected: false),
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

    // Get our custom cell, which is a card cell subclass, with a custom toggle icon.
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: ToggleButtonCell.self), for: indexPath)
    guard let cardCell = cell as? ToggleButtonCell else { return cell }

    // Get the card cell's data from the data source.
    let imagedata = dataSource[indexPath.item]

    // Set the card's image based on the datasource.
    cardCell.setCardImage(named: imagedata.image)

    // Apply the Material theme to the cards, which uses the primary color to theme the toggle
    // button color. In this example, we've overriden it with a white color.
    cardCell.applyTheme(withScheme: containerScheme)
    cardCell.setImageTintColor(.white, for: .normal) // Override the default toggle color.

    // Enable toggle button behavior in the card.
    cardCell.isSelectable = true

    // Select the card based on its state in the data source.
    cardCell.isSelected = imagedata.selected
    if imagedata.selected {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }

    // Ensure the card is accessible.
    cardCell.isAccessibilityElement = true
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
    return CGSize(width: cardWidth, height: cardWidth)
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
