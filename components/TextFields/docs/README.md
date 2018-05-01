# Text Fields

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/textfields.png" alt="Text Fields" width="375">
</div>

Text fields allow users to input text into your app. They are a direct connection to your users' thoughts and intentions via on-screen, or physical, keyboard. The Material Design Text Fields take the familiar element to new levels by adding useful animations, character counts, helper text, error states, and styles.

MDC's text fields come in several styles and have a great range of customization. Google's UX research has determined that Outlined and Filled (aka 'text box') styles perform the best by a large margin. So use `MDCTextInputControllerOutlinedField` , `MDCTextInputControllerTextFieldBox`, and `MDCTextInputControllerTextArea` if you can and set colors and fonts that match your company's branding.

For more information on text field styles, and animated images of each style in action, see [Text Field Styles](./styling).

## Design & API documentation

* [Material Design guidelines: Text Fields](https://material.io/guidelines/components/text-fields.html)
* [API: MDCTextFiel](https://material.io/components/ios/catalog/textfields/api-docs/Classes/MDCTextField.html)
* [API: MDCMultilineTextField](https://material.io/components/ios/catalog/textfields/api-docs/Classes/MDCMultilineTextField.html)

<!-- toc -->

- - -

## Overview

Text Fields provides both a single-line version based on `UITextField` and a multi-line version backed by `UITextView` as well as objects that customize the text fields' behavior and appearance called 'Text Input Controllers'.

The actual components (`MDCTextField` & `MDCMultilineTextField`) are 'dumb': they do not have styles, animations, or advanced features. They are designed to be controlled from the outside, via very liberal public API, with a text input controller.

Most text input controllers included are based on `MDCTextInputControllerUnderline` which manipulates the exposed elements of the text field to make placeholders float.

There is also a text input controller for full-width forms (`MDCTextInputControllerFullWidth`). Like `MDCTextInputControllerUnderline`, it also handles errors and character counting.

Customize the included text input controllers via their parameters or create your own to express your app's brand identity thru typography, color, and animation: if the placeholder should move, add constraints or change the frame. If the trailing label should display validation information, change the text and color it.

This pattern is not a delegation or data source-like relationship but rather a controller-to-view relationship: the text field does not require nor expect to be served data or instruction but is instead malleable and easily influenced by outside interference.

## Installation

- [Typical installation](../../../docs/component-installation.md)

- [Classes](classes.md)

## Usage

- [Usage](usage.md)

- [Examples](examples.md)

## Extensions

- [Color Theming](color-theming.md)

- [Typography Theming](typography-theming.md)
