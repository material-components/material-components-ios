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

import MaterialComponents.MaterialFeatureHighlight_ColorThemer
import MaterialComponents.MaterialFeatureHighlight_TypographyThemer
import MaterialComponents.MaterialButtons_ButtonThemer

/// Example to show how to use a feature highlight
class FeatureHighlightSwiftViewController: UIViewController {

  let showButton = MDCButton()
  let featureButton = MDCButton()
  var colorScheme = MDCSemanticColorScheme()
  var typographyScheme = MDCTypographyScheme()
  let buttonScheme = MDCButtonScheme()

  override func viewDidLoad() {
    super.viewDidLoad()
    colorScheme.backgroundColor = .white
    view.backgroundColor = colorScheme.backgroundColor

    showButton.setTitle("Show Feature Highlight", for: .normal)
    showButton.addTarget(self, action: #selector(showFeatureHighlight), for: .touchUpInside)
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: showButton)
    self.view.addSubview(showButton)

    featureButton.setTitle("Feature", for: .normal)
    MDCContainedButtonThemer.applyScheme(buttonScheme, to: featureButton)
    self.view.addSubview(featureButton)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    showButton.sizeToFit()
    showButton.frame.origin.y =
      view.bounds.height - (showButton.frame.height + 60)
    showButton.frame.origin.x = view.center.x - showButton.frame.width / 2

    featureButton.sizeToFit()
    featureButton.frame.origin.x = view.center.x - featureButton.frame.width / 2
    featureButton.frame.origin.y = view.bounds.height / 2 - featureButton.frame.height / 2
  }

  func showFeatureHighlight() {
    let vc = MDCFeatureHighlightViewController(highlightedView: featureButton,
                                               completion: nil)
    MDCFeatureHighlightColorThemer.applySemanticColorScheme(colorScheme, to: vc)
    MDCFeatureHighlightTypographyThemer.applyTypographyScheme(typographyScheme, to: vc)
    vc.mdc_adjustsFontForContentSizeCategory = true
    vc.titleText = "Hey this is a title for the Feature Highlight"
    vc.bodyText = "This is the description of the feature highlight view controller"
    self.present(vc, animated: true, completion: nil)
  }
}

extension FeatureHighlightSwiftViewController {

  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Feature Highlight", "Feature Highlight (Swift)"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
