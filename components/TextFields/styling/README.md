#  Text field styles

MDC's text fields are designed to be styled by controllers implementing the `MDCTextInputController` protocol. The following controllers are included in the text field component and each one is highly customizeable to express your app's branding and styling.

Some of the classes are marked as "Preferred". These are known, thru extensive UX research, to have big performance gains in usability.

Another two of the classes are "Legacy". They are included to support older designs and avoid breaking changes that come from the new layout and size of new styles.

## MDCTextInputControllerOutlined (Preferred)

![MDCTextInputControllerOutlined](MDCTextInputControllerOutlined.gif)

- Stroked border
- Border-crossing, floating placeholder
- No fill

### Notes:
This class is intended for single line text fields only. For a visually compatible multi-line controller, use `MDCTextInputControllerOutlinedTextArea`.

## MDCTextInputControllerFilled (Preferred)

![MDCTextInputControllerFilled](MDCTextInputControllerFilled.gif)

- Optionally stroked border / underline
- Floating placeholder
- Colored fill

## MDCTextInputControllerOutlinedTextArea (Preferred)

- Stroked border
- Border-crossing, floating placeholder
- No fill

### Notes:
This class is intended for multi-line text fields only. For a visually compatible single line controller, use `MDCTextInputControllerOutlined`.

## MDCTextInputControllerDefault

![MDCTextInputControllerDefault](MDCTextInputControllerDefault.gif)

- Underline
- Optionally floating placeholder (default is to float)
- No fill
- "Classic" early Material Design look

## MDCTextInputControllerFullWidth

- No border / underline
- Inline placeholder
- Optional fill
- No leading underline label
- Trailing underline label is inline with placeholder

## MDCTextInputControllerLegacyDefault

![MDCTextInputControllerLegacyDefault](MDCTextInputControllerLegacyDefault.gif)

- Underline
- Optionally floating placeholder (default is to float)
- No fill
- "Classic" early Material Design look
- Legacy clear button (X)

### Notes:
This class has different layout behavior and sizing than `MDCTextInputControllerDefault` but is included for backwards compatibility.

## MDCTextInputControllerLegacyFullWidth

- No border / underline
- Inline placeholder
- Optional fill
- No leading underline label
- Trailing underline label is inline with placeholder
- Legacy clear button (X)

### Notes:
This class has different layout behavior and sizing than `MDCTextInputControllerFullWidth` but is included for backwards compatibility.
