<!--docs:
title: "App bars: bottom"
layout: detail
section: components
excerpt: "A bottom app bar displays navigation and key actions at the bottom of mobile screens."
iconId: bottom_app_bar
path: /catalog/bottomappbar/
api_doc_root: true
-->

# App bars: bottom

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BBottomAppBar%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BBottomAppBar%5D)

[Bottom app bars](https://material.io/components/app-bars-bottom/) display navigation and key actions at the bottom of the screen.

![Bottom app bar hero](docs/assets/bottom-app-bar-hero.png)

**Contents**

* [Using bottom app bars](#using-bottom-app-bars)
* [Bottom app bar](#bottom-app-bar)
* [Theming](#theming)

- - -

## Using bottom app bars

### Installing

In order to use `MDCBottomAppBarView`, first add the component to your `Podfile`:

```bash
pod MaterialComponents/BottomAppBar
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the installer:

```bash
pod install
```

After that, import the relevant target or file.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialBottomAppBar
```

#### Objective-C
```objc
#import "MaterialBottomAppBar.h"
```
<!--</div>-->

From there, initialize an `MDCBottomAppBarView` like you would any `UIView`.

### Making bottom app bars accessible

The following recommendations will ensure that the bottom app bar is accessible to as many users as possible:

### Set `-accessibilityLabel`

Set an appropriate
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel)
to all buttons within the bottom app bar.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
bottomAppBar.floatingButton.accessibilityLabel = "Compose"
let trailingButton = UIBarButtonItem()
trailingButton.accessibilityLabel = "Buy"
bottomAppBar.trailingBarButtonItems = [ trailingButton ]
```

#### Objective-C

```objc
bottomAppBar.floatingButton.accessibilityLabel = @"Compose";
UIBarButtonItem *trailingButton = 
    [[UIBarButtonItem alloc] initWithTitle:nil
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(didTapTrailing:)];
trailingButton.accessibilityLabel = @"Buy";
[bottomAppBar setTrailingBarButtonItems:@[ trailingButton ]];
```
<!--</div>-->

### Set `-accessibilityHint`

Set an appropriate
[`accessibilityHint`](https://developer.apple.com/documentation/objectivec/nsobject/1615093-accessibilityhint)
to all buttons within the bottom app bar.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
bottomAppBar.floatingButton.accessibilityHint = "Create new email"
let trailingButton = UIBarButtonItem()
trailingButton.accessibilityHint = "Purchase the item"
bottomAppBar.trailingBarButtonItems = [ trailingButton ]
```

#### Objective-C

```objc
bottomAppBar.floatingButton.accessibilityHint = @"Create new email";
UIBarButtonItem *trailingButton = 
    [[UIBarButtonItem alloc] initWithTitle:nil
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(didTapTrailing:)];
trailingButton.accessibilityHint = @"Purchase the item";
[bottomAppBar setTrailingBarButtonItems:@[ trailingButton ]];
```
<!--</div>-->

## Bottom app bar

Bottom app bars group primary and secondary actions at the bottom of the screen, where they are easily reachable by the user's thumb.

### Bottom app bar example

Use the `UIView` subclass `MDCBottomAppBarView` to add a bottom app bar to your app. `MDCBottomAppBarView` contains a horizontally centered [floating action button](https://material.io/develop/ios/components/fabs/) for primary actions and a customizable [navigation bar](https://material.io/components/ios/catalog/navigation-bar) for secondary actions. The `MDCBottomAppBarView` API includes properties that allow changes in elevation, position, and visibility of the embedded floating action button.

Instances of `UIBarButtonItem` can be added to a `MDCBottomAppBarView`'s navigation bar. Leading and trailing navigation items will be shown and hidden based on the position of the floating action button.

Transitions involving floating action button position, elevation, and visibility are animated by default, but animation can be disabled if desired.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bottomAppBar = MDCBottomAppBarView()
addSubview(bottomAppBar)
view.leftAnchor.constraint(equalTo: bottomAppBarView.leftAnchor).isActive = true
view.rightAnchor.constraint(equalTo: bottomAppBarView.rightAnchor).isActive = true
view.bottomAnchor.constraint(equalTo: bottomAppBarView.bottomAnchor).isActive = true
```

#### Objective-C

```objc
MDCBottomAppBarView *bottomAppBar = [[MDCBottomAppBarView alloc] init];
[self addSubview:bottomAppBar];
[self.view.leftAnchor constraintEqualToAnchor:bottomAppBarView.leftAnchor].active = YES;
[self.view.rightAnchor constraintEqualToAnchor:bottomAppBarView.rightAnchor].active = YES;
[self.view.bottomAnchor constraintEqualToAnchor:self.textField.bottomAnchor].active = YES;
```

<!--</div>-->

### Bottom app bar anatomy

A bottom app bar has a container and an optional navigation icon, anchored
floating action button (FAB), action item(s) and an overflow menu.

![Bottom app bar anatomy diagram](docs/assets/bottom-app-bar-anatomy.png)

1.  Container
2.  Navigation icon (optional)
3.  Floating action button (FAB) (optional)
4.  Action item(s) (optional)
5.  Overflow menu (optional)

### Container attributes

&nbsp;        | Attribute            | Related method(s)                          | Default value
------------- | -------------------- | ------------------------------------------ | -------------
**Color**     | `barTintColor`       | `-setBarTintColor:` <br> `-barTintColor`   | White
**Elevation** | `elevation`         | `-setElevation:` <br> `-elevation`          | 8

### Navigation icon attributes

&nbsp;    | Attribute            | Related method(s)                          | Default value
--------- | -------------------- | ------------------------------------------ | -------------
**Icon**  | `leadingBarButtonItems` <br> `trailingBarButtonItems` | `-setLeadingBarButtonItems:` <br> `-leadingBarButtonItems` <br> `-setTrailingBarButtonItems:` <br> `-trailingBarButtonItems` | `nil`

### FAB attributes

&nbsp;                           | Attribute                          | Related method(s)                                                      | Default value
-------------------------------- | ---------------------------------- | ---------------------------------------------------------------------- | -------------
**Alignment mode**               | `floatingButtonPosition`           | `-setFloatingButtonPosition:` <br> `-floatingButtonPosition`           | `.center`
**Elevation**                    | `floatingButtonElevation`          | `-setFloatingButtonElevation:` <br> `-floatingButtonElevation`           | 0

## Theming

`MDCBottomAppBarView` does not currently have a Material Design theming extension or otherwise support theming. Please indicate interest in adding theming support by commenting on [issue #7172](https://github.com/material-components/material-components-ios/issues/7172).
