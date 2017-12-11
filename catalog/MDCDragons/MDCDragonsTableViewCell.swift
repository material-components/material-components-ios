//
//  MDCDragonsTableViewCell.swift
//  MDCDragons
//
//  Created by yar on 12/11/17.
//  Copyright © 2017 Google. All rights reserved.
//

import UIKit
import CatalogByConvention
import MaterialComponents.MaterialIcons_ic_arrow_back

class MDCDragonsTableViewCell: UITableViewCell {

  lazy var defaultButton: UIButton = {
    let image = MDCIcons.imageFor_ic_chevron_right()
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    button.setImage(image, for: .normal)
    return button
  }()

  lazy var expandedButton: UIButton = {
    let image = MDCIcons.imageFor_ic_chevron_right()
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    button.setImage(image, for: .normal)
    button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    return button
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.accessoryView = self.defaultButton
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func awakeFromNib() {
      super.awakeFromNib()

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
