# Text Fields

<!--{% if site.link_to_site == "true" %}-->
<a alt="Text Fields"><img src="docs/assets/text_fields.png" width="320px"></a>
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/text_fields.mp4" autoplay loop></video></div>{% endif %}-->

Text fields allow users to input text into your app. They are a direct connection to your users' thoughts and intentions via on-screen, or physical, keyboard. The Material Design Text Fields take the familiar element to a new level by adding useful animations, character counts, helper text and error states.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
<li class="icon-link"><a href="https://material.io/guidelines/components/text-fields.html">Text Fields</a></li>
</ul>


## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 8.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/TextFields'
~~~

Then run the following command:

~~~ bash
pod install
~~~

- - -

### Overview

Text Fields provides both a single-line version based on UITextField and a multi-line version based on UITextView as well as objects that customize the text fields' behavior and appearance.

The actual components (MDCTextField & MDCTextView) are 'dumb': they do not have styles, animations, or advanced features. They are designed to be controlled from the outside, via very liberal public API, with a Text Input Controller. 

A text input controller is included (MDCTextInputController) that supplies the features and styles defined in the Material guidelines. It manipulates the exposed elements of the text field to make placeholders float or error text appear red.

This pattern is not a delegation or data source-like relationship but rather a controller-to-view relationship: the text field does not require nor expect to be served data or instruction but is instead malleable and easily influenced by outside interference.

Customize the included MDCTextInputController and its parameters or create your own to express your app's brand identity thru typography, color, and animation: if the placeholder should move, add constraints or change the frame. If the trailing label should display validation information, change the text and color it.

### Text Field Classes

#### Text Field

This is a single line text input. It's subclassed from UITextField and supports all the features you'd expect from a UITextField:

* Placeholder
* Associate views (left and right)
* Custom fonts, colors 
* Clear button

as well as new features:

* Underline
* Labels below the input
* Custom layouts
* Persistable placeholder

#### Text View

The text view has all the same features of the text field (except associate views and clear button) but also adds behavior already found in UITextView:

* Multiline input
* Clickable URLs
* Scrollable text

#### Text Input Controller

This class holds all the 'magic' logic necessary to make the naturally 'dumb' text field and text view behave with:

* Animations
* Styles
* Errors
* Character counts 

- - -

## Usage

A text field or text view can be added to a view hierarchy the same way UITextField and UITextView are but to achieve the animations and presentations defined by the guidelines (floating placeholders, character counts), an MDCTextInputController must be initialized to manage the text field.

**NOTE:** Expect to interact with _both the text field_ (for the traditional API) _and the controller_ (for changes affecting the presentation and state).

### Importing

Before using Text Fields, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
import MaterialComponents.MaterialTextFields
~~~

#### Objective-C

~~~ objc
#import "MaterialTextFields.h"
~~~
<!--</div>-->

## Examples

### Text Field with Character Count

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
// First the text field component is setup just like a UITextField
let textFieldDefaultCharMax = MDCTextField()
scrollView.addSubview(textFieldDefaultCharMax)

textFieldDefaultCharMax.placeholder = "Enter up to 50 characters"
textFieldDefaultCharMax.delegate = self

// Second the controller is created to manage the text field
let textFieldControllerDefaultCharMax = MDCTextInputController(input: textFieldDefaultCharMax)
textFieldControllerDefaultCharMax.characterCountMax = 50
~~~

#### Objective-C

~~~ objc
// First the text field component is setup just like a UITextField
MDCTextField *textFieldDefaultCharMax = [[MDCTextField alloc] init];
[self.scrollView addSubview:textFieldDefaultCharMax];

textFieldDefaultCharMax.placeholder = @"Enter up to 50 characters";
textFieldDefaultCharMax.delegate = self;

// Second the controller is created to manage the text field
MDCTextInputController *textFieldControllerDefaultCharMax = [[MDCTextInputController alloc] initWithTextInput: textFieldDefaultCharMax];
textFieldControllerDefaultCharMax.characterCountMax = 50;
~~~
<!--</div>-->

### Text Field with Floating Placeholder

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
let textFieldFloating = MDCTextField()
scrollView.addSubview(textFieldFloating)
textFieldFloating.translatesAutoresizingMaskIntoConstraints = false

textFieldFloating.placeholder = "Full Name"
textFieldFloating.delegate = self
textFieldFloating.clearButtonMode = .unlessEditing

let textFieldControllerFloating = MDCTextInputController(input: textFieldFloating)

textFieldControllerFloating.presentation = .floatingPlaceholder
~~~

#### Objective-C

~~~ objc
MDCTextField *textFieldFloating = [[MDCTextField alloc] init];
[self.scrollView addSubview:textFieldFloating];
textFieldFloating.translatesAutoresizingMaskIntoConstraints = NO;

textFieldFloating.placeholder = @"Full Name";
textFieldFloating.delegate = self;
textFieldFloating.clearButtonMode = UITextFieldViewModeUnlessEditing;

MDCTextInputController *textFieldControllerFloating = [[MDCTextInputController alloc] initWithTextInput:textFieldFloating];

textFieldControllerFloating.presentationStyle = MDCTextInputPresentationStyleFloatingPlaceholder;
~~~
<!--</div>-->
