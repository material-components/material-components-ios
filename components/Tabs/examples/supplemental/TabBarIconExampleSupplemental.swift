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

import MaterialComponents.MaterialButtons

extension TabBarIconSwiftExample {

  // MARK: Methods

  func setupExampleViews() {
    view.backgroundColor = UIColor.white

    appBar.addSubviewsToParent()

    let badgeIncrementItem = UIBarButtonItem(title: "Add",
                                             style: .plain,
                                             target: self,
                                             action:#selector(incrementDidTouch(_: )))

    self.navigationItem.rightBarButtonItem = badgeIncrementItem

    self.title = "Tabs With Icons"

    setupScrollingContent()
  }

  func setupScrollView() -> UIScrollView {
    let scrollView = UIScrollView(frame: CGRect())
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = false
    scrollView.isScrollEnabled = false
    self.view.addSubview(scrollView)

    scrollView.backgroundColor = UIColor.red

    let views = ["scrollView": scrollView, "header": self.appBar.headerStackView]
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[header][scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: views))


    return scrollView
  }

  func setupScrollingContent() {
    let infoPage = UIView(frame: CGRect())
    infoPage.translatesAutoresizingMaskIntoConstraints = false
    infoPage.backgroundColor = MDCPalette.lightBlue().tint300
    scrollView.addSubview(infoPage)

    let infoLabel = UILabel(frame: CGRect())
    infoLabel.translatesAutoresizingMaskIntoConstraints = false
    infoLabel.textColor = UIColor.white
    infoLabel.numberOfLines = 0
    infoLabel.text = "Tabs enable content organization at a high level, such as switching between views"
    infoPage.addSubview(infoLabel)

    NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: infoPage, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: infoLabel, attribute: .centerY, relatedBy: .equal, toItem: infoPage, attribute: .centerY, multiplier: 1, constant: -50).isActive = true

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[infoLabel]-50-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["infoLabel": infoLabel]))
    NSLayoutConstraint(item: infoPage, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: infoPage, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 1, constant: 0).isActive = true

    NSLayoutConstraint(item: self.starPage, attribute: .width, relatedBy: .equal, toItem: infoPage, attribute: .width, multiplier: 1, constant: 0).isActive = true

    let views = ["infoPage": infoPage, "starPage": self.starPage]

    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[infoPage][starPage]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[infoPage]|", options: [], metrics: nil, views: views))

    addStar(centered: true)
  }

  func setupStarPage() -> UIView {
    let starPage = UIView(frame: CGRect())
    starPage.translatesAutoresizingMaskIntoConstraints = false
    starPage.backgroundColor = MDCPalette.lightBlue().tint200
    self.scrollView.addSubview(starPage)

    return starPage
  }

  func addStar(centered: Bool) {
    
  }
}

extension TabBarIconSwiftExample {
  override var childViewControllerForStatusBarStyle: UIViewController? {
    return appBar.headerViewController
  }
}

// MARK: Catalog by convention
extension TabBarIconSwiftExample {
  class func catalogBreadcrumbs() -> [String] {
    return ["Tab Bar", "Icons and Text (Swift)"]
  }
  func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
