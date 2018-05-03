# Dialogs

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/dialogs.png" alt="Dialogs" width="375">
</div>

Dialogs provides both a presentation controller for displaying a modal dialog and an alert
controller that will display a simple modal alert.

<!-- design-and-api -->

<!-- toc -->

- - -

## Overview

To display a modal using MaterialDialogs you set two properties on the view controller to be
presented. Set modalPresentationStyle to UIModalPresentationCustom and set
transitioningDelegate to and instance of MDCDialogTransitionController. Then you present the
view controller from the root controller to display it as a modal dialog.

### Presentation and transition controller

Presenting dialogs uses two classes: MDCDialogPresentationController and
MDCDialogTransitionController. These allow the presentation of view controllers in a material
specificed manner. MDCDialogPresentationController is a subclass of UIPresentationController
that observes the presented view controller for preferred content size.
MDCDialogTransitionController implements UIViewControllerAnimatedTransitioning and
UIViewControllerTransitioningDelegate to vend the presentation controller during the transition.

### Alert controller

MDCAlertController provides a simple interface for developers to present a modal dialog
according to the Material spec.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: modal dialog](typical-use-modal-dialog.md)
- [Typical use: alert](typical-use-alert.md)

## Extensions

- [Color Theming](color-theming.md)
- [Typography Theming](typography-theming.md)
