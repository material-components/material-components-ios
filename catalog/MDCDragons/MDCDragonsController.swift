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

import UIKit
import CatalogByConvention
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography
import MaterialComponents.MaterialIcons_ic_chevron_right
import MaterialComponents.MaterialKeyboardWatcher
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme

class MDCDragonsController: UIViewController,
  UITableViewDelegate,
  UITableViewDataSource,
  UISearchBarDelegate,
  UIGestureRecognizerDelegate
{

  let containerScheme: MDCContainerScheming = {
    let scheme = MDCContainerScheme()
    scheme.colorScheme = MDCSemanticColorScheme(defaults: .material201907)
    scheme.typographyScheme = MDCTypographyScheme(defaults: .material201902)
    scheme.shapeScheme = MDCShapeScheme()
    return scheme
  }()

  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 50
    static let headerViewMaxHeight: CGFloat = 113
    static let headerViewMinHeight: CGFloat = 53
  }
  fileprivate var cellsBySection: [[DragonCell]]
  fileprivate var nodes: [CBCNode]
  fileprivate var searched: [DragonCell]!
  fileprivate var results: [DragonCell]!
  fileprivate var tableView: UITableView!
  fileprivate var isSearchActive = false

  fileprivate var headerViewController = MDCFlexibleHeaderViewController()

  private let keyboardWatcher = MDCKeyboardWatcher()

  var headerView: HeaderView!

  enum Section {
    case main
  }

  @available(iOS 14.0, *)
  private(set) lazy var dataSource: UICollectionViewDiffableDataSource<Section, CBCNode>! = nil
  var collectionView: UICollectionView! = nil

  init(node: CBCNode) {
    let filteredPresentable = node.children.filter { return $0.isPresentable() }
    let filteredDragons = Set(node.children).subtracting(filteredPresentable)
    cellsBySection = [
      filteredDragons.map { DragonCell(node: $0) },
      filteredPresentable.map { DragonCell(node: $0) },
    ]
    cellsBySection = cellsBySection.map { $0.sorted { $0.node.title < $1.node.title } }
    nodes = node.children
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

    view.backgroundColor = containerScheme.colorScheme.backgroundColor

    if #available(iOS 14.0, *) {
      #if compiler(>=5.3)
        configureCollectionView()
        configureDataSource()
      #endif
    } else {
      tableView = UITableView(frame: self.view.bounds, style: .grouped)
      tableView.register(
        MDCDragonsTableViewCell.self,
        forCellReuseIdentifier: "MDCDragonsTableViewCell")
      tableView.backgroundColor = containerScheme.colorScheme.backgroundColor
      tableView.delegate = self
      tableView.dataSource = self
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 44
      view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false

      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        tableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
        tableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
      ])

      tableView.contentInsetAdjustmentBehavior = .always
    }

    setupHeaderView()
    let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapgesture.delegate = self
    view.addGestureRecognizer(tapgesture)
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
    headerViewController.headerView.backgroundColor = containerScheme.colorScheme.primaryColor
    if #available(iOS 14.0, *) {
      headerViewController.headerView.trackingScrollView = collectionView
    } else {
      headerViewController.headerView.trackingScrollView = tableView
    }
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
    guard
      let cell =
        tableView.dequeueReusableCell(
          withIdentifier: "MDCDragonsTableViewCell",
          for: indexPath) as? MDCDragonsTableViewCell
    else {
      return UITableViewCell()
    }
    let nodeData =
      isSearchActive ? searched[indexPath.item] : cellsBySection[indexPath.section][indexPath.row]
    let componentName = nodeData.node.title
    cell.textLabel?.text = componentName
    cell.textLabel?.textColor = containerScheme.colorScheme.onBackgroundColor
    cell.tintColor = containerScheme.colorScheme.onBackgroundColor
    let node = nodeData.node
    if !node.isExample() && !isSearchActive {
      if nodeData.expanded {
        cell.accessoryView = cell.expandedAccessoryView
        cell.textLabel?.textColor = containerScheme.colorScheme.primaryColor
      } else {
        cell.accessoryView = cell.collapsedAccessoryView
        cell.textLabel?.textColor = containerScheme.colorScheme.onBackgroundColor
      }
    } else {
      cell.accessoryView = nil
      if indexPath.section != 0 {
        cell.textLabel?.textColor = containerScheme.colorScheme.onBackgroundColor
        if let text = cell.textLabel?.text {
          cell.textLabel?.text = "  " + text
        }
      } else if isSearchActive {
        cell.textLabel?.textColor = containerScheme.colorScheme.onBackgroundColor
      }
    }
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let cell = tableView.cellForRow(at: indexPath) as? MDCDragonsTableViewCell else {
      return
    }
    let nodeData =
      isSearchActive ? searched[indexPath.item] : cellsBySection[indexPath.section][indexPath.row]
    if nodeData.node.isExample() || isSearchActive {
      setupTransition(nodeData: nodeData)
    } else if !isSearchActive {
      self.tableView.beginUpdates()
      if nodeData.expanded {
        collapseCells(at: indexPath)
        cell.accessoryView = cell.collapsedAccessoryView
        cell.textLabel?.textColor = containerScheme.colorScheme.onBackgroundColor

      } else {
        expandCells(at: indexPath)
        cell.accessoryView = cell.expandedAccessoryView
        cell.textLabel?.textColor = containerScheme.colorScheme.primaryColor
      }
      self.tableView.endUpdates()
      nodeData.expanded = !nodeData.expanded
    }
  }

  func setupTransition(nodeData: DragonCell) {
    var vc = nodeData.node.createExampleViewController()
    vc.title = nodeData.node.title

    let containerSchemeSel = NSSelectorFromString("setContainerScheme:")
    if vc.responds(to: containerSchemeSel) {
      vc.perform(containerSchemeSel, with: containerScheme)
    }
    if !vc.responds(to: NSSelectorFromString("catalogShouldHideNavigation")) {
      let container = MDCAppBarContainerViewController(contentViewController: vc)
      container.appBar.headerViewController.headerView.backgroundColor =
        headerViewController.headerView.backgroundColor
      container.appBar.navigationBar.tintColor = .white
      container.appBar.navigationBar.titleTextAttributes =
        [
          .foregroundColor: UIColor.white,
          .font: UIFont.systemFont(ofSize: 16),
        ]
      container.isTopLayoutGuideAdjustmentEnabled = true

      let headerView = container.appBar.headerViewController.headerView
      if let collectionVC = vc as? UICollectionViewController {
        headerView.trackingScrollView = collectionVC.collectionView
      } else if let scrollView = vc.view as? UIScrollView {
        headerView.trackingScrollView = scrollView
      }
      vc = container
      if let splitViewController = self.splitViewController {
        vc.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        vc.navigationItem.leftItemsSupplementBackButton = true
        vc.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
      }
    } else {
      navigationController?.setNavigationBarHidden(true, animated: true)
    }
    /**
     The view should be pushed to the navigation controller for iPhones, and to the split view controller
     for larger devices.
     */
    if UIDevice.current.userInterfaceIdiom == .phone {
      self.navigationController?.pushViewController(vc, animated: true)
    } else {
      self.showDetailViewController(vc, sender: self)
      self.splitViewController?.toggleSideBarView()
    }
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

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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

  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollWillEndDragging(
        withVelocity: velocity,
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
    // load our initial data
    refreshTable()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searched = results
    refreshTable()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    isSearchActive = true
    refreshTable()
  }

  @objc func dismissKeyboard() {
    self.view.endEditing(true)
    isSearchActive = false

  }

  func refreshTable() {
    if #available(iOS 14.0, *) {
      #if compiler(>=5.3)
        applySnapshot()
      #endif
    } else {
      tableView.reloadData()
    }
  }

  @objc(gestureRecognizer:shouldReceiveTouch:)
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch)
    -> Bool
  {
    if gestureRecognizer is UITapGestureRecognizer {
      if #available(iOS 14.0, *) {
        let location = touch.location(in: collectionView)
        return (collectionView.indexPathForItem(at: location) == nil)
      } else {
        let location = touch.location(in: tableView)
        return (tableView.indexPathForRow(at: location) == nil)
      }
    }
    return true
  }

}

