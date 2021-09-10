// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

// swiftlint:disable function_body_length
// swiftlint:disable line_length

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialAppBar_ColorThemer 
import MaterialComponents.MaterialAppBar_TypographyThemer 
import MaterialComponents.MaterialButtons_ButtonThemer 
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialPalettes

extension TabBarIconSwiftExample {

  func setupAlignmentButton() -> MDCButton {
    let alignmentButton = MDCButton()

    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = containerScheme.colorScheme
    buttonScheme.typographyScheme = containerScheme.typographyScheme
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: alignmentButton)

    alignmentButton.setTitle("Change Alignment", for: .normal)
    alignmentButton.setTitleColor(.white, for: .normal)

    self.view.addSubview(alignmentButton)
    alignmentButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint(
      item: alignmentButton,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .centerX,
      multiplier: 1,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: alignmentButton,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .bottom,
      multiplier: 1,
      constant: -40
    ).isActive = true

    return alignmentButton
  }

  func setupAppBar() -> MDCAppBarViewController {
    let appBarViewController = MDCAppBarViewController()

    self.addChild(appBarViewController)
    appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
    appBarViewController.headerView.minimumHeight = 56 + 72
    appBarViewController.headerView.tintColor = MDCPalette.blue.tint500
    MDCAppBarColorThemer.applyColorScheme(containerScheme.colorScheme, to: appBarViewController)
    MDCAppBarTypographyThemer.applyTypographyScheme(
      containerScheme.typographyScheme, to: appBarViewController)

    appBarViewController.headerStackView.bottomBar = self.tabBar
    appBarViewController.headerStackView.setNeedsLayout()
    return appBarViewController
  }

  func setupExampleViews() {
    view.backgroundColor = UIColor.white

    view.addSubview(appBarViewController.view)
    appBarViewController.didMove(toParent: self)

    let badgeIncrementItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(incrementDidTouch(sender:)))

    self.navigationItem.rightBarButtonItem = badgeIncrementItem

    setupScrollingContent()
  }

  func setupScrollView() -> UIScrollView {
    let scrollView = UIScrollView(frame: CGRect())
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = false
    scrollView.isScrollEnabled = false
    self.view.addSubview(scrollView)

    scrollView.backgroundColor = UIColor.red

    let views: [String: UIView] = [
      "scrollView": scrollView,
      "header": self.appBarViewController.headerStackView,
    ]
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:[header][scrollView]|",
        options: [],
        metrics: nil,
        views: views))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[scrollView]|",
        options: [],
        metrics: nil,
        views: views))

    return scrollView
  }

  func setupScrollingContent() {
    // The scrollView will have two UIViews (pages.) One has a label with text (infoLabel); we call
    // this infoPage. Another has 1+ star images; we call this self.starPage. Tapping on the 'INFO'
    // tab will show the infoPage and tapping on the 'STARS' tab will show the self.starPage.

    // Create the first view and its content. Then add to scrollView.

    let infoPage = UIView(frame: CGRect())
    infoPage.translatesAutoresizingMaskIntoConstraints = false
    infoPage.backgroundColor = MDCPalette.lightBlue.tint300
    scrollView.addSubview(infoPage)

    let infoLabel = UILabel(frame: CGRect())
    infoLabel.translatesAutoresizingMaskIntoConstraints = false
    infoLabel.textColor = UIColor.white
    infoLabel.numberOfLines = 0
    infoLabel.text =
      "Tabs enable content organization at a high level,"
      + " such as switching between views"
    infoPage.addSubview(infoLabel)

    // Layout the views to be equal height and width to each other and self.view,
    // hug the edges of the scrollView and meet in the middle.

    NSLayoutConstraint(
      item: infoLabel,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: infoPage,
      attribute: .centerX,
      multiplier: 1,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: infoLabel,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: infoPage,
      attribute: .centerY,
      multiplier: 1,
      constant: -50
    ).isActive = true

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-50-[infoLabel]-50-|",
        options: [],
        metrics: nil,
        views: ["infoLabel": infoLabel]))
    NSLayoutConstraint(
      item: infoPage,
      attribute: .width,
      relatedBy: .equal,
      toItem: self.view,
      attribute: .width,
      multiplier: 1,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: infoPage,
      attribute: .height,
      relatedBy: .equal,
      toItem: self.scrollView,
      attribute: .height,
      multiplier: 1,
      constant: 0
    ).isActive = true

    NSLayoutConstraint(
      item: self.starPage,
      attribute: .width,
      relatedBy: .equal,
      toItem: infoPage,
      attribute: .width,
      multiplier: 1,
      constant: 0
    ).isActive = true

    let views = ["infoPage": infoPage, "starPage": self.starPage]

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[infoPage][starPage]|",
        options: [
          .alignAllTop,
          .alignAllBottom,
        ],
        metrics: nil,
        views: views))
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[infoPage]|",
        options: [],
        metrics: nil,
        views: views))

    addStar(centered: true)
  }

  func setupStarPage() -> UIView {
    let starPage = UIView(frame: CGRect())
    starPage.translatesAutoresizingMaskIntoConstraints = false
    starPage.backgroundColor = MDCPalette.lightBlue.tint200
    self.scrollView.addSubview(starPage)

    return starPage
  }

  func addStar(centered: Bool) {
    let starImage = UIImage(
      named: "TabBarDemo_ic_star",
      in: Bundle(for: TabBarIconSwiftExample.self),
      compatibleWith: nil)
    let starView = UIImageView(image: starImage)
    starView.translatesAutoresizingMaskIntoConstraints = false
    starPage.addSubview(starView)
    starView.sizeToFit()

    let x = centered ? 1.0 : (CGFloat(arc4random_uniform(199) + 1) / 100.0)  // 0 < x <=2
    let y = centered ? 1.0 : (CGFloat(arc4random_uniform(199) + 1) / 100.0)  // 0 < y <=2

    NSLayoutConstraint(
      item: starView,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: starPage,
      attribute: .centerX,
      multiplier: x,
      constant: 0
    ).isActive = true
    NSLayoutConstraint(
      item: starView,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self.starPage,
      attribute: .centerY,
      multiplier: y,
      constant: 0
    ).isActive = true
  }
}

extension TabBarIconSwiftExample {
  override var childForStatusBarStyle: UIViewController? {
    return appBarViewController
  }

  override func viewWillTransition(
    to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
  ) {
    coordinator.animate(
      alongsideTransition: { (_) in
        if let selectedItem = self.tabBar.selectedItem {
          self.tabBar(self.tabBar, didSelect: selectedItem)
        }
      }, completion: nil)
    super.viewWillTransition(to: size, with: coordinator)
  }
}

// MARK: - Catalog by convention
extension TabBarIconSwiftExample {

  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Tab Bar", "Tabs with Icons (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
