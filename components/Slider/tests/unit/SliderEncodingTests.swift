/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

import XCTest
import MaterialComponents.MaterialSlider

class SliderEncodingTests : XCTestCase {

  func testSliderEncoding() {
    // Given
    let slider = MDCSlider()
    slider.color = .yellow
    slider.disabledColor = .green
    slider.trackBackgroundColor = .purple
    slider.thumbRadius = 42
    slider.thumbElevation = .dialog
    slider.numberOfDiscreteValues = 5
    slider.value = 3
    slider.minimumValue = 2
    slider.maximumValue = 7
    slider.isContinuous = false  // default is true
    slider.filledTrackAnchorValue = -30
    slider.shouldDisplayDiscreteValueLabel = false  // default is true
    slider.isThumbHollowAtStart = false  // default is true

    // When
    let data = NSKeyedArchiver.archivedData(withRootObject: slider)
    let unarchivedSlider = NSKeyedUnarchiver.unarchiveObject(with: data) as? MDCSlider

    // Then
    XCTAssertNotNil(unarchivedSlider)
    XCTAssertEqual(unarchivedSlider?.color, slider.color)
    XCTAssertEqual(unarchivedSlider?.disabledColor, slider.disabledColor)
    XCTAssertEqual(unarchivedSlider?.trackBackgroundColor, slider.trackBackgroundColor)
    XCTAssertEqual(unarchivedSlider?.thumbRadius, slider.thumbRadius)
    XCTAssertEqual(unarchivedSlider?.thumbElevation, slider.thumbElevation)
    XCTAssertEqual(unarchivedSlider?.numberOfDiscreteValues, slider.numberOfDiscreteValues)
    XCTAssertEqual(unarchivedSlider?.value, slider.value)
    XCTAssertEqual(unarchivedSlider?.minimumValue, slider.minimumValue)
    XCTAssertEqual(unarchivedSlider?.maximumValue, slider.maximumValue)
    XCTAssertEqual(unarchivedSlider?.isContinuous, slider.isContinuous)
    XCTAssertEqual(unarchivedSlider?.filledTrackAnchorValue, slider.filledTrackAnchorValue)
    XCTAssertEqual(unarchivedSlider?.shouldDisplayDiscreteValueLabel,
                   slider.shouldDisplayDiscreteValueLabel)
    XCTAssertEqual(unarchivedSlider?.isThumbHollowAtStart, slider.isThumbHollowAtStart)
  }
}
