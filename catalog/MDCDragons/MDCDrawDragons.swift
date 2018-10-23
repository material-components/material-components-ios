// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import UIKit

class MDCDrawDragons {
  static func image(with drawer: ((UIColor, CGSize) -> ()), size: CGSize, fillColor: UIColor) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
    drawer(fillColor, size)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  static func drawDragon(fillColor: UIColor, size: CGSize) -> () {
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 96.72, y: 63.07))
    bezierPath.addCurve(to: CGPoint(x: 92.22, y: 56.75), controlPoint1: CGPoint(x: 96.17, y: 60.32), controlPoint2: CGPoint(x: 94.44, y: 58.18))
    bezierPath.addCurve(to: CGPoint(x: 73.45, y: 89.46), controlPoint1: CGPoint(x: 89.11, y: 72.34), controlPoint2: CGPoint(x: 82.01, y: 82.76))
    bezierPath.addCurve(to: CGPoint(x: 25.73, y: 97.14), controlPoint1: CGPoint(x: 57.1, y: 102.26), controlPoint2: CGPoint(x: 35.38, y: 101.48))
    bezierPath.addCurve(to: CGPoint(x: 5.4, y: 76.84), controlPoint1: CGPoint(x: 19.44, y: 94.31), controlPoint2: CGPoint(x: 10.82, y: 86.81))
    bezierPath.addCurve(to: CGPoint(x: 2.85, y: 42.03), controlPoint1: CGPoint(x: -0.01, y: 66.86), controlPoint2: CGPoint(x: -2.21, y: 54.42))
    bezierPath.addCurve(to: CGPoint(x: 30.42, y: 87.59), controlPoint1: CGPoint(x: 5.1, y: 74.19), controlPoint2: CGPoint(x: 20.61, y: 83.98))
    bezierPath.addCurve(to: CGPoint(x: 48.13, y: 87.54), controlPoint1: CGPoint(x: 35.04, y: 89.29), controlPoint2: CGPoint(x: 41.69, y: 89.54))
    bezierPath.addCurve(to: CGPoint(x: 68.14, y: 58.56), controlPoint1: CGPoint(x: 58.17, y: 84.41), controlPoint2: CGPoint(x: 67.69, y: 75.78))
    bezierPath.addCurve(to: CGPoint(x: 56.63, y: 64.6), controlPoint1: CGPoint(x: 64.39, y: 62.46), controlPoint2: CGPoint(x: 60.56, y: 64.65))
    bezierPath.addCurve(to: CGPoint(x: 65.77, y: 50.36), controlPoint1: CGPoint(x: 61.74, y: 61.13), controlPoint2: CGPoint(x: 64.75, y: 54.34))
    bezierPath.addCurve(to: CGPoint(x: 64.56, y: 37.29), controlPoint1: CGPoint(x: 66.87, y: 46.04), controlPoint2: CGPoint(x: 66.96, y: 40.35))
    bezierPath.addCurve(to: CGPoint(x: 55.72, y: 34.99), controlPoint1: CGPoint(x: 62.38, y: 34.5), controlPoint2: CGPoint(x: 57.83, y: 34.08))
    bezierPath.addCurve(to: CGPoint(x: 50.94, y: 39.3), controlPoint1: CGPoint(x: 54.45, y: 35.53), controlPoint2: CGPoint(x: 52.18, y: 36.85))
    bezierPath.addCurve(to: CGPoint(x: 50.85, y: 47.55), controlPoint1: CGPoint(x: 49.8, y: 41.56), controlPoint2: CGPoint(x: 49.51, y: 45.32))
    bezierPath.addCurve(to: CGPoint(x: 52.08, y: 49.49), controlPoint1: CGPoint(x: 51.26, y: 48.23), controlPoint2: CGPoint(x: 51.82, y: 48.82))
    bezierPath.addCurve(to: CGPoint(x: 52.03, y: 51.37), controlPoint1: CGPoint(x: 52.35, y: 50.15), controlPoint2: CGPoint(x: 52.15, y: 50.81))
    bezierPath.addCurve(to: CGPoint(x: 49.98, y: 59.29), controlPoint1: CGPoint(x: 51.68, y: 53.05), controlPoint2: CGPoint(x: 50.71, y: 56.33))
    bezierPath.addCurve(to: CGPoint(x: 51.36, y: 66.52), controlPoint1: CGPoint(x: 48.97, y: 63.36), controlPoint2: CGPoint(x: 48.48, y: 67))
    bezierPath.addCurve(to: CGPoint(x: 46.47, y: 70.12), controlPoint1: CGPoint(x: 48.37, y: 70.9), controlPoint2: CGPoint(x: 47.12, y: 70.21))
    bezierPath.addCurve(to: CGPoint(x: 45.57, y: 68.92), controlPoint1: CGPoint(x: 45.63, y: 70), controlPoint2: CGPoint(x: 45.22, y: 70.12))
    bezierPath.addCurve(to: CGPoint(x: 45.59, y: 68.7), controlPoint1: CGPoint(x: 45.57, y: 68.85), controlPoint2: CGPoint(x: 45.58, y: 68.77))
    bezierPath.addCurve(to: CGPoint(x: 39.86, y: 67.54), controlPoint1: CGPoint(x: 43.32, y: 69.49), controlPoint2: CGPoint(x: 41.33, y: 69.38))
    bezierPath.addCurve(to: CGPoint(x: 45.76, y: 65.46), controlPoint1: CGPoint(x: 41.73, y: 67.58), controlPoint2: CGPoint(x: 43.7, y: 66.89))
    bezierPath.addCurve(to: CGPoint(x: 45.76, y: 65.29), controlPoint1: CGPoint(x: 45.76, y: 65.41), controlPoint2: CGPoint(x: 45.76, y: 65.35))
    bezierPath.addCurve(to: CGPoint(x: 41.67, y: 64.83), controlPoint1: CGPoint(x: 44.21, y: 65.74), controlPoint2: CGPoint(x: 42.85, y: 65.59))
    bezierPath.addCurve(to: CGPoint(x: 45.72, y: 63.55), controlPoint1: CGPoint(x: 43.1, y: 64.82), controlPoint2: CGPoint(x: 44.46, y: 64.44))
    bezierPath.addCurve(to: CGPoint(x: 45.7, y: 63.16), controlPoint1: CGPoint(x: 45.72, y: 63.42), controlPoint2: CGPoint(x: 45.71, y: 63.29))
    bezierPath.addCurve(to: CGPoint(x: 41.94, y: 61.74), controlPoint1: CGPoint(x: 44.26, y: 63.42), controlPoint2: CGPoint(x: 42.97, y: 63.12))
    bezierPath.addCurve(to: CGPoint(x: 45.45, y: 60.43), controlPoint1: CGPoint(x: 43.38, y: 61.96), controlPoint2: CGPoint(x: 44.53, y: 61.46))
    bezierPath.addCurve(to: CGPoint(x: 45.4, y: 60.05), controlPoint1: CGPoint(x: 45.43, y: 60.3), controlPoint2: CGPoint(x: 45.41, y: 60.18))
    bezierPath.addCurve(to: CGPoint(x: 42.27, y: 60.15), controlPoint1: CGPoint(x: 44.17, y: 60.61), controlPoint2: CGPoint(x: 43.12, y: 60.64))
    bezierPath.addCurve(to: CGPoint(x: 45.17, y: 58.56), controlPoint1: CGPoint(x: 43.39, y: 59.99), controlPoint2: CGPoint(x: 44.35, y: 59.46))
    bezierPath.addCurve(to: CGPoint(x: 44.31, y: 54.58), controlPoint1: CGPoint(x: 44.93, y: 57.22), controlPoint2: CGPoint(x: 44.64, y: 55.89))
    bezierPath.addCurve(to: CGPoint(x: 44.19, y: 54.37), controlPoint1: CGPoint(x: 44.27, y: 54.51), controlPoint2: CGPoint(x: 44.23, y: 54.44))
    bezierPath.addCurve(to: CGPoint(x: 40.21, y: 61.14), controlPoint1: CGPoint(x: 42.64, y: 56.43), controlPoint2: CGPoint(x: 41.34, y: 58.71))
    bezierPath.addCurve(to: CGPoint(x: 42.95, y: 77.89), controlPoint1: CGPoint(x: 38.33, y: 66.64), controlPoint2: CGPoint(x: 39.49, y: 72.24))
    bezierPath.addCurve(to: CGPoint(x: 39.02, y: 71.94), controlPoint1: CGPoint(x: 41.22, y: 75.93), controlPoint2: CGPoint(x: 39.92, y: 73.94))
    bezierPath.addCurve(to: CGPoint(x: 34.09, y: 79.74), controlPoint1: CGPoint(x: 38.87, y: 74.3), controlPoint2: CGPoint(x: 37.85, y: 76.83))
    bezierPath.addCurve(to: CGPoint(x: 37.8, y: 61.3), controlPoint1: CGPoint(x: 40.86, y: 72.66), controlPoint2: CGPoint(x: 35.98, y: 67.01))
    bezierPath.addLine(to: CGPoint(x: 37.87, y: 61.07))
    bezierPath.addCurve(to: CGPoint(x: 42.06, y: 51.73), controlPoint1: CGPoint(x: 38.53, y: 57.99), controlPoint2: CGPoint(x: 39.96, y: 54.88))
    bezierPath.addCurve(to: CGPoint(x: 37.37, y: 51.87), controlPoint1: CGPoint(x: 40.49, y: 50.45), controlPoint2: CGPoint(x: 38.92, y: 50.61))
    bezierPath.addCurve(to: CGPoint(x: 36.49, y: 52.73), controlPoint1: CGPoint(x: 37.09, y: 52.1), controlPoint2: CGPoint(x: 36.8, y: 52.39))
    bezierPath.addCurve(to: CGPoint(x: 39.51, y: 53.83), controlPoint1: CGPoint(x: 37.16, y: 53.34), controlPoint2: CGPoint(x: 38.08, y: 53.77))
    bezierPath.addCurve(to: CGPoint(x: 35.14, y: 54.47), controlPoint1: CGPoint(x: 37.82, y: 54.81), controlPoint2: CGPoint(x: 36.31, y: 55.02))
    bezierPath.addCurve(to: CGPoint(x: 34.74, y: 55.05), controlPoint1: CGPoint(x: 35.01, y: 54.66), controlPoint2: CGPoint(x: 34.87, y: 54.85))
    bezierPath.addCurve(to: CGPoint(x: 37.59, y: 58.53), controlPoint1: CGPoint(x: 35.3, y: 56.86), controlPoint2: CGPoint(x: 36.17, y: 58.16))
    bezierPath.addCurve(to: CGPoint(x: 32.93, y: 57.95), controlPoint1: CGPoint(x: 35.84, y: 59.11), controlPoint2: CGPoint(x: 34.33, y: 58.76))
    bezierPath.addCurve(to: CGPoint(x: 32.75, y: 58.26), controlPoint1: CGPoint(x: 32.87, y: 58.05), controlPoint2: CGPoint(x: 32.81, y: 58.16))
    bezierPath.addCurve(to: CGPoint(x: 35.83, y: 62.65), controlPoint1: CGPoint(x: 33.38, y: 60.48), controlPoint2: CGPoint(x: 34.3, y: 62.14))
    bezierPath.addCurve(to: CGPoint(x: 30.63, y: 62.04), controlPoint1: CGPoint(x: 33.61, y: 63.58), controlPoint2: CGPoint(x: 31.97, y: 63.16))
    bezierPath.addLine(to: CGPoint(x: 30.52, y: 62.26))
    bezierPath.addCurve(to: CGPoint(x: 35.49, y: 66), controlPoint1: CGPoint(x: 31.75, y: 64.39), controlPoint2: CGPoint(x: 33.35, y: 65.74))
    bezierPath.addCurve(to: CGPoint(x: 29.01, y: 65.29), controlPoint1: CGPoint(x: 33.21, y: 66.52), controlPoint2: CGPoint(x: 31, y: 66.63))
    bezierPath.addCurve(to: CGPoint(x: 28.92, y: 65.5), controlPoint1: CGPoint(x: 28.98, y: 65.36), controlPoint2: CGPoint(x: 28.95, y: 65.43))
    bezierPath.addCurve(to: CGPoint(x: 34.49, y: 68.94), controlPoint1: CGPoint(x: 30.09, y: 67.73), controlPoint2: CGPoint(x: 32.03, y: 68.75))
    bezierPath.addCurve(to: CGPoint(x: 27.68, y: 69.73), controlPoint1: CGPoint(x: 32.27, y: 70.38), controlPoint2: CGPoint(x: 30.01, y: 70.78))
    bezierPath.addCurve(to: CGPoint(x: 27.68, y: 71.47), controlPoint1: CGPoint(x: 27.62, y: 70.32), controlPoint2: CGPoint(x: 27.61, y: 70.9))
    bezierPath.addCurve(to: CGPoint(x: 23.18, y: 66.49), controlPoint1: CGPoint(x: 25.25, y: 70.66), controlPoint2: CGPoint(x: 23.84, y: 68.91))
    bezierPath.addCurve(to: CGPoint(x: 23.13, y: 61.12), controlPoint1: CGPoint(x: 22.78, y: 65.03), controlPoint2: CGPoint(x: 23.1, y: 63.08))
    bezierPath.addCurve(to: CGPoint(x: 23.77, y: 52.79), controlPoint1: CGPoint(x: 23.18, y: 58.6), controlPoint2: CGPoint(x: 23.08, y: 55.91))
    bezierPath.addCurve(to: CGPoint(x: 25.84, y: 56.24), controlPoint1: CGPoint(x: 24.33, y: 54.19), controlPoint2: CGPoint(x: 25, y: 55.37))
    bezierPath.addCurve(to: CGPoint(x: 26.4, y: 53.83), controlPoint1: CGPoint(x: 26.14, y: 55.36), controlPoint2: CGPoint(x: 26.22, y: 54.54))
    bezierPath.addCurve(to: CGPoint(x: 27.06, y: 50.12), controlPoint1: CGPoint(x: 26.79, y: 52.28), controlPoint2: CGPoint(x: 27.07, y: 51.12))
    bezierPath.addCurve(to: CGPoint(x: 26.31, y: 47.12), controlPoint1: CGPoint(x: 27.05, y: 48.92), controlPoint2: CGPoint(x: 26.55, y: 48.05))
    bezierPath.addCurve(to: CGPoint(x: 26.03, y: 44.42), controlPoint1: CGPoint(x: 26.09, y: 46.31), controlPoint2: CGPoint(x: 26.14, y: 45.44))
    bezierPath.addCurve(to: CGPoint(x: 21.57, y: 29.52), controlPoint1: CGPoint(x: 25.44, y: 38.66), controlPoint2: CGPoint(x: 23.8, y: 33.82))
    bezierPath.addCurve(to: CGPoint(x: 28.5, y: 36.3), controlPoint1: CGPoint(x: 25.07, y: 31.07), controlPoint2: CGPoint(x: 27.24, y: 33.41))
    bezierPath.addCurve(to: CGPoint(x: 21.99, y: 17.68), controlPoint1: CGPoint(x: 31.03, y: 29.17), controlPoint2: CGPoint(x: 29.49, y: 22.84))
    bezierPath.addCurve(to: CGPoint(x: 33.01, y: 26.57), controlPoint1: CGPoint(x: 27.21, y: 18.32), controlPoint2: CGPoint(x: 30.98, y: 21.13))
    bezierPath.addCurve(to: CGPoint(x: 31.3, y: 7.93), controlPoint1: CGPoint(x: 37.97, y: 19.89), controlPoint2: CGPoint(x: 37.4, y: 13.68))
    bezierPath.addCurve(to: CGPoint(x: 40.65, y: 18.63), controlPoint1: CGPoint(x: 36.45, y: 8.97), controlPoint2: CGPoint(x: 39.44, y: 12.69))
    bezierPath.addCurve(to: CGPoint(x: 47.35, y: 0.57), controlPoint1: CGPoint(x: 48.65, y: 14.02), controlPoint2: CGPoint(x: 51.66, y: 8.18))
    bezierPath.addCurve(to: CGPoint(x: 53.03, y: 13.05), controlPoint1: CGPoint(x: 52.01, y: 2.68), controlPoint2: CGPoint(x: 54.47, y: 6.42))
    bezierPath.addCurve(to: CGPoint(x: 67.05, y: 0), controlPoint1: CGPoint(x: 61.6, y: 12.44), controlPoint2: CGPoint(x: 66.53, y: 8.33))
    bezierPath.addCurve(to: CGPoint(x: 67.47, y: 13.59), controlPoint1: CGPoint(x: 69.76, y: 3.58), controlPoint2: CGPoint(x: 70.85, y: 7.76))
    bezierPath.addCurve(to: CGPoint(x: 82.41, y: 6.1), controlPoint1: CGPoint(x: 74.33, y: 15.34), controlPoint2: CGPoint(x: 79.31, y: 12.84))
    bezierPath.addCurve(to: CGPoint(x: 81.19, y: 16.8), controlPoint1: CGPoint(x: 83.14, y: 9.47), controlPoint2: CGPoint(x: 82.96, y: 13))
    bezierPath.addCurve(to: CGPoint(x: 93.01, y: 16.05), controlPoint1: CGPoint(x: 85.52, y: 19.5), controlPoint2: CGPoint(x: 89.44, y: 18.88))
    bezierPath.addCurve(to: CGPoint(x: 87.11, y: 26.98), controlPoint1: CGPoint(x: 92.01, y: 20.28), controlPoint2: CGPoint(x: 90.18, y: 24.01))
    bezierPath.addCurve(to: CGPoint(x: 100, y: 37.88), controlPoint1: CGPoint(x: 95.27, y: 28.08), controlPoint2: CGPoint(x: 98.91, y: 32.15))
    bezierPath.addCurve(to: CGPoint(x: 91.18, y: 37.63), controlPoint1: CGPoint(x: 97.44, y: 36.62), controlPoint2: CGPoint(x: 94.5, y: 36.53))
    bezierPath.addCurve(to: CGPoint(x: 96.72, y: 63.06), controlPoint1: CGPoint(x: 96.75, y: 45.45), controlPoint2: CGPoint(x: 99.79, y: 53.87))
    bezierPath.addLine(to: CGPoint(x: 96.72, y: 63.07))
    bezierPath.close()
    bezierPath.move(to: CGPoint(x: 32.14, y: 37.61))
    bezierPath.addCurve(to: CGPoint(x: 30.77, y: 48.05), controlPoint1: CGPoint(x: 32.57, y: 41.99), controlPoint2: CGPoint(x: 28.12, y: 45.01))
    bezierPath.addCurve(to: CGPoint(x: 32.14, y: 37.61), controlPoint1: CGPoint(x: 33.92, y: 45.24), controlPoint2: CGPoint(x: 33.77, y: 41.61))
    bezierPath.close()
    bezierPath.usesEvenOddFillRule = true
    bezierPath.apply(CGAffineTransform(scaleX: (size.width/100), y: (size.height/100)))
    fillColor.setFill()
    bezierPath.fill()
  }
}
