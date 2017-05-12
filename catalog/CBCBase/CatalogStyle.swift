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

import UIKit

class CatalogStyle {
  // Font used in all headers.
  static let headerFont = UIFont(name: "RobotoMono-Regular", size: 16)
  // Primary color (Black 90%)
  static let primaryColor = UIColor(white: 0.1, alpha: 1)
  // Primary text color
  static let primaryTextColor = UIColor.white
  // Secondary color (Green A400)
  static let secondaryColor = UIColor(red: 0, green: 0xe6/255.0, blue: 0x76/255.0, alpha: 1)
  // Grey background color.
  static let greyColor = UIColor(white: 0.9, alpha: 1)
  // NSAttributedString attributes for headers. 
  static let headerTitleAttributes: [String: Any] = [
    NSForegroundColorAttributeName: CatalogStyle.primaryTextColor,
    NSFontAttributeName: CatalogStyle.headerFont as Any
  ]
}
