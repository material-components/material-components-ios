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
    <a href="https://material.io/guidelines/components/cards.html">Material Design guidelines: Cards</a>
  </li>
</ul>

## Installation

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

Cards provides two different versions, `MDCCard` inheriting from `UIControl` and `MDCCardCollectionCell` inheriting from `UICollectionViewCell`.

A card's state determines its visual styling.

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

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let card = MDCCard()

// Customization (optional)
card.cornerRadius = 8
card.setShadowElevation(6, for: .highlighted)
card.setBorderWidth(1, for: .normal)
card.setBorderColor(UIColor.brown, for: .normal)

// Adding content inside a card (optional)
let imageView = UIImageView()
card.addSubview(imageView)

view.addSubview(card)
```

#### Objective-C

``` objc
MDCCard *card = [[MDCCard alloc] init];

// Customization (optional)
[card setCornerRadius:8.f];
[card setShadowElevation:6.f forState:UIControlStateHighlighted];
[card setBorderWidth:1.f forState:UIControlStateNormal];
[card setBorderColor:[UIColor brownColor] forState:UIControlStateNormal];

// Adding content inside a card (optional)
UIImageView *imageView = [[UIImageView alloc] init];
[card addSubview:imageView];

[self.view addSubview:card];
```
<!--</div>-->

### Use `MDCCardCollectionCell` as a base class for your custom collection view cell

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
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

``` objc
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

- - -

## Related Components

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--components"><a href="../CollectionCells">Collection Cells</a></li>
</ul>

