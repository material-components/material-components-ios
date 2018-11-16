### Typical use: customizing a color scheme

You'll typically want to create one default `MDCSemanticColorScheme` instance for your app where all
of the color properties are set to your desired brand or style.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let colorScheme = MDCSemanticColorScheme()
colorScheme.primaryColor = UIColor(red: CGFloat(0x21) / 255.0,
                                   green: CGFloat(0x21) / 255.0,
                                   blue: CGFloat(0x21) / 255.0,
                                   alpha: 1)
colorScheme.primaryColorVariant = UIColor(red: CGFloat(0x44) / 255.0,
                                   green: CGFloat(0x44) / 255.0,
                                   blue: CGFloat(0x44) / 255.0,
                                   alpha: 1)

// In this case we don't intend to use a secondary color, so we make it match our primary color
colorScheme.secondaryColor = colorScheme.primaryColor
```

#### Objective-C

```objc
// A helper method for creating colors from hex values.
static UIColor *ColorFromRGB(uint32_t colorValue) {
  return [[UIColor alloc] initWithRed:(CGFloat)(((colorValue >> 16) & 0xFF) / 255.0)
                                green:(CGFloat)(((colorValue >> 8) & 0xFF) / 255.0)
                                 blue:(CGFloat)((colorValue & 0xFF) / 255.0) alpha:1];
}

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
colorScheme.primaryColor = ColorFromRGB(0x212121);
colorScheme.primaryColorVariant = ColorFromRGB(0x444444);

// In this case we don't intend to use a secondary color, so we make it match our primary color
colorScheme.secondaryColor = colorScheme.primaryColor;
```
<!--</div>-->
