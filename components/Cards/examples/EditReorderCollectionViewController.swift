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

import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialTypographyScheme

class EditReorderCollectionViewController: UIViewController,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  enum ToggleMode: Int {
    case edit = 1, reorder
  }

  let collectionView = UICollectionView(frame: .zero,
                                        collectionViewLayout: UICollectionViewFlowLayout())
  var toggle = ToggleMode.edit

  @objc var containerScheme: MDCContainerScheming

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    containerScheme = MDCContainerScheme()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  let images = [
    (image: "amsterdam-kadoelen",     title: "Kadoelen"),
    (image: "amsterdam-zeeburg",      title: "Zeeburg"),
    (image: "venice-st-marks-square", title: "St. Mark's Square"),
    (image: "venice-grand-canal",     title: "Grand Canal"),
    (image: "austin-u-texas-pond",    title: "Austin U"),
  ]
  var dataSource: [(image: String, title: String, selected: Bool)] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.frame = view.bounds
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = containerScheme.colorScheme.backgroundColor
    collectionView.alwaysBounceVertical = true
    collectionView.register(CardEditReorderCollectionCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.allowsMultipleSelection = true
    view.addSubview(collectionView)

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reorder",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(toggleModes))

    let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                        action: #selector(reorderCards(gesture:)))
    longPressGesture.cancelsTouchesInView = false
    collectionView.addGestureRecognizer(longPressGesture)

    // randomly select images to display 30 items
    let count = UInt32(images.count)
    for _ in 0 ..< 30 {
      let ind = Int(arc4random_uniform(count))
      dataSource.append((image: images[ind].image, title: images[ind].title, selected: false))
    }

    if #available(iOS 11, *) {
      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        collectionView.leftAnchor.constraint(equalTo: guide.leftAnchor),
        collectionView.rightAnchor.constraint(equalTo: guide.rightAnchor),
        collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)])
      collectionView.contentInsetAdjustmentBehavior = .always
    } else {
      preiOS11Constraints()
    }

    self.updateTitle()
  }

  func preiOS11Constraints() {
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                            options: [],
                                                            metrics: nil,
                                                            views: ["view": collectionView]))
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                            options: [],
                                                            metrics: nil,
                                                            views: ["view": collectionView]))
  }

  func updateTitle() {
    switch toggle {
    case .edit:
      navigationItem.rightBarButtonItem?.title = "Reorder"
      self.title = "Cards (Edit)"
    case .reorder:
      navigationItem.rightBarButtonItem?.title = "Edit"
      self.title = "Cards (Reorder)"
    }
  }

  @objc func toggleModes() {
    switch toggle {
    case .edit:
      toggle = .reorder
    case .reorder:
      toggle = .edit
    }
    self.updateTitle()
    collectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    guard let cardCell = cell as? CardEditReorderCollectionCell else { return cell }

    cardCell.apply(containerScheme: containerScheme,
                   typographyScheme: containerScheme.typographyScheme)

    let title = dataSource[indexPath.item].title
    let imageName = dataSource[indexPath.item].image
    cardCell.configure(title: title, imageName: imageName)

    cardCell.isSelectable = (toggle == .edit)
    if self.dataSource[indexPath.item].selected {
      collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
      cardCell.isSelected = true
    }

    cardCell.isAccessibilityElement = true
    cardCell.accessibilityLabel = title

    return cardCell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard toggle == .edit else { return }
    dataSource[indexPath.item].selected = true
  }

  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    guard toggle == .edit else { return }
    dataSource[indexPath.item].selected = false
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cardSize = (collectionView.bounds.size.width / 3) - 12
    return CGSize(width: cardSize, height: cardSize)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }

  func collectionView(_ collectionView: UICollectionView,
                      canMoveItemAt indexPath: IndexPath) -> Bool {
    return toggle == .reorder
  }

  func collectionView(_ collectionView: UICollectionView,
                      moveItemAt sourceIndexPath: IndexPath,
                      to destinationIndexPath: IndexPath) {
    let sourceItem = dataSource[sourceIndexPath.item]

    // reorder all cells in between source and destination, moving each by 1 position
    if sourceIndexPath.item < destinationIndexPath.item {
      for ind in sourceIndexPath.item ..< destinationIndexPath.item {
        dataSource[ind] = dataSource[ind + 1]
      }
    } else {
      for ind in (destinationIndexPath.item + 1 ... sourceIndexPath.item).reversed() {
        dataSource[ind] = dataSource[ind - 1]
      }
    }

    dataSource[destinationIndexPath.item] = sourceItem
  }

  @available(iOS 9.0, *)
  @objc func reorderCards(gesture: UILongPressGestureRecognizer) {

    switch(gesture.state) {
    case .began:
      guard let selectedIndexPath = collectionView.indexPathForItem(at:
        gesture.location(in: collectionView)) else { break }
      collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
    case .changed:
      guard let gestureView = gesture.view else { break }
      collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gestureView))
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      collectionView.cancelInteractiveMovement()
    }
  }

}

extension EditReorderCollectionViewController {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Cards", "Edit/Reorder"],
      "primaryDemo": false,
      "presentable": true,
    ]
  }
}
