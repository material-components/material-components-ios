<!--docs:
title: "Bottom App Bar"
layout: detail
section: components
excerpt: "Bottom app bar provides a bar at the bottom of the screen with primary action and navigation buttons."
icon_id: bottom_app_bar
path: /catalog/bottomappbar/
api_doc_root: true
-->

# Bottom App Bar

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/bottomappbar.png" alt="Text Fields" width="375">
</div>

## Extensions

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="docs/color-theming.md">Color Theming</a></li>
</ul>

- - -

A bottom app bar provides a docked bar at the bottom of the screen for common application actions. The bottom app bar includes a <a href="https://material.io/components/ios/catalog/buttons/api-docs/Classes/MDCFloatingButton.html">floating button</a> for a primary action and a <a href="https://material.io/components/ios/catalog/flexible-headers/navigation-bars/">navigation bar</a> area for secondary actions. Transition animations are provided when the floating button shifts left or right, based on the application navigation state, and when the floating action button changes elevation or is hidden.

## Installation

### Requirements

- Xcode 8.0 or higher.
- iOS SDK version 8.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/BottomAppBar'
~~~

Then run the following command:

~~~ bash
pod install
~~~

- - -

### Overview

Bottom app bars follow a recommended Material Design interaction design pattern for providing primary and secondary actions that are easily accessible. With a bottom app bar users are more easily able to use single-handed touch interaction with an application since actions are displayed close to the bottom of the screen within easy reach of a user's thumb.

The bottom app bar includes a <a href="https://material.io/components/ios/catalog/buttons/api-docs/Classes/MDCFloatingButton.html">floating action button</a> that is intended to provide users with a primary action. Secondary actions are available on a <a href="https://material.io/components/ios/catalog/flexible-headers/navigation-bars/">navigation bar</a> that can be customized with several buttons on the left and right sides of the navigation bar. The primary action floating action button is centered on the bottom app bar by default.

MDCBottomAppBarView should be attached to the bottom of the screen or used in conjunction with an expandable bottom drawer. The MDCBottomAppBarView API includes properties that allow changes to the elevation, position and visibility of the embedded floating action button.

UIBarButtonItems can be added to the navigation bar of the MDCBottomAppBarView. Leading and trailing navigation items will be shown and hidden based on the position of the floating action button.

Transitions between floating action button position, elevation and visibility states are animated by default, but can be disabled if desired.

## Usage

MDCBottomAppBarView can be added to a view hierarchy like any UIView. Material Design guidelines recommend always placing the bottom app bar at the bottom of the screen.

### Importing

Before using Bottom App Bar, you'll need to import it:

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

## Examples

### Bottom App Bar with floating action button and navigation

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bottomBarView = MDCBottomAppBarView(frame: frame)
view.addSubview(bottomBarView)

// Add touch handler to the floating button.
bottomBarView.floatingButton.addTarget(self,
                                       action: #selector(didTapFloatingButton(_:)),
                                       for: .touchUpInside)

// Set the image on the floating button.
let addImage = UIImage(named:"Add")
bottomBarView.floatingButton.setImage(addImage, for: .normal)

// Theme the floating button (optional).
let colorScheme = MDCBasicColorScheme(primaryColor: .white)
MDCButtonColorThemer.apply(colorScheme, to: bottomBarView.floatingButton)

// Configure the navigation buttons to be shown on the bottom app bar.
let barButtonLeadingItem = UIBarButtonItem()
let menuImage = UIImage(named:"Menu")
barButtonLeadingItem.image = menuImage

let barButtonTrailingItem = UIBarButtonItem()
let searchImage = UIImage(named:"Search")
barButtonTrailingItem.image = searchImage

bottomBarView.leadingBarButtonItems = [ barButtonLeadingItem ]
bottomBarView.trailingBarButtonItems = [ barButtonTrailingItem ]
```

#### Objective-C

```objc
MDCBottomAppBarView *bottomBarView = [[MDCBottomAppBarView alloc] initWithFrame:frame];
[view addSubview:bottomBarView];

// Add touch handler to the floating button.
[self.bottomBarView.floatingButton addTarget:self
                                      action:@selector(didTapFloatingButton:)
                            forControlEvents:UIControlEventTouchUpInside];

// Set the image on the floating button.
UIImage *addImage = [UIImage imageNamed:@"Add"];
[bottomBarView.floatingButton setImage:addImage forState:UIControlStateNormal];

// Theme the floating button (optional).
MDCBasicColorScheme *colorScheme =
    [[MDCBasicColorScheme alloc] initWithPrimaryColor:[UIColor whiteColor]];
[MDCButtonColorThemer applyColorScheme:colorScheme
                              toButton:self.bottomBarView.floatingButton];

// Configure the navigation buttons to be shown on the bottom app bar.
UIBarButtonItem *barButtonLeadingItem =
    [[UIBarButtonItem alloc] initWithTitle:nil
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(didTapMenu:)];
UIImage *menuImage = [UIImage imageNamed:@"Menu"];
[barButtonLeadingItem setImage:menuImage];

UIBarButtonItem *barButtonTrailingItem =
    [[UIBarButtonItem alloc] initWithTitle:nil
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(didTapSearch:)];
UIImage *searchImage = [UIImage imageNamed:@"Search"];
[barButtonTrailingItem setImage:searchImage];

[bottomBarView setLeadingBarButtonItems:@[ barButtonLeadingItem ]];
[bottomBarView setTrailingBarButtonItems:@[ barButtonTrailingItem ]];
```

<!--</div>-->

