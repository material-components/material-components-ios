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

class MDCCatalogTileDataSlider: NSObject {

  static func drawTile(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    let gradientColor = UIColor(red: 0.102, green: 0.090, blue: 0.094, alpha: 0.000)
    let fillColor2 = UIColor(red: 0.209, green: 0.730, blue: 0.965, alpha: 1.000)
    let fillColor3 = UIColor(red: 0.407, green: 0.798, blue: 0.974, alpha: 1.000)
    let fillColor4 = UIColor(red: 0.605, green: 0.865, blue: 0.983, alpha: 1.000)
    let gradientColor1 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.500)

    let gradient50 = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor1.CGColor, gradientColor.CGColor], [0, 1])!

    let group2: CGRect = CGRect(x: frame.minX + 24.5, y: frame.minY + 55.5, width: floor((frame.width - 24.5) * 0.85015 + 0.5), height: floor((frame.height - 55.5) * 0.12060 + 0.5))

    CGContextSaveGState(context)
    CGContextBeginTransparencyLayer(context, nil)

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.1)
    CGContextBeginTransparencyLayer(context, nil)

    let rectanglePath = UIBezierPath(rect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 1.00000 + 0.5) - floor(group2.width * 0.00000 + 0.5), height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5)))
    fillColor.setFill()
    rectanglePath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    CGContextSaveGState(context)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangle2Rect = CGRect(x: group2.minX + floor(group2.width * 0.84514 + 0.02) + 0.48, y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.95558 - 0.33) - floor(group2.width * 0.84514 + 0.02) + 0.35, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5))
    let rectangle2Path = UIBezierPath(rect: rectangle2Rect)
    CGContextSaveGState(context)
    rectangle2Path.addClip()
    CGContextDrawLinearGradient(context, gradient50,
      CGPoint(x: rectangle2Rect.midX + -5.59 * rectangle2Rect.width / 15.35, y: rectangle2Rect.midY + 0 * rectangle2Rect.height / 2),
      CGPoint(x: rectangle2Rect.midX + 3.52 * rectangle2Rect.width / 15.35, y: rectangle2Rect.midY + 0 * rectangle2Rect.height / 2),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle3Path = UIBezierPath(rect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.85971) - floor(group2.width * 0.00000 + 0.5) + 0.5, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5)))
    fillColor.setFill()
    rectangle3Path.fill()

    let ovalPath = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.81655) + 0.5, y: group2.minY + floor(group2.height * 0.00000 + 0.5), width: floor(group2.width * 0.90288) - floor(group2.width * 0.81655), height: floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00000 + 0.5)))
    fillColor.setFill()
    ovalPath.fill()

    CGContextSaveGState(context)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangle4Rect = CGRect(x: group2.minX + floor(group2.width * 0.49982 + 0.02) + 0.48, y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.61025 - 0.33) - floor(group2.width * 0.49982 + 0.02) + 0.35, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5))
    let rectangle4Path = UIBezierPath(rect: rectangle4Rect)
    CGContextSaveGState(context)
    rectangle4Path.addClip()
    CGContextDrawLinearGradient(context, gradient50,
      CGPoint(x: rectangle4Rect.midX + -5.59 * rectangle4Rect.width / 15.35, y: rectangle4Rect.midY + 0 * rectangle4Rect.height / 2),
      CGPoint(x: rectangle4Rect.midX + 3.52 * rectangle4Rect.width / 15.35, y: rectangle4Rect.midY + 0 * rectangle4Rect.height / 2),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle5Path = UIBezierPath(rect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.45683) - floor(group2.width * 0.00000 + 0.5) + 0.5, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5)))
    fillColor2.setFill()
    rectangle5Path.fill()

    let oval2Path = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.45683) + 0.5, y: group2.minY + floor(group2.height * 0.00000 + 0.5), width: floor(group2.width * 0.54317) - floor(group2.width * 0.45683), height: floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00000 + 0.5)))
    fillColor2.setFill()
    oval2Path.fill()

    CGContextSaveGState(context)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangle6Rect = CGRect(x: group2.minX + floor(group2.width * 0.28399 + 0.02) + 0.48, y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.39442 - 0.33) - floor(group2.width * 0.28399 + 0.02) + 0.35, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5))
    let rectangle6Path = UIBezierPath(rect: rectangle6Rect)
    CGContextSaveGState(context)
    rectangle6Path.addClip()
    CGContextDrawLinearGradient(context, gradient50,
      CGPoint(x: rectangle6Rect.midX + -5.59 * rectangle6Rect.width / 15.35, y: rectangle6Rect.midY + 0 * rectangle6Rect.height / 2),
      CGPoint(x: rectangle6Rect.midX + 3.52 * rectangle6Rect.width / 15.35, y: rectangle6Rect.midY + 0 * rectangle6Rect.height / 2),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle7Path = UIBezierPath(rect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.29137) - floor(group2.width * 0.00000 + 0.5) + 0.5, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5)))
    fillColor3.setFill()
    rectangle7Path.fill()

    let oval3Path = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.24101) + 0.5, y: group2.minY + floor(group2.height * 0.00000 + 0.5), width: floor(group2.width * 0.32734) - floor(group2.width * 0.24101), height: floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00000 + 0.5)))
    fillColor3.setFill()
    oval3Path.fill()

    CGContextSaveGState(context)
    CGContextSetBlendMode(context, .Multiply)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangle8Rect = CGRect(x: group2.minX + floor(group2.width * 0.14011 + 0.02) + 0.48, y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.22176 - 0.33) - floor(group2.width * 0.14011 + 0.02) + 0.35, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5))
    let rectangle8Path = UIBezierPath(rect: rectangle8Rect)
    CGContextSaveGState(context)
    rectangle8Path.addClip()
    CGContextDrawLinearGradient(context, gradient50,
      CGPoint(x: rectangle8Rect.midX + -5.65 * rectangle8Rect.width / 11.35, y: rectangle8Rect.midY + 0 * rectangle8Rect.height / 2),
      CGPoint(x: rectangle8Rect.midX + 5.68 * rectangle8Rect.width / 11.35, y: rectangle8Rect.midY + 0 * rectangle8Rect.height / 2),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle9Path = UIBezierPath(rect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.41667 + 0.5), width: floor(group2.width * 0.14029) - floor(group2.width * 0.00000 + 0.5) + 0.5, height: floor(group2.height * 0.58333 + 0.5) - floor(group2.height * 0.41667 + 0.5)))
    fillColor4.setFill()
    rectangle9Path.fill()

    let oval4Path = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.09712) + 0.5, y: group2.minY + floor(group2.height * 0.00000 + 0.5), width: floor(group2.width * 0.18345) - floor(group2.width * 0.09712), height: floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00000 + 0.5)))
    fillColor4.setFill()
    oval4Path.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
