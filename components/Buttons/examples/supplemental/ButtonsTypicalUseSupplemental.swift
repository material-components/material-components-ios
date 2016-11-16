/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

class ButtonsTypicalUseSupplemental: NSObject {

  static let floatingButtonPlusDimension = CGFloat(24)

  static func plusShapePath() -> UIBezierPath {
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: 19, y: 13))
    bezierPath.addLineToPoint(CGPoint(x: 13, y: 13))
    bezierPath.addLineToPoint(CGPoint(x: 13, y: 19))
    bezierPath.addLineToPoint(CGPoint(x: 11, y: 19))
    bezierPath.addLineToPoint(CGPoint(x: 11, y: 13))
    bezierPath.addLineToPoint(CGPoint(x: 5, y: 13))
    bezierPath.addLineToPoint(CGPoint(x: 5, y: 11))
    bezierPath.addLineToPoint(CGPoint(x: 11, y: 11))
    bezierPath.addLineToPoint(CGPoint(x: 11, y: 5))
    bezierPath.addLineToPoint(CGPoint(x: 13, y: 5))
    bezierPath.addLineToPoint(CGPoint(x: 13, y: 11))
    bezierPath.addLineToPoint(CGPoint(x: 19, y: 11))
    bezierPath.addLineToPoint(CGPoint(x: 19, y: 13))
    bezierPath.closePath()
    return bezierPath;
  }

  static func createPlusShapeLayer(floatingButton: MDCFloatingButton) -> CAShapeLayer {
    let plusShape = CAShapeLayer()
    plusShape.path = ButtonsTypicalUseSupplemental.plusShapePath().CGPath
    plusShape.fillColor = UIColor.whiteColor().CGColor
    plusShape.position =
      CGPointMake((floatingButton.frame.size.width - floatingButtonPlusDimension) / 2,
                  (floatingButton.frame.size.height - floatingButtonPlusDimension) / 2)
    return plusShape;
  }

}
