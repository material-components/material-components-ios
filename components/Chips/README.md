<!--docs:
title: "Chips"
layout: detail
section: components
excerpt: "Chips are compact elements that represent an input, attribute, or action."
iconId: chip
path: /catalog/chips/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme Chips -->

# Chips

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BChips%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BChips%5D)

Chips are compact elements that represent an input, attribute, or action.

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-chips">Material Design guidelines: Chips</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/chips/api-docs/Classes.html#/c:objc(cs)MDCChipCollectionViewFlowLayout">MDCChipCollectionViewFlowLayout</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/chips/api-docs/Classes/MDCChipCollectionViewCell.html">MDCChipCollectionViewCell</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/chips/api-docs/Classes/MDCChipField.html">MDCChipField</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/chips/api-docs/Classes/MDCChipView.html">MDCChipView</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/chips/api-docs/Protocols/MDCChipFieldDelegate.html">MDCChipFieldDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/chips/api-docs/Enums.html">Enumerations</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://material.io/components/ios/catalog/chips/api-docs/Enums/MDCChipFieldDelimiter.html">MDCChipFieldDelimiter</a></li>
</ul>

## Table of contents

- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Chips Collections](#chips-collections)
  - [Input Chips](#input-chips)
  - [Choice Chips](#choice-chips)
  - [Filter Chips](#filter-chips)
  - [Action Chips](#action-chips)
- [Tips](#tips)
  - [Ink ripple animation](#ink-ripple-animation)
  - [Stateful properties](#stateful-properties)
  - [Selected Image View](#selected-image-view)
  - [Padding](#padding)
- [Behavioral flags](#behavioral-flags)
  - [Accessibility](#accessibility)
- [Examples](#examples)
  - [Create a single Chip](#create-a-single-chip)
- [Extensions](#extensions)
  - [Theming](#theming)

- - -

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Chips'
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
import MaterialComponents.MaterialChips
```

#### Objective-C

```objc
#import "MaterialChips.h"
```
<!--</div>-->


## Chips Collections

<!-- Extracted from docs/chips-collections.md -->

Material design suggest the usage of chips collection in four context: Input Chips, Choice Chips, Filter Chips, and Action Chips.

### Input Chips
Input chips represent a complex piece of information in compact form, such as an entity (person, place, or thing) or text. They enable user input and verify that input by converting text into chips.


#### Implementation
We currently provide an implementation of Input Chips called `MDCChipField`. 


### Choice Chips
Choice chips allow selection of a single chip from a set of options.

Choice chips clearly delineate and display options in a compact area. They are a good alternative to toggle buttons, radio buttons, and single select menus.

#### Implementation
It is easiest to create choice Chips using a `UICollectionView`:

 - Use `MDCChipCollectionViewFlowLayout` as the `UICollectionView` layout:
 <!--<div class="material-code-render" markdown="1">-->
 ```objc
 MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 ```
 <!--</div>-->
 
 - Leave the default `UICollectionView` selection setting (single selection).
 - Use `MDCChipCollectionViewCell` as `UICollectionView` cells. (`MDCChipCollectionViewCell` manages the state of the chip based on selection state of `UICollectionView` automatically)

  <!--<div class="material-code-render" markdown="1">-->
   ```objc
  - (void)loadView {
    [super loadView];
    …
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    ...
   }

  - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    // configure the chipView
     return cell;
  }
  ```
  <!--</div>-->

- Use `UICollectionViewDelegate` methods `collectionView:didSelectItemAtIndexPath:` for reacting to new choices.

- Use `UICollectionView` `selectItemAtIndexPath:animated:scrollPosition:` method to edit choice selection programmatically.


### Filter Chips
Filter chips use tags or descriptive words to filter content.

Filter chips clearly delineate and display options in a compact area. They are a good alternative to toggle buttons or checkboxes.


#### Implementation
It is easiest to create filter Chips using a `UICollectionView`:

 - Use `MDCChipCollectionViewFlowLayout` as the `UICollectionView` layout:
 <!--<div class="material-code-render" markdown="1">-->
 ```objc
 MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 ```
 <!--</div>-->
 
 - Allow multi cell selection in the `UICollectionView`:
  <!--<div class="material-code-render" markdown="1">-->
  ```objc
  collectionView.allowsMultipleSelection = YES; 
  ```
  <!--</div>-->
 - Use `MDCChipCollectionViewCell` as `UICollectionView` cells. (`MDCChipCollectionViewCell` manages the state of the chip based on selection state of `UICollectionView` automatically)

  <!--<div class="material-code-render" markdown="1">-->
   ```objc
  - (void)loadView {
    [super loadView];
    …
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    ...
   }

  - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    // configure the chipView
     return cell;
  }
  ```
  <!--</div>-->

- Use `UICollectionViewDelegate` methods `collectionView:didSelectItemAtIndexPath:` and `collectionView:didDeselectItemAtIndexPath:` for reacting to filter changes.

- Use `UICollectionView` `deselectItemAtIndexPath:animated:` and `selectItemAtIndexPath:animated:scrollPosition:` methods to edit filter selection in code.


### Action Chips
Action chips offer actions related to primary content. They should appear dynamically and contextually in a UI.

An alternative to action chips are buttons, which should appear persistently and consistently.

#### Implementation
It is easiest to create action Chips using a `UICollectionView`:

 - Use `MDCChipCollectionViewFlowLayout` as the `UICollectionView` layout:
 <!--<div class="material-code-render" markdown="1">-->
 ```objc
 MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 ```
 <!--</div>-->
 
 - Leave the default `UICollectionView` selection setting (single selection).
 - Use `MDCChipCollectionViewCell` as `UICollectionView` cells. (`MDCChipCollectionViewCell` manages the state of the chip based on selection state of `UICollectionView` automatically)

  <!--<div class="material-code-render" markdown="1">-->
   ```objc
  - (void)loadView {
    [super loadView];
    …
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    ...
   }

  - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    // configure the chipView
     return cell;
  }
  ```
  <!--</div>-->

- Make sure that `MDCChipCollectionViewCell` does not stay in selected state

 <!--<div class="material-code-render" markdown="1">-->
   ```objc
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // For action chips, we never want the chip to stay in selected state.
    // Other possible apporaches would be relying on theming or Customizing collectionViewCell
    // selected state.
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    // Trigger the action
  }
  ```
  <!--</div>-->

- Use `UICollectionViewDelegate` method `collectionView:didSelectItemAtIndexPath:` to Trigger the action.

- - -


## Tips

<!-- Extracted from docs/tips.md -->

### Ink ripple animation
Chips display animated ink splashes when the user presses the chip. Keep in mind this will appear on
top of your 'highlighted' backgroundColor.

### Stateful properties
Like UIButton, Material Chips have many state-dependant properties. Set your background color, title
color, border style, and elevation for each of their states. If you don't set a value for a specific
state it will fall back to whatever value has been provided for the Normal state. Don't forget that
you'll also need to set values for the combined states, such as Highlighted | Selected.

### Selected Image View
In order to make it as clear as possible a chip has been selected, you can optionally set the image
of the `selectedImageView`. This image will only appear when the chip is selected. If you have a
image set on the standard `imageView`, then the `selectedImageView` will appear on top. Otherwise
you'll need to resize the chip to show the selected image. See the Filter chip example to see this
in action.

### Padding
There are 4 `padding` properties which control how a chip is laid out. One for each of the chip's
subviews (`imageView` and `selectedImageView` share one padding property), and one which wraps all
the others (`contentPadding`). This is useful so that you can set each of the padding properties to
ensure your chips look correct whether or not they have an image and/or accessory view. The chip
uses these property to determine `intrinsicContentSize` and `sizeThatFits`.

- - -


## Behavioral flags

<!-- Extracted from docs/enable-chips-that-delete.md -->

If within your `MDCChipField` you want chips that can be deleted follow these steps.

### Accessibility

Enabling this flag will add 24x24 touch targets within the chip view. This goes against Google's recommended 
48x48 touch targets. We recommend if you enable this behavior your associate it with a `MDCSnackbar` or 
`MDCDialog` to confirm allow the user to confirm their behavior.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let chipField = MDCChipField()
chipField.showChipsDeleteButton = true
```

#### Objective-C
```objc
MDCChipField *chipField = [[MDCChipField alloc] init];
chipField.showChipsDeleteButton = YES;
```
<!--</div>-->


## Examples

<!-- Extracted from docs/Examples.md -->

### Create a single Chip

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let chipView = MDCChipView()
chipView.titleLabel.text = "Tap me"
chipView.setTitleColor(UIColor.red, for: .selected)
chipView.sizeToFit()
chipView.addTarget(self, action: #selector(tap), for: .touchUpInside)
self.view.addSubview(chipView)
```

#### Objective-C

```objc
MDCChipView *chipView = [[MDCChipView alloc] init];
chipView.titleLabel.text = @"Tap me";
[chipView setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
[chipView sizeToFit];
[chipView addTarget:self
               action:@selector(tap:)
     forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:chipView];
```
<!--</div>-->


## Extensions

<!-- Extracted from docs/theming.md -->

### Theming

 `MDCChipView` supports Material Theming using a Container Scheme.
There are two variants for Material Theming of an MDCChipVIew, which are the default theme
and the outlined theme.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Import the Chips Theming Extensions module
import MaterialComponents.MaterialChips_MaterialTheming
 ...
 // Create or use your app's Container Scheme
let containerScheme = MDCContainerScheme()
 // Theme the chip with either default theme
chip.applyTheme(withScheme: containerScheme)
 // Or outlined theme
chip.applyOutlinedTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Import the Tabs Theming Extensions header
#import <MaterialComponents/MaterialChips+MaterialTheming.h>
 ...
 // Create or use your app's Container Scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
 // Theme the chip with either default theme
[self.chip applyThemeWithScheme:containerScheme];
 // Or outlined theme
[self.chip applyOutlinedThemeWithScheme:containerScheme];
```

<!--</div>-->
