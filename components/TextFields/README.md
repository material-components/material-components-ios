# Text Fields

Text Fields provides both a single line version based on UITextField and a multiline version based on UITextView as well as objects for customizing their behavior and appearance.

The components themselves are kept deliberately dumb (they do not have multiple presentation styles like the Material Design guidelines.) They are designed to be controllable from the outside via very liberal public API. Included is a Text Input Controller which adds all the bells and whitles defined in the spec.

This pattern is not a delegation or data source-like relationship but rather a controller-to-view relationship: the text field does not require nor expect to be served data or instruction but is instead malleable and easily influenced by outside interference.

### Material Design Specifications

<ul class="icon-list">
<li class="icon-link"><a href="https://material.googleplex.com/components/text-fields.html">Text Fields</a></li>
</ul>

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

## Usage

A text field or text view can be added to a view hierarchy the same way UITextField and UITextView are but to achieve the animations and presentations defined by the guidelines (floating placeholders, character counts), an MDCTextInputController must be initialized to manage the text field.

*NOTE:* Expect to interact with both the text field (for the traditional API) and the controller (for changes affecting the presentation and state).

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

### Display a modal dialog

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
// The following is called from the presenting view controller and has the
// following variable defined to keep a reference to the transition
// controller.
strong var dialogTransitionController: MDCDialogTransitionController

// To present the dialog myDialogViewController
dialogTransitionController = MDCDialogTransitionController()
myDialogViewController.modalPresentationStyle = .custom
myDialogViewController.transitioningDelegate = dialogTransitionController

present(myDialogViewController, animated: true, completion:...)
~~~

#### Objective-C

~~~ objc
// self is the presenting view controller and which has the following property
// defined to keep a reference to the transition controller.
@property(nonatomic) MDCDialogTransitionController *dialogTransitionController;

// To present the dialog myDialogViewController
self.dialogTransitionController = [[MDCDialogTransitionController alloc] init];
myDialogViewController.modalPresentationStyle = UIModalPresentationCustom;
myDialogViewController.transitioningDelegate = self.dialogTransitionController;
[self presentViewController:myDialogViewController animated:YES completion:...];

~~~
<!--</div>-->

### Present an alert

<!--<div class="material-code-render" markdown="1">-->
#### Swift

~~~ swift
// Present a modal alert
let alertController = MDCAlertController(title: titleString, message: messageString)
let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
alertController.addAction(action)

present(alertController, animated:true, completion:...)
~~~

#### Objective-C

~~~ objc
// Present a modal alert
MDCAlertController *alertController =
[MDCAlertController alertControllerWithTitle:titleString
message:messageString];

MDCAlertAction *alertAction =
[MDCAlertAction actionWithTitle:@"OK"
handler:^(MDCAlertAction *action) {
NSLog(@"OK");
}];

[alertController addAction:alertAction];

[self presentViewController:alertController animated:YES completion:...];
~~~
<!--</div>-->
