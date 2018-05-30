# Snackbar

<!-- badges -->

Snackbars provide brief feedback about an operation through a message at the bottom of the screen.
Snackbars contain up to two lines of text directly related to the operation performed. They may
contain a text action, but no icons.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/snackbar.png" alt="Snackbar" width="375">
</div>

<!-- design-and-api -->

## Related components

* [OverlayWindow](../../OverlayWindow)

<!-- toc -->

- - -

## Overview

### Snackbar Manager and Message

Snackbar is comprised of two classes: MDCSnackbarManager and MDCSnackbarMessage. Snackbar messages
contain text to be displayed to a user. Messages are passed to the manager. The manager decides when
it is appropriate to show a message to the user.

### Suspending and Resuming Display of Messages

Snackbar manager can be instructed to suspend and resume displaying messages as needed. When
messages are suspended the manager provides a suspension token that the client must keep as long as
messages are suspended. When the client releases the suspension token or calls the manager's resume
method with the suspension token, then messages will resume being displayed.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

Displaying a snackbar requires using two classes: MDCSnackbarManager and MDCSnackbarMessage.
First, create an instance of MDCSnackbarMessage and provide a string to display to the user. Next,
pass the MDCSnackbarMessage to the MDCSnackbarManager with the static showMessage method. This will
automatically construct an MDCSnackbarMessageView and appropriate overlay views so the snackbar is
visible to the user.

- [Typical use: display a message](typical-use-display-a-message.md)
- [Typical use: display a message with an action](typical-use-display-a-message-with-action.md)

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)
