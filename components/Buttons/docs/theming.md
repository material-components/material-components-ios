## Theming

You can theme an MDCButton to match one of the Material Design button styles using your app's
schemes in the button theming extension.

You must first import the extension and create an `MDCContainerScheme` instance. A container scheme defines
the design parameters that you can use to theme your app. For additional information on [`MDCContainerScheme`](<#Inset-link-to-theming-doc>).

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the container scheme
import MaterialComponentsBeta.MaterialConainerScheme

// Step 2: Create or get a container scheme
let containerScheme = MDCContainerScheme()

// Step 3: Apply the container scheme to your button using the desired button style
```

#### Objective-C

```objc
// Step 1: Import the Container scheme
#import <MaterialComponentsBeta/MaterialContainerScheme.h>

// Step 2: Create or get a button scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Step 3: Apply the container scheme to your button using the desired button style
```
<!--</div>-->

### Theming an MDCButton

#### Create a button

First you will need to create a button. Additionally for theming you will need to import the theming extension.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import Material Buttons
import MaterialComponents.MaterialButtons
import MaterialComponentsBeta.MaterialButtons_Theming

// Step 2: Create a button
let button = MDCButton()
```

#### Objective-C

```objc
// Step 1: Import Material Buttons 
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponentsBeta/MaterialButtons+Theming.h>

// Step 2: Create a button
MDCButton *button = [[MDCButton alloc] init];
```
<!--</div>-->

#### Text buttons

<img src="assets/text.gif" alt="An animation showing a Material Design text button." width="128">

To theme a button as a Material Design text button.

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

<img src="assets/outlined.gif" alt="An animation showing a Material Design outlined button." width="115">

To theme a button as a Material Design outlined button.

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

<img src="assets/contained.gif" alt="An animation showing a Material Design contained button." width="128">

To theme a button as a Material Design contained button.

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

### Theming an MDCFloatingButton

#### Create a button

First you will need to create a button. Additionally for theming you will need to import the theming extension.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import Material Buttons
import MaterialComponents.MaterialButtons
import MaterialComponentsBeta.MaterialButtons_Theming

// Step 2: Create a button
let floatingButton = MDCFloatingButton()
```

#### Objective-C

```objc
// Step 1: Import Material Buttons 
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponentsBeta/MaterialButtons+Theming.h>

// Step 2: Create a button
MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
```
<!--</div>-->

<img src="assets/fab.gif" alt="An animation showing a Material Design floating action button." width="99">

To theme a button as a Material Design floating action button.

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
