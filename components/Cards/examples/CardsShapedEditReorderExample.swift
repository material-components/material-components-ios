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

import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialShapeLibrary
import MaterialComponents.MaterialContainerScheme

class ShapedCardCollectionCell: MDCCardCollectionCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonShapedCardCollectionCellInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonShapedCardCollectionCellInit()
  }

  func commonShapedCardCollectionCellInit() {
    let shapeGenerator = MDCRectangleShapeGenerator()
    shapeGenerator.topLeftCorner = MDCCutCornerTreatment(cut: 20)
    self.shapeGenerator = shapeGenerator

    self.isAccessibilityElement = true
    self.accessibilityTraits = .button
    self.accessibilityLabel = "Shaped collection cell"
  }
}

class CardsShapedEditReorderExampleViewController: UIViewController,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout
{

  @objc var containerScheme: MDCContainerScheming

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    containerScheme = MDCContainerScheme()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  enum ToggleMode: Int {
    case edit = 1
    case reorder
  }

  let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout())
  var dataSource = [(Int, Bool)]()
  var longPressGesture: UILongPressGestureRecognizer!
  var toggle = ToggleMode.reorder
  var toggleButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.frame = view.bounds
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    collectionView.alwaysBounceVertical = true
    collectionView.register(ShapedCardCollectionCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.allowsMultipleSelection = true
    view.addSubview(collectionView)

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Reorder",
      style: .plain,
      target: self,
      action: #selector(toggleModes))

    longPressGesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(handleReordering(gesture:)))
    longPressGesture.cancelsTouchesInView = false
    collectionView.addGestureRecognizer(longPressGesture)

    for i in 0..<20 {
      dataSource.append((i, false))
    }

    let guide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      collectionView.leftAnchor.constraint(equalTo: guide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: guide.rightAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
    ])
    collectionView.contentInsetAdjustmentBehavior = .always
  }

  func preiOS11Constraints() {
    self.view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[view]|",
        options: [],
        metrics: nil,
        views: ["view": collectionView]))
    self.view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[view]|",
        options: [],
        metrics: nil,
        views: ["view": collectionView]))
  }

  @objc func toggleModes() {
    if toggle == .edit {
      toggle = .reorder
      navigationItem.rightBarButtonItem?.title = "Reorder"
    } else if toggle == .reorder {
      toggle = .edit
      navigationItem.rightBarButtonItem?.title = "Edit"
    }
    collectionView.reloadData()
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "Cell",
        for: indexPath) as! MDCCardCollectionCell
    cell.applyTheme(withScheme: containerScheme)
    cell.backgroundColor = .white
    cell.isSelectable = (toggle == .edit)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if toggle == .edit {
      dataSource[indexPath.item].1 = !dataSource[indexPath.item].1
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return dataSource.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    moveItemAt sourceIndexPath: IndexPath,
    to destinationIndexPath: IndexPath
  ) {
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let cardSize = (collectionView.bounds.size.width / 3) - 12
    return CGSize(width: cardSize, height: cardSize)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 8
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 8
  }

  func collectionView(
    _ collectionView: UICollectionView,
    canMoveItemAt indexPath: IndexPath
  ) -> Bool {
    return toggle == .reorder
  }

  @objc func handleReordering(gesture: UILongPressGestureRecognizer) {
    if toggle == .reorder {
      switch gesture.state {
      case .began:
        guard
          let selectedIndexPath = collectionView.indexPathForItem(
            at:
              gesture.location(in: collectionView))
        else {
          break
        }
        collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
      case .changed:
        collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
      case .ended:
        collectionView.endInteractiveMovement()
      default:
        collectionView.cancelInteractiveMovement()
      }
    }
  }

}

extension CardsShapedEditReorderExampleViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Cards", "Shaped Edit/Reorder"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
