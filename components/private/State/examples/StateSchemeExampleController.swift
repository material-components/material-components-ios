// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

class StateSchemeExampleController: UIViewController {

  let colorScheme = StateExampleColorScheme(withDefaults: .material201804)
  let stateScheme = StateScheme(withDefaults: .material201804)

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = colorScheme.backgroundColor

    experimentWithSchemeAPI()
  }

  /*
   The following retrieves the overlay and content colors for the normal state in the on-white theme.

   The console output after running this example is:

   State Example> overlayColorResource for state: [enabled] is: [ nil ]. It should be: [nil]

   State Example> contentColorResource for state: [disabled] is: [palette: grey tint: tint800 opacity: 0.38]
   State Example> It should be: [MDCPalette.grey.tint800 at 38%]. Is it ? true

   State Example> ContentColorResource for state: [pressed] is: [palette: grey tint: tint900]
   State Example> It is overriden by the current color scheme and should therefore be: [MDCPalette.grey.tint900]. Is it ? true

   State Example> contentColorResource for state: [enabled] is: [ semantic: onSurface (on-surface) ]
   State Example> It should be the semantic color: [onSurface]. Is it ? true

   Note: There is no UI for this example.

   */
  func experimentWithSchemeAPI() {

    let enabled = MDCControlState.normal
    let disabled = MDCControlState.disabled
    let pressed = MDCControlState.highlighted

    let overlayResource = stateScheme.overlayColorResource(forState: enabled, forTheme: StateTheme.onWhite)
    print("State Example> overlayColorResource for state: [\(enabled)] is: [", overlayResource ?? "nil", "]. It should be: [nil]")

    if let disabledResource = stateScheme.contentColorResource(forState: disabled, forTheme: StateTheme.onWhite) {
      print("State Example> contentColorResource for state: [\(disabled)] is: [\(disabledResource)]")
      let disabledColor = colorScheme.realColor(colorResource: disabledResource)
      print("State Example> It should be: [MDCPalette.grey.tint800 at 38%]. Is it ?", disabledColor == MDCPalette.grey.tint800.withAlphaComponent(0.38))
    } else {
      print("State Example> Error: disabledResource should not be nil")
    }

    if let pressedResource = stateScheme.contentColorResource(forState: pressed, forTheme: StateTheme.onWhite) {
      print("State Example> ContentColorResource for state: [\(pressed)] is: [\(pressedResource)]")
      let pressedColor = colorScheme.realColor(colorResource: pressedResource)
      print("State Example> It is overriden by the current color scheme and should therefore be: [MDCPalette.grey.tint900]. Is it ?", pressedColor == MDCPalette.grey.tint900)
    } else {
      print("State Example> Error: pressedColor should not be nil")
    }

    if let contentResource = stateScheme.contentColorResource(forState: enabled, forTheme: StateTheme.onWhite) {
      print("State Example> contentColorResource for state: [\(enabled)] is: [", contentResource, "]")

      let contentColor = colorScheme.realColor(colorResource: contentResource)
      print("State Example> It should be the semantic color: [onSurface]. Is it ?", contentColor == colorScheme.onSurfaceColor)
    } else {
      print("State Example> Error: contentColor should not be nil")
    }
  }
}

// MARK: Catalog by convention

extension StateSchemeExampleController {
  class func catalogMetadata() -> [String: Any] {
    return [
      "breadcrumbs": ["Alpha: States", "States Prototype"],
      "primaryDemo": false,
      "presentable": false,
    ]
  }
}
