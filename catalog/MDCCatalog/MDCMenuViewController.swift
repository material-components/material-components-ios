//
//  MDCMenuViewController.swift
//  MDCCatalog
//
//  Created by Yarden Eitan on 4/25/18.
//  Copyright © 2018 Google. All rights reserved.
//

import UIKit
import MaterialComponents.MDCIcons

class MDCMenuViewController: UITableViewController {

  let tableData = [("Setting",  MDCIcons.""), ("Themes", ""), ("Help", "")]

  override func viewDidLoad() {
    super.viewDidLoad()
    MDCIcons.settings

  }




}
