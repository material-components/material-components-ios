### MDCTextField Accessibility

Like UITextFields, MDCTextFields are accessible by default. To best take advantage of their accessibility features
please review the following recommendations.

#### `-accessibilityValue` Behavior

Similar to UITextFields, MDCTextFields are not accessibility elements themselves. Rather, they are accessibility
containers whose subviews act as accessibility elements. Such subviews include the MDCTextField's placeholder
label, the leading and trailing underline labels, and the clear button. The `accessibilityLabels` of these subviews
contribute to the `accessibilityValue` of the MDCTextField as a whole, giving it a value consistent with that of a
UITextField in a similar state. If the MDCTextField is empty, it will return a combination of any placeholderLabel text and
leading underline text. If the MDCTextField is not empty, it will return a combination of the MDCTextField's current text
and any leading underline text.

#### Using `-accessibilityLabel`

MDCTextField does not provide a custom implementation for `accessibilityLabel`. The client is free to set an
appropriate `accessibilityLabel` following norms established by Apple if they wish. However, they should consider
whether or not it it will provide information that is superfluous. A common scenario in which an
`accessibilityLabel` might not be necessary would be an MDCTextField whose leading underline label (a view not
present in UITextFields) conveys the information that an accessibility label might have otherwise conveyed. For
example, if an MDCTextField is intended to hold a user's zip code, and the leading underline label's
`accessibilityLabel` is already "Zip code", setting an `accessibilityLabel` of "Zip code" on the MDCTextField
may lead to duplicate VoiceOver statements.

#### Using `-accessibilityHint`

In general, Apple advises designing your user interface in such a way that clarification in the form of  an
`-accessibilityHint` is not needed. However, it is always an option.
