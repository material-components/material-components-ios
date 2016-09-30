<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/OverlayWindow/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios/tree/develop/components/OverlayWindow">GitHub</a> for README documentation.{% endif %}-->

# Overlay Window

Provides a window which can have an arbitrary number of overlay views that will sit above the root
view of the window. Overlays will be the full size of the screen, and will be rotated as appropriate
based on device orientation. For performance, owners of overlay views should set the |hidden|
property to YES when the overlay is not in use.

Overlay Window is used by components such as Snackbar. Snackbar uses Overlay Window to ensure
displayed message views are always visible to the user by being at the top of the view hierarchy.

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/OverlayWindow'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Usage

### Importing

Before using the Overlay Window, you'll need to import it:

#### Objective-C

~~~ objc
#import "MaterialOverlayWindow.h"
~~~

#### Swift

~~~ swift
import MaterialComponents
~~~

## Examples

### Setting the Overlay Window

Using the Overlay Window requires that the App Delegate set the window as an Overlay Window or a
subclass of Overlay Window.

#### Objective-C

~~~ objc
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  ...
  self.window =
    [[MDCOverlayWindow alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
  ...
}
~~~

#### Swift

~~~ swift
func application(application: UIApplication, didFinishLaunchingWithOptions
               launchOptions: [NSObject: AnyObject]?) -> Bool {
  ...
  self.window = MDCOverlayWindow(frame: (UIApplication.sharedApplication().keyWindow?.bounds)!)
  ...
}
~~~

### Using the Overlay Window

Once the Overlay Window is set in the App Delegate, the client can use the Overlay Window to display
views at the top most level of the view hierarchy.

~~~ objc
UIView *overlayView = [UIView alloc] init];
...
// Set up view to be displayed in the overlay window.
...
if ([window isKindOfClass:[MDCOverlayWindow class]]) {
  MDCOverlayWindow *overlayWindow = (MDCOverlayWindow *)window;
  [overlayWindow activateOverlay:overlayView withLevel:UIWindowLevelNormal];
}
~~~

#### Swift

~~~ swift
let overlayView = UIView()
...
// Set up view to be displayed in the overlay window.
...
if (self.window?.isKindOfClass(UIWindow) != nil) {
  overlayWindow.activateOverlay(overlayView, level:UIWindowLevelNormal)
}
~~~
