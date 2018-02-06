<!--docs:
title: "Cards"
layout: detail
section: components
excerpt: "Cards are contained surfaces that serve as an entry point to more detailed information, with flexible visual parameters."
iconId: list
path: /catalog/cards/
api_doc_root: true
-->

# Cards

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/cards.png" alt="Cards" width="375">
</div>

Cards are contained surfaces that serve as an entry point to more detailed information, with flexible visual parameters.

They can be used as a standalone UIControl, or as a UICollectionViewCell in a UICollectionView.
Cards are meant to be interactive, and shouldn't be used solely for displaying purposes.

Cards adhere to Material Design layout and styling.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">
    <a href="https://material.io/guidelines/components/cards.htm">Material Design guidelines: Cards</a>
  </li>
</ul>

## Installation

### Requirements

- Xcode 8.0 or higher.
- iOS SDK version 8.0 or higher.
- To use the baked UICollectionView or UICollectionViewController reordering, then you must use iOS SDK version 9.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/Cards'
```

Then run the following command:

``` bash
pod install
```

- - -

### Overview

Cards can be used either as a standalone `UIControl`, or as a `UICollectionViewCell`.

A card consists of different visual styling based on the current state it is in.

When treated as a `UIControl` (`MDCCard`), it has a default styling (`UIControlStateNormal`), and a highlighted styling (`UIControlStateHighlighted`) when interacted with.

When treated as a `UICollectionViewCell` (`MDCCardCollectionCell`), it has a default styling (`MDCCardCellStateNormal`), a highlighted styling (`MDCCardCellStateHighlighted`), and lastly a selected styling (`MDCCardCellStateSelected`).

Customization to the card is exposed via its API either in `MDCCard` or `MDCCardCollectionCell`. Currently the card consists of these customizations:
* The border width for a specific state
* The border color for a specific state
* The shadow elevation for a specific state
* The shadow color for a specific state
* The corner radius for the card

(`MDCCardCollectionCell` customization only):
* Changing the image that appears in the Selected state.
* Changing the image tint color that appears in the Selected state.

### Cards Classes

#### MDCCard

`MDCCard` subclasses `UIControl` and provides a simple class for developers to subclass and create custom cards with ink, shadows, corner radius, and stroke matching the Material spec.

`MDCCard` utilizes the `highlighted` property that is built-in in `UIControl` and the `UIControlState` to move between states.

#### MDCCardCollectionCell

`MDCCardCollectionCell` subclasses `UICollectionViewCell` and provides a simple collection view cell for developers to utilize in their collections with ink, shadows, corner radius, and stroke matching the Material spec.

`MDCCardCollectionCell` utilizes the `selected` property that is built-in in `UICollectionViewCell` and has its own `MDCCardCellState` to keep track of the current state it is in.

## Installation

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/Collections'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

``` bash
pod install
```

- - -

## Usage

An `MDCCard` can be added and used as you would add any `UIView` or `UIControl`, if manually in code, or through the interface builder.

An `MDCCardCollectionCell` can be added, used, and reused as a `UICollectionViewCell`, if manually in code, or through the interface builder.

### Importing

Before using Cards, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
``` swift
import MaterialComponents.MaterialCards
```

#### Objective-C
``` objc
#import "MaterialCards.h"
```
<!--</div>-->

## Examples

### Use `MDCCard` as a base class for your custom card

### Use `MDCCardCollectionCell` as a base class for your custom cell

- - -

## Related Components

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--components"><a href="../CollectionCells">Collection Cells</a></li>
</ul>

