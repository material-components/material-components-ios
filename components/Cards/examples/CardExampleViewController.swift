//
//  CardExampleViewController.swift
//  MaterialComponentsExamples
//
//  Created by Yarden Eitan on 1/12/18.
//

import UIKit

class CardExampleViewController: UIViewController {
  @IBOutlet var contentView: UIView!

    override func viewDidLoad() {
      super.viewDidLoad()

      let bundle = Bundle(for: CardExampleViewController.self)
      bundle.loadNibNamed("CardExampleViewController", owner: self, options: nil)
      contentView.frame = self.view.bounds;
      self.view.addSubview(contentView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CardExampleViewController {
  @objc class func catalogBreadcrumbs() -> [String] {
    return ["Cards", "Card (Swift)"]
  }

  @objc class func catalogIsPresentable() -> Bool {
    return true
  }

  @objc class func catalogIsDebug() -> Bool {
    return true
  }
}
