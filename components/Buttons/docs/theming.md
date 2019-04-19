### Theming extensions

You can theme an MDCButton to match one of the Material Design button styles using button theming
extensions. The content below assumes that you have read the article on
[Theming](../../docs/theming.md).

### How to theme an MDCButton

First, create a button and import the theming extension header for Buttons.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

let button = MDCButton()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponentsBeta/MaterialButtons+Theming.h>

MDCButton *button = [[MDCButton alloc] init];
```
<!--</div>-->

You can then provide a container scheme instance to any of the MDCButton theming extensions.

#### Text buttons

[Learn more about text buttons](https://material.io/design/components/buttons.html#text-button).

<img src="assets/text.gif" alt="An animation showing a Material Design text button." width="128">

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
button.applyTextTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.button applyTextThemeWithScheme:self.containerScheme];
```
<!--</div>-->

#### Outlined buttons

[Learn more about outlined buttons](https://material.io/design/components/buttons.html#outlined-button).

<img src="assets/outlined.gif" alt="An animation showing a Material Design outlined button." width="115">

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
button.applyOutlinedTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.button applyOutlinedThemeWithScheme:self.containerScheme];
```
<!--</div>-->

#### Contained buttons

[Learn more about contained buttons](https://material.io/design/components/buttons.html#contained-button).

<img src="assets/contained.gif" alt="An animation showing a Material Design contained button." width="128">

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
button.applyContainedTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.button applyContainedThemeWithScheme:self.containerScheme];
```
<!--</div>-->

### How to theme an MDCFloatingButton

First, create a button and import the theming extension header for Buttons.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialButtons
import MaterialComponentsBeta.MaterialButtons_Theming

let floatingButton = MDCFloatingButton()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponentsBeta/MaterialButtons+Theming.h>

MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
```
<!--</div>-->

[Learn more about floating action buttons](https://material.io/design/components/buttons-floating-action-button.html).

<img src="assets/fab.gif" alt="An animation showing a Material Design floating action button." width="99">

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
floatingButton.applySecondaryTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.floatingButton applySecondaryThemeWithScheme: self.containerScheme];
```
<!--</div>-->

### Legacy APIs: how to theme a button using a themer

The following documentation refers to legacy theming APIs that will be deprecated and deleted in the
future.

You can theme an MDCButton to match one of the Material Design button styles using your app's
schemes in the ButtonThemer extension.

You must first add the ButtonThemer extension to your project:

```bash
pod 'MaterialComponents/Buttons+ButtonThemer'
```

You can then import the extension and create an `MDCButtonScheme` instance. A button scheme defines
the design parameters that you can use to theme your buttons.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ButtonThemer extension
import MaterialComponents.MaterialButtons_ButtonThemer

// Step 2: Create or get a button scheme
let buttonScheme = MDCButtonScheme()

// Step 3: Apply the button scheme to your component using the desired button style
```

#### Objective-C

```objc
// Step 1: Import the ButtonThemer extension
#import "MaterialButtons+ButtonThemer.h"

// Step 2: Create or get a button scheme
MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];

// Step 3: Apply the button scheme to your component using the desired button style
```
<!--</div>-->

#### Text buttons

<img src="assets/text.gif" alt="An animation showing a Material Design text button." width="128">

To theme a button as a Material Design text button, use `MDCTextButtonThemer`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
MDCTextButtonThemer.applyScheme(buttonScheme, to: button)
```

#### Objective-C

```objc
[MDCTextButtonThemer applyScheme:buttonScheme toButton:button];
```
<!--</div>-->

#### Outlined buttons

<img src="assets/outlined.gif" alt="An animation showing a Material Design outlined button." width="115">

To theme a button as a Material Design outlined button, use `MDCOutlinedButtonThemer`
with an `MDCButton`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
MDCOutlinedButtonThemer.applyScheme(buttonScheme, to: button)
```

#### Objective-C

```objc
[MDCOutlinedButtonThemer applyScheme:buttonScheme toButton:button];
```
<!--</div>-->

#### Contained buttons

<img src="assets/contained.gif" alt="An animation showing a Material Design contained button." width="128">

To theme a button as a Material Design contained button, use `MDCContainedButtonThemer`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)
```

#### Objective-C

```objc
[MDCContainedButtonThemer applyScheme:buttonScheme toButton:button];
```
<!--</div>-->

#### Floating action buttons

<img src="assets/fab.gif" alt="An animation showing a Material Design floating action button." width="99">

To theme a button as a Material Design floating action button, use `MDCFloatingActionButtonThemer`
with an `MDCFloatingButton`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
MDCFloatingActionButtonThemer.applyScheme(buttonScheme, to: button)
```

#### Objective-C

```objc
[MDCFloatingActionButtonThemer applyScheme:buttonScheme toButton:button];
```
<!--</div>-->
