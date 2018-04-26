<!--docs:
title: "Activity Indicators"
layout: detail
section: components
excerpt: "Progress and activity indicators are visual indications of an app loading content."
iconId: progress_activity
path: /catalog/progress-indicators/activity-indicators/
api_doc_root: true
-->

# Activity Indicators

<div class="article__asset article__asset--screenshot" style="align:center">
  <img src="docs/assets/activityindicator.gif" alt="Activity Indicator" width="127">
</div>

Material Design progress indicators display the length of a process or express an unspecified wait
time. On iOS, progress indicators are implemented as Activity Indicators, which are circular, and
Progress Views, which are linear.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/components/progress-activity.html">Material Design guidelines: Progress & activity</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/progress-indicators/activity-indicators/api-docs/Classes/MDCActivityIndicator.html">API: MDCActivityIndicator</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/progress-indicators/activity-indicators/api-docs/Enums/MDCActivityIndicatorMode.html">API: MDCActivityIndicatorMode</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/progress-indicators/activity-indicators/api-docs/Protocols/MDCActivityIndicatorDelegate.html">API: MDCActivityIndicatorDelegate</a></li>
</ul>

## Related Components

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--components"><a href="../ProgressView">Progress Views</a></li>
</ul>

- - -

## Installation

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

``` bash
pod 'MaterialComponents/ActivityIndicator'
```
<!--{: .code-renderer.code-renderer--install }-->

To add this component along with its themer and other related extensions, please add the following instead:
``` bash
pod 'MaterialComponents/ActivityIndicator+Extensions'
```

Then, run the following command:

``` bash
pod install
```

### Importing

To import the component:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialActivityIndicator
```

#### Objective-C

``` objc
#import "MaterialActivityIndicator.h"
```
<!--</div>-->

- - -

## Overview

`MDCActivityIndicator` is a view that has two modes: indeterminate and determinate. Indeterminate
indicators express an unspecified wait time, while determinate indicators represent the length of a
process. Activity indicators are indeterminate by default.

### Typical use: Indeterminate

MDCActivityIndicator instances are indeterminate by default.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let activityIndicator = MDCActivityIndicator()
activityIndicator.sizeToFit()
view.addSubview(activityIndicator)

// Start animation
activityIndicator.startAnimating()

// Stop animation
activityIndicator.stopAnimating()
```

#### Objective-C

``` objc
MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
[activityIndicator sizeToFit];
[view addSubview:activityIndicator];

// Start animation
[activityIndicator startAnimating];

// Stop animation
[activityIndicator stopAnimating];
```
<!--</div>-->


### Typical use: Determinate

MDCActivityIndicator instances can be shown as determinate by modifying the `indicatorMode`
property and setting a percentage progress with `progress`. `progress` must be set to a floating
point number between 0 and 1. Values beyond this range will be capped within the range.

Note: Activity indicators are hidden unless they are animating, even if the indicator is determinate
progress.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let activityIndicator = MDCActivityIndicator()
activityIndicator.sizeToFit()
activityIndicator.indicatorMode = .determinate
activityIndicator.progress = 0.5
view.addSubview(activityIndicator)

// Show the indicator
activityIndicator.startAnimating()

// Hide the indicator
activityIndicator.stopAnimating()
```

#### Objective-C

``` objc
MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
[activityIndicator sizeToFit];
activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
activityIndicator.progress = 0.5;
[view addSubview:activityIndicator];

// Show the indicator
[activityIndicator startAnimating];

// Hide the indicator
[activityIndicator stopAnimating];
```
<!--</div>-->

### How to theme an activity indicator

MDCActivityIndicatorColorThemer allows you to theme an activity indicator with your app's color
scheme. This themer will apply your color scheme's primary color to the activity indicator.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let colorScheme: MDCSemanticColorScheme()

let activityIndicator = MDCActivityIndicator()
MDCActivityIndicatorColorThemer.apply(colorScheme, to: activityIndicator)
```

#### Objective-C

``` objc
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
[MDCActivityIndicatorColorThemer applySemanticColorScheme:colorScheme
                                      toActivityIndicator:activityIndicator1];
```
<!--</div>-->

### How to set multiple indeterminate colors

Indeterminate activity indicators support showing multiple colors via the `cycleColors` API.
Consider using this property if your brand consists of more than one primary color.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
let activityIndicator = MDCActivityIndicator()
activityIndicator.cycleColors = [.blue, .red, .green, .yellow]
```

#### Objective-C

``` objc
MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
activityIndicator.cycleColors =  @[ [UIColor blueColor],
                                    [UIColor redColor],
                                    [UIColor greenColor],
                                    [UIColor yellowColor] ];
```
<!--</div>-->
