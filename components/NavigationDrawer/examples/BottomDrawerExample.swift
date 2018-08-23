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

class BottomDrawerInfiniteScrollingExample: UIViewController {

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentTableViewController()

  override func viewDidLoad() {
    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    showWrappedViewController();
  }

  func showWrappedViewController() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.mainContentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.trackingScrollView = contentViewController.tableView
    present(bottomDrawerViewController, animated: true, completion: nil)
  }
}

class BottomDrawerWithScrollableContentExample: UIViewController {

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentWithScrollViewController()

  override func viewDidLoad() {
    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    showWrappedViewController();
  }

  func showWrappedViewController() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.mainContentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    bottomDrawerViewController.trackingScrollView = contentViewController.collectionView
    present(bottomDrawerViewController, animated: true, completion: nil)
  }
}

class BottomDrawerWithHeaderExample: UIViewController {

  let headerViewController = DrawerHeaderViewController()
  let contentViewController = DrawerContentViewController()

  override func viewDidLoad() {
    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    showWrappedViewController()
  }

  func showWrappedViewController() {
    let bottomDrawerViewController = MDCBottomDrawerViewController()
    bottomDrawerViewController.mainContentViewController = contentViewController
    bottomDrawerViewController.headerViewController = headerViewController
    present(bottomDrawerViewController, animated: true, completion: nil)
  }

}

class BottomDrawerNoHeaderExample: UIViewController {

  let contentViewController = DrawerContentViewController()
  let bottomDrawerTransitionController = MDCBottomDrawerTransitionController()

  override func viewDidLoad() {
    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    showContentViewControllerOnly()
  }

  func showContentViewControllerOnly() {
    contentViewController.transitioningDelegate = bottomDrawerTransitionController
    contentViewController.modalPresentationStyle = .custom
    present(contentViewController, animated: true, completion: nil)
  }

}

class DrawerContentTableViewController: UITableViewController {

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: tableView.contentSize.height)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.purple
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    self.tableView.isScrollEnabled = false
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "cell #\(indexPath.item)"
    cell.backgroundColor = .white
    print(cell.textLabel?.text ?? "")
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

class DrawerContentWithScrollViewController: UIViewController,
    UICollectionViewDelegate, UICollectionViewDataSource {

  let collectionView: UICollectionView
  let layout = UICollectionViewFlowLayout()
  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width,
                    height: collectionView.collectionViewLayout.collectionViewContentSize.height)
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
    self.view.backgroundColor = .lightGray
    collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width,
                             height: self.view.bounds.height)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.isScrollEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    self.view.addSubview(collectionView)
  }

  override func viewWillLayoutSubviews() {
    let s = self.view.frame.size.width / 3
    layout.itemSize = CGSize(width: s, height: s)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 102
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    let color = CGFloat(indexPath.row % 2) * 0.2 + 0.8
    print(indexPath.item)
    cell.backgroundColor = UIColor(white: color, alpha: 1)
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}

class DrawerContentViewController: UIViewController {

  let preferredHeight: CGFloat = 2000

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: preferredHeight)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.purple
  }
}

class DrawerHeaderViewController: UIViewController {
  let preferredHeight: CGFloat = 80

  override var preferredContentSize: CGSize {
    get {
      return CGSize(width: view.bounds.width, height: preferredHeight)
    }
    set {
      super.preferredContentSize = newValue
    }
  }

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
  }
}

extension DrawerHeaderViewController : MDCBottomDrawerHeader {

  func updateTransitionRatio(_ transitionToTopRatio: CGFloat) {
    // Updates the layout according to the transition to top radio.
  }

}

extension BottomDrawerInfiniteScrollingExample {

  @objc class func catalogDescription() -> String {
    return "Navigation Drawer"
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Navigation Drawer", "Bottom Drawer Infinite Scrolling"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

}

extension BottomDrawerWithScrollableContentExample {

  @objc class func catalogDescription() -> String {
    return "Navigation Drawer "
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Navigation Drawer", "Bottom Drawer Scrollable Content"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }

}

extension BottomDrawerWithHeaderExample {

  @objc class func catalogDescription() -> String {
    return "Navigation Drawer"
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return true
  }

  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Navigation Drawer", "Bottom Drawer"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }

}

extension BottomDrawerNoHeaderExample {

  @objc class func catalogDescription() -> String {
    return "Navigation Drawer"
  }

  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Navigation Drawer", "Bottom Drawer No Header"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return false
  }

}
