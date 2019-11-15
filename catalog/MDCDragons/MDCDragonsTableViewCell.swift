// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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
import CatalogByConvention
import MaterialComponents.MaterialIcons_ic_arrow_back

class MDCDragonsTableViewCell: UITableViewCell {

  lazy var collapsedAccessoryView: UIView = {
    let image = MDCIcons.imageFor_ic_chevron_right()
    let view = UIImageView(image: image)
    view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    return view
  }()

  lazy var expandedAccessoryView: UIView = {
    let image = MDCIcons.imageFor_ic_chevron_right()
    let view = UIImageView(image: image)
    view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.accessoryView = self.collapsedAccessoryView

    // Treat the entire cell as an accessibility button for VoiceOver purposes.
    self.isAccessibilityElement = true
    self.accessibilityTraits = .button
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
