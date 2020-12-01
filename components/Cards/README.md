<!--docs:
title: "Cards"
layout: detail
section: components
excerpt: "Cards contain content and actions about a single subject."
iconId: list
path: /catalog/cards/
api_doc_root: true
-->

# Cards

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BCards%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BCards%5D)

[Cards](https://material.io/components/cards/) contain content and actions about
a single subject.

![An arrangement of cards containing various charts and graphs](docs/assets/card-hero.png)

## Contents

*   [Using cards](#using-cards)
*   [Card](#card)
*   [Theming](#theming)

## Using cards

### Installing

In order to use Material cards, first add the `Cards` subspec to your `Podfile`:

```bash
pod MaterialComponents/Cards
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the installer:

```bash
pod install
```

After that, import the relevant target or file.

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

### Cards Classes

On iOS, the Cards component offers two implementations to choose from, `MDCCard` and `MDCCardCollectionCell`.

#### `MDCCard`

`MDCCard` subclasses `UIControl`. Subclassing `MDCCard` allows you to create cards that match the Material spec.

`MDCCard` uses `UIControlState` to represent state. Its styling changes depending on whether its state is `.normal` or `.highlighted`.

`MDCCard` allows the following properties to be customized:

* The border width for a specific state
* The border color for a specific state
* The shadow elevation for a specific state
* The shadow color for a specific state
* The corner radius for the card

#### `MDCCardCollectionCell`

`MDCCardCollectionCell` subclasses `UICollectionViewCell`. Subclassing `MDCCardCollectionCell` allows you to have Material cards as cells in your `UICollectionView`.

`MDCCardCollectionCell` has its own notion of state, `MDCCardCellState`, which is tied to the `UICollectionViewCell` `highlighted` and `selected` properties.

In addition to those offered by `MDCCard`, `MDCCardCollectionCell` offers the following customization options:

* Changing the image that appears in the Selected state.
* Changing the image tint color that appears in the Selected state.

### Making cards accessible

Accessibility best practices depend on whether you are using an `MDCCard` or an `MDCCardCollectionCell`.

#### `MDCCard`accessibility

The nested elements in an `MDCCard` are available to assistive technologies without additional 
customization. However, additional setup may be needed to accommodate the following scenarios:

#### Cards with Images 

Images may have additional context beyond text that is already presented on the card. For example, news article images can benefit from an 
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) 
describing their content.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
articleImageView.isAccessibilityElement = true
articleImageView.accessibilityLabel = "Event or scene description"
```

#### Objective-C
```objc
articleImageView.isAccessibilityElement = YES;
articleImageView.accessibilityLabel = @"Event or scene description";
```
<!--</div>-->

#### Cards with "star ratings"

Star or rating images should have [`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) property values describing their purpose and [`accessibilityValue`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619583-accessibilityvalue) property values describing their rating value.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
ratingView.isAccessibilityElement = true
ratingView.accessibilityLabel = "Average customer rating, out of " + 
  "\(MDCProductRating.maximumValue) stars"
ratingView.accessibilityValue = (String)product.averageRating
```

#### Objective-C
```objc
ratingView.isAccessibilityElement = YES;
ratingView.accessibilityLabel = [NSString stringWithFormat:@"Average customer" +
  " rating, out of %d stars", MDCProductRating.maximumValue];
ratingView.accessibilityValue = @(product.averageRating).stringValue;
```
<!--</div>-->

#### Cards whose contents should be read in a specific order

Primary content or actions that appear lower on the screen will be read last by assistive 
technologies, sometimes after longer or non-primary content. To change the order, or group 
elements together, you can make the card an accessibility container by adopting the 
[`UIAccessibilityContainer`](https://developer.apple.com/documentation/uikit/accessibility/uiaccessibilitycontainer) 
protocol. Grouping and order is controlled by creating as many 
[`UIAccessibilityElement`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement) 
elements as needed, and returning them in the desired order. 

#### `MDCCardCollectionCell` accessibility

Since assistive technologies visit all cards in a collection in a sequential order, it is often 
easier to distinguish between elements that belong to different cards by aggregating all the 
card's information so the card is read as a single sentence. This can be done by setting an appropriate 
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) 
for the card. Additionally, set the card's 
[`isAccessibilityElement`](https://developer.apple.com/documentation/objectivec/nsobject/1615141-isaccessibilityelement) 
to true. Cards are a container element and setting `isAccessibiltyElement` for a container 
turns off individually selecting its subelements.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
card.isAccessibilityElement = true
card.accessibilityLabel = "Location \(userLocation.name) is popular with users " +
  "who enjoy \(userLocation.popularActivityMatchingUserProfile(userProfile))"
```

#### Objective-C
```objc
card.isAccessibilityElement = YES;
card.accessibilityLabel = [NSString 
  stringWithFormat:@"Location %@ is popular with users who enjoy %@",  
  userLocation.name, 
  userLocation.popularActivityMatchingUserProfile(userProfile)];
```
<!--</div>-->

## Types

## Card

![Card with sample image and buttons](docs/assets/custom-card.png)

While iOS has two different implementations for Cards, there is really only one type of card from the design perspective. The example above could be built using either an `MDCCard` or an `MDCCardCollectionCell`. [Here](examples/CardWithImageViewAndButtonsExample.swift) is an example class that does it with `MDCCard`.

### `MDCCard` example

[`MDCCard` GitHub source](https://github.com/material-components/material-components-ios/blob/develop/components/Cards/src/MDCCard.h).

`MDCCard` can be used like a regular `UIView`. This is an example of a regular card:

![single basic card](docs/assets/single-basic-card.png)

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let card = MDCCard(frame: CGRect(x: 30, y: 100, width: 150, height: 150))
card.applyTheme(withScheme: containerScheme)
view.addSubview(card)
```

#### Objective-C

```objc
MDCCard *card = [[MDCCard alloc] initWithFrame:CGRectMake(30, 100, 150, 150)];
[card applyThemeWithScheme:containerScheme];
[view addSubview:card];
```

<!--</div>-->

### `MDCCardCollectionCell` example

[`MDCCardCollectionCell` GitHub source](https://github.com/material-components/material-components-ios/blob/develop/components/Cards/src/MDCCardCollectionCell.h)

`MDCCardCollectionCell` can be used like a regular `UICollectionViewCell`. This is an example of `MDCCardCollectionCell`s in a collection:

![card collection cells](docs/assets/card-collection-cells.png)

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
  cell.cornerRadius = 8
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
  [cell setCornerRadius:8];
  return cell;
}
```
<!--</div>-->

### Anatomy and key properties

A card has a container and an optional thumbnail, header text, secondary text,
media, supporting text, buttons and icons.

![card anatomy diagram](docs/assets/card-anatomy.png)

1.  Container
2.  Thumbnail
3.  Header text
4.  Secondary text
5.  Media
6.  Supporting text
7.  Buttons
8.  Icons
9.  Checked icon (not shown)

_**Note:** All the optional elements of a card's content are implemented through the use of other views/components._

#### `MDCCard` attributes 

&nbsp;               | Attribute                 | Related method(s)                                                   | Default value
-------------------- | ------------------------- | ------------------------------------------------------------------- | -------------
**Color**            | `backgroundColor`         | `-setBackgroundColor:`<br/>`backgroundColor:`                       | Surface color
**Foreground color** | N/A                       | N/A                                                                 | N/A
**Stroke color**     | `layer.borderColor`       | `-setBorderColor:forState:`<br/>`-borderColorForState:`             | On surface color at 37% opacity
**Stroke width**     | `layer.borderWidth`       | `-setBorderWidth:forState:`<br/>`-borderWidthForState:`             | 1
**Shape**            | `shapeGenerator`          | `-setShapeGenerator:`<br/>`-shapeGenerator`                         | `MDCRectangleShapeGenerator`
**Elevation**        | N/A                       | `-setShadowElevation:forState:`<br/>`-shadowElevationForState:`     | 1
**Ripple color**     | `rippleView.rippleColor`  | N/A                                                                 | `nil`

#### `MDCCardCollectionCell` attributes

&nbsp;               | Attribute                 | Related method(s)                                                   | Default value
-------------------- | ------------------------- | ------------------------------------------------------------------- | -------------
**Color**            | `backgroundColor`         | `-setBackgroundColor:`<br/>`backgroundColor:`                       | Surface color
**Foreground color** | N/A                       | N/A                                                                 | N/A
**Stroke color**     | `layer.borderColor`       | `-setBorderColor:forState:`<br/>`-borderColorForState:`             | On surface color at 37% opacity
**Stroke width**     | `layer.borderWidth`       | `-setBorderWidth:forState:`<br/>`-borderWidthForState:`             | 1
**Shape**            | `shapeGenerator`          | `-setShapeGenerator:`<br/>`-shapeGenerator`                         | `MDCRectangleShapeGenerator`
**Elevation**        | N/A                       | `-setShadowElevation:forState:`<br/>`-shadowElevationForState:`     | 1
**Ripple color**     | `rippleView.rippleColor`  | N/A                                                                 | `nil`

### Theming

Cards supports Material Theming using a Container Scheme. `MDCCard` and `MDCCardCollectionCell` have both default and outlined theming methods. Learn more about theming extensions [here](../../docs/theming.md). Below is a screenshot of an `MDCCard` with the Material Design Shrine theme:

![Shrine card](docs/assets/shrine-card.png)

To make use of Cards theming install the Cards theming extensions with Cocoapods. First, add the following line to your `Podfile`:

```bash
pod MaterialComponents/Cards+Theming
```

<!--{: .code-renderer.code-renderer--install }-->

Then Run the installer:

```bash
pod install
```

Next, import the Cards theming target, and call the correct theming method.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_Theming

...
 // Create a card
let card = MDCCard()
 // Create or use your app's Container Scheme
let containerScheme = MDCContainerScheme()
 // Theme the card with either default theme
card.applyTheme(withScheme: containerScheme)
 // Or outlined theme
card.applyOutlinedTheme(withScheme: containerScheme)
```

#### Objective-C
```objc
#import "MaterialCards.h"
#import "MaterialCards+Theming.h"

...
 // Create a card
MDCCard *card = [[MDCCard alloc] init];
 // Create or use your app's Container Scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
 // Theme the card with either default theme
[self.card applyThemeWithScheme:containerScheme];
 // Or outlined theme
[self.card applyOutlinedThemeWithScheme:containerScheme];
```
<!--</div>-->
