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

/// A table view controller that adds a UITableView as a child of its view.
///
/// The purpose of this view controller is to demonstrate how the flexible header view interacts
/// with view controllers whose self.view is *not* the tracking scroll view. In cases like these,
/// the flexible header view can be added as a sibling to the tracking scroll view.
class SiblingOfTrackingScrollViewViewController: UIViewController {

  init(title: String? = nil) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding unsupported")
  }

  var tableView = UITableView(frame: CGRect(), style: .plain)

  var headerView: MDCFlexibleHeaderView?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(tableView)
    self.tableView.frame = self.view.bounds

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.delegate = self
    tableView.dataSource = self

    view.isOpaque = false
    view.backgroundColor = .white
  }
}

extension SiblingOfTrackingScrollViewViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
}

extension SiblingOfTrackingScrollViewViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let titleString = title ?? ""
    cell.textLabel?.text = "\(titleString): Row \(indexPath.item)"
    return cell
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidScroll()
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidEndDecelerating()
  }

  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    headerView?.trackingScrollWillEndDragging(
      withVelocity: velocity,
      targetContentOffset: targetContentOffset)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    headerView?.trackingScrollDidEndDraggingWillDecelerate(decelerate)
  }

  func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidChangeAdjustedContentInset(scrollView)
  }
}
