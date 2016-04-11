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

class MDCCatalogTileDataInk: MDCCatalogTileData {
  static var tileImage: UIImage? = nil

  static func drawTile(frame: CGRect) {
    drawAndCache(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.077, green: 0.591, blue: 0.945, alpha: 1.000)
    let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

    let rectanglePath = UIBezierPath(rect: CGRect(x: frame.minX + floor((frame.width - 139.5) * 0.49485 + 0.5), y: frame.minY + floor((frame.height - 80.1) * 0.32043 - 0.4) + 0.9, width: 139.5, height: 80.1))
    fillColor.setFill()
    rectanglePath.fill()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.5)
    CGContextBeginTransparencyLayer(context, nil)

    let clipPath = UIBezierPath(rect: CGRect(x: frame.minX + 24, y: frame.minY + 24, width: 139.5, height: 80.1))
    clipPath.addClip()

    let ovalPath = UIBezierPath(ovalInRect: CGRect(x: frame.minX + 77.65, y: frame.minY + 18.95, width: 90.2, height: 90.2))
    fillColor2.setFill()
    ovalPath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
