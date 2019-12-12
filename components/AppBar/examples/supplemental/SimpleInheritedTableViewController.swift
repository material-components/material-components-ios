// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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
import MaterialComponents.MaterialFlexibleHeader

/// A table view controller which inherits directly from UITableViewController.
///
/// This intentionally sets things up such that its view is a subclass of UIScrollView, which is
/// handled specially by some components.
class SimpleInheritedTableViewController: UITableViewController {

  init(title: String? = nil) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding unsupported")
  }

  var headerView: MDCFlexibleHeaderView?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let titleString = title ?? ""
    cell.textLabel?.text = "\(titleString): Row \(indexPath.item)"
    return cell
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidScroll()
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidEndDecelerating()
  }

  override func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    headerView?.trackingScrollWillEndDragging(
      withVelocity: velocity,
      targetContentOffset: targetContentOffset)
  }

  override func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    headerView?.trackingScrollDidEndDraggingWillDecelerate(decelerate)
  }
}
