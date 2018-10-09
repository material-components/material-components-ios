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
import MaterialComponents.MaterialTypographyScheme

final class AppTheme {
  let colorScheme: MDCColorScheming
  let typographyScheme: MDCTypographyScheming
  let buttonScheme: MDCButtonScheming

  init(colorScheme: MDCColorScheming, typographyScheme: MDCTypographyScheming) {
    self.colorScheme = colorScheme
    self.typographyScheme = typographyScheme
    let buttonScheme = MDCButtonScheme()
    buttonScheme.colorScheme = colorScheme
    buttonScheme.typographyScheme = typographyScheme
    self.buttonScheme = buttonScheme
  }

  static let defaultTheme: AppTheme = {
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor =  UIColor(red: CGFloat(0x21) / 255.0,
                                        green: CGFloat(0x21) / 255.0,
                                        blue: CGFloat(0x21) / 255.0,
                                        alpha: 1)
    colorScheme.primaryColorVariant = .init(white: 0.7, alpha: 1)
    colorScheme.secondaryColor = UIColor(red: CGFloat(0x00) / 255.0,
                                         green: CGFloat(0xE6) / 255.0,
                                         blue: CGFloat(0x76) / 255.0,
                                         alpha: 1)
    let typographyScheme = MDCTypographyScheme()
    typographyScheme.headline1 = UIFont.systemFont(ofSize: 20)
    typographyScheme.headline2 = UIFont.systemFont(ofSize: 18)
    typographyScheme.headline3 = UIFont.systemFont(ofSize: 15)
    return AppTheme(colorScheme: colorScheme, typographyScheme: typographyScheme)
  }()

  static var globalTheme: AppTheme = defaultTheme {
    didSet {
      NotificationCenter.default.post(name: AppTheme.didChangeGlobalThemeNotificationName,
                                      object: nil,
                                      userInfo:
        [AppTheme.globalThemeNotificationColorSchemeKey: AppTheme.globalTheme.colorScheme,
         AppTheme.globalThemeNotificationTypographySchemeKey: AppTheme.globalTheme.typographyScheme]
      )
    }
  }

  static let didChangeGlobalThemeNotificationName =
    Notification.Name("MDCCatalogDidChangeGlobalTheme")
  static let globalThemeNotificationColorSchemeKey = "colorScheme"
  static let globalThemeNotificationTypographySchemeKey = "typographyScheme"
}
