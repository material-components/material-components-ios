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
  let containerScheme: MDCContainerScheming

  var colorScheme: MDCColorScheming {
    return containerScheme.colorScheme
  }

  var typographyScheme: MDCTypographyScheming {
    return containerScheme.typographyScheme
  }

  init(containerScheme: MDCContainerScheming) {
    self.containerScheme = containerScheme
  }

  static var globalTheme = AppTheme(containerScheme: DefaultContainerScheme()) {
    didSet {
      NotificationCenter.default.post(name: AppTheme.didChangeGlobalThemeNotificationName,
                                      object: nil,
                                      userInfo: nil)
    }
  }

  static let didChangeGlobalThemeNotificationName =
    Notification.Name("MDCCatalogDidChangeGlobalTheme")
}

func DefaultContainerScheme() -> MDCContainerScheme {
  let containerScheme = MDCContainerScheme()

  let colorScheme = MDCSemanticColorScheme(defaults: .material201907)
  colorScheme.primaryColor =  primaryColor()
  colorScheme.primaryColorVariant = primaryColorVariant()
  colorScheme.secondaryColor = secondaryColor()
  containerScheme.colorScheme = colorScheme

  let typographyScheme = MDCTypographyScheme()
  typographyScheme.headline1 = UIFont.systemFont(ofSize: 20)
  typographyScheme.headline2 = UIFont.systemFont(ofSize: 18)
  typographyScheme.headline3 = UIFont.systemFont(ofSize: 15)
  containerScheme.typographyScheme = typographyScheme

  let shapeScheme = MDCShapeScheme()
  containerScheme.shapeScheme = shapeScheme

  return containerScheme
}

private func primaryColor() -> UIColor {
  if #available(iOS 13.0, *) {
    return UIColor(dynamicProvider: { (trait) -> UIColor in
      if (trait.userInterfaceStyle == .dark) {
        return UIColor(
          red: CGFloat(0xde) / 255.0,
          green: CGFloat(0xde) / 255.0,
          blue: CGFloat(0xde) / 255.0,
          alpha: 1)
      }
      return UIColor(
        red: CGFloat(0x21) / 255.0,
        green: CGFloat(0x21) / 255.0,
        blue: CGFloat(0x21) / 255.0,
        alpha: 1)
    })
  }
  return UIColor(
    red: CGFloat(0x21) / 255.0,
    green: CGFloat(0x21) / 255.0,
    blue: CGFloat(0x21) / 255.0,
    alpha: 1)
}

private func primaryColorVariant() -> UIColor {
  if #available(iOS 13.0, *) {
    return UIColor(dynamicProvider: { (trait) -> UIColor in
      if (trait.userInterfaceStyle == .dark) {
        return .init(white: 0.3, alpha: 1)
      }
      return .init(white: 0.7, alpha: 1)
    })
  }
  return .init(white: 0.7, alpha: 1)
}

private func secondaryColor() -> UIColor {
  if #available(iOS 13.0, *) {
    return UIColor(dynamicProvider: { (trait) -> UIColor in
      if (trait.userInterfaceStyle == .dark) {
        return UIColor(
          red: CGFloat(0xFF) / 255.0,
          green: CGFloat(0x19) / 255.0,
          blue: CGFloat(0x89) / 255.0,
          alpha: 1)
      }
      return  UIColor(
        red: CGFloat(0x00) / 255.0,
        green: CGFloat(0xE6) / 255.0,
        blue: CGFloat(0x76) / 255.0,
        alpha: 1)
    })
  }
  return UIColor(
    red: CGFloat(0x00) / 255.0,
    green: CGFloat(0xE6) / 255.0,
    blue: CGFloat(0x76) / 255.0,
    alpha: 1)
}
