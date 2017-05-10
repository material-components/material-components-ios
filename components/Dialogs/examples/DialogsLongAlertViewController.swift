/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

import Foundation
import MaterialComponents

class DialogsLongAlertViewController: UIViewController {

  let flatButton = MDCFlatButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white

    flatButton.setTitle("PRESENT ALERT", for: UIControlState())
    flatButton.setTitleColor(CatalogStyle.primaryColor, for: UIControlState())
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    self.view.addSubview(flatButton)

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item:flatButton,
                       attribute:.centerX,
                       relatedBy:.equal,
                       toItem:self.view,
                       attribute:.centerX,
                       multiplier:1.0,
                       constant: 0.0),
      NSLayoutConstraint(item:flatButton,
                       attribute:.centerY,
                       relatedBy:.equal,
                       toItem:self.view,
                       attribute:.centerY,
                       multiplier:1.0,
                       constant: 0.0)
    ])
  }

  func tap(_ sender: Any) {
    let messageString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur " +
    "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus " +
    "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, " +
    "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. " +
    "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean " +
    "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus urna " +
    "ut nulla. Phasellus elementum lorem sit amet sapien dictum, vel cursus est semper. Aenean " +
    "vel turpis maximus, accumsan dui quis, cursus turpis. Nunc a tincidunt nunc, ut tempus " +
    "libero. Morbi ut orci laoreet, luctus neque nec, rhoncus enim. Cras dui erat, blandit ac " +
    "malesuada vitae, fringilla ac ante. Nullam dui diam, condimentum vitae mi et, dictum " +
    "euismod libero. Aliquam commodo urna vitae massa convallis aliquet."

    let materialAlertController = MDCAlertController(title: nil, message: messageString)

    let action = MDCAlertAction(title:"OK") { (_) in print("OK") }

    materialAlertController.addAction(action)

    self.present(materialAlertController, animated: true, completion: nil)
  }
}

// MARK: Catalog by convention
extension DialogsLongAlertViewController {
  class func catalogBreadcrumbs() -> [String] {
    return [ "Dialogs", "Swift Alert Example"]
  }
  class func catalogDescription() -> String {
    return "Swift Alert Example"
  }
}
