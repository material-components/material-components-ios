# Bottom navigation

<!-- badges -->

Bottom navigation bars allow movement between primary destinations in an app. Tapping on a bottom
navigation icon takes you directly to the associated view or refreshes the currently active view.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/bottom-navigation.gif" alt="An animation showing a change of selection in a bottom navigation component." width="320">
</div>

<!-- design-and-api -->

<!-- toc -->

- - -

## Overview

MDCBottomNavigationBar can be added to a view hierarchy like any UIView. Material Design guidelines recommend always placing bottom navigation at the bottom of the screen.

MDCBottomNavigationBar works much like a UITabBar and both are populated with an array of UITabBarItems. However, MDCBottomNavigationBar is built with Material Design in mind and should be used with other Material Design components where possible to provide a consistent look and feel in an app. Additionally, while MDCBottomNavigationBar has similar features to MDCTabBar, MDCTabBar is chiefly intended for top navigation, whereas MDCBottomNavigationBar — as the name indicates — in intended for bottom navigation.

It is recommended that three to five items are used to populate the content of the bottom navigation bar. If there are fewer than three destinations, consider using tabs instead. If your top-level navigation has more than six destinations, provide access to destinations not covered in bottom navigation through alternative locations, such as a navigation drawer.

Title visibility can be configured in three ways: only show the title of the *selected* item, always show title regardless of any item's selection state, and never show title regardless of any item's selection state. The default behavior of bottom navigation is to only show the title for an item that is selected.

In landscape orientation, items can be configured to be justified or compactly clustered together. When items are justified the bottom navigation bar is fitted to the width of the device. Justified items can have their titles shown below their respective icons or adjacent to their respective icons.

### Guidance

Bottom navigation should be used for top-level destinations in an app of similar importance or destinations requiring direct access from anywhere in the app. 

Be cautious when combining bottom navigation with similar navigation placed at the bottom of the screen (e.g. a bottom tab bar), as the combination may cause confusion when navigating an app. For example, tapping across both bottom tabs and bottom navigation could display a mixture of different transitions across the same content.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)

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




