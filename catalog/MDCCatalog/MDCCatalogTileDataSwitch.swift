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

class MDCCatalogTileDataSwitch: MDCCatalogTileData {
  static var tileImage: UIImage? = nil

  static func drawTile(frame: CGRect) {
    drawAndCache(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {
    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.119, green: 0.630, blue: 0.950, alpha: 1.000)
    let fillColor2 = UIColor(red: 0.077, green: 0.591, blue: 0.945, alpha: 1.000)

    let group: CGRect = CGRect(x: frame.minX + floor((frame.width - 56.43) * 0.59180 - 0.37) + 0.87, y: frame.minY + floor((frame.height - 31.91) * 0.38869 + 0.25) + 0.25, width: 56.43, height: 31.91)

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.3)
    CGContextBeginTransparencyLayer(context, nil)

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: group.minX + 40.47, y: group.minY + 31.91))
    bezierPath.addCurveToPoint(CGPoint(x: group.minX + 56.43, y: group.minY + 15.96), controlPoint1: CGPoint(x: group.minX + 49.28, y: group.minY + 31.91), controlPoint2: CGPoint(x: group.minX + 56.43, y: group.minY + 24.77))
    bezierPath.addCurveToPoint(CGPoint(x: group.minX + 40.47, y: group.minY), controlPoint1: CGPoint(x: group.minX + 56.43, y: group.minY + 7.14), controlPoint2: CGPoint(x: group.minX + 49.28, y: group.minY))
    bezierPath.addLineToPoint(CGPoint(x: group.minX, y: group.minY))
    bezierPath.addLineToPoint(CGPoint(x: group.minX, y: group.minY + 31.91))
    bezierPath.addLineToPoint(CGPoint(x: group.minX + 40.47, y: group.minY + 31.91))
    bezierPath.closePath()
    fillColor.setFill()
    bezierPath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let ovalPath = UIBezierPath(ovalInRect: CGRect(x: frame.minX + floor((frame.width - 43.3) * 0.37111 - 0.2) + 0.7, y: frame.minY + floor((frame.height - 43.3) * 0.37735 - 0.05) + 0.55, width: 43.3, height: 43.3))
    fillColor2.setFill()
    ovalPath.fill()
  }

}
