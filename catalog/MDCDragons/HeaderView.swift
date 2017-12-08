//
//  HeaderView.swift
//  MDCDragons
//
//  Created by Yarden Eitan on 12/8/17.
//  Copyright © 2017 Google. All rights reserved.
//

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
    if let searchBarTextField = self.searchBar.value(forKey: "_searchField") as? UITextField,
      let glassIconView = searchBarTextField.leftView as? UIImageView,
      let xIconView = searchBarTextField.value(forKey: "_clearButton") as? UIButton {
      searchBarTextField.tintColor = .white
      glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
      glassIconView.tintColor = .white
      xIconView.setImage(UIImage(), for: .normal)
      xIconView.tintColor = .white
    }
  }
  
}
