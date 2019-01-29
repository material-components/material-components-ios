# Dialogs

<!-- badges -->

Dialogs inform users about a task and can contain critical information, require decisions, or
involve multiple tasks.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/dialogs.gif" alt="Dialogs" width="320">
</div>

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

- [Theming](theming.md)

## Accessibility

- [Accessibility](accessibility.md)
