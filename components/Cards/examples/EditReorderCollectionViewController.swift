//
//  EditReorderCollectionViewController.swift
//  MaterialComponentsExamples
//
//  Created by Yarden Eitan on 1/12/18.
//

import UIKit

enum ToggleMode: Int {
  case edit = 1, reorder
}

class EditReorderCollectionViewController: UIViewController,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {

  let collectionView = UICollectionView(frame: .zero,
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
    collectionView.alwaysBounceVertical = true;
    collectionView.register(MDCCollectionViewCardCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reorder",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(toggleModes))

    if #available(iOS 9.0, *) {
      longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleReordering(gesture:)))
      longPressGesture.cancelsTouchesInView = false
      collectionView.addGestureRecognizer(longPressGesture)
    }

    for i in 0..<20 {
      dataSource.append((i, false))
    }

    #if swift(>=3.2)
      if #available(iOS 11, *) {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([collectionView.leftAnchor.constraint(equalTo: guide.leftAnchor),
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

  }

  func preiOS11Constraints() {
    collectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["view": collectionView]));
    collectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["view": collectionView]));
  }

  func toggleModes() {
    if toggle == .edit {
      toggle = .reorder
      navigationItem.rightBarButtonItem?.title = "Reorder"
    } else if toggle == .reorder {
      toggle = .edit
      navigationItem.rightBarButtonItem?.title = "Edit"
    }
    collectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                  for: indexPath) as! MDCCollectionViewCardCell
    cell.backgroundColor = .white
    if toggle == .edit {
      if dataSource[indexPath.item].1 {
        cell.selectionState(MDCCardCellSelectionState.selected)
      } else {
        cell.selectionState(MDCCardCellSelectionState.unselected)
      }
    } else {
      cell.selectionState(MDCCardCellSelectionState.unselected)
      cell.editMode = false
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if toggle == .edit {
      dataSource[indexPath.item].1 = !dataSource[indexPath.item].1
      let cell = collectionView.cellForItem(at: indexPath) as! MDCCollectionViewCardCell
      if dataSource[indexPath.item].1 {
        cell.selectionState(MDCCardCellSelectionState.select)
      } else {
        cell.selectionState(MDCCardCellSelectionState.unselect)
      }
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cardSize = (collectionView.bounds.size.width / 3) - 12
    return CGSize(width: cardSize, height: cardSize)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }

  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return toggle == .reorder
  }

  @available(iOS 9.0, *)
  @objc func handleReordering(gesture: UILongPressGestureRecognizer) {
    if toggle == .reorder {
      switch(gesture.state) {
      case .began:
        guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
          break
        }
        let cell = collectionView.cellForItem(at: selectedIndexPath) as! MDCCollectionViewCardCell
        cell.longPressActive = true
        collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
      case .changed:
        collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
      case .ended:
        endLongPress(gesture: gesture)
        collectionView.endInteractiveMovement()
      default:
        endLongPress(gesture: gesture)
        collectionView.cancelInteractiveMovement()
      }
    }
  }

  func endLongPress(gesture: UILongPressGestureRecognizer) {
    for cell in collectionView.visibleCells {
      if let cell = cell as? MDCCollectionViewCardCell, cell.longPressActive {
        let loc = gesture.location(in: cell)
        cell.setLongPressActive(false, withLocation: loc)
      }
    }
  }

}

extension EditReorderCollectionViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Edit/Reorder (Swift)"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

  @objc class func catalogIsDebug() -> Bool {
    return false
  }
}
