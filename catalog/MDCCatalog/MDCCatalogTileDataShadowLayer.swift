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

class MDCCatalogTileDataShadowLayer: NSObject {

  static func drawTile(frame frame: CGRect = CGRect(x: 0, y: 0, width: 188, height: 155)) {

    let context = UIGraphicsGetCurrentContext()

    let fillColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.000)
    let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.900)
    let shadowColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.250)

    let shadow = NSShadow()
    shadow.shadowColor = shadowColor.colorWithAlphaComponent(0 * CGColorGetAlpha(shadowColor.CGColor))
    shadow.shadowOffset = CGSize(width: 0.1, height: 2.1)
    shadow.shadowBlurRadius = 6
    let shadow2 = NSShadow()
    shadow2.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.13)
    shadow2.shadowOffset = CGSize(width: 0.1, height: 7.6)
    shadow2.shadowBlurRadius = 7
    let shadow3 = NSShadow()
    shadow3.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.08)
    shadow3.shadowOffset = CGSize(width: 0.1, height: -3.6)
    shadow3.shadowBlurRadius = 4
    let shadow4 = NSShadow()
    shadow4.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.16)
    shadow4.shadowOffset = CGSize(width: 4.1, height: 3.1)
    shadow4.shadowBlurRadius = 4
    let shadow7 = NSShadow()
    shadow7.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.16)
    shadow7.shadowOffset = CGSize(width: -4.1, height: 1.1)
    shadow7.shadowBlurRadius = 5

    let shadowLayer: CGRect = CGRect(x: frame.minX + 50.2, y: frame.minY + 20.6, width: floor((frame.width - 50.2) * 0.66473 + 49.9) - 49.4, height: floor((frame.height - 20.6) * 0.62054 + 20.7) - 20.2)

    let bluePath = UIBezierPath(rect: CGRect(x: shadowLayer.minX + floor(shadowLayer.width * 0.00000 + 0.5), y: shadowLayer.minY + floor(shadowLayer.height * 0.17266 + 0.5), width: floor(shadowLayer.width * 0.82969 + 0.5) - floor(shadowLayer.width * 0.00000 + 0.5), height: floor(shadowLayer.height * 1.00000 + 0.5) - floor(shadowLayer.height * 0.17266 + 0.5)))
    fillColor.setFill()
    bluePath.fill()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.9)
    CGContextBeginTransparencyLayer(context, nil)

    let rectangle6Path = UIBezierPath(rect: CGRect(x: shadowLayer.minX + floor(shadowLayer.width * 0.17031 - 0.1) + 0.6, y: shadowLayer.minY + floor(shadowLayer.height * 0.00000 + 0.1) + 0.4, width: floor(shadowLayer.width * 1.00000 - 0.1) - floor(shadowLayer.width * 0.17031 - 0.1), height: floor(shadowLayer.height * 0.82734 + 0.1) - floor(shadowLayer.height * 0.00000 + 0.1)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow7.shadowOffset, shadow7.shadowBlurRadius, (shadow7.shadowColor as! UIColor).CGColor)
    fillColor2.setFill()
    rectangle6Path.fill()
    CGContextRestoreGState(context)

    let rectangle2Path = UIBezierPath(rect: CGRect(x: shadowLayer.minX + floor(shadowLayer.width * 0.17031 - 0.1) + 0.6, y: shadowLayer.minY + floor(shadowLayer.height * 0.00000 + 0.1) + 0.4, width: floor(shadowLayer.width * 1.00000 - 0.1) - floor(shadowLayer.width * 0.17031 - 0.1), height: floor(shadowLayer.height * 0.82734 + 0.1) - floor(shadowLayer.height * 0.00000 + 0.1)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius, (shadow2.shadowColor as! UIColor).CGColor)
    fillColor2.setFill()
    rectangle2Path.fill()
    CGContextRestoreGState(context)

    let rectangle3Path = UIBezierPath(rect: CGRect(x: shadowLayer.minX + floor(shadowLayer.width * 0.17031 - 0.1) + 0.6, y: shadowLayer.minY + floor(shadowLayer.height * 0.00480 + 0.5), width: floor(shadowLayer.width * 1.00000 - 0.1) - floor(shadowLayer.width * 0.17031 - 0.1), height: floor(shadowLayer.height * 0.83213 + 0.5) - floor(shadowLayer.height * 0.00480 + 0.5)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow3.shadowOffset, shadow3.shadowBlurRadius, (shadow3.shadowColor as! UIColor).CGColor)
    fillColor2.setFill()
    rectangle3Path.fill()
    CGContextRestoreGState(context)

    let rectanglePath = UIBezierPath(rect: CGRect(x: shadowLayer.minX + floor(shadowLayer.width * 0.17031 - 0.1) + 0.6, y: shadowLayer.minY + floor(shadowLayer.height * 0.00000 + 0.1) + 0.4, width: floor(shadowLayer.width * 1.00000 - 0.1) - floor(shadowLayer.width * 0.17031 - 0.1), height: floor(shadowLayer.height * 0.82734 + 0.1) - floor(shadowLayer.height * 0.00000 + 0.1)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    fillColor2.setFill()
    rectanglePath.fill()
    CGContextRestoreGState(context)

    let rectangle4Path = UIBezierPath(rect: CGRect(x: shadowLayer.minX + floor(shadowLayer.width * 0.17031 - 0.1) + 0.6, y: shadowLayer.minY + floor(shadowLayer.height * 0.00000 + 0.1) + 0.4, width: floor(shadowLayer.width * 1.00000 - 0.1) - floor(shadowLayer.width * 0.17031 - 0.1), height: floor(shadowLayer.height * 0.82734 + 0.1) - floor(shadowLayer.height * 0.00000 + 0.1)))
    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow4.shadowOffset, shadow4.shadowBlurRadius, (shadow4.shadowColor as! UIColor).CGColor)
    fillColor2.setFill()
    rectangle4Path.fill()
    CGContextRestoreGState(context)

    CGContextEndTransparencyLayer(context)
    CGContextRestoreGState(context)
  }

}
