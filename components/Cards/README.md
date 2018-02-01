<!--docs:
title: "Cards"
layout: detail
section: components
excerpt: "Card classes that adhere to Material Design layout and styling."
iconId: list
path: /catalog/cards/
api_doc_root: true
-->

# Cards

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/cards.png" alt="Cards" width="375">
</div>

Cards provides an card control and a card collection view cell that adhere to Material Design
layout and styling.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/guidelines/components/cards.html">Material Design guidelines: Cards</a></li>
</ul>


### Cards Classes

#### Card

MDCCard provides a simple class for developers to subclass and create custom cards with ink,
shadows, corner radius and stroke matching the Material spec.

#### CardCell

MDCCardCollectionCell provices a simple collection view cell for developers to utilize in their
collections with ink, shadows, corner radius, and stroke matching the Material spec.


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

