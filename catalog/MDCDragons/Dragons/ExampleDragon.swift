/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

class ExampleDragon: UIViewController {
  
  struct MDCPalette {
    static let blue: UIColor = UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1.0)
    static let red: UIColor = UIColor(red: 0.957, green: 0.263, blue: 0.212, alpha: 1.0)
    static let green: UIColor = UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.0)
    static let yellow: UIColor = UIColor(red: 1.0, green: 0.922, blue: 0.231, alpha: 1.0)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}

extension ExampleDragon {
  
  // MARK: Catalog by convention
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Example Dragon", "Example Dragon 2"]
  }
  
  @objc class func catalogIsPrimaryDemo() -> Bool {
    return false
  }
}

