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

class MDCCatalogTileDataPageControl: MDCCatalogTileData {
  static var tileImage: UIImage? = nil

  static func drawTile(frame: CGRect) {
    drawAndCache(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let gradientColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)
    let fillColor10 = UIColor(red: 0.506, green: 0.831, blue: 0.976, alpha: 1.000)
    let gradientColor2 = UIColor(red: 0.075, green: 0.592, blue: 0.945, alpha: 0.300)
    let fillColor7 = UIColor(red: 0.902, green: 0.965, blue: 0.996, alpha: 0.500)
    let fillColor8 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.800)
    let color2 = UIColor(red: 0.902, green: 0.965, blue: 0.996, alpha: 0.300)

    let gradient2Array = [gradientColor2.CGColor, gradientColor2.colorWithAlphaComponent(0.5).CGColor, gradientColor.CGColor]
    let gradient2 = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradient2Array, [0.28, 0.68, 0.98])!

    let group2: CGRect = CGRect(x: frame.minX + 30.75, y: frame.minY + 51, width: floor((frame.width - 30.75) * 0.81399 + 0.5), height: floor((frame.height - 51) * 0.22127 + 0.5))

    let ovalPath = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.82031 + 0.5), y: group2.minY + floor(group2.height * 0.00000 + 0.49) + 0.01, width: floor(group2.width * 1.00000 + 0.5) - floor(group2.width * 0.82031 + 0.5), height: floor(group2.height * 0.99947 + 0.49) - floor(group2.height * 0.00000 + 0.49)))
    fillColor10.setFill()
    ovalPath.fill()

    let rectanglePath = UIBezierPath(roundedRect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.00000 + 0.49) + 0.01, width: floor(group2.width * 0.58984) - floor(group2.width * 0.00000 + 0.5) + 0.5, height: floor(group2.height * 0.99947 + 0.49) - floor(group2.height * 0.00000 + 0.49)), cornerRadius: 11.4)
    fillColor10.setFill()
    rectanglePath.fill()

    CGContextSaveGState(context)
    CGContextBeginTransparencyLayer(context, nil)

    let clipPath = UIBezierPath(roundedRect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.00000 + 0.49) + 0.01, width: floor(group2.width * 0.39922 + 0.4) - floor(group2.width * 0.00000 + 0.5) + 0.1, height: floor(group2.height * 0.99947 + 0.49) - floor(group2.height * 0.00000 + 0.49)), cornerRadius: 11.4)
    clipPath.addClip()

    let rectangle2Rect = CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.00000 + 0.49) + 0.01, width: floor(group2.width * 0.39922 + 0.4) - floor(group2.width * 0.00000 + 0.5) + 0.1, height: floor(group2.height * 0.99947 + 0.49) - floor(group2.height * 0.00000 + 0.49))
    let rectangle2Path = UIBezierPath(roundedRect: rectangle2Rect, cornerRadius: 11.4)
    CGContextSaveGState(context)
    rectangle2Path.addClip()
    CGContextDrawLinearGradient(context, gradient2,
      CGPoint(x: rectangle2Rect.midX + -23.3 * rectangle2Rect.width / 51.1, y: rectangle2Rect.midY + 0 * rectangle2Rect.height / 23),
      CGPoint(x: rectangle2Rect.midX + 15.87 * rectangle2Rect.width / 51.1, y: rectangle2Rect.midY + 0 * rectangle2Rect.height / 23),
      [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let oval2Path = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.10977 + 0.45) + 0.05, y: group2.minY + floor(group2.height * 0.00000 + 0.49) + 0.01, width: floor(group2.width * 0.28945 + 0.45) - floor(group2.width * 0.10977 + 0.45), height: floor(group2.height * 0.99947 + 0.49) - floor(group2.height * 0.00000 + 0.49)))
    color2.setFill()
    oval2Path.fill()

    let oval3Path = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.21836 - 0.45) + 0.95, y: group2.minY + floor(group2.height * 0.00053 + 0.5), width: floor(group2.width * 0.39805 - 0.45) - floor(group2.width * 0.21836 - 0.45), height: floor(group2.height * 1.00000 + 0.5) - floor(group2.height * 0.00053 + 0.5)))
    fillColor7.setFill()
    oval3Path.fill()

    let oval4Path = UIBezierPath(ovalInRect: CGRect(x: group2.minX + floor(group2.width * 0.32930 + 0.35) + 0.15, y: group2.minY + floor(group2.height * 0.00000 + 0.49) + 0.01, width: floor(group2.width * 0.50898 + 0.35) - floor(group2.width * 0.32930 + 0.35), height: floor(group2.height * 0.99947 + 0.49) - floor(group2.height * 0.00000 + 0.49)))
    fillColor8.setFill()
    oval4Path.fill()
  }

}
