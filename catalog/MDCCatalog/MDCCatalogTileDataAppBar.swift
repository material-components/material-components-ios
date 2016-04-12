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

class MDCCatalogTileDataAppBar: MDCCatalogTileData {

  static func drawTileImage(frame: CGRect) -> UIImage {
    return drawImage(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

    let group2: CGRect = CGRect(x: frame.minX + 24.5, y: frame.minY + 24, width: floor((frame.width - 24.5) * 1.02783 + 24.45) - 23.95, height: floor((frame.height - 24) * 0.42786 + 0.5))

    let rectanglePath = UIBezierPath(rect: CGRect(x: group2.minX + floor(group2.width * 0.00000 + 0.5), y: group2.minY + floor(group2.height * 0.00000 + 0.5), width: floor(group2.width * 1.00000 + 0.45) - floor(group2.width * 0.00000 + 0.5) + 0.05, height: floor(group2.height * 1.00000 + 0.45) - floor(group2.height * 0.00000 + 0.5) + 0.05))
    fillColor.setFill()
    rectanglePath.fill()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.2)
    CGContextBeginTransparencyLayer(context, nil)

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.42819 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.22445 * group2.width, y: group2.minY + 0.42819 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.22445 * group2.width, y: group2.minY + 0.39251 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.39251 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.42819 * group2.height))
    bezierPath.closePath()
    bezierPath.moveToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.51740 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.22445 * group2.width, y: group2.minY + 0.51740 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.22445 * group2.width, y: group2.minY + 0.48171 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.48171 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.51740 * group2.height))
    bezierPath.closePath()
    bezierPath.moveToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.60660 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.22445 * group2.width, y: group2.minY + 0.60660 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.22445 * group2.width, y: group2.minY + 0.57092 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.57092 * group2.height))
    bezierPath.addLineToPoint(CGPoint(x: group2.minX + 0.11734 * group2.width, y: group2.minY + 0.60660 * group2.height))
    bezierPath.closePath()
    fillColor2.setFill()
    bezierPath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
