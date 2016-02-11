/*
Copyright 2015-present Google Inc. All Rights Reserved.

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

class Node {
  let title: String
  var children = [Node]()
  var map = [String:Node]()

  var viewController: AnyClass?

  init(title: String) {
    self.title = title
  }
}

class NodeViewController: UITableViewController {
  let node: Node

  init(node: Node) {
    self.node = node
    super.init(nibName: nil, bundle: nil)
    self.title = self.node.title
  }

  required init?(coder aDecoder: NSCoder) {
    self.node = Node(title: "Invalid node")
    super.init(coder: aDecoder)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  // MARK: UITableViewDataSource

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return node.children.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell")
    if cell == nil {
      cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
    }
    cell?.textLabel?.text = self.node.children[indexPath.row].title
    return cell!
  }

  // MARK: UITableViewDelegate

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let node = self.node.children[indexPath.row]
    var vc: UIViewController
    if let vClass = node.viewController {
      vc = ViewControllerFromClass(vClass)
    } else {
      vc = NodeViewController(node: node)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
