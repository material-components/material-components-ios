//
//  DragonCell.swift
//  MDCDragons
//
//  Created by yar on 12/11/17.
//  Copyright © 2017 Google. All rights reserved.
//

import Foundation
import CatalogByConvention

class DragonCell: NSObject {
  var node: CBCNode
  var expanded: Bool = false

  init(node: CBCNode) {
    self.node = node
  }
}
