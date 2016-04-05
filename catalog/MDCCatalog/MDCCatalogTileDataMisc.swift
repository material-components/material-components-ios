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

class MDCCatalogTileDataMisc: NSObject {

  static func drawTile(frame frame: CGRect = CGRect(x: 0, y: 0, width: 192, height: 182)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    var fillColorRedComponent: CGFloat = 1,
    fillColorGreenComponent: CGFloat = 1,
    fillColorBlueComponent: CGFloat = 1
    fillColor.getRed(&fillColorRedComponent, green: &fillColorGreenComponent, blue: &fillColorBlueComponent, alpha: nil)

    let color2 = UIColor(red: (fillColorRedComponent * 0.7), green: (fillColorGreenComponent * 0.7), blue: (fillColorBlueComponent * 0.7), alpha: (CGColorGetAlpha(fillColor.CGColor) * 0.7 + 0.3))
    let fillColor2 = UIColor(red: 0.605, green: 0.865, blue: 0.983, alpha: 1.000)
    let fillColor3 = UIColor(red: 0.308, green: 0.764, blue: 0.970, alpha: 1.000)
    let fillColor4 = UIColor(red: 0.407, green: 0.798, blue: 0.974, alpha: 1.000)
    let fillColor5 = UIColor(red: 0.506, green: 0.831, blue: 0.978, alpha: 1.000)

    let shadow = NSShadow()
    shadow.shadowColor = color2.colorWithAlphaComponent(0.19 * CGColorGetAlpha(color2.CGColor))
    shadow.shadowOffset = CGSize(width: 0.1, height: 1.1)
    shadow.shadowBlurRadius = 1.1

    CGContextSaveGState(context)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let clippingRectPath = UIBezierPath(rect: CGRect(x: frame.minX + 24.5, y: frame.minY + 24, width: 139, height: 80))
    clippingRectPath.addClip()

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: frame.minX + 82.7, y: frame.minY + 105.76))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 114.64, y: frame.minY + 135.99))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 124.48, y: frame.minY + 124.73))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 154.8, y: frame.minY + 155.05))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 185.18, y: frame.minY + 124.67))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 154.8, y: frame.minY + 94.3))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 154.75, y: frame.minY + 94.35))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 124.43, y: frame.minY + 64.03))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 82.7, y: frame.minY + 105.76))
    bezierPath.closePath()
    fillColor2.setFill()
    bezierPath.fill()

    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPoint(x: frame.minX + 124.07, y: frame.minY + 2.97))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 93.7, y: frame.minY + 33.35))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 184.82, y: frame.minY + 124.36))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 191.92, y: frame.minY + 55.92))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 184.82, y: frame.minY + 2.97))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 154.45, y: frame.minY - 27.4))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 124.07, y: frame.minY + 2.97))
    bezier2Path.closePath()
    fillColor3.setFill()
    bezier2Path.fill()

    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPoint(x: frame.minX + 113.47, y: frame.minY + 53.5))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 116.13, y: frame.minY + 50.84))
    bezier3Path.addCurveToPoint(CGPoint(x: frame.minX + 116.13, y: frame.minY + 41.97), controlPoint1: CGPoint(x: frame.minX + 118.58, y: frame.minY + 48.39), controlPoint2: CGPoint(x: frame.minX + 118.58, y: frame.minY + 44.42))
    bezier3Path.addCurveToPoint(CGPoint(x: frame.minX + 107.26, y: frame.minY + 41.97), controlPoint1: CGPoint(x: frame.minX + 113.68, y: frame.minY + 39.52), controlPoint2: CGPoint(x: frame.minX + 109.71, y: frame.minY + 39.52))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 104.6, y: frame.minY + 44.63))
    bezier3Path.addLineToPoint(CGPoint(x: frame.minX + 113.47, y: frame.minY + 53.5))
    bezier3Path.closePath()
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    fillColor.setFill()
    bezier3Path.fill()
    CGContextRestoreGState(context)

    CGContextSaveGState(context)
    CGContextTranslateCTM(context, frame.minX + 62.9, frame.minY + 63.83)
    CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)

    let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 43.4, height: 43.7))
    fillColor.setFill()
    rectanglePath.fill()

    CGContextRestoreGState(context)

    let bezier4Path = UIBezierPath()
    bezier4Path.moveToPoint(CGPoint(x: frame.minX + 83.48, y: frame.minY + 83.64))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 86.03, y: frame.minY + 81.08))
    bezier4Path.addCurveToPoint(CGPoint(x: frame.minX + 86.03, y: frame.minY + 72.21), controlPoint1: CGPoint(x: frame.minX + 88.48, y: frame.minY + 78.64), controlPoint2: CGPoint(x: frame.minX + 88.48, y: frame.minY + 74.66))
    bezier4Path.addCurveToPoint(CGPoint(x: frame.minX + 77.16, y: frame.minY + 72.21), controlPoint1: CGPoint(x: frame.minX + 83.58, y: frame.minY + 69.76), controlPoint2: CGPoint(x: frame.minX + 79.61, y: frame.minY + 69.76))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 74.6, y: frame.minY + 74.77))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 3, y: frame.minY + 3.37))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 5.94, y: frame.minY + 86.16))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 7.25, y: frame.minY + 102.63))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX, y: frame.minY + 107.88))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 3.1, y: frame.minY + 124.76))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 33.48, y: frame.minY + 155.14))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 63.85, y: frame.minY + 124.76))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 94.23, y: frame.minY + 94.39))
    bezier4Path.addLineToPoint(CGPoint(x: frame.minX + 83.48, y: frame.minY + 83.64))
    bezier4Path.closePath()
    fillColor4.setFill()
    bezier4Path.fill()

    let bezier5Path = UIBezierPath()
    bezier5Path.moveToPoint(CGPoint(x: frame.minX + 82.47, y: frame.minY + 44.5))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 95.29, y: frame.minY + 31.68))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 117.34, y: frame.minY + 9.63))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 85.2, y: frame.minY - 19.83))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 32.47, y: frame.minY - 27))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 2.1, y: frame.minY + 3.37))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 32.47, y: frame.minY + 33.75))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 43.23, y: frame.minY + 23))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 32.47, y: frame.minY + 33.75))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 62.85, y: frame.minY + 64.12))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 73.6, y: frame.minY + 53.37))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 76.26, y: frame.minY + 56.03))
    bezier5Path.addCurveToPoint(CGPoint(x: frame.minX + 85.13, y: frame.minY + 56.03), controlPoint1: CGPoint(x: frame.minX + 78.71, y: frame.minY + 58.48), controlPoint2: CGPoint(x: frame.minX + 82.68, y: frame.minY + 58.48))
    bezier5Path.addCurveToPoint(CGPoint(x: frame.minX + 85.13, y: frame.minY + 47.16), controlPoint1: CGPoint(x: frame.minX + 87.58, y: frame.minY + 53.58), controlPoint2: CGPoint(x: frame.minX + 87.58, y: frame.minY + 49.61))
    bezier5Path.addLineToPoint(CGPoint(x: frame.minX + 82.47, y: frame.minY + 44.5))
    bezier5Path.closePath()
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    fillColor5.setFill()
    bezier5Path.fill()
    CGContextRestoreGState(context)

    let bezier6Path = UIBezierPath()
    bezier6Path.moveToPoint(CGPoint(x: frame.minX + 104.2, y: frame.minY + 83.75))
    bezier6Path.addLineToPoint(CGPoint(x: frame.minX + 106.86, y: frame.minY + 86.41))
    bezier6Path.addCurveToPoint(CGPoint(x: frame.minX + 115.73, y: frame.minY + 86.41), controlPoint1: CGPoint(x: frame.minX + 109.31, y: frame.minY + 88.86), controlPoint2: CGPoint(x: frame.minX + 113.28, y: frame.minY + 88.86))
    bezier6Path.addCurveToPoint(CGPoint(x: frame.minX + 115.73, y: frame.minY + 77.54), controlPoint1: CGPoint(x: frame.minX + 118.18, y: frame.minY + 83.96), controlPoint2: CGPoint(x: frame.minX + 118.18, y: frame.minY + 79.98))
    bezier6Path.addLineToPoint(CGPoint(x: frame.minX + 113.07, y: frame.minY + 74.87))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    fillColor.setFill()
    bezier6Path.fill()
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