extension MDCDragonsController {
  func collapseCells(at indexPath: IndexPath) {
    let upperCount = cellsBySection[indexPath.section][indexPath.row].node.children.count
    let indexPaths = (indexPath.row + 1..<indexPath.row + 1 + upperCount).map {
      IndexPath(row: $0, section: indexPath.section)
    }
    tableView.deleteRows(at: indexPaths, with: .automatic)
    cellsBySection[indexPath.section].removeSubrange(
      (indexPath.row + 1..<indexPath.row + 1 + upperCount))

  }

  func expandCells(at indexPath: IndexPath) {
    let nodeChildren = cellsBySection[indexPath.section][indexPath.row].node.children
    let upperCount = nodeChildren.count
    let indexPaths = (indexPath.row + 1..<indexPath.row + 1 + upperCount).map {
      IndexPath(row: $0, section: indexPath.section)
    }
    tableView.insertRows(at: indexPaths, with: .automatic)
    cellsBySection[indexPath.section].insert(
      contentsOf: nodeChildren.map { DragonCell(node: $0) },
      at: indexPath.row + 1)
  }
}

extension MDCDragonsController {
  func setUpKeyboardWatcher() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillShow(notification:)),
      name: .MDCKeyboardWatcherKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillHide(notification:)),
      name: .MDCKeyboardWatcherKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillChangeFrame(notification:)),
      name: .MDCKeyboardWatcherKeyboardWillChangeFrame, object: nil)
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
    if #available(iOS 14.0, *) {
    } else {
      guard let endFrame = userInfo[AnyHashable("UIKeyboardFrameEndUserInfoKey")] as? CGRect
      else { return }
      let endKeyboardFrameOriginInWindow = view.convert(endFrame.origin, from: nil)
      let tableViewMaxY = tableView.frame.maxY
      let baseInset = tableViewMaxY - endKeyboardFrameOriginInWindow.y
      let scrollIndicatorInset = baseInset
      var contentInset = baseInset
      if endKeyboardFrameOriginInWindow.y < tableViewMaxY {
        contentInset -= view.safeAreaInsets.bottom
      }
      tableView.contentInset.bottom = contentInset
      tableView.scrollIndicatorInsets.bottom = scrollIndicatorInset
    }
  }

  #if compiler(>=5.3)
    @available(iOS 14.0, *)
    func configureCollectionView() {
      let collectionView = UICollectionView(
        frame: view.bounds, collectionViewLayout: generateLayout())
      view.addSubview(collectionView)
      collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      collectionView.backgroundColor = containerScheme.colorScheme.backgroundColor
      self.collectionView = collectionView
      collectionView.delegate = self
    }

    @available(iOS 14.0, *)
    func configureDataSource() {
      let containerCellRegistration =
        UICollectionView.CellRegistration<
          UICollectionViewListCell,
          CBCNode
        > { (cell, indexPath, menuItem) in
          // Populate the cell with our item description.
          var contentConfiguration = UIListContentConfiguration.sidebarCell()
          contentConfiguration.text = menuItem.title
          contentConfiguration.textProperties.color =
            self.containerScheme.colorScheme.onBackgroundColor
          cell.contentConfiguration = contentConfiguration

          let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
          cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
          cell.backgroundConfiguration = UIBackgroundConfiguration.listSidebarCell()
        }

      let cellRegistration =
        UICollectionView.CellRegistration<
          UICollectionViewListCell,
          CBCNode
        > { cell, indexPath, menuItem in
          // Populate the cell with our item description.
          var contentConfiguration = UIListContentConfiguration.sidebarCell()
          contentConfiguration.text = menuItem.title
          contentConfiguration.textProperties.color =
            self.containerScheme.colorScheme.onBackgroundColor
          cell.contentConfiguration = contentConfiguration
          cell.backgroundConfiguration = UIBackgroundConfiguration.listSidebarCell()
        }

      dataSource =
        UICollectionViewDiffableDataSource<Section, CBCNode>(collectionView: collectionView) {
          (
            collectionView: UICollectionView,
            indexPath: IndexPath,
            item: CBCNode
          ) -> UICollectionViewCell? in
          // Return the cell.
          if item.children.isEmpty {
            return collectionView.dequeueConfiguredReusableCell(
              using: cellRegistration,
              for: indexPath,
              item: item)
          } else {
            return collectionView.dequeueConfiguredReusableCell(
              using: containerCellRegistration,
              for: indexPath,
              item: item)
          }
        }
      // load our initial data
      applySnapshot(animatingDifferences: false)
    }

    @available(iOS 14.0, *)
    func generateLayout() -> UICollectionViewLayout {
      let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
      return layout
    }

    @available(iOS 14.0, *)
    func applySnapshot(animatingDifferences: Bool = true) {
      let sectionSnapshot =
        createSectionSnapshot(section: isSearchActive ? searched.map { $0.node } : nodes)
      self.dataSource.apply(sectionSnapshot, to: .main, animatingDifferences: animatingDifferences)
    }

    @available(iOS 14.0, *)
    func createSectionSnapshot(section: [CBCNode]) -> NSDiffableDataSourceSectionSnapshot<CBCNode> {
      var snapshot = NSDiffableDataSourceSectionSnapshot<CBCNode>()

      func addItems(_ menuItems: [CBCNode], to parent: CBCNode?) {
        snapshot.append(menuItems, to: parent)
        for menuItem in menuItems where !menuItem.children.isEmpty {
          addItems(menuItem.children, to: menuItem)
        }
      }

      addItems(section, to: nil)
      return snapshot
    }
  #endif

}

extension MDCDragonsController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if #available(iOS 14.0, *) {
      guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
      collectionView.deselectItem(at: indexPath, animated: true)

      if menuItem.isExample() || isSearchActive {
        setupTransition(nodeData: DragonCell(node: menuItem))
      }
    }
  }
}
