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

class MDCCatalogTileDataHeaderStackView: MDCCatalogTileData {
  static var tileImage: UIImage? = nil

  static func drawTile(frame: CGRect) {
    drawAndCache(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let gradientColor = UIColor(red: 0.076, green: 0.590, blue: 0.945, alpha: 1.000)
    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    var fillColorRedComponent: CGFloat = 1,
    fillColorGreenComponent: CGFloat = 1,
    fillColorBlueComponent: CGFloat = 1
    fillColor.getRed(&fillColorRedComponent, green: &fillColorGreenComponent, blue: &fillColorBlueComponent, alpha: nil)

    let color = UIColor(red: (fillColorRedComponent * 0.6), green: (fillColorGreenComponent * 0.6), blue: (fillColorBlueComponent * 0.6), alpha: (CGColorGetAlpha(fillColor.CGColor) * 0.6 + 0.4))
    let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    let blue80 = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 0.560)

    let gradientArray = [gradientColor.CGColor, gradientColor.colorWithAlphaComponent(0.5).CGColor, UIColor.clearColor().CGColor]
    let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradientArray, [0.14, 0.51, 1])!

    let shadow = NSShadow()
    shadow.shadowColor = color.colorWithAlphaComponent(0.4 * CGColorGetAlpha(color.CGColor))
    shadow.shadowOffset = CGSize(width: 0.1, height: 1.1)
    shadow.shadowBlurRadius = 1.1

    let headerStackView: CGRect = CGRect(x: frame.minX + 26, y: frame.minY + 24, width: floor((frame.width - 26) * 0.85185 + 0.5), height: floor((frame.height - 24) * 0.61069 + 0.5))

    CGContextSaveGState(context)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangle5Path = UIBezierPath(rect: CGRect(x: headerStackView.minX + floor(headerStackView.width * 0.00000 + 0.5), y: headerStackView.minY + floor(headerStackView.height * 0.00000 + 0.5), width: floor(headerStackView.width * 1.00000 + 0.5) - floor(headerStackView.width * 0.00000 + 0.5), height: floor(headerStackView.height * 1.00000 + 0.5) - floor(headerStackView.height * 0.00000 + 0.5)))
    rectangle5Path.addClip()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.1)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangleRect = CGRect(x: headerStackView.minX + floor(headerStackView.width * -0.01087) + 0.5, y: headerStackView.minY + floor(headerStackView.height * 0.30469 - 0.48) + 0.98, width: floor(headerStackView.width * 1.00362) - floor(headerStackView.width * -0.01087), height: floor(headerStackView.height * 1.00031 - 0.13) - floor(headerStackView.height * 0.30469 - 0.48) - 0.35)
    let rectanglePath = UIBezierPath(rect: rectangleRect)
    CGContextSaveGState(context)
    rectanglePath.addClip()
    CGContextDrawLinearGradient(context, gradient,
      CGPoint(x: rectangleRect.midX + -0 * rectangleRect.width / 140, y: rectangleRect.midY + 3.99 * rectangleRect.height / 55.65),
      CGPoint(x: rectangleRect.midX + -0 * rectangleRect.width / 140, y: rectangleRect.midY + 26.77 * rectangleRect.height / 55.65),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)


    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle2Path = UIBezierPath(rect: CGRect(x: headerStackView.minX + floor(headerStackView.width * -0.01087) + 0.5, y: headerStackView.minY + floor(headerStackView.height * 0.21687 - 0.15) + 0.65, width: floor(headerStackView.width * 1.00362) - floor(headerStackView.width * -0.01087), height: floor(headerStackView.height * 0.57937 - 0.15) - floor(headerStackView.height * 0.21687 - 0.15)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    blue80.setFill()
    rectangle2Path.fill()
    CGContextRestoreGState(context)

    let rectangle3Path = UIBezierPath(rect: CGRect(x: headerStackView.minX + floor(headerStackView.width * -0.01087) + 0.5, y: headerStackView.minY + floor(headerStackView.height * 0.00000 + 0.5), width: floor(headerStackView.width * 1.00362) - floor(headerStackView.width * -0.01087), height: floor(headerStackView.height * 0.36250 + 0.5) - floor(headerStackView.height * 0.00000 + 0.5)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    fillColor.setFill()
    rectangle3Path.fill()
    CGContextRestoreGState(context)

    let rectangle4Path = UIBezierPath(rect: CGRect(x: headerStackView.minX + floor(headerStackView.width * 0.03569 - 0.43) + 0.93, y: headerStackView.minY + floor(headerStackView.height * 0.54500 - 0.1) + 0.6, width: floor(headerStackView.width * 0.37518 - 0.28) - floor(headerStackView.width * 0.03569 - 0.43) - 0.15, height: floor(headerStackView.height * 0.58000 + 0.1) - floor(headerStackView.height * 0.54500 - 0.1) - 0.2))
    fillColor2.setFill()
    rectangle4Path.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
