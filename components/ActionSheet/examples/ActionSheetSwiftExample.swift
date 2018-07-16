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

class ActionSheetSwiftExample: UIViewController {
  lazy var actionSheet: MDCActionSheetController = {
    let actionSheet = MDCActionSheetController()
    return actionSheet
  }()

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor

    let showButton = MDCButton()
    showButton.setTitle("Show Action Sheet", for: .normal)
    showButton.sizeToFit()
    showButton.center = view.center
    MDCContainedButtonThemer.applyScheme(MDCButtonScheme(), to: showButton)
    MDCContainedButtonColorThemer.applySemanticColorScheme(colorScheme, to: showButton)
    MDCButtonTypographyThemer.applyTypographyScheme(typographyScheme, to: showButton)
    showButton.addTarget(self,
                         action: #selector(showActionSheet),
                            for: .touchUpInside)
    view.addSubview(showButton)
  }

  func showActionSheet() {
    print("We came here")
    view.addSubview(actionSheet.view)
    /*present(actionSheet, animated: false, completion: {
      print("Show action sheet")
    })*/
  }
}

// MARK: Catalog by Convensions
extension ActionSheetSwiftExample {
  class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  class func catalogBreadcrumbs() -> [String] {
    return ["Action Sheet", "Action Sheet (Swift)"]
  }
}
