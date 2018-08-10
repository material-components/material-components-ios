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

class MDCActionSheetSwiftSupplemental {
  static var actionOne: MDCActionSheetAction {
    return MDCActionSheetAction(title: "Home",
                                image: UIImage(named: "Home")!) { (_) in
                                  print("Home action") }
  }

  static var actionTwo: MDCActionSheetAction {
    return MDCActionSheetAction(title: "Favorite",
                                image: UIImage(named: "Favorite")!) { (_) in
                                  print("Favorite action") }
  }

  static var actionThree: MDCActionSheetAction {
    return MDCActionSheetAction(title: "Email",
                                image: UIImage(named: "Email")!) { (_) in
                                  print("Email action") }
  }

  static var message: String =
  """
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ultricies diam libero, eget
  porta arcu feugiat sit amet. Maecenas placerat felis sed risusnmaximus tempus. Integer feugiat,
  augue in pellentesque dictum, justo erat ultricies leo, quis eleifend nisi eros dictum mi. In
  finibus vulputate eros, in luctus diam auctor in.
  """

  static func typical() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action Sheet",
                                               message: message)
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func missingTitle() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: nil,
                                               message: message)

    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func missingMessage() -> MDCActionSheetController {
    let actionSheet: MDCActionSheetController = MDCActionSheetController(title: "Action Sheet")
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func missingHeading() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController()
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    actionSheet.addAction(actionThree)
    return actionSheet
  }

  static func missingIcons() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action Sheet", message: message)
    let action1 = MDCActionSheetAction(title: "Home", image: nil, handler: { _ in
      print("Home action")
      })
    let action2 = MDCActionSheetAction(title: "Favorite", image: nil, handler: { _ in
      print("Favorite action")
    })
    let action3 = MDCActionSheetAction(title: "Email", image: nil, handler: { _ in
      print("Email action")
    })
    actionSheet.addAction(action1)
    actionSheet.addAction(action2)
    actionSheet.addAction(action3)
    return actionSheet
  }

  static func dynamic() -> MDCActionSheetController {
    let actionSheet = MDCActionSheetController(title: "Action sheet", message: message)
    actionSheet.mdc_adjustsFontForContentSizeCategory = true
    actionSheet.addAction(actionOne)
    actionSheet.addAction(actionTwo)
    return actionSheet
  }
}
