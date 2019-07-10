### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/<#ComponentName#>'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To import the component:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.Material<#ComponentName#>
```

#### Objective-C

```objc
#import "Material<#ComponentName#>.h"
```

### Installation with Carthage

While it is not officially supported (yet) but there is a workaround with
the help of CocoaPods. Create a new sample project (lets call it
`TestApp`) and set it up with the following `Podfile`:

```ruby
platform :ios, "10.0"
use_frameworks!

target 'TestApp' do
  pod 'MaterialComponents'
end
```
```

You must add `use_frameworks!` but can also install specific
components rather than installing them all.

Run the app at least once then locate the project included
frameworks. These will be in the Xcode Derived Data directory, a quick
way to access them is by right clicking on the framework
name under `Products` in Xcode Project Navigator and click `Show in
Finder`.

If you install  all the components, the  following Material components
will be installed:

    - MaterialComponents.framework
    - MDFIntertionalization.framework
    - MDFTextAccessibility.framework
    - MotionAnimator.framework
    - MotionInterchange.framework
    - MotionTransitioning.framework

Copy all these frameworks to the Carthage build directory of your
**actual** project (e.g. `Carthage/Build/iOS/....`) and update the
input list to Carthage `copy-frameworks` build step (it is better to
use a tool like `carting` to perfrom this update).

Run your actual project and enjoy using Material Components.

<!--</div>-->
