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

class MDCCatalogTileDataTypography: MDCCatalogTileData {
  static var tileImage: UIImage? = nil

  static func drawTile(frame: CGRect) {
    drawAndCache(draw, frame: frame, image: &tileImage)
  }

  static func draw(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let fillColor = UIColor(red: 0.077, green: 0.591, blue: 0.945, alpha: 1.000)

    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.51375 * frame.width, y: frame.minY + 0.26476 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.44831 * frame.width, y: frame.minY + 0.26476 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.44831 * frame.width, y: frame.minY + 0.48366 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.41213 * frame.width, y: frame.minY + 0.48366 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.41213 * frame.width, y: frame.minY + 0.26476 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.34726 * frame.width, y: frame.minY + 0.26476 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.34726 * frame.width, y: frame.minY + 0.22910 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.51375 * frame.width, y: frame.minY + 0.22910 * frame.height))
    bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.51375 * frame.width, y: frame.minY + 0.26476 * frame.height))
    bezierPath.closePath()
    fillColor.setFill()
    bezierPath.fill()

    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPoint(x: frame.minX + 0.58179 * frame.width, y: frame.minY + 0.24850 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.58179 * frame.width, y: frame.minY + 0.29448 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.60932 * frame.width, y: frame.minY + 0.29448 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.60932 * frame.width, y: frame.minY + 0.32595 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.58179 * frame.width, y: frame.minY + 0.32595 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.58179 * frame.width, y: frame.minY + 0.43155 * frame.height))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 0.58532 * frame.width, y: frame.minY + 0.44720 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.58179 * frame.width, y: frame.minY + 0.43878 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.58296 * frame.width, y: frame.minY + 0.44400 * frame.height))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 0.59793 * frame.width, y: frame.minY + 0.45201 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.58767 * frame.width, y: frame.minY + 0.45041 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.59187 * frame.width, y: frame.minY + 0.45201 * frame.height))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 0.61018 * frame.width, y: frame.minY + 0.45026 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.60197 * frame.width, y: frame.minY + 0.45201 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.60605 * frame.width, y: frame.minY + 0.45143 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.61018 * frame.width, y: frame.minY + 0.48313 * frame.height))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 0.58712 * frame.width, y: frame.minY + 0.48715 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.60220 * frame.width, y: frame.minY + 0.48581 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.59452 * frame.width, y: frame.minY + 0.48715 * frame.height))
    bezier2Path.addCurveToPoint(CGPoint(x: frame.minX + 0.54676 * frame.width, y: frame.minY + 0.43313 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.56021 * frame.width, y: frame.minY + 0.48715 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.54676 * frame.width, y: frame.minY + 0.46915 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.54676 * frame.width, y: frame.minY + 0.32595 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.52110 * frame.width, y: frame.minY + 0.32595 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.52110 * frame.width, y: frame.minY + 0.29448 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.54676 * frame.width, y: frame.minY + 0.29448 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.54676 * frame.width, y: frame.minY + 0.24850 * frame.height))
    bezier2Path.addLineToPoint(CGPoint(x: frame.minX + 0.58179 * frame.width, y: frame.minY + 0.24850 * frame.height))
    bezier2Path.closePath()
    fillColor.setFill()
    bezier2Path.fill()
  }

}
