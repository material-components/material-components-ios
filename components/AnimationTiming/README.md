<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/AnimationTiming/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios/tree/develop/components/AnimationTiming">GitHub</a> for README documentation.{% endif %}-->

# Animation Timing

Animation timing easing curves create smooth and consistent motion. Easing curves allow elements to
move between positions or states. These easing curves affect an object's speed, opacity, and scale.
These animation curves allow acceleration and deceleration changes to be smooth across the duration
of an animation so that movement doesn't appear mechanical.

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/AnimationTiming'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Usage

### Importing

Before using animation timing, you'll need to import it:

#### Objective-C

~~~ objc
#import "MaterialAnimationTiming.h"
~~~

#### Swift

~~~ swift
import MaterialComponents
~~~

## Examples

### Using Animation Timing

To use an animation timing curve select an appropriate a predefined MDCAnimationTimingFunction enum
value. Use this value to look up an animation curve's timing function. The timing function can then
be used in an animation.

~~~ objc
MDCAnimationTimingFunction materialCurve = MDCAnimationTimingFunctionEaseOut;
CAAnimationTimingFunction *timingFunction =
    [CAAnimationTimingFunction mdc_functionWithAnimationTiming:materialCurve];

CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
animation.timingFunction = timingFunction
~~~

#### Swift

~~~ swift
let materialCurve = MDCAnimationTimingFunction.EaseOut
let timingFunction = CAAnimationTimingFunction.mdc_functionWithAnimationTiming(materialCurve)

let animation = CABasicAnimation(keyPath:"transform.translation.x")
animation.timingFunction = timingFunction
~~~
