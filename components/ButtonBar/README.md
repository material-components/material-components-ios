# Button Bar

<!--{% if site.link_to_site == "true" %}-->
[![Button Bar](docs/assets/button_bar.png)](docs/assets/button_bar.mp4)
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/button_bar.mp4" autoplay loop></video></div>{% endif %}-->

The Button Bar is a view that represents a list of UIBarButtonItems as horizontally aligned buttons.
<!--{: .intro }-->

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/ButtonBar/apidocs/Classes/MDCButtonBar.html">MDCButtonBar</a></li>
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/ButtonBar/apidocs/Protocols/MDCButtonBarDelegate.html">MDCButtonBarDelegate</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/ButtonBar'
~~~

Then, run the following command:

~~~ bash
pod install
~~~



- - -

## Overview

A Button Bar is similar in concept to a UIToolbar, but Button Bars are **not** a drop-in API
replacement for UIToolbar. Button Bars are slightly more versatile in that one might use a Button
Bar to create a Toolbar or a Navigation Bar (left/right button bars).

Button Bar supports a subset of UIBarButtonItem's properties. Learn more by reading the section on
[UIBarButtonItem properties](#uibarbuttonitem-properties).




- - -

## Usage

### Importing

Before using Button Bar, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
import MaterialComponents
~~~

#### Objective-C

~~~ objc
#import "MaterialButtonBar.h"
~~~
<!--</div>-->


Create an instance of MDCButtonBar and provide it with an array of UIBarButtonItems.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
let buttonBar = MDCButtonBar()

let actionItem = UIBarButtonItem(
  title: "<# title #>",
  style: .Done, // ignored
  target: self,
  action: "<# selector #>"
)

buttonBar.items = [actionItem]

let size = buttonBar.sizeThatFits(self.view.bounds.size)
buttonBar.frame = CGRect(x: <# x #>, y: <# y #>, width: size.width, height: size.height)
self.view.addSubview(buttonBar)
~~~

#### Objective-C

~~~ objc
MDCButtonBar *buttonBar = [[MDCButtonBar alloc] init];

UIBarButtonItem *item =
    [[UIBarButtonItem alloc] initWithTitle:@"<# title #>"
                                     style:UIBarButtonItemStyleDone // ignored
                                    target:self
                                    action:@selector(<# selector #>)];

buttonBar.items = @[ actionItem ];

CGSize size = [buttonBar sizeThatFits:self.view.bounds.size];
buttonBar.frame = (CGRect){<# origin #>, size};
[self.view addSubview:buttonBar];
~~~
<!--</div>-->

### UIBarButtonItem properties

#### Supported

The following properties are taken into consideration when `items` is set and the corresponding
buttons are created.

Changes made to properties marked (observed) will be reflected in the corresponding buttons.

- `title` (observed)
- `image` (observed)
- `enabled` (observed)
- `width`
- `target`
- `action`
- `titleTextAttributesForState:`

TODO(featherless): File bugs to observe the rest of the properties.

Note: in order to make Button Bar reflect changes to not-observed properties you must clear the
MDCButtonBar instance's `items` property and reset it, like so:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
item.target = <some other target>

let items = buttonBar.items
buttonBar.items = nil
buttonBar.items = items
~~~

#### Objective-C

~~~ objc
item.target = <some other target>;

NSArray *items = buttonBar.items;
buttonBar.items = nil;
buttonBar.items = items;
~~~
<!--</div>-->

#### Unsupported

TODO(featherless): File issues for each of these.

- `style` is ignored.
- instances initialized with `initWithBarButtonSystemItem:`. See
  issue [#264](https://github.com/material-components/material-components-ios/issues/264) for more details.
- `landscapeImagePhone`
- `imageInsets`
- `landscapeImagePhoneInsets`
- `possibleTitles`
