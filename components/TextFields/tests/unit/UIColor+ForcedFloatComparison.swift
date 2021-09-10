// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

import UIKit

/*
 There is a bug in UIColor's implementation of `encodeWithCoder:` that causes it to be saved not
 with CGFloats for each RGB value but Floats. The loss of precision will break comparisons. See
 https://stackoverflow.com/questions/22338594/why-does-this-code-behave-differently-on-64-bit-builds-ios-uicolor-uikeyed
 */

/* Casts the RGB CGFloats to Float before comparison. */
extension UIColor {
  func isEqualAsFloats(_ other: UIColor?) -> Bool {
    var red1: CGFloat = 0.0
    var green1: CGFloat = 0.0
    var blue1: CGFloat = 0.0
    var alpha1: CGFloat = 0.0
    getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)

    var red2: CGFloat = 0.0
    var green2: CGFloat = 0.0
    var blue2: CGFloat = 0.0
    var alpha2: CGFloat = 0.0
    other?.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

    return Float(red1) == Float(red2) && Float(green1) == Float(green2)
      && Float(blue1) == Float(blue2) && Float(alpha1) == Float(alpha2)
  }
}
