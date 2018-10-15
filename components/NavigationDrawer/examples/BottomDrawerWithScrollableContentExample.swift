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
import MaterialComponentsAlpha.MaterialNavigationDrawer
import MaterialComponents.MaterialColorScheme

class BottomDrawerWithScrollableContentExample: UIViewController {
  var colorScheme = MDCSemanticColorScheme()

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentWithScrollViewController()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor
    headerViewController.colorScheme = colorScheme
    contentViewController.colorScheme = colorScheme
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.contentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.trackingScrollView = contentViewController.collectionView
    present(bottomDrawerViewController, animated: true, completion: nil)
  }

}

class DrawerContentWithScrollViewController: UIViewController,
    UICollectionViewDelegate, UICollectionViewDataSource {
  var colorScheme: MDCSemanticColorScheme!

  let collectionView: UICollectionView
  let layout = UICollectionViewFlowLayout()
  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width,
                    height: layout.collectionViewContentSize.height)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.primaryColor
    collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width,
                             height: self.view.bounds.height)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.isScrollEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    self.view.addSubview(collectionView)
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let s = self.view.frame.size.width / 3
    layout.itemSize = CGSize(width: s, height: s)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 102
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    let colorPick = indexPath.row % 2 == 0
    print(indexPath.item)
    cell.backgroundColor = colorPick ? colorScheme.surfaceColor : colorScheme.primaryColorVariant
    return cell
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}

extension BottomDrawerWithScrollableContentExample {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Drawer", "Bottom Drawer Scrollable Content"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
