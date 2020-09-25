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

[Chips](https://material.io/components/chips) are compact elements that represent an input, attribute, or action.

![Chips hero image](docs/assets/chips-hero.png)

## Contents

* [Using chips](#using-chips)
* [Input chips](#input-chips)
* [Choice chips](#choice-chips)
* [Filter chips](#filter-chips)
* [Action chips](#action-chips)
* [Theming chips](#theming-chips)

## Using chips

### Installing chips

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Chips'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing chips

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

### Usage

Create and add a single chip to your view controller just like any other `UIView`.

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

### Making chips accessible

Always ensure that your chips meet minimum touch requirements, as defined by either Apple's Human Interface Guidelines or Material. Material recommends a 48x48 minimum touch target.

Remember to set any relevation `accessibilityLabels` or `accessibilityTraits`, especially if you are not satisfied with default system values.

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

### Adjusting chip sizes after changing the label

If the label of a chip in a collection view can be changed dynamically (e.g. in reaction to a user's
tap), then you may notice that the chip's frame does not automatically update to accomodate the new
size of the chip's label. To force your chip to update its layout when this happens you can invoke
`invalidateIntrinsicContentSize` on the chip view. For example:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
chipView.invalidateIntrinsicContentSize()
```

#### Objective-C
```objc
[chipView invalidateIntrinsicContentSize];
```
<!--</div>-->

## Types

There are four types of chips:

1. [input (text entry)](#input-chips)
1. [choice](#choice-chips)
1. [filter](#filter-chips)
1. [action](#action-chips)

![Examples of the four different chip types](docs/assets/chips-composite.png)

### Input chips

Input chips represent a complex piece of information in compact form, such as an entity (person, place, or thing) or text. They enable user input and verify that input by converting text into chips.

We currently provide an implementation of Input Chips called `MDCChipField`.

```objc
MDCChipField *chipField = [[MDCChipField alloc] init];
chipField.delegate = self;
chipField.textField.placeholderLabel.text = @"This is a chip field.";
chipField.showChipsDeleteButton = true
[chipField sizeToFit];
[self.view addSubview:chipField];
```
<!--</div>-->

### Choice chips

Choice chips allow selection of a single chip from a set of options.

Choice chips clearly delineate and display options in a compact area. They are a good alternative to toggle buttons, radio buttons, and single select menus.

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

### Filter chips

Filter chips use tags or descriptive words to filter content.

Filter chips clearly delineate and display options in a compact area. They are a good alternative to toggle buttons or checkboxes.

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

### Action chips

Action chips offer actions related to primary content. They should appear dynamically and contextually in a UI.

An alternative to action chips are buttons, which should appear persistently and consistently.

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

### Anatomy and key properties

The following is an anatomy diagram of a chip:

![Chip anatomy diagram](docs/assets/chips-anatomy.png)

1.  Container
1.  Thumbnail (optional)
1.  Text
1.  Remove icon (optional)

#### Container attributes

&nbsp;               | Attribute                        | Related method(s)                               | Default value
-------------------- | -------------------------------- | ------------------------------- | -------------
**Color**            | N/A                              | `-setBackgroundColor:forState:`<br/>`-backgroundColorForState:`  | On surface color at 12% opacity
**Ripple color**     | N/A                              | `-setRippleColor:forState:`<br/>`-rippleColorForState:`  | White at 14% opacity
**Stroke width**     | N/A                              | `-setBorderWidth:forState:`<br/>`-borderWidthForState:`  | 0
**Stroke color**     | N/A                              | `-setBorderColor:forState:`<br/>`-borderColorForState:`  | `nil`
**Min height**       | `minimumSize`                    | N/A                                                      | `{ 0, 32 }`
**Padding**          | `contentPadding` | N/A | `{ 4, 4, 4, 4 }` 
**Min touch target** | `centerVisibleArea`, `visibleAreaInsets` | N/A                          | `NO`, `{ 0, 0, 0, 0 }`

#### Thumbnail attributes

**Chip icon**

&nbsp;         | Attribute                                       | Related method(s)                                                     | Default value
-------------- | ----------------------------------------------- | --------------------------------------------------------------------- | -------------
**Icon**       | `imageView`, `selectedImageView`                | N/A                                                                   | `nil`
**Padding**    | `imagePadding`, `accessoryPadding` | N/A | `{ 0, 0, 0, 0 }`, `{ 0, 0, 0, 0 }`

#### Text attributes

&nbsp;         | Attribute                                       | Related method(s)                                                           | Default value
-------------- | ----------------------------------------------- | --------------------------------------------------------------------------- | -------------
**Text label** | `titleLabel`                                    | N/A                   | N/A
**Color**       | N/A                              | `-setTitleColor:forState:`<br/>`-titleColorForState:`  | On surface color at 87% opacity
**Typography** | `titleFont`                        | N/A | Body 2
**Padding**    | `titlePadding` | N/A       | `{ 3, 8, 4, 8 }`

## Theming chips

`MDCChipView` supports Material Theming using a Container Scheme.
There are two variants for Material Theming of an `MDCChipView`, which are the default theme and the outlined theme.

Below is a Chip collection with the Shrine theme applied to it.

![shrine-chips](docs/assets/shrine-chips.png)

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
