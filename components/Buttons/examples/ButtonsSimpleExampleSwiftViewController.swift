//
//  ButtonsSimpleExampleSwiftViewController.swift
//  Pods
//
//  Created by Peter Friese on 05/03/2016.
//
//

import Foundation
import MaterialComponents

class ButtonsSimpleExampleSwiftViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.whiteColor()
    
    let raisedButton = MDCRaisedButton()
    raisedButton.setElevation(4, forState: .Normal)
    raisedButton.setTitle("Tap Me Too", forState: .Normal)
    raisedButton.sizeToFit()
    raisedButton.translatesAutoresizingMaskIntoConstraints = false
    raisedButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
    self.view.addSubview(raisedButton)
    
    let flatButton = MDCFlatButton()
    flatButton.customTitleColor = UIColor.grayColor()
    flatButton.setTitle("Touch me", forState: .Normal)
    flatButton.sizeToFit()
    flatButton.translatesAutoresizingMaskIntoConstraints = false
    flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
    self.view.addSubview(flatButton)
    
    let floatingButton = MDCFloatingButton()
    floatingButton.setTitle("+", forState: .Normal)
    floatingButton.sizeToFit()
    floatingButton.translatesAutoresizingMaskIntoConstraints = false
    floatingButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
    self.view.addSubview(floatingButton)
    
    let views = [
      "raised": raisedButton,
      "flat": flatButton,
      "floating": floatingButton
    ]
    
    self.view.addConstraint(NSLayoutConstraint(item: flatButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
    
    self.view.addConstraint(NSLayoutConstraint(item: flatButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[raised]-40-[flat]-40-[floating]", options: .AlignAllCenterX, metrics: nil, views: views))
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tap(sender: AnyObject) {
    print("\(sender.dynamicType) was tapped.")
  }
  
  class func catalogHierarchy() -> [String] {
    return ["Buttons", "3 kinds of buttons (Swift)"]
  }
  
}
