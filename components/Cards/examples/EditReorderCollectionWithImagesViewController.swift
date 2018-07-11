/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit

class EditReorderCollectionWithImagesViewController: UIViewController,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

  enum ToggleMode: Int {
    case edit = 1, reorder
  }

  let collectionView = UICollectionView(frame: .zero,
                                        collectionViewLayout: UICollectionViewFlowLayout())
  lazy var dataSource = [
    ("veggie_basket", "Veggie Basket", false),
    ("spices_and_herbs", "Spices & Herbs", false),
    ("salt_farmer", "Salt Farmer", false),
    ("french_quarter", "French Quarter", false),
    ("sf_bayview", "Bayview", false),
    ("london-belgravia", "London, Belgravia", false),
    ("georgetown", "Georgetown", false),
    ("dc_cathedral_heights", "Cathedral Heights", false),
    ("dc_cleveland_park", "Cleveland Park", false),
    ("amsterdam", "Amsterdam", false),
    ("silk_weavers", "Silk Weavers", false),
    ("marina_beach", "Marina Beach", false),
    ("temple_market", "Temple Market", false),
    ("fishing_boat", "Fishing Boat", false),
    ("salt_farm", "Salt Farm", false),
    ("chettinad_mansion", "Mansions", false),
    ("chettinad_street", "Chettinad", false),
    ("tile_makers", "Tile Makers", false),
    ("fisherman", "Fisherman", false),
    ("fishermen_village", "Fishermen Village", false),
    ("twilight_zone", "Twilight Zone", false),
    ("marina_fish", "Marina Fish", false),
    ("flower_market", "Flower Market", false)
  ]
  var longPressGesture: UILongPressGestureRecognizer!
  var toggle = ToggleMode.reorder
  var toggleButton: UIButton!
  var colorScheme = MDCSemanticColorScheme()
  let cardScheme = MDCCardScheme();

  override func viewDidLoad() {
    super.viewDidLoad()

    cardScheme.colorScheme = colorScheme
    collectionView.frame = view.bounds
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    collectionView.alwaysBounceVertical = true;
    collectionView.register(CardEditReorderCollectionCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.allowsMultipleSelection = true
    view.addSubview(collectionView)

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reorder",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(toggleModes))

    if #available(iOS 9.0, *) {
      longPressGesture = UILongPressGestureRecognizer(target: self,
                                                      action: #selector(handleReordering(gesture:)))
      longPressGesture.cancelsTouchesInView = false
      collectionView.addGestureRecognizer(longPressGesture)
    }

    #if swift(>=3.2)
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
    #else
    preiOS11Constraints()
    #endif

    self.updateTitle()
  }

  func preiOS11Constraints() {
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                            options: [],
                                                            metrics: nil,
                                                            views: ["view": collectionView]));
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                            options: [],
                                                            metrics: nil,
                                                            views: ["view": collectionView]));
  }

  func updateTitle() {
    if toggle == .edit {
      navigationItem.rightBarButtonItem?.title = "Reorder"
      self.title = "Cards (Edit)"
    } else if toggle == .reorder {
      navigationItem.rightBarButtonItem?.title = "Edit"
      self.title = "Cards (Reorder)"
    }
  }

  func toggleModes() {
    if toggle == .edit {
      toggle = .reorder
    } else if toggle == .reorder {
      toggle = .edit
    }
    self.updateTitle()
    collectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    guard let cardCell = cell as? CardEditReorderCollectionCell else { return cell }

    MDCCardThemer.applyScheme(cardScheme, toCardCell: cardCell)
    cardCell.isSelectable = (toggle == .edit)

    let title = dataSource[indexPath.item].1
    let imageName = dataSource[indexPath.item].0
    cardCell.configure(title: title, imageName: imageName)
    cardCell.isSelected = dataSource[indexPath.item].2

    cardCell.isAccessibilityElement = true
    cardCell.accessibilityLabel = title

    return cardCell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if toggle == .edit {
      dataSource[indexPath.item].2 = !dataSource[indexPath.item].2
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      moveItemAt sourceIndexPath: IndexPath,
                      to destinationIndexPath: IndexPath) {
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

  @available(iOS 9.0, *)
  @objc func handleReordering(gesture: UILongPressGestureRecognizer) {
    if toggle == .reorder {
      switch(gesture.state) {
      case .began:
        guard let selectedIndexPath = collectionView.indexPathForItem(at:
          gesture.location(in: collectionView)) else {
            break
        }
        collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
      case .changed:
        collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
      case .ended:
        collectionView.endInteractiveMovement()
      default:
        collectionView.cancelInteractiveMovement()
      }
    }
  }

}

extension EditReorderCollectionWithImagesViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Edit/Reorder - With Images"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }

  @objc class func catalogIsDebug() -> Bool {
    return false
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }
}
