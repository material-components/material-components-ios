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

import MaterialComponents.MaterialFlexibleHeader
import MaterialComponents.MaterialLibraryInfo
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialShadowLayer
import MaterialComponents.MaterialThemes
import MaterialComponents.MaterialTypography

import UIKit

class MDCDragonsController: UITableViewController, UISearchBarDelegate {
  
  fileprivate struct Constants {
    static let headerScrollThreshold: CGFloat = 50
    static let inset: CGFloat = 16
    static let logoTitleVerticalSpacing: CGFloat = 32
    static let logoWidthHeight: CGFloat = 40
    static let spacing: CGFloat = 1
  }
  
  fileprivate let dragonCells: [DragonCell]
  
  static let colors: [UIColor] = [UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0),
                                  UIColor(red: 0.957, green: 0.263, blue: 0.212, alpha: 1.0),
                                  UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.0),
                                  UIColor(red: 1.0, green: 0.922, blue: 0.231, alpha: 1.0)]
  
  fileprivate lazy var headerViewController = MDCFlexibleHeaderViewController()
  var headerView: HeaderView!
  var searched: [DragonCell] = []

  init(node: CBCNode) {
    dragonCells = node.children.map { DragonCell(node: $0) }
    searched = dragonCells
    super.init(style: .plain)
    title = "Material Dragons"
    addChildViewController(headerViewController)
    headerViewController.headerView.minMaxHeightIncludesSafeArea = false
    headerViewController.headerView.maximumHeight = 113
    headerViewController.headerView.minimumHeight = 53

    tableView.register(MDCDragonsTableViewCell.self, forCellReuseIdentifier: "MDCDragonsTableViewCell")
    tableView?.backgroundColor = UIColor(white: 0.97, alpha: 1)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHeaderView()
    let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapgesture.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapgesture)
    
    if #available(iOS 11.0, *) {
      tableView?.contentInsetAdjustmentBehavior = .always
    }
  }
  
  func setupHeaderView() {
    headerView = HeaderView(frame: headerViewController.headerView.bounds)
    headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    headerView.title.text = title!
    headerView.searchBar.delegate = self
    
    headerViewController.headerView.addSubview(headerView)
    headerViewController.headerView.forwardTouchEvents(for: headerView)
    headerViewController.headerView.backgroundColor = MDCDragonsController.colors[2]
    headerViewController.headerView.trackingScrollView = tableView
    view.addSubview(headerViewController.view)
    headerViewController.didMove(toParentViewController: self)
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
  
  override var childViewControllerForStatusBarStyle: UIViewController? {
    return headerViewController
  }
  
  override var childViewControllerForStatusBarHidden: UIViewController? {
    return headerViewController
  }
  
  // MARK: UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searched.count
  }
  
  // MARK: UITableViewDelegate
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell =
      tableView.dequeueReusableCell(withIdentifier: "MDCDragonsTableViewCell",
                                    for: indexPath) as? MDCDragonsTableViewCell else {
      return UITableViewCell()
    }
    cell.backgroundColor = .white
    let nodeData = searched[indexPath.item]
    let componentName = nodeData.node.title
    cell.textLabel?.text = componentName
    let node = searched[indexPath.item].node
    if !node.isExample() {
      if nodeData.expanded {
        cell.accessoryView = cell.expandedButton
      } else {
        cell.accessoryView = cell.defaultButton
      }
    } else {
      cell.accessoryView = nil
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let cell = tableView.cellForRow(at: indexPath) as? MDCDragonsTableViewCell else {
      return
    }
    let nodeData = searched[indexPath.item]
    if nodeData.node.isExample() {
      let vc = nodeData.node.createExampleViewController()
      self.navigationController?.pushViewController(vc, animated: true)
    } else {
      self.tableView.beginUpdates()
      if nodeData.expanded {
        collapseCells(at: indexPath.item)
        cell.accessoryView = cell.defaultButton
      } else {
        expandCells(at: indexPath.item)
        cell.accessoryView = cell.expandedButton
      }
      self.tableView.endUpdates()
      nodeData.expanded = !nodeData.expanded
    }
  }
  
}

// UIScrollViewDelegate
extension MDCDragonsController {
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidScroll()
      self.adjustLogoForScrollView(scrollView)
    }
  }
  
  override func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool) {
    let headerView = headerViewController.headerView
    if scrollView == headerView.trackingScrollView {
      headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
    }
  }
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == headerViewController.headerView.trackingScrollView {
      self.headerViewController.headerView.trackingScrollDidEndDecelerating()
    }
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
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
      searched = dragonCells
    } else {
      searched = dragonCells.filter ({ (cell) -> Bool in
        return cell.node.title.range(of: searchText, options: .caseInsensitive) != nil
      })
    }
    self.tableView?.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searched = dragonCells
    self.tableView?.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }

  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
}

extension MDCDragonsController {
  func collapseCells(at index: Int) {
    let indexPaths = (index+1..<index+1+searched[index].node.children.count).map {
      IndexPath(row: $0, section: 0)
    }
    tableView.deleteRows(at: indexPaths, with: .automatic)
    searched.removeSubrange((index+1..<index+1+searched[index].node.children.count))

  }

  func expandCells(at index: Int) {
    let indexPaths = (index+1..<index+1+searched[index].node.children.count).map {
      IndexPath(row: $0, section: 0)
    }
    tableView.insertRows(at: indexPaths, with: .automatic)
    searched.insert(contentsOf: searched[index].node.children.map { DragonCell(node: $0) },
                    at: index+1)
  }
}

