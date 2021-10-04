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

import Foundation
import MaterialComponents.MaterialList
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialContainerScheme

class BaseCellExample: UIViewController {
  private let arbitraryCellHeight: CGFloat = 75
  fileprivate let baseCellIdentifier: String = "baseCellIdentifier"
  fileprivate let numberOfCells: Int = 100
  var containerScheme: MDCContainerScheming = MDCContainerScheme()

  private lazy var collectionView: UICollectionView = {
    return UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  }()

  private var collectionViewLayout: UICollectionViewFlowLayout {
    return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
  }

  private var collectionViewEstimatedCellSize: CGSize {
    return CGSize(
      width: collectionView.bounds.size.width - 20,
      height: arbitraryCellHeight)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    parent?.automaticallyAdjustsScrollViewInsets = false
    automaticallyAdjustsScrollViewInsets = false
    setUpCollectionView()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    positionCollectionView()
  }

  func setUpCollectionView() {
    collectionViewLayout.estimatedItemSize = collectionViewEstimatedCellSize
    collectionViewLayout.minimumInteritemSpacing = 5
    collectionViewLayout.minimumLineSpacing = 5
    collectionView.backgroundColor = containerScheme.colorScheme.backgroundColor
    collectionView.register(MDCBaseCell.self, forCellWithReuseIdentifier: baseCellIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
  }

  func positionCollectionView() {
    var originX = view.bounds.origin.x
    var originY = view.bounds.origin.y
    var width = view.bounds.size.width
    var height = view.bounds.size.height

    originX += view.safeAreaInsets.left
    originY += view.safeAreaInsets.top
    width -= (view.safeAreaInsets.left + view.safeAreaInsets.right)
    height -= (view.safeAreaInsets.top + view.safeAreaInsets.bottom)

    let frame = CGRect(x: originX, y: originY, width: width, height: height)
    collectionView.frame = frame
    collectionViewLayout.estimatedItemSize = collectionViewEstimatedCellSize
    collectionViewLayout.invalidateLayout()
    collectionView.reloadData()
  }
}

extension BaseCellExample: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? MDCBaseCell else { fatalError() }
    cell.elevation = ShadowElevation(rawValue: 10)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didUnhighlightItemAt indexPath: IndexPath
  ) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? MDCBaseCell else { fatalError() }
    cell.elevation = ShadowElevation(rawValue: 0)
  }
}

extension BaseCellExample: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return numberOfCells
  }

  static let colorNames: [String] = [
    "Red", "Green", "Blue", "Orange", "Yellow", "Brown", "Cyan", "Purple",
  ]
  static let colorNameToColorMap: [String: UIColor] = [
    "Red": .red,
    "Green": .green,
    "Blue": .blue,
    "Orange": .orange,
    "Yellow": .yellow,
    "Brown": .brown,
    "Cyan": .cyan,
    "Purple": .purple,
  ]

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: baseCellIdentifier,
        for: indexPath) as? MDCBaseCell
    else { fatalError() }

    cell.layer.borderColor = containerScheme.colorScheme.onBackgroundColor.cgColor
    let styleIndex = indexPath.row % BaseCellExample.colorNames.count
    let colorName = BaseCellExample.colorNames[styleIndex]
    let backgroundColor = BaseCellExample.colorNameToColorMap[colorName]
    cell.accessibilityLabel = colorName
    cell.isAccessibilityElement = true
    cell.backgroundColor = backgroundColor
    cell.layer.borderWidth = 1
    cell.inkColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    return cell
  }
}

// MARK: Catalog By Convention
extension BaseCellExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["List Items", "MDCBaseCell Example (Swift)"],
      "description": "MDCBaseCell Example (Swift)",
      "primaryDemo": true,
      "presentable": true,
    ]
  }
}
