# Feature Highlight

<!--{% if site.link_to_site == "true" %}-->
[![Feature Highlight](docs/assets/feature_highlight.jpg)](docs/assets/feature_highlight.mp4)
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/feature_highlight.mp4" autoplay loop></video></div>{% endif %}-->

The Feature Highlight component is a way to visually highlight a part of the screen in order to introduce users to new features and functionality.

### Material Design Specifications

<ul class="icon-list">
<li class="icon-link"><a href="https://material.google.com/growth-communications/feature-discovery.html">Feature Discovery</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/FeatureHighlight'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Usage

### Importing

Before using Feature Highlight, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
#import "MaterialFeatureHighlight.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~
<!--</div>-->

### Highlighting a view

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
MDCFeatureHighlightCompletion completion = ^(accepted) {
  // perform analytics here
  // and record whether the highlight was accepted
};

MDCFeatureHighlightViewController *highlightController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:highlightedView
                                                              completion:completion];
highlightController.titleText = @"Just how you want it";
highlightController.bodyText = @"Tap the menu button to switch accounts, change settings & more.";
highlightController.outerHighlightColor = 
    [[UIColor blueColor] colorWithAlphaComponent:kMDCFeatureHighlightBackgroundAlpha]
[self presentViewController:highlightController animated:YES completion:nil];
~~~

#### Swift
~~~ swift
let completion = {(accepted) in
  // perform analytics here
  // and record whether the highlight was accepted
}
let highlightController = MDCFeatureHighlightViewController.init(highlightedView: highlightedView
                                                                 completion: completion)
highlightController.titleText = "Just how you want it"
highlightController.bodyText = "Tap the menu button to switch accounts, change settings & more."
highlightController.outerHighlightColor = 
    UIColor.blue.withAlphaComponent(kMDCFeatureHighlightBackgroundAlpha)
self.present(viewController: highlightController, animated: true)
~~~
<!--</div>-->

Often when highlighting a view you will want to display a different view to the one you are highlighting. For example, flipping the primary and secondary colors in the presented version.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
UIButton *displayedButton = [UIButton buttonType:UIButtonTypeSystem];
[displayedButton setTitle:[highlightedButton titleForState:UIControlStateNormal] 
                 forState:UIControlStateNormal];
[displayedButton setTitleColor:highlightedButton.backgroundColor forState:UIControlStateNormal];
displayedButton.backgroundColor = [highlightedButton titleColorForState:UIControlStateNormal];
MDCFeatureHighlightViewController *highlightController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:highlightedButton
                                                             andShowView:displayedView
                                                              completion:completion];
~~~

~~~ swift
let displayedButton = UIButton(type: .system)
displayedButton.setTitle(highlightedButton.titleForState(.normal), for: .normal)
displayedButton.setTitleColor(highlightedButton.backgroundColor, for: .normal)
displayedButton.backgroundColor = highlightedButton.titleColorForState(.normal)

let highlightController = 
    MDCFeatureHighlightViewController.init(highlightedView: highlightedButton, 
                                           displayedView: displayedButton)
~~~
<!--</div>-->
