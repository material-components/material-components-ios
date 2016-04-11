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

class MDCCatalogTileDataFlexibleHeader: MDCCatalogTileData {
  static var tileImage: UIImage? = nil

  static func drawTile(frame: CGRect) {
    drawAndCache(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    let blue10 = fillColor.colorWithAlphaComponent(0.1)
    let blue5 = fillColor.colorWithAlphaComponent(0.05)

    let flexibleHeaderView: CGRect = CGRect(x: frame.minX + 24.5, y: frame.minY + 24, width: floor((frame.width - 24.5) * 0.85015 + 0.5), height: floor((frame.height - 24) * 0.61145 + 0.5))

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.05)
    CGContextBeginTransparencyLayer(context, nil)

    let rectanglePath = UIBezierPath(rect: CGRect(x: flexibleHeaderView.minX + floor(flexibleHeaderView.width * 0.00000 + 0.5), y: flexibleHeaderView.minY + floor(flexibleHeaderView.height * 0.00000 + 0.5), width: floor(flexibleHeaderView.width * 1.00000 + 0.5) - floor(flexibleHeaderView.width * 0.00000 + 0.5), height: floor(flexibleHeaderView.height * 1.00000 + 0.4) - floor(flexibleHeaderView.height * 0.00000 + 0.5) + 0.1))
    blue5.setFill()
    rectanglePath.fill()

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)

    let rectangle2Path = UIBezierPath(rect: CGRect(x: flexibleHeaderView.minX + floor(flexibleHeaderView.width * 0.00000 + 0.5), y: flexibleHeaderView.minY + floor(flexibleHeaderView.height * 0.00031 - 0.33) + 0.83, width: floor(flexibleHeaderView.width * 1.00000 + 0.5) - floor(flexibleHeaderView.width * 0.00000 + 0.5), height: floor(flexibleHeaderView.height * 0.83989 + 0.42) - floor(flexibleHeaderView.height * 0.00031 - 0.33) - 0.75))
    blue10.setFill()
    rectangle2Path.fill()

    let rectangle3Path = UIBezierPath(rect: CGRect(x: flexibleHeaderView.minX + floor(flexibleHeaderView.width * 0.00000 + 0.5), y: flexibleHeaderView.minY + floor(flexibleHeaderView.height * 0.00000 - 0.3) + 0.8, width: floor(flexibleHeaderView.width * 1.00000 + 0.5) - floor(flexibleHeaderView.width * 0.00000 + 0.5), height: floor(flexibleHeaderView.height * 0.64045 + 0.4) - floor(flexibleHeaderView.height * 0.00000 - 0.3) - 0.7))
    blue10.setFill()
    rectangle3Path.fill()

    let rectangle4Path = UIBezierPath(rect: CGRect(x: flexibleHeaderView.minX + floor(flexibleHeaderView.width * 0.00000 + 0.5), y: flexibleHeaderView.minY + floor(flexibleHeaderView.height * 0.00000 + 0.4) + 0.1, width: floor(flexibleHeaderView.width * 1.00000 + 0.5) - floor(flexibleHeaderView.width * 0.00000 + 0.5), height: floor(flexibleHeaderView.height * 0.47441 + 0.4) - floor(flexibleHeaderView.height * 0.00000 + 0.4)))
    blue10.setFill()
    rectangle4Path.fill()

    let rectangle5Path = UIBezierPath(rect: CGRect(x: flexibleHeaderView.minX + floor(flexibleHeaderView.width * 0.00000 + 0.5), y: flexibleHeaderView.minY + floor(flexibleHeaderView.height * 0.00000 + 0.4) + 0.1, width: floor(flexibleHeaderView.width * 1.00000 + 0.5) - floor(flexibleHeaderView.width * 0.00000 + 0.5), height: floor(flexibleHeaderView.height * 0.36205 + 0.4) - floor(flexibleHeaderView.height * 0.00000 + 0.4)))
    fillColor.setFill()
    rectangle5Path.fill()
  }

}
