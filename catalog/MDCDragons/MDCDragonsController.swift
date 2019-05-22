/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import CatalogByConvention

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialIcons_ic_chevron_right
import MaterialComponents.MaterialKeyboardWatcher
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography

import UIKit

class MDCDragonsController: UIViewController,
                            UITableViewDelegate,
                            UITableViewDataSource,
                            UISearchBarDelegate,
                            UIGestureRecognizerDelegate {

  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 50
    static let headerViewMaxHeight: CGFloat = 113
    static let headerViewMinHeight: CGFloat = 53
    static let bgColor = UIColor(white: 0.97, alpha: 1)
    static let headerColor = UIColor(red: 0.384, green: 0, blue: 0.933, alpha: 1.0)
    static let titleColor = UIColor(white: 0, alpha: 0.87)
    static let subtitleColor = UIColor(white: 0, alpha: 0.60)
  }
  fileprivate var cellsBySection: [[DragonCell]]
  fileprivate var searched: [DragonCell]!
  fileprivate var results: [DragonCell]!
  fileprivate var tableView: UITableView!
  fileprivate var isSearchActive = false

  fileprivate var headerViewController = MDCFlexibleHeaderViewController()

  private let keyboardWatcher = MDCKeyboardWatcher()

  var headerView: HeaderView!

  init(node: CBCNode) {
    let filteredPresentable = node.children.filter { return $0.isPresentable() }
    let filteredDragons = Set(node.children).subtracting(filteredPresentable)
    cellsBySection = [filteredDragons.map { DragonCell(node: $0) },
                      filteredPresentable.map { DragonCell(node: $0) }]
    cellsBySection = cellsBySection.map { $0.sorted() { $0.node.title < $1.node.title } }
    super.init(nibName: nil, bundle: nil)
    results = getLeafNodes(node: node)
    searched = results

    setUpKeyboardWatcher()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func getLeafNodes(node: CBCNode) -> [DragonCell] {
    if node.children.count == 0 {
      return [DragonCell(node: node)]
    }

    var cells = [DragonCell]()
    for child in node.children {
      cells += getLeafNodes(node: child)
    }

    return cells
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Material Dragons"
    addChild(headerViewController)
    headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    headerViewController.headerView.maximumHeight = Constants.headerViewMaxHeight
    headerViewController.headerView.minimumHeight = Constants.headerViewMinHeight
    tableView = UITableView(frame: self.view.bounds, style: .grouped)
    tableView.register(MDCDragonsTableViewCell.self,
                       forCellReuseIdentifier: "MDCDragonsTableViewCell")
    tableView.backgroundColor = Constants.bgColor
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    view.backgroundColor = Constants.bgColor

    if #available(iOS 11, *) {
      tableView.translatesAutoresizingMaskIntoConstraints = false

      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([tableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                                   tableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
                                   tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                   tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)])
    } else {
      preiOS11Constraints()
    }

    setupHeaderView()
    let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapgesture.delegate = self
    view.addGestureRecognizer(tapgesture)

    if #available(iOS 11.0, *) {
      tableView.contentInsetAdjustmentBehavior = .always
    }
  }

  func preiOS11Constraints() {
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  func setupHeaderView() {
    headerView = HeaderView(frame: headerViewController.headerView.bounds)
    headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    headerView.title.text = title!
    headerView.searchBar.delegate = self

    headerViewController.headerView.addSubview(headerView)
    headerViewController.headerView.forwardTouchEvents(for: headerView)
    headerViewController.headerView.backgroundColor = Constants.headerColor
    headerViewController.headerView.trackingScrollView = tableView
    view.addSubview(headerViewController.view)
    headerViewController.didMove(toParent: self)
  }

  func adjustLogoForScrollView(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let inset = scrollView.contentInset.top
    let relativeOffset = inset + offset

    headerView.imageView.alpha = 1 - (relativeOffset / Constants.headerScrollThreshold)
    headerView.title.alpha = 1 - (relativeOffset / Constants.headerScrollThreshold)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override var childForStatusBarStyle: UIViewController? {
    return headerViewController
  }

  override var childForStatusBarHidden: UIViewController? {
    return headerViewController
  }

  // MARK: UITableViewDataSource
  func numberOfSections(in tableView: UITableView) -> Int {
    return isSearchActive ? 1 : 2
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return isSearchActive ? "Results" : (section == 0 ? "Dragons" : "Catalog")
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isSearchActive ? searched.count : cellsBySection[section].count
  }

  // MARK: UITableViewDelegate
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell =
      tableView.dequeueReusableCell(withIdentifier: "MDCDragonsTableViewCell",
                                    for: indexPath) as? MDCDragonsTableViewCell else {
      return UITableViewCell()
    }
    cell.backgroundColor = .white
    let nodeData = isSearchActive ? searched[indexPath.item] : cellsBySection[indexPath.section][indexPath.row]
    let componentName = nodeData.node.title
    cell.textLabel?.text = componentName
    let node = nodeData.node
    if !node.isExample() && !isSearchActive {
      if nodeData.expanded {
        cell.accessoryView = cell.expandedButton
        cell.textLabel?.textColor = Constants.headerColor
      } else {
        cell.accessoryView = cell.defaultButton
        cell.textLabel?.textColor = Constants.titleColor
      }
    } else {
      cell.accessoryView = nil
      if indexPath.section != 0 {
        cell.textLabel?.textColor = Constants.subtitleColor
        if let text = cell.textLabel?.text {
          cell.textLabel?.text = "  " + text
        }
      } else if isSearchActive {
        cell.textLabel?.textColor = Constants.titleColor
      }
    }
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let cell = tableView.cellForRow(at: indexPath) as? MDCDragonsTableViewCell else {
      return
    }
    let nodeData = isSearchActive ? searched[indexPath.item] : cellsBySection[indexPath.section][indexPath.row]
    if nodeData.node.isExample() || isSearchActive {
      setupTransition(nodeData: nodeData)
    } else if !isSearchActive {
      self.tableView.beginUpdates()
      if nodeData.expanded {
        collapseCells(at: indexPath)
        cell.accessoryView = cell.defaultButton
        cell.textLabel?.textColor = Constants.titleColor
      } else {
        expandCells(at: indexPath)
        cell.accessoryView = cell.expandedButton
        cell.textLabel?.textColor = Constants.headerColor
      }
      self.tableView.endUpdates()
      nodeData.expanded = !nodeData.expanded
    }
  }

  func setupTransition(nodeData: DragonCell) {
    var vc = nodeData.node.createExampleViewController()
    if !vc.responds(to: NSSelectorFromString("catalogShouldHideNavigation")) {
      let container = MDCAppBarContainerViewController(contentViewController: vc)
      container.appBar.headerViewController.headerView.backgroundColor = headerViewController.headerView.backgroundColor
      container.appBar.navigationBar.tintColor = .white
      container.appBar.navigationBar.titleTextAttributes =
        [ .foregroundColor: UIColor.white,
          .font: UIFont.systemFont(ofSize: 16) ]
      container.isTopLayoutGuideAdjustmentEnabled = true
      vc.title = nodeData.node.title

      let headerView = container.appBar.headerViewController.headerView
      if let collectionVC = vc as? UICollectionViewController {
        headerView.trackingScrollView = collectionVC.collectionView
      } else if let scrollView = vc.view as? UIScrollView {
        headerView.trackingScrollView = scrollView
      }
      vc = container
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }

}

// UIScrollViewDelegate
extension MDCDragonsController {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidScroll()
      self.adjustLogoForScrollView(scrollView)
    }
  }

  func scrollViewDidEndDragging( _ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(withVelocity: velocity,
                                               targetContentOffset: targetContentOffset)
    }
  }

}

