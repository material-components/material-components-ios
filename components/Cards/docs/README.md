# Cards

<!-- badges -->

Cards contain content and actions about a single subject. They can be used standalone, or as part
of a list. Cards are meant to be interactive, and aren't meant to be be used solely for style
purposes.

<div class="article__asset article__asset--screenshot">
  <img src="assets/cards.png" alt="Cards" width="320">
</div>

<!-- design-and-api -->

<!-- toc -->

- - -

## Overview

Cards provides two different versions, `MDCCard` inheriting from `UIControl` and `MDCCardCollectionCell` inheriting from `UICollectionViewCell`.

A card's state determines its visual styling.

When treated as a `UIControl` (`MDCCard`), it has a default styling (`UIControlStateNormal`), and a highlighted styling (`UIControlStateHighlighted`) when interacted with.

When treated as a `UICollectionViewCell` (`MDCCardCollectionCell`), it has a default styling (`MDCCardCellStateNormal`), a highlighted styling (`MDCCardCellStateHighlighted`), and lastly a selected styling (`MDCCardCellStateSelected`).

Customization to the card is exposed via its API either in `MDCCard` or `MDCCardCollectionCell`. Currently the card consists of these customizations:

- The border width for a specific state
- The border color for a specific state
- The shadow elevation for a specific state
- The shadow color for a specific state
- The corner radius for the card

(`MDCCardCollectionCell` customization only):

- Changing the image that appears in the Selected state.
- Changing the image tint color that appears in the Selected state.

An `MDCCard` can be added and used as you would add any `UIView` or `UIControl`, if manually in code, or through Interface Builder.

An `MDCCardCollectionCell` can be added, used, and reused as a `UICollectionViewCell`, if manually in code, or through Interface Builder.

MDCCardThemer exposes apis to theme MDCCard and MDCCardCollectionCell instances as either a default or outlined variant. An outlined variant behaves identically to a default styled card, but differs in its coloring and in that it has a stroked border. Use 'applyScheme:toCard:' to style an instance with default values and 'applyOutlinedVariantWithScheme:toCard:' to style an instance with the outlined values.

### Cards Classes

#### MDCCard

`MDCCard` subclasses `UIControl` and provides a simple class for developers to subclass and create custom cards with ink, shadows, corner radius, and stroke matching the Material spec.

`MDCCard` uses the `highlighted` property that is built-in in `UIControl` and the `UIControlState` to move between states.

#### MDCCardCollectionCell

`MDCCardCollectionCell` subclasses `UICollectionViewCell` and provides a simple collection view cell for developers to use in their collections with ink, shadows, corner radius, and stroke matching the Material spec.

`MDCCardCollectionCell` uses the `selected` property that is built-in in `UICollectionViewCell` and has its own `MDCCardCellState` to keep track of the current state it is in.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use: as a view](typical-use-view.md)
- [Typical use: in a collection view](typical-use-collections.md)

## Extensions

- [Theming](theming.md)

## Accessibility

- [Accessibility Labels](accessibility.md)

## Unsupported

- [Color Theming](color-theming.md)
- [Shape Theming](shape-theming.md)
