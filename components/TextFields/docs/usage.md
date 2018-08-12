A text field that conforms to `MDCTextInput` can be added to a view hierarchy the same way `UITextField` and `UIView` are. But to achieve the animations and presentations defined by the guidelines (floating placeholders, character counts), a controller that conforms to protocol `MDCTextInputController` must be initialized to manage the text field.

**NOTE:** Expect to interact with _both the text field_ (for the traditional API) _and the controller_ (for changes affecting the presentation and state).
