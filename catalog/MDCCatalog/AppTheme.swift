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

import Foundation
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialContainerScheme
import MaterialComponents.MaterialShapeScheme
import MaterialComponents.MaterialTypographyScheme

final class AppTheme {
  static var containerScheme: MDCContainerScheming = DefaultContainerScheme() {
    didSet {
      NotificationCenter.default.post(name: AppTheme.didChangeGlobalThemeNotificationName,
                                      object: nil,
                                      userInfo: nil)
    }
  }

  static let didChangeGlobalThemeNotificationName =
    Notification.Name("MDCCatalogDidChangeGlobalTheme")

  private init() {
    // An AppTheme is not intended to be created; use the static APIs instead.
  }
}

func DefaultContainerScheme() -> MDCContainerScheme {
  let containerScheme = MDCContainerScheme()

  containerScheme.colorScheme = MDCSemanticColorScheme(defaults: .material201907)
  containerScheme.typographyScheme = MDCTypographyScheme(defaults: .material201902)
  containerScheme.shapeScheme = MDCShapeScheme()

  return containerScheme
}
