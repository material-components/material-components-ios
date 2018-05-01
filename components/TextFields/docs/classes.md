### Text Field Classes: The Inputs

#### Text Field

This is a single-line text input. It's subclassed from `UITextField` and supports all the features you'd expect from a `UITextField`:

* Placeholder
* Overlay views (left and right / leading and trailing)
* Custom fonts, colors
* Clear button

as well as new features:

* Underline
* Labels below the input
* Custom layouts
* Persistable placeholder
* Border view

#### Multi-line Text Field

This is a multi-line text input. It's subclassed from `UIView` with an embedded `UITextView`. It supports all the features of the single-line text field and `UITextView` plus:

* Minimum number of lines

### Text Field Classes: The Controllers

#### Default Text Input Controller

This class holds all the 'magic' logic necessary to make the naturally 'dumb' text field and text view behave with:

* Animations
* Styles
* Errors
* Character counts

- - -

#### Full Width Text Input Controller

Similar to the default text input controller but optimized for full width forms like emails.
