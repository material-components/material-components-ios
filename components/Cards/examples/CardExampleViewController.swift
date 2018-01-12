//
//  CardExampleViewController.swift
//  MaterialComponentsExamples
//
//  Created by Yarden Eitan on 1/12/18.
//

import UIKit

class CardExampleViewController: UIViewController {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var cardView: MDCCard!

    override func viewDidLoad() {
      super.viewDidLoad()

      let bundle = Bundle(for: CardExampleViewController.self)
      bundle.loadNibNamed("CardExampleViewController", owner: self, options: nil)
      contentView.frame = self.view.bounds
      self.view.addSubview(contentView)

      let bezierPath = UIBezierPath(roundedRect: imageView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: cardView.cornerRadius(),
                                                        height: cardView.cornerRadius()))
      let shapeLayer = CAShapeLayer()
      shapeLayer.frame = imageView.bounds
      shapeLayer.path = bezierPath.cgPath
      imageView.layer.mask = shapeLayer

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
    return false
  }
}
