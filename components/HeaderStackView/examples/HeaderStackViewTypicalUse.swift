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
import MaterialComponents.MaterialHeaderStackView

open class HeaderStackViewTypicalUseSwiftExample: UIViewController {

  var toggled: Bool = true
  var exampleView = ExampleInstructionsViewHeaderStackViewSwiftTypicalUse()
  var stackView = MDCHeaderStackView()
  var navBar = MDCNavigationBar()
  var topView = UIView()
  var colorScheme = MDCSemanticColorScheme()

  override open func viewDidLoad() {

    super.viewDidLoad()
    self.setupExampleViews()

    stackView.autoresizingMask = .flexibleWidth
    stackView.topBar = topView
    stackView.bottomBar = navBar

    let frame = self.view.bounds
    stackView.frame = frame
    stackView.sizeToFit()

    view.addSubview(stackView)
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override open var prefersStatusBarHidden: Bool {
    return true
  }

  func setupExampleViews() {
    exampleView.frame = view.bounds
    exampleView.autoresizingMask = [ .flexibleLeftMargin, .flexibleRightMargin ]
    view.addSubview(exampleView)

    view.backgroundColor = colorScheme.backgroundColor
    topView.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.size.width, height: 100))
    topView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
    let image = UIImage(named: "header_stack_view_theme",
                        in: Bundle(for: HeaderStackViewTypicalUseSwiftExample.self),
                        compatibleWith: nil)
    let imageView = UIImageView(image: image)
    imageView.frame = topView.bounds
    imageView.contentMode = .scaleAspectFill
    imageView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
    topView.clipsToBounds = true
    topView.addSubview(imageView)

    navBar.titleTextAttributes = itemTitleTextAttributes()

    let moreButton = UIBarButtonItem(title: "Reveal",
                                     style: .plain,
                                     target: self,
                                     action: #selector(didTapToggleButton))
    moreButton.setTitleTextAttributes(itemTitleTextAttributes(), for: .normal)
    navBar.trailingBarButtonItems = [ moreButton ]
  }

  func didTapToggleButton() {
    toggled = !toggled
    UIView.animate(withDuration: 0.4, animations: {
      var frame = self.stackView.frame
      if (self.toggled) {
        frame.size.height = 200
      } else {
        frame.size = self.stackView.sizeThatFits(self.stackView.bounds.size)
      }
      self.stackView.frame = frame
      self.stackView.layoutIfNeeded()
    })
  }

  func itemTitleTextAttributes() -> [String: Any] {
    return [ NSForegroundColorAttributeName : UIColor.white ]
  }
}

class ExampleInstructionsViewHeaderStackViewSwiftTypicalUse : UIView {
  override func draw(_ rect: CGRect) {
    UIColor.white.setFill()
    UIBezierPath(rect: rect).fill()
    let textSizeRect = textSize(forRect: rect)
    let rectForText = CGRect(x: rect.origin.x + rect.size.width / 2 - textSizeRect.width / 2,
                             y: rect.origin.y + rect.size.height / 2 - textSizeRect.height / 2,
                             width: textSizeRect.width,
                             height: textSizeRect.height)
    instructionsString().draw(in: rectForText)
    drawArrow(withFrame: CGRect(x: rect.size.width / 2 - 12,
                                y: rect.size.height / 2 - 58 - 12,
                                width: 24,
                                height: 24))
  }

  func textSize(forRect rect: CGRect) -> CGSize {
    return instructionsString()
      .boundingRect(with: rect.size,
                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                    context: nil).size
  }

  func instructionsString() -> NSAttributedString {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    style.lineBreakMode = .byWordWrapping
    let instructionsDictionary1 = [
      NSFontAttributeName : UIFont.preferredFont(forTextStyle: .headline),
      NSForegroundColorAttributeName : MDCPalette.grey.tint600.withAlphaComponent(0.87),
      NSParagraphStyleAttributeName : style
    ]

    let instructionsDictionary2 = [
      NSFontAttributeName : UIFont.preferredFont(forTextStyle: .subheadline),
      NSForegroundColorAttributeName : MDCPalette.grey.tint600.withAlphaComponent(0.87),
      NSParagraphStyleAttributeName : style
    ]

    let instructionText = "SWIPE RIGHT\n\n\nfrom left edge to go back\n\n\n\n\n"
    let instructionsAttributedString = NSMutableAttributedString(string: instructionText)
    instructionsAttributedString.addAttributes(instructionsDictionary1,
                                               range: NSMakeRange(0, 11))
    let endLength = instructionText.characters.count - 11
    instructionsAttributedString.addAttributes(instructionsDictionary2,
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
