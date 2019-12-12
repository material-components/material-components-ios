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

class HeaderView: UIView {
  @IBOutlet var containerView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
    addSubview(containerView)
    self.backgroundColor = .clear
    containerView.backgroundColor = .clear
    containerView.frame = self.bounds
    containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    title.textColor = UIColor(white: 1, alpha: 1)
    title.font = UIFont.systemFont(ofSize: 20)
    let image = MDCDrawDragons.image(with: MDCDrawDragons.drawDragon,
                                     size: CGSize(width: 40,
                                                  height: 40),
                                     fillColor: .white)
    imageView.image = image

    // To make the search icon tinted white we have to reach the internal UITextField of the UISearchBar
    if let searchBarTextField = self.searchBar.value(forKey: "searchField") as? UITextField,
      let glassIconView = searchBarTextField.leftView as? UIImageView {
      glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
      glassIconView.tintColor = .white
    }
    searchBar.tintColor = .white
    searchBar.scopeBarBackgroundImage = UIImage()
  }
}
