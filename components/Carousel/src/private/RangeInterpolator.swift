// Copyright 2023-present the Material Components for iOS authors. All Rights Reserved.
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

struct RangeInterpolator {
  private let from: [Double]
  private let to: [Double]

  init(from: [Double], to: [Double]) {
    self.from = from
    self.to = to
  }

  /// Returns the interpolated value of the value passed in.
  ///
  /// - Parameter value: The value we want to interpolate.
  /// - Returns: The interpolated value based on provided ranges.
  func map(value: Double) -> Double? {
    if let (x1, x2, y1, y2) = pickRange(value: value) {
      return y1 + (value - x1) * (y2 - y1) / (x2 - x1)
    }
    return nil
  }

  /// Returns a tuple that gives 2 ranges: a range that contains the value passed in and the
  /// corresponding range we want to run the interpolator on.
  ///
  /// - Parameter value: The value we want to find the interpolator range for.
  /// - Returns: an optional tuple that returns 2 ranges: the range of the provided value and the
  ///   range the interpolator will use.
  private func pickRange(value: Double) -> (Double, Double, Double, Double)? {
    for i in 0..<(from.count - 1) {
      if from[i] <= value && value <= from[i + 1] {
        return (from[i], from[i + 1], to[i], to[i + 1])
      }
    }
    return nil
  }
}
