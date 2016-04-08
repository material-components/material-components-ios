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

class MDCCatalogTileDataNavigationBar: NSObject {

  static func drawTile(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let gradientColor = UIColor(red: 0.076, green: 0.590, blue: 0.945, alpha: 1.000)
    let fillColor = UIColor(red: 0.077, green: 0.591, blue: 0.945, alpha: 1.000)
    let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    let textForeground = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

    let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, gradientColor.CGColor, gradientColor.CGColor], [0, 0.14, 1])!

    let group4: CGRect = CGRect(x: frame.minX + floor((frame.width - 139) * 0.50000) + 0.5, y: frame.minY + floor((frame.height - 80.03) * 0.32077 - 0.42) + 0.92, width: 139, height: 80.03)

    CGContextSaveGState(context)
    CGContextBeginTransparencyLayer(context, nil)

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.1)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangleRect = CGRect(x: group4.minX, y: group4.minY + 24.37, width: 139, height: 55.65)
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

    let rectangle2Path = UIBezierPath(rect: CGRect(x: group4.minX, y: group4.minY, width: 139, height: 29))
    fillColor.setFill()
    rectangle2Path.fill()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.75)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let pictureRect = CGRect(x: group4.minX + 118.2, y: group4.minY + 9.65, width: 13, height: 12)
    let picturePath = UIBezierPath(rect: pictureRect)
    CGContextSaveGState(context)
    picturePath.addClip()
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: group4.minX + 124.17, y: group4.minY + 19.45))
    bezierPath.addLineToPoint(CGPoint(x: group4.minX + 123.38, y: group4.minY + 18.73))
    bezierPath.addCurveToPoint(CGPoint(x: group4.minX + 118.72, y: group4.minY + 12.45), controlPoint1: CGPoint(x: group4.minX + 120.57, y: group4.minY + 16.19), controlPoint2: CGPoint(x: group4.minX + 118.72, y: group4.minY + 14.51))
    bezierPath.addCurveToPoint(CGPoint(x: group4.minX + 121.71, y: group4.minY + 9.45), controlPoint1: CGPoint(x: group4.minX + 118.72, y: group4.minY + 10.77), controlPoint2: CGPoint(x: group4.minX + 120.04, y: group4.minY + 9.45))
    bezierPath.addCurveToPoint(CGPoint(x: group4.minX + 124.17, y: group4.minY + 10.59), controlPoint1: CGPoint(x: group4.minX + 122.66, y: group4.minY + 9.45), controlPoint2: CGPoint(x: group4.minX + 123.57, y: group4.minY + 9.89))
    bezierPath.addCurveToPoint(CGPoint(x: group4.minX + 126.62, y: group4.minY + 9.45), controlPoint1: CGPoint(x: group4.minX + 124.76, y: group4.minY + 9.89), controlPoint2: CGPoint(x: group4.minX + 125.67, y: group4.minY + 9.45))
    bezierPath.addCurveToPoint(CGPoint(x: group4.minX + 129.62, y: group4.minY + 12.45), controlPoint1: CGPoint(x: group4.minX + 128.3, y: group4.minY + 9.45), controlPoint2: CGPoint(x: group4.minX + 129.62, y: group4.minY + 10.77))
    bezierPath.addCurveToPoint(CGPoint(x: group4.minX + 124.96, y: group4.minY + 18.74), controlPoint1: CGPoint(x: group4.minX + 129.62, y: group4.minY + 14.51), controlPoint2: CGPoint(x: group4.minX + 127.76, y: group4.minY + 16.19))
    bezierPath.addLineToPoint(CGPoint(x: group4.minX + 124.17, y: group4.minY + 19.45))
    bezierPath.closePath()
    fillColor2.setFill()
    bezierPath.fill()

    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPoint(x: group4.minX + 124.17, y: group4.minY + 19.45))
    bezier2Path.addLineToPoint(CGPoint(x: group4.minX + 123.38, y: group4.minY + 18.73))
    bezier2Path.addCurveToPoint(CGPoint(x: group4.minX + 118.72, y: group4.minY + 12.45), controlPoint1: CGPoint(x: group4.minX + 120.57, y: group4.minY + 16.19), controlPoint2: CGPoint(x: group4.minX + 118.72, y: group4.minY + 14.51))
    bezier2Path.addCurveToPoint(CGPoint(x: group4.minX + 121.71, y: group4.minY + 9.45), controlPoint1: CGPoint(x: group4.minX + 118.72, y: group4.minY + 10.77), controlPoint2: CGPoint(x: group4.minX + 120.04, y: group4.minY + 9.45))
    bezier2Path.addCurveToPoint(CGPoint(x: group4.minX + 124.17, y: group4.minY + 10.59), controlPoint1: CGPoint(x: group4.minX + 122.66, y: group4.minY + 9.45), controlPoint2: CGPoint(x: group4.minX + 123.57, y: group4.minY + 9.89))
    bezier2Path.addCurveToPoint(CGPoint(x: group4.minX + 126.62, y: group4.minY + 9.45), controlPoint1: CGPoint(x: group4.minX + 124.76, y: group4.minY + 9.89), controlPoint2: CGPoint(x: group4.minX + 125.67, y: group4.minY + 9.45))
    bezier2Path.addCurveToPoint(CGPoint(x: group4.minX + 129.62, y: group4.minY + 12.45), controlPoint1: CGPoint(x: group4.minX + 128.3, y: group4.minY + 9.45), controlPoint2: CGPoint(x: group4.minX + 129.62, y: group4.minY + 10.77))
    bezier2Path.addCurveToPoint(CGPoint(x: group4.minX + 124.96, y: group4.minY + 18.74), controlPoint1: CGPoint(x: group4.minX + 129.62, y: group4.minY + 14.51), controlPoint2: CGPoint(x: group4.minX + 127.76, y: group4.minY + 16.19))
    bezier2Path.addLineToPoint(CGPoint(x: group4.minX + 124.17, y: group4.minY + 19.45))
    bezier2Path.closePath()
    fillColor2.setFill()
    bezier2Path.fill()

    CGContextSaveGState(context)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let picture2Rect = CGRect(x: group4.minX + 10.2, y: group4.minY + 11.65, width: 12, height: 8)
    let picture2Path = UIBezierPath(rect: picture2Rect)
    CGContextSaveGState(context)
    picture2Path.addClip()
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 12.27))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 20.66, y: group4.minY + 12.27))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 20.66, y: group4.minY + 11.18))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 11.18))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 12.27))
    bezier3Path.closePath()
    bezier3Path.moveToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 15))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 20.66, y: group4.minY + 15))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 20.66, y: group4.minY + 13.91))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 13.91))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 15))
    bezier3Path.closePath()
    bezier3Path.moveToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 17.72))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 20.66, y: group4.minY + 17.72))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 20.66, y: group4.minY + 16.63))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 16.63))
    bezier3Path.addLineToPoint(CGPoint(x: group4.minX + 10.85, y: group4.minY + 17.72))
    bezier3Path.closePath()
    fillColor2.setFill()
    bezier3Path.fill()

    let labelRect = CGRect(x: group4.minX + 32.5, y: group4.minY + 6.86, width: 36.21, height: 17)
    let labelTextContent = NSString(string: "AppBar")
    let labelStyle = NSMutableParagraphStyle()
    labelStyle.alignment = .Center

    let labelFontAttributes = [NSFontAttributeName: UIFont(name: "Roboto-Medium", size: 11)!, NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: labelStyle]

    let labelTextHeight: CGFloat = labelTextContent.boundingRectWithSize(CGSize(width: labelRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: labelFontAttributes, context: nil).size.height
    CGContextSaveGState(context)
    CGContextClipToRect(context, labelRect)
    labelTextContent.drawInRect(CGRect(x: labelRect.minX, y: labelRect.minY + (labelRect.height - labelTextHeight) / 2, width: labelRect.width, height: labelTextHeight), withAttributes: labelFontAttributes)
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
