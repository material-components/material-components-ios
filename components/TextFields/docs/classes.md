### Text Field Classes: The Inputs

#### Text Field

This is a single-line text input. It's subclassed from `UITextField` and supports all the features you'd expect from a `UITextField`:

- Placeholder
- Overlay views (left and right / leading and trailing)
- Custom fonts, colors
- Clear button

as well as new features:

- Underline
- Labels below the input
- Custom layouts
- Persistable placeholder
- Border view

#### Multi-line Text Field

This is a multi-line text input. It's subclassed from `UIView` with an embedded `UITextView`. It supports all the features of the single-line text field and `UITextView` plus:

<ul class="icon-list">
<li class="icon-list-item icon-list-item">Minimum number of lines</li>
</ul>

### Text Input Controller Classes: Recommended

See [Text Field Styles](./styling) for images and details.

These are the controllers that have been optimized for discoverability and clickability thru rigorous research, design iterations, and user testing. Always try to use one of these first.

#### MDCTextInputControllerFilled

Filled background with underline.

#### MDCTextInputControllerOutlined

Outlined background with no fill.

#### MDCTextInputControllerOutlinedTextArea

Nearly identical to `MDCTextInputControllerOutlined` but with two differences:

- Intended only for multi-line text fields that remain expanded when empty
- The floating placeholder does not cross the border but rather floats below it

### Text Input Controller Classes: Cautioned

See [Text Field Styles](./styling) for images and details.

These are the controllers that have performed the worst in user testing or haven't been extensively user tested at all. Use them only if you have to or conduct your own A/B testing against one of the recommended controllers to see if they perform as expected in your application.

#### MDCTextInputControllerFullWidth

Optimized for full width forms like emails. While common in messaging apps, its design hasn't been rigorously tested with users. For now, the Material Design team suggests using this only when another design is impracticle.

#### MDCTextInputControllerUnderline

'Classic' 2014 Material Design text field. This style is still found in many applications and sites but should be considered deprecated. It tested poorly in Material Research's user testing. Use `MDCTextInputControllerFilled` or `MDCTextInputControllerOutlined` instead.

#### MDCTextInputControllerLegacyDefault && MDCTextInputControllerLegacyFullWidth

Soon to be deprecated styles only created and included for backwards compatibility of the library. They have no visual distinction from the other full width and underline controllers but their layout behaves slightly differently.

### Text Input Controller Classes: For Subclassing Only

See [Text Field Styles](./styling) for images and details.

#### MDCTextInputControllerBase

__This class is meant to be subclassed and not used on its own.__ It's a full implementation of the `MDCTextInputControllerFloatingPlaceholder` protocol and holds all the 'magic' logic necessary to make:

- Floating placeholder animations
- Errors
- Character counts
