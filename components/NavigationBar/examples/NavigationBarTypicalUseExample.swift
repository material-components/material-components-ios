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

import UIKit
import MaterialComponents.MaterialNavigationBar_ColorThemer 
import MaterialComponents.MaterialNavigationBar
import MaterialComponents.MaterialPalettes

open class NavigationBarTypicalUseSwiftExample: UIViewController {

  var navBar = MDCNavigationBar()
  @objc var colorScheme = MDCSemanticColorScheme(defaults: .material201804)
  var exampleView = ExampleInstructionsViewNavigationBarTypicalUseSwift()

  override open func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = colorScheme.backgroundColor

    title = "Navigation Bar (Swift)"

    navBar = MDCNavigationBar()
    navBar.observe(navigationItem)

    let mutator = MDCNavigationBarTextColorAccessibilityMutator()
    mutator.mutate(navBar)

    MDCNavigationBarColorThemer.applySemanticColorScheme(colorScheme, to: navBar)

    view.addSubview(navBar)

    navBar.translatesAutoresizingMaskIntoConstraints = false

    self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.navBar.topAnchor).isActive =
      true

    let viewBindings = ["navBar": navBar]

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[navBar]|",
        options: [],
        metrics: nil,
        views: viewBindings))
    self.setupExampleViews()
  }

  func setupExampleViews() {
    /// Both self.viewDidLoad() and super.viewDidLoad() will add NavigationBars to the hierarchy.
    /// We only want to keep one.

    for subview in view.subviews {
      if let navBarSubview = subview as? MDCNavigationBar, navBarSubview != self.navBar {
        navBarSubview.removeFromSuperview()
      }
    }

    exampleView.frame = self.view.bounds
    self.view.insertSubview(exampleView, belowSubview: navBar)
    exampleView.translatesAutoresizingMaskIntoConstraints = false
    let viewBindings: [String: Any] = ["exampleView": exampleView, "navBar": navBar]
    var constraintsArray: [NSLayoutConstraint] = []
    constraintsArray += NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[exampleView]|",
      options: [],
      metrics: nil,
      views: viewBindings)
    constraintsArray += NSLayoutConstraint.constraints(
      withVisualFormat: "V:[navBar]-[exampleView]|",
      options: [],
      metrics: nil,
      views: viewBindings)
    view.addConstraints(constraintsArray)
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override open var prefersStatusBarHidden: Bool {
    return true
  }

  open override func willAnimateRotation(
    to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval
  ) {
    exampleView.setNeedsDisplay()
  }
}

class ExampleInstructionsViewNavigationBarTypicalUseSwift: UIView {
  override func draw(_ rect: CGRect) {
    UIColor.white.setFill()
    UIBezierPath(rect: rect).fill()
    let textSizeRect = textSize(forRect: rect)
    let rectForText = CGRect(
      x: rect.origin.x + rect.size.width / 2 - textSizeRect.width / 2,
      y: rect.origin.y + rect.size.height / 2 - textSizeRect.height / 2,
      width: textSizeRect.width,
      height: textSizeRect.height)
    instructionsString().draw(in: rectForText)
    drawArrow(
      withFrame: CGRect(
        x: rect.size.width / 2 - 12,
        y: rect.size.height / 2 - 58 - 12,
        width: 24,
        height: 24))
  }

  func textSize(forRect rect: CGRect) -> CGSize {
    return instructionsString()
      .boundingRect(
        with: rect.size,
        options: NSStringDrawingOptions.usesLineFragmentOrigin,
        context: nil
      ).size
  }

  func instructionsString() -> NSAttributedString {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    style.lineBreakMode = .byWordWrapping
    let instructionsDictionary1 = [
      NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline),
      NSAttributedString.Key.foregroundColor: MDCPalette.grey.tint600.withAlphaComponent(0.87),
      NSAttributedString.Key.paragraphStyle: style,
    ]
    let instructionsDictionary2 = [
      NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
      NSAttributedString.Key.foregroundColor: MDCPalette.grey.tint600.withAlphaComponent(0.87),
      NSAttributedString.Key.paragraphStyle: style,
    ]
    let instructionText = "SWIPE RIGHT\n\n\nfrom left edge to go back\n\n\n\n\n"
    let instructionsAttributedString = NSMutableAttributedString(string: instructionText)
    instructionsAttributedString.addAttributes(
      instructionsDictionary1,
      range: NSMakeRange(0, 11))
    let endLength = instructionText.count - 11
    instructionsAttributedString.addAttributes(
      instructionsDictionary2,
      range: NSMakeRange(11, endLength))
    return instructionsAttributedString
  }

  func drawArrow(withFrame frame: CGRect) {
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: frame.origin.x + 12, y: frame.origin.y + 4))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 10.59, y: frame.origin.y + 5.41))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 16.17, y: frame.origin.y + 11))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 4, y: frame.origin.y + 11))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 4, y: frame.origin.y + 13))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 16.17, y: frame.origin.y + 13))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 10.59, y: frame.origin.y + 18.59))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 12, y: frame.origin.y + 20))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 20, y: frame.origin.y + 12))
    bezierPath.addLine(to: CGPoint(x: frame.origin.x + 12, y: frame.origin.y + 4))
    bezierPath.close()
    bezierPath.miterLimit = 4
    MDCPalette.grey.tint600.withAlphaComponent(0.87).setFill()
    bezierPath.fill()
  }
}

extension NavigationBarTypicalUseSwiftExample {

  // (CatalogByConvention)
  @objc class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Navigation Bar", "Navigation Bar (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }

  @objc func catalogShouldHideNavigation() -> Bool {
    return true
  }
}