// UISearchBarDelegate
extension MDCDragonsController {

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      isSearchActive = false
      searched = results
    } else {
      isSearchActive = true
      searched = results.filter {
        return $0.node.title.range(of: searchText, options: .caseInsensitive) != nil
      }
    }
    tableView.reloadData()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searched = results
    tableView.reloadData()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    isSearchActive = true
    tableView.reloadData()
  }

  @objc func dismissKeyboard() {
    self.view.endEditing(true)
    isSearchActive = false
    tableView.reloadData()
  }

  @objc(gestureRecognizer:shouldReceiveTouch:)
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    if gestureRecognizer is UITapGestureRecognizer {
      let location = touch.location(in: tableView)
      return (tableView.indexPathForRow(at: location) == nil)
    }
    return true
  }

}

extension MDCDragonsController {
  func collapseCells(at indexPath: IndexPath) {
    let upperCount = cellsBySection[indexPath.section][indexPath.row].node.children.count
    let indexPaths = (indexPath.row+1..<indexPath.row+1+upperCount).map {
      IndexPath(row: $0, section: indexPath.section)
    }
    tableView.deleteRows(at: indexPaths, with: .automatic)
    cellsBySection[indexPath.section].removeSubrange((indexPath.row+1..<indexPath.row+1+upperCount))

  }

  func expandCells(at indexPath: IndexPath) {
    let nodeChildren = cellsBySection[indexPath.section][indexPath.row].node.children
    let upperCount = nodeChildren.count
    let indexPaths = (indexPath.row+1..<indexPath.row+1+upperCount).map {
      IndexPath(row: $0, section: indexPath.section)
    }
    tableView.insertRows(at: indexPaths, with: .automatic)
    cellsBySection[indexPath.section].insert(contentsOf: nodeChildren.map { DragonCell(node: $0) },
                                                     at: indexPath.row+1)
  }
}

extension MDCDragonsController {
  func setUpKeyboardWatcher() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .MDCKeyboardWatcherKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .MDCKeyboardWatcherKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: .MDCKeyboardWatcherKeyboardWillChangeFrame, object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    updateScrollViewWithKeyboardNotificationUserInfo(userInfo: userInfo)
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    updateScrollViewWithKeyboardNotificationUserInfo(userInfo: userInfo)
  }

  @objc func keyboardWillChangeFrame(notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    updateScrollViewWithKeyboardNotificationUserInfo(userInfo: userInfo)
  }

  func updateScrollViewWithKeyboardNotificationUserInfo(userInfo: [AnyHashable: Any]) {
    guard let endFrame = userInfo[AnyHashable("UIKeyboardFrameEndUserInfoKey")] as? CGRect
      else { return }
    let endKeyboardFrameOriginInWindow = view.convert(endFrame.origin, from: nil)
    let tableViewMaxY = tableView.frame.maxY
    let baseInset = tableViewMaxY - endKeyboardFrameOriginInWindow.y
    let scrollIndicatorInset = baseInset
    var contentInset = baseInset
    if #available(iOS 11, *) {
      if endKeyboardFrameOriginInWindow.y < tableViewMaxY {
        contentInset -= view.safeAreaInsets.bottom
      }
    }
    tableView.contentInset.bottom = contentInset
    tableView.scrollIndicatorInsets.bottom = scrollIndicatorInset
  }
}
