# Activity Indicator

<!--{% if site.link_to_site == "true" %}-->
[![Activity Indicator](docs/assets/activity_indicator.png)](docs/assets/activity_indicator.mp4)
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/activity_indicator.mp4" autoplay loop></video></div>{% endif %}-->

Activity indicators are visual indications of an app loading content. The Activity Indicator is a circular indicator that either rotates clockwise or fills to completion clockwise when displaying progress.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://material.google.com/components/progress-activity.html">Progress & activity</a></li>
</ul>

### API Documentation

<ul class="icon-list">
<li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/ActivityIndicator/apidocs/Classes/MDCActivityIndicator.html>MDCActivityIndicator</a></li>
<li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/ActivityIndicator/apidocs/Enums/MDCActivityIndicatorMode.html">MDCActivityIndicatorMode</a></li>
<li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/ActivityIndicator/apidocs/Protocols/MDCActivityIndicatorDelegate.html">MDCActivityIndicatorDelegate</a></li>
</ul>

- - -

## Activity Indicator Modes

### Indeterminate indicators
When indicators are indeterminate they request that the user wait while something finishes when it's not necessary to indicate how long it will take.

### Determinate indicators
When indicators are determinate they indicate how long an operation will take when the percentage complete is detectable.

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/ActivityIndicator'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Overview

Progress and activity indicators are visual indications of an app loading content.

- - -

## Usage

### Importing

Before using Activity Indicator, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialActivityIndicator.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

### Indeterminate indicators
Indeterminate indicators visualize an unspecified wait time.

### Determinate indicators
Determinate indicators display how long an operation will take.

- - -


## Examples


### Indeterminate indicators
When indicators are indeterminate they request that the user wait while something finishes when it's not necessary to indicate how long it will take. This is the default mode and no additional parameters need to be set.

#### Objective-C

~~~ objc
MDCActivityIndicator *activityIndicator =
    [[MDCActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
[view addSubview:activityIndicator];

// Start animation
[activityIndicator startAnimating];
...
// Stop animation
[activityIndicator stopAnimating];
~~~

#### Swift
~~~ swift
let activityIndicator = MDCActivityIndicator(frame: CGRectMake(0, 0, 32, 32))
view.addSubview(activityIndicator)

// Start animation
activityIndicator.startAnimating()
...
// Stop animation
activityIndicator.stopAnimating()
~~~

### Determinate indicators
When indicators are determinate they indicate how long an operation will take when the percentage complete is detectable. The indicator mode must be set to determinate and a progress amount must be provided as a float in the range [0,1].

#### Objective-C

~~~ objc
MDCActivityIndicator *activityIndicator =
    [[MDCActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
activityIndicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
activityIndicator.progress = 0.5;
[view addSubview:activityIndicator];

// Start animation
[activityIndicator startAnimating];
...
// Stop animation
[activityIndicator stopAnimating];
~~~

#### Swift
~~~ swift
let activityIndicator = MDCActivityIndicator(frame: CGRectMake(0, 0, 32, 32))
activityIndicator.indicatorMode = .ModeDeterminate
activityIndicator.progress = 0.5
view.addSubview(activityIndicator)

// Start animation
activityIndicator.startAnimating()
...
// Stop animation
activityIndicator.stopAnimating()
~~~
