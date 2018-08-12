<!--docs:
title: "Overlay window"
layout: detail
section: components
excerpt: "A window for managing sets of overlay views."
iconId: tooltip
path: /catalog/snackbars/overlay-window/
-->

# Overlay window

Provides a window which can have an arbitrary number of overlay views that will sit above the root
view of the window. Overlays will be the full size of the screen, and will be rotated as appropriate
based on device orientation. For performance, owners of overlay views should set the |hidden|
property to YES when the overlay is not in use.

Overlay Window is used by components such as Snackbar. Snackbar uses Overlay Window to ensure
displayed message views are always visible to the user by being at the top of the view hierarchy.

## Installation

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/OverlayWindow'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

- - -

## Usage

### Importing

Before using the Overlay Window, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialOverlayWindow
```

#### Objective-C

```objc
#import "MaterialOverlayWindow.h"
```
<!--</div>-->

## Examples

### Setting the Overlay Window

Using the Overlay Window requires that the App Delegate set the window as an Overlay Window or a
subclass of Overlay Window.


<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

  window = MDCOverlayWindow(frame: (application.keyWindow?.bounds)!)

}
```

#### Objective-C

```objc
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [[MDCOverlayWindow alloc] initWithFrame:application.keyWindow.bounds];

}
```
<!--</div>-->

### Using the Overlay Window

Once the Overlay Window is set in the App Delegate, the client can use the Overlay Window to display
views at the top most level of the view hierarchy.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Set up view to be displayed in the overlay window.
let myOverlayView = UIView()
...

// When you're ready to show the overlay, activate it
if let overlayWindow = window as? MDCOverlayWindow {
  overlayWindow.activateOverlay(myOverlayView, withLevel:UIWindowLevelNormal)
}
```

#### Objective-C

```objc
// Set up view to be displayed in the overlay window.
UIView *overlayView = [[UIView alloc] init];
...

// When you're ready to show the overlay, activate it
if ([self.window isKindOfClass:[MDCOverlayWindow class]]) {
  MDCOverlayWindow *overlayWindow = (MDCOverlayWindow *)self.window;
  [overlayWindow activateOverlay:overlayView withLevel:UIWindowLevelNormal];
}
```
<!--</div>-->

- - -

## Related Components

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--components"><a href="../Snackbar">Snackbars</a></li>
</ul>
