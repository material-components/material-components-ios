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

class ActionSheetNoTitleSwiftExample: UIViewController {

  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = colorScheme.backgroundColor

    let showButton = MDCButton()
    showButton.setTitle("Show Action Sheet", for: .normal)
    showButton.sizeToFit()
    showButton.frame.size.height = 48
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
    let message: String =  "Action sheet message that can be up to two lines"
    let actionSheet: MDCActionSheetController = MDCActionSheetController(title: nil,
                                                                         message: message)

    let action = MDCActionSheetAction(title: "Home",
                                      image: nil,
                                      handler: { action in
                                        print("Home action") })
    actionSheet.addAction(action)
    let secondAction = MDCActionSheetAction(title: "Favorite",
                                            image:  nil,
                                            handler: { action in
                                              print("Favorite action") })
    actionSheet.addAction(secondAction)

    let thirdAction = MDCActionSheetAction(title: "Email",
                                           image: nil,
                                           handler: { _ in
                                            print("Email action") })
    actionSheet.addAction(thirdAction)
    present(actionSheet, animated: true, completion: nil)
    actionSheet.title = "Hello"
  }
}

// MARK: Catalog by Convensions
extension ActionSheetNoTitleSwiftExample {
  class func catalogIsPrimaryDemo() -> Bool {
    return false
  }

  class func catalogBreadcrumbs() -> [String] {
    return ["Action Sheet", "Action Sheet No Title (Swift)"]
  }
}
