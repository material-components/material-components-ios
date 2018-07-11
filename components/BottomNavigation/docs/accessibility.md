## Accessibility {#a11y}

To help ensure your bottom navigation item is accessible to as many users as possible, please
be sure to review the following recommendations:

### `-accessibilityLabel`
The label will be the title of the UITabBarItem. Currently you can't set this to a custom value.

### Set `-accessibilityValue` 

Set an appropriate
[`accessibilityValue`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619583-accessibilityvalue)
value if your item has a badge value. For example, an item with an inbox icon with a badge value for how many
emails are unread.

#### Objective-C
```objc
tabBarItem.accessibilityValue = @"10 unread emails";
```
#### Swift
```swift
tabBarItem.accessibilityValue = "10 unread emails"
```

### Minimum touch size

Make sure that your bottom navigation bar respects the minimum touch area. The Google Material spec calls for [touch areas that should be least 48 points high and 64 wide](https://material.io/design/layout/spacing-methods.html#touch-click-targets). 

##### Objective-C
```objc
CGSize size = [_bottomNavigationBar sizeThatFits:self.view.bounds.size];
CGRect bottomNavBarFrame = CGRectMake(0, 
CGRectGetHeight(self.view.bounds) - size.height,
size.width,
size.height);
_bottomNavigationBar.frame = bottomNavBarFrame;
```

##### Swift
```swift
let size = bottomNavBar.sizeThatFits(view.bounds.size)
let bottomNavBarFrame = CGRect(x: 0,
y: view.bounds.height - size.height,
width: size.width,
height: size.height)
bottomNavBar.frame = bottomNavBarFrame
```
As long as you use `sizeThatFits` you'll be fine. If you explicitly set the height the component will respond to that new height and may not respect the recommended touch area.
