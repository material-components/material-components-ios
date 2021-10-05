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

import UIKit
import MaterialComponents.MaterialRipple
import MaterialComponents.MaterialContainerScheme

class RippleCell: UICollectionViewCell {

  var rippleView: MDCRippleView!

  override init(frame: CGRect) {
    super.init(frame: frame)

    rippleView = MDCRippleView(frame: self.contentView.bounds)
    self.contentView.addSubview(rippleView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class UICollectionViewWithRippleExample: UIViewController,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout,
  MDCRippleTouchControllerDelegate
{

  let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout())

  var rippleTouchController: MDCRippleTouchController?
  @objc var containerScheme: MDCContainerScheming!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    containerScheme = MDCContainerScheme()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = containerScheme.colorScheme.backgroundColor
    collectionView.backgroundColor = containerScheme.colorScheme.backgroundColor
    collectionView.frame = view.bounds
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.alwaysBounceVertical = true
    collectionView.register(RippleCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.allowsMultipleSelection = true
    view.addSubview(collectionView)

    rippleTouchController = MDCRippleTouchController(view: collectionView)
    rippleTouchController?.delegate = self

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

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        as? RippleCell
    else { fatalError() }
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.lightGray.cgColor
    cell.backgroundColor = containerScheme.colorScheme.surfaceColor
    return cell
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 30
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let size = collectionView.bounds.size.width - 12
    return CGSize(width: size, height: 60)
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

  func rippleTouchController(
    _ rippleTouchController: MDCRippleTouchController,
    rippleViewAtTouchLocation location: CGPoint
  ) -> MDCRippleView? {
    guard let indexPath = self.collectionView.indexPathForItem(at: location) else {
      return nil
    }
    let cell = self.collectionView.cellForItem(at: indexPath) as? RippleCell
    if let cell = cell {
      return cell.rippleView
    }
    return nil
  }

}

extension UICollectionViewWithRippleExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Ripple", "UICollectionView with Ripple"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
