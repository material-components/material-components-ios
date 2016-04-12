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

class MDCCatalogTileDataButtons: MDCCatalogTileData {

  static func drawTileImage(frame: CGRect) -> UIImage {
    return drawImage(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.077, green: 0.591, blue: 0.945, alpha: 1.000)

    let group: CGRect = CGRect(x: frame.minX + floor((frame.width - 139.08) * 0.50026 + 0.03) + 0.47, y: frame.minY + floor((frame.height - 49.7) * 0.25641 + 0.2) + 0.3, width: 139.08, height: 49.7)

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.95)
    CGContextBeginTransparencyLayer(context, nil)

    let rectanglePath = UIBezierPath(roundedRect: CGRect(x: group.minX, y: group.minY + 12.72, width: 77.75, height: 24.25), cornerRadius: 3.4)
    fillColor.setFill()
    rectanglePath.fill()

    let ovalPath = UIBezierPath(ovalInRect: CGRect(x: group.minX + 89.28, y: group.minY, width: 49.8, height: 49.7))
    fillColor.setFill()
    ovalPath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
