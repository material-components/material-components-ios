/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

import Foundation

import MaterialComponents

class SwitchSwiftExampleViewController : UIViewController {

  let switchComponent = MDCSwitch()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.whiteColor()

    switchComponent.on = true
    switchComponent.addTarget(self, action: #selector(didChangeSwitchValue), forControlEvents: UIControlEvents.ValueChanged)
    view.addSubview(switchComponent)
    switchComponent.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    switchComponent.autoresizingMask = [.FlexibleBottomMargin, .FlexibleTopMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
  }

  func didChangeSwitchValue(senderSwitch:MDCSwitch) {
    NSLog("Did change switch value to: %@.", senderSwitch.on);
  }
}
