<!--docs:
title: "Snackbar"
layout: detail
section: components
excerpt: "Snackbars provide brief feedback about an operation through a message at the bottom of the screen."
iconId: toast
-->

# Snackbar

<!--{% if site.link_to_site == "true" %}-->
<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/snackbar.png" alt="Snackbar" width="320">
</div>
<!--{% else %}
<div class="article__asset article__asset--screenshot" markdown="1">
  <video src="docs/assets/snackbar.mp4" autoplay loop></video>
</div>
{% endif %}-->

Snackbars provide brief feedback about an operation through a message at the bottom of the screen.
Snackbars contain up to two lines of text directly related to the operation performed. They may
contain a text action, but no icons.
<!--{: .article__intro }-->

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.google.com/components/snackbars-toasts.html">Snackbars</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/Snackbar'
```

Then, run the following command:

``` bash
pod install
```

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

- - -

## Usage

Displaying a snackbar requires using two classes: MDCSnackbarManager and MDCSnackbarMessage.
First, create an instance of MDCSnackbarMessage and provide a string to display to the user. Next,
pass the MDCSnackbarMessage to the MDCSnackbarManager with the static showMessage method. This will
automatically construct an MDCSnackbarMessageView and appropriate overlay views so the snackbar is
visible to the user.

### Importing

Before using Snackbar, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialSnackbar
```

#### Objective-C
``` objc
#import "MaterialSnackbar.h"
```
<!--</div>-->

- - -

## Examples

### Display a Snackbar Message

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let message = MDCSnackbarMessage()
message.text = "The groundhog (Marmota monax) is also known as a woodchuck or whistlepig."
MDCSnackbarManager.show(message)
```

#### Objective-C

``` objc
MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
message.text = @"How much wood would a woodchuck chuck if a woodchuck could chuck wood?";
[MDCSnackbarManager showMessage:message];
```
<!--</div>-->

### Display a Snackbar Message with an Action

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let action = MDCSnackbarMessageAction()
let actionHandler = {() in
  let answerMessage = MDCSnackbarMessage()
  answerMessage.text = "Fascinating"
  MDCSnackbarManager.show(answerMessage)
}
action.handler = actionHandler
action.title = "OK"
message.action = action
```

#### Objective-C

``` objc
MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
void (^actionHandler)() = ^() {
  MDCSnackbarMessage *answerMessage = [[MDCSnackbarMessage alloc] init];
  answerMessage.text = @"A lot";
  [MDCSnackbarManager showMessage:answerMessage];
};
action.handler = actionHandler;
action.title = @"Answer";
message.action = action;
```
<!--</div>-->
