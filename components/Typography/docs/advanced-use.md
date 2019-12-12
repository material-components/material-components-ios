### Custom Fonts
Material Components for iOS allows you to set your own font for all of the components. Use the class
method `setFontLoader:` on MDCTypography to specify a loader that conforms to the
`MDCTypographyFontLoading` protocol.

If you want to use the system font use `MDCSystemFontLoader` which already conforms to the
`MDCTypographyFontLoading` protocol. It is used if no font loader is set.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
class CustomFontLoader: NSObject, MDCTypographyFontLoading {
  func regularFont(ofSize fontSize: CGFloat) -> UIFont {
    // Consider using MDFFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomRegularFont", size: fontSize)!
  }
  func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
    // Consider using MDFFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomMediumFont", size: fontSize)!
  }
  func lightFont(ofSize fontSize: CGFloat) -> UIFont {
    // Consider using MDFFontDiskLoader to register your font.
    return UIFont.init(name: "yourCustomLightFont", size: fontSize)!
  }
}

...

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

  // Before any UI is called
  MDCTypography.setFontLoader(CustomFontLoader())

}
```

#### Objective-C

```objc
@interface CustomFontLoader : NSObject <MDCTypographyFontLoading>
@end

@implementation CustomFontLoader

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  // Consider using MDFFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomRegularFont" size:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  // Consider using MDFFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomMediumFont" size:fontSize];
}

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  // Consider using MDFFontDiskLoader to register your font.
  return [UIFont fontWithName:@"yourCustomLightFont" size:fontSize];
}

@end

...

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Before any UI is called
  [MDCTypography setFontLoader:[[CustomFontLoader alloc] init]];
}
```
<!--</div>-->
