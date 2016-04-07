/*
Copyright 2016-present Google Inc. All Rights Reserved.

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

import UIKit
import MaterialComponents

class MDCCatalogTileDataSpritedAnimationView: NSObject {

  static func drawTile(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    let blue60 = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.600)
    let blue40 = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.400)
    let blue20 = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.200)

    let spritedButtonAnimation: CGRect = CGRect(x: frame.minX + 56.33, y: frame.minY + 14.3, width: floor((frame.width - 56.33) * 0.57217 + 56.16) - 55.66, height: floor((frame.height - 14.3) * 0.53546 + 14.1) - 13.6)

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.2)
    CGContextBeginTransparencyLayer(context, nil)

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.71213 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.35858 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.64143 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.28787 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.42929 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.35858 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.28787 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.28786 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.35858 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.42929 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.50001 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.28786 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.64142 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.35858 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.71213 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.57071 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.64143 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.71213 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.71213 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.64142 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.57071 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.50001 * spritedButtonAnimation.height))
    bezierPath.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.71213 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.35858 * spritedButtonAnimation.height))
    bezierPath.closePath()
    blue20.setFill()
    bezierPath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.66830 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.30849 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.58169 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.25849 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.48170 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.43170 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.30850 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.33170 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.25850 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.41831 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.43170 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.51831 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.33170 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.69151 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.41830 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.74151 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.51830 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.56831 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.69150 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.66830 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.74151 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.58170 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.56830 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.48170 * spritedButtonAnimation.height))
    bezier2Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.66830 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.30849 * spritedButtonAnimation.height))
    bezier2Path.closePath()
    blue40.setFill()
    bezier2Path.fill()

    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.61300 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.27146 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.51641 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.24558 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.46464 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.43876 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.27146 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.38701 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.24558 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.48360 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.43876 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.53536 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.38699 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.72854 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.48359 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.75442 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.53535 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.56123 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.72855 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.61300 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.75443 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.51641 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.56124 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.46464 * spritedButtonAnimation.height))
    bezier3Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.61300 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.27146 * spritedButtonAnimation.height))
    bezier3Path.closePath()
    blue60.setFill()
    bezier3Path.fill()

    let bezier4Path = UIBezierPath()
    bezier4Path.moveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.55000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.25000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.45000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.25000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.45000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.45000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.24999 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.45000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.24999 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.55000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.45000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.55000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.45000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.74999 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.55000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.74999 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.55000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.55000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.75001 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.55000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.75001 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.45000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.55000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.45000 * spritedButtonAnimation.height))
    bezier4Path.addLineToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.55000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.25000 * spritedButtonAnimation.height))
    bezier4Path.closePath()
    fillColor.setFill()
    bezier4Path.fill()

    let bezier5Path = UIBezierPath()
    bezier5Path.moveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.90000 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.09999 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.49999 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.27950 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.90000 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.09999 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.72050 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.10000 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.09999 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.27950 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.27950 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.10000 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.90000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.49999 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.72050 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.10000 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.90000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.27950 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.90000 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.90000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.72050 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.72050 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.90000 * spritedButtonAnimation.height))
    bezier5Path.closePath()
    bezier5Path.moveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.00000 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.00000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.49999 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.22399 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.00000 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.00000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.22400 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 1.00000 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.00000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.77600 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.22399 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 1.00000 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 1.00000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.49999 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 0.77600 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 1.00000 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 1.00000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.77600 * spritedButtonAnimation.height))
    bezier5Path.addCurveToPoint(CGPoint(x: spritedButtonAnimation.minX + 0.50000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.00000 * spritedButtonAnimation.height), controlPoint1: CGPoint(x: spritedButtonAnimation.minX + 1.00000 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.22400 * spritedButtonAnimation.height), controlPoint2: CGPoint(x: spritedButtonAnimation.minX + 0.77600 * spritedButtonAnimation.width, y: spritedButtonAnimation.minY + 0.00000 * spritedButtonAnimation.height))
    bezier5Path.closePath()
    fillColor.setFill()
    bezier5Path.fill()
  }
}
