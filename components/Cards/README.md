<!--docs:
title: "Card"
layout: detail
section: components
excerpt: "Cards are contained surfaces that serve as an entry point to more detailed information, with flexible visual parameters."
iconId: list
path: /catalog/cards/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme Cards -->

# Cards

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/cards.png" alt="Cards" width="375">
</div>

Cards are contained surfaces that serve as an entry point to more detailed information, with flexible visual parameters.

They can be used as a standalone UIControl, or as a UICollectionViewCell in a UICollectionView.
Cards are meant to be interactive, and shouldn't be used solely for displaying purposes.

Cards adhere to Material Design layout and styling.

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-cards">Material Design guidelines: Cards</a></li>
</ul>

## Table of contents

- [Overview](#overview)
  - [Cards Classes](#cards-classes)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use: as a view](#typical-use-as-a-view)
  - [Typical use: in a collection view](#typical-use-in-a-collection-view)
- [Extensions](#extensions)
  - [Color Theming](#color-theming)

- - -

## Overview

Cards provides two different versions, `MDCCard` inheriting from `UIControl` and `MDCCardCollectionCell` inheriting from `UICollectionViewCell`.

A card's state determines its visual styling.

When treated as a `UIControl` (`MDCCard`), it has a default styling (`UIControlStateNormal`), and a highlighted styling (`UIControlStateHighlighted`) when interacted with.

When treated as a `UICollectionViewCell` (`MDCCardCollectionCell`), it has a default styling (`MDCCardCellStateNormal`), a highlighted styling (`MDCCardCellStateHighlighted`), and lastly a selected styling (`MDCCardCellStateSelected`).

Customization to the card is exposed via its API either in `MDCCard` or `MDCCardCollectionCell`. Currently the card consists of these customizations:
  <li class="icon-list-item icon-list-item--spec">The border width for a specific state</li>
  <li class="icon-list-item icon-list-item--spec">The border color for a specific state</li>
  <li class="icon-list-item icon-list-item--spec">The shadow elevation for a specific state</li>
  <li class="icon-list-item icon-list-item--spec">The shadow color for a specific state</li>
  <li class="icon-list-item icon-list-item--spec">The corner radius for the card</li>
</ul>

(`MDCCardCollectionCell` customization only):
  <li class="icon-list-item icon-list-item--spec">Changing the image that appears in the Selected state.</li>
  <li class="icon-list-item icon-list-item--spec">Changing the image tint color that appears in the Selected state.</li>
</ul>

An `MDCCard` can be added and used as you would add any `UIView` or `UIControl`, if manually in code, or through Interface Builder.

An `MDCCardCollectionCell` can be added, used, and reused as a `UICollectionViewCell`, if manually in code, or through Interface Builder.

MDCCardThemer exposes apis to theme MDCCard and MDCCardCollectionCell instances as either a default or outlined variant. An outlined variant behaves identically to a default styled card, but differs in its coloring and in that it has a stroked border. Use 'applyScheme:toCard:' to style an instance with default values and 'applyOutlinedVariantWithScheme:toCard:' to style an instance with the outlined values.
### Cards Classes

#### MDCCard

`MDCCard` subclasses `UIControl` and provides a simple class for developers to subclass and create custom cards with ink, shadows, corner radius, and stroke matching the Material spec.

`MDCCard` utilizes the `highlighted` property that is built-in in `UIControl` and the `UIControlState` to move between states.

#### MDCCardCollectionCell

`MDCCardCollectionCell` subclasses `UICollectionViewCell` and provides a simple collection view cell for developers to utilize in their collections with ink, shadows, corner radius, and stroke matching the Material spec.

`MDCCardCollectionCell` utilizes the `selected` property that is built-in in `UICollectionViewCell` and has its own `MDCCardCellState` to keep track of the current state it is in.

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Cards'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To import the component:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialCards
```

#### Objective-C

```objc
#import "MaterialCards.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/typical-use-view.md -->

### Typical use: as a view

`MDCCard` can be used like a regular UIView.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let card = MDCCard()

// Create, position, and add content views:
let imageView = UIImageView()
card.addSubview(imageView)
```

#### Objective-C

```objc
MDCCard *card = [[MDCCard alloc] init];

// Create, position, and add content views:
UIImageView *imageView = [[UIImageView alloc] init];
[card addSubview:imageView];
```
<!--</div>-->

<!-- Extracted from docs/typical-use-collections.md -->

### Typical use: in a collection view

Use `MDCCardCollectionCell` as a base class for your custom collection view cell

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
collectionView.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: "Cell")

func collectionView(_ collectionView: UICollectionView,
                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                for: indexPath) as! MDCCardCollectionCell
  // If you wanted to have the card show the selected state when tapped
  // then you need to turn isSelectable to true, otherwise the default is false.
  cell.isSelectable = true
  
  cell.selectedImageTintColor = .blue
  cell.cornerRadius = 8
  cell.setShadowElevation(6, for: .selected)
  cell.setShadowColor(UIColor.black, for: .highlighted)
  return cell
}
```

#### Objective-C

```objc
[self.collectionView registerClass:[MDCCardCollectionCell class]
        forCellWithReuseIdentifier:@"Cell"];

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCardCollectionCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                            forIndexPath:indexPath];
  // If you wanted to have the card show the selected state when tapped
  // then you need to turn selectable to true, otherwise the default is false.
  [cell setSelectable:YES];
  
  [cell setSelectedImageTintColor:[UIColor blueColor]];
  [cell setCornerRadius:8.f];
  [cell setShadowElevation:6.f forState:MDCCardCellStateSelected];
  [cell setShadowColor:[UIColor blackColor] forState:MDCCardCellStateHighlighted];
}
```
<!--</div>-->


## Extensions

<!-- Extracted from docs/color-theming.md -->

### Color Theming

You can theme a card with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/Cards+ColorThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialCards_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialCards+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
[MDCCardsColorThemer applySemanticColorScheme:colorScheme
     toCard:component];
```
<!--</div>-->

