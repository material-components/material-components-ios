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

class MDCCatalogTileDataNavBar: NSObject {

  static func drawTile(frame frame: CGRect = CGRect(x: 0, y: 34, width: 144, height: 86)) {

    let context = UIGraphicsGetCurrentContext()

    let gradientColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)
    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    let fillColor2 = UIColor(red: 0.994, green: 0.994, blue: 0.994, alpha: 1.000)
    let textForeground = UIColor(red: 0.996, green: 0.996, blue: 0.996, alpha: 0.200)
    let gradientColor2 = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)

    let gradientArray = [gradientColor2.CGColor, gradientColor2.colorWithAlphaComponent(0.5).CGColor, gradientColor.CGColor]
    let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradientArray, [0.14, 0.5, 1])!

    let frame = CGRect(x: 0, y: 0, width: 188, height: 155)

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.1)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangleRect = CGRect(x: frame.minX + 24.5, y: frame.minY + 48.38, width: 139, height: 55.65)
    let rectanglePath = UIBezierPath(rect: rectangleRect)
    CGContextSaveGState(context)
    rectanglePath.addClip()
    CGContextDrawLinearGradient(context, gradient,
      CGPoint(x: rectangleRect.midX + -0 * rectangleRect.width / 139, y: rectangleRect.midY + -16.12 * rectangleRect.height / 55.65),
      CGPoint(x: rectangleRect.midX + -0 * rectangleRect.width / 139, y: rectangleRect.midY + 25.22 * rectangleRect.height / 55.65),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle2Path = UIBezierPath(rect: CGRect(x: frame.minX + 24.5, y: frame.minY + 24, width: 139, height: 29))
    fillColor.setFill()
    rectangle2Path.fill()

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: frame.minX + 148.67, y: frame.minY + 43.45))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 147.88, y: frame.minY + 42.73))
    bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 143.22, y: frame.minY + 36.45), controlPoint1: CGPoint(x: frame.minX + 145.07, y: frame.minY + 40.19), controlPoint2: CGPoint(x: frame.minX + 143.22, y: frame.minY + 38.51))
    bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 146.21, y: frame.minY + 33.45), controlPoint1: CGPoint(x: frame.minX + 143.22, y: frame.minY + 34.77), controlPoint2: CGPoint(x: frame.minX + 144.54, y: frame.minY + 33.45))
    bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 148.67, y: frame.minY + 34.59), controlPoint1: CGPoint(x: frame.minX + 147.16, y: frame.minY + 33.45), controlPoint2: CGPoint(x: frame.minX + 148.07, y: frame.minY + 33.89))
    bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 151.12, y: frame.minY + 33.45), controlPoint1: CGPoint(x: frame.minX + 149.26, y: frame.minY + 33.89), controlPoint2: CGPoint(x: frame.minX + 150.17, y: frame.minY + 33.45))
    bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 154.12, y: frame.minY + 36.45), controlPoint1: CGPoint(x: frame.minX + 152.8, y: frame.minY + 33.45), controlPoint2: CGPoint(x: frame.minX + 154.12, y: frame.minY + 34.77))
    bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 149.46, y: frame.minY + 42.74), controlPoint1: CGPoint(x: frame.minX + 154.12, y: frame.minY + 38.51), controlPoint2: CGPoint(x: frame.minX + 152.26, y: frame.minY + 40.19))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 148.67, y: frame.minY + 43.45))
    bezierPath.closePath()
    fillColor2.setFill()
    bezierPath.fill()

    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPoint(x: frame.minX + 148.67, y: frame.minY + 43.45))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 147.88, y: frame.minY + 42.73))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 143.22, y: frame.minY + 36.45), controlPoint1: CGPoint(x: frame.minX + 145.07, y: frame.minY + 40.19), controlPoint2: CGPoint(x: frame.minX + 143.22, y: frame.minY + 38.51))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 146.21, y: frame.minY + 33.45), controlPoint1: CGPoint(x: frame.minX + 143.22, y: frame.minY + 34.77), controlPoint2: CGPoint(x: frame.minX + 144.54, y: frame.minY + 33.45))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 148.67, y: frame.minY + 34.59), controlPoint1: CGPoint(x: frame.minX + 147.16, y: frame.minY + 33.45), controlPoint2: CGPoint(x: frame.minX + 148.07, y: frame.minY + 33.89))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 151.12, y: frame.minY + 33.45), controlPoint1: CGPoint(x: frame.minX + 149.26, y: frame.minY + 33.89), controlPoint2: CGPoint(x: frame.minX + 150.17, y: frame.minY + 33.45))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 154.12, y: frame.minY + 36.45), controlPoint1: CGPoint(x: frame.minX + 152.8, y: frame.minY + 33.45), controlPoint2: CGPoint(x: frame.minX + 154.12, y: frame.minY + 34.77))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 149.46, y: frame.minY + 42.74), controlPoint1: CGPoint(x: frame.minX + 154.12, y: frame.minY + 38.51), controlPoint2: CGPoint(x: frame.minX + 152.26, y: frame.minY + 40.19))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 148.67, y: frame.minY + 43.45))
    bezier2Path.closePath()
    fillColor2.setFill()
    bezier2Path.fill()

    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 36.27))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 45.16, y: frame.minY + 36.27))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 45.16, y: frame.minY + 35.18))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 35.18))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 36.27))
    bezier3Path.closePath()
    bezier3Path.moveToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 39))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 45.16, y: frame.minY + 39))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 45.16, y: frame.minY + 37.91))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 37.91))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 39))
    bezier3Path.closePath()
    bezier3Path.moveToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 41.72))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 45.16, y: frame.minY + 41.72))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 45.16, y: frame.minY + 40.63))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 40.63))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 35.35, y: frame.minY + 41.72))
    bezier3Path.closePath()
    fillColor2.setFill()
    bezier3Path.fill()

    let labelRect = CGRect(x: frame.minX + 57, y: frame.minY + 29.86, width: 36.21, height: 17)
    let labelTextContent = NSString(string: "AppBar")
    let labelStyle = NSMutableParagraphStyle()
    labelStyle.alignment = .Center

    let labelFontAttributes = [NSFontAttributeName: UIFont(name: "Roboto-Medium", size: 11)!, NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: labelStyle]

    let labelTextHeight: CGFloat = labelTextContent.boundingRectWithSize(CGSize(width: labelRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: labelFontAttributes, context: nil).size.height
    CGContextSaveGState(context)
    CGContextClipToRect(context, labelRect)
    labelTextContent.drawInRect(CGRect(x: labelRect.minX, y: labelRect.minY + (labelRect.height - labelTextHeight) / 2, width: labelRect.width, height: labelTextHeight), withAttributes: labelFontAttributes)
    CGContextRestoreGState(context)
  }

}
