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

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialPalettes
import MaterialComponents.MaterialTabs

class TabBarIconSwiftExample: UIViewController {

  // MARK: Properties
  var alignment: MDCTabBarAlignment {
    get {
      return tabBar.alignment
    }
    set(newAlignment) {
      tabBar.setAlignment(newAlignment, animated: true)
    }
  }

  lazy var alignmentButton: MDCRaisedButton = self.setupAlignmentButton()

  lazy var appBar: MDCAppBar = self.setupAppBar()

  lazy var scrollView: UIScrollView = self.setupScrollView()

  lazy var starPage: UIView = self.setupStarPage()

  lazy var tabBar: MDCTabBar = {
    let tabBar = MDCTabBar()
    tabBar.delegate = self
    tabBar.alignment = .centerSelected

    let bundle = Bundle(for: type(of: self))
    let info = UIImage.init(named: "TabBarDemo_ic_info", in: bundle, compatibleWith:nil)
    let star = UIImage.init(named: "TabBarDemo_ic_star", in: bundle, compatibleWith:nil)

    tabBar.items = [UITabBarItem(title: "Info", image: info, tag:0),
                    UITabBarItem(title: "Stars", image: star, tag:0)]
    tabBar.items[1].badgeValue = "1"

    let blue = MDCPalette.blue.tint500
    tabBar.tintColor = blue
    tabBar.inkColor = blue

    tabBar.barTintColor = UIColor.white
    tabBar.itemAppearance = .titledImages
    tabBar.selectedItemTintColor = UIColor.black.withAlphaComponent(0.87)
    tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.38)

    return tabBar
  }()

  // MARK: Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    setupExampleViews()

    alignmentButton.addTarget(self,
                              action:#selector(changeAlignmentDidTouch(sender:)),
                              for: .touchUpInside)
  }

  func changeAlignmentDidTouch(sender: UIButton) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    sheet.addAction(UIAlertAction(title: "Leading", style: .default, handler: { _ in
      self.alignment = .leading
    }))
    sheet.addAction(UIAlertAction(title: "Center", style: .default, handler: { _ in
      self.alignment = .center
    }))
    sheet.addAction(UIAlertAction(title: "Justified", style: .default, handler: { _ in
      self.alignment = .justified
    }))
    sheet.addAction(UIAlertAction(title: "Selected Center", style: .default, handler: { _ in
      self.alignment = .centerSelected
    }))
    present(sheet, animated: true, completion:nil)
  }

  func incrementStarBadge() {
    let starItem = tabBar.items[1]
    guard let badgeValue = starItem.badgeValue,
      let badgeNumber = Int(badgeValue), badgeNumber > 0 else {
      return
    }

    starItem.badgeValue = NumberFormatter.localizedString(from:(badgeNumber + 1) as NSNumber,
                                                          number: .none)
  }
  // MARK: Action
  func incrementDidTouch(sender: UIBarButtonItem) {
    incrementStarBadge()

    addStar(centered: false)
  }

}

// MARK: Tab Bar delegate
extension TabBarIconSwiftExample: MDCTabBarDelegate {
  func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
    guard let index = tabBar.items.index(of: item) else {
      fatalError("MDCTabBarDelegate given selected item not found in tabBar.items")
    }

    scrollView.setContentOffset(CGPoint(x: CGFloat(index) * view.bounds.width, y: 0),
                                animated: true)
  }
}
