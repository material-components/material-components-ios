/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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
import MaterialComponents

protocol MDCCatalogBarDelegate {
  func didPressExit()
}

class MDCCatalogBar: UIView {

  var catalogBarDelegate: MDCCatalogBarDelegate?
  var titleString = "Component"
  let descriptionLabel = UILabel()
  let exitLabel = UILabel()

  internal var title:String {
    get {
      return titleString
    }
    set {
      titleString = newValue
      descriptionLabel.text = titleString
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonMDCCatalogBarInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    descriptionLabel.frame = CGRectMake(20, 0, self.frame.size.width - 120, self.frame.size.height)
    exitLabel.frame = CGRectMake(self.frame.size.width - 100, 0, 80, self.frame.size.height)
  }

  func commonMDCCatalogBarInit() {
    self.backgroundColor = UIColor(white: 0.2, alpha: 1)
    descriptionLabel.text = title
    descriptionLabel.textColor = UIColor.whiteColor()
    descriptionLabel.font = MDCTypography.body1Font()
    addSubview(descriptionLabel)

    let blueColor = UIColor(red:0.012, green:0.663, blue:0.957, alpha:1)
    exitLabel.text = "Exit Demo".uppercaseString
    exitLabel.textColor = blueColor;
    exitLabel.font = MDCTypography.buttonFont()
    exitLabel.textAlignment = .Right
    addSubview(exitLabel)

    let tap = UITapGestureRecognizer(target: self, action: "exitPressed")
    addGestureRecognizer(tap)
  }

  func exitPressed() {
    catalogBarDelegate?.didPressExit()
  }

}
