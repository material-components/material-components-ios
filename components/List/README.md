<!--docs:
title: "List"
layout: detail
section: components
excerpt: "Material Design Lists are used to show continuous groups of images or text."
iconId: <#icon_id#>
path: /catalog/list/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme List -->

# List

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BList%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BList%5D)

Material Design Lists are continuous groups of text and/or images. The [Material guidelines](https://material.io/go/design-lists) for Lists are extensive, and there is no class at this time for implementing any one of them, let alone all of them. However, we are starting to add classes that represent individual List Items. We currently offer two List Item Cells:

### MDCBaseCell

The MDCBaseCell is a List Item at its simplest--a basic UICollectionViewCell subclass with Material Ink Ripple and Elevation. The MDCBaseCell provides a starting point to build anything the guidelines provide. To build a List using the MDCBaseCell simply treat it like you would any other UICollectionViewCell.

Below is an example:

![MDCBaseCell Example](https://user-images.githubusercontent.com/8020010/42164205-3a7f699a-7dfd-11e8-9109-a7a6040996db.gif)

### MDCSelfSizingStereoCell

The MDCSelfSizingStereoCell is a subclass of MDCBaseCell. It exposes two image views (trailing and leading) and two labels (title and detail) that the user can configure however they like.

Below is an example:

![MDCSelfSizingStereoCell Example](https://user-images.githubusercontent.com/8020010/44807557-dcf11a80-ab97-11e8-83a6-6d7b69e59ecd.gif)

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/go/lists">Material Design guidelines: Lists</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/list/api-docs/Classes/MDCBaseCell.html">MDCBaseCell</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/list/api-docs/Classes/MDCSelfSizingStereoCell.html">MDCSelfSizingStereoCell</a></li>
</ul>

## Table of contents

- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use](#typical-use)
- [Extensions](#extensions)
  - [Color Theming](#color-theming)
  - [Typography Theming](#typography-theming)
- [Accessibility](#accessibility)
  - [Setting `-isAccessibilityElement`](#setting-`-isaccessibilityelement`)
- [How to implement your own List Cell](#how-to-implement-your-own-list-cell)
  - [Layout](#layout)
  - [Ink Ripple](#ink-ripple)
  - [Self Sizing](#self-sizing)
  - [Typography](#typography)
  - [Dynamic Type](#dynamic-type)
  - [iPhone X Safe Area Support](#iphone-x-safe-area-support)
  - [Landscape Support](#landscape-support)
  - [Right to Left Text Support](#right-to-left-text-support)


## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/List'
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
import MaterialComponents.MaterialList
```

#### Objective-C

```objc
#import "MaterialList.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/typical-use.md -->

### Typical use

Because List Items ultimately inherit from UICollectionViewCell, clients are not expected to instantiate them themselves. Rather, cell classes are registered with UICollectionViews. Then, in `-collectionView:cellForItemAtIndexPath:`, the client is expected to cast the cell to a List Item class.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// registering the cell
collectionView.register(MDCBaseCell.self, forCellWithReuseIdentifier: "baseCellIdentifier")

// casting the cell to the desired type within `-collectionView:cellForItemAtIndexPath:`
guard let cell = collectionView.cellForItem(at: indexPath) as? MDCBaseCell else { fatalError() }
```

#### Objective-C

```objc
// registering the cell
[self.collectionView registerClass:[MDCBaseCell class]
        forCellWithReuseIdentifier:@"BaseCellIdentifier"];

// casting the cell to the desired type within `-collectionView:cellForItemAtIndexPath:`
MDCBaseCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseCellIdentifier"
                                              forIndexPath:indexPath];
```
<!--</div>-->


## Extensions

<!-- Extracted from docs/color-theming.md -->

### Color Theming

You can theme a List Item with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod `MaterialComponents/List+ColorThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialList_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
MDCListColorThemer.applySemanticColorScheme(colorScheme, to: cell)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialList+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSematnicColorScheme alloc] init];

// Step 3: Apply the color scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
[MDCListColorThemer applySemanticColorScheme:colorScheme
                                  toBaseCell:cell];
```
<!--</div>-->

<!-- Extracted from docs/typography-theming.md -->

### Typography Theming

You can theme a List Item cell with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod `MaterialComponents/List+TypographyThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialList_TypographyThemer

// Step 2: Create or get a color scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the typography scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
MDCListTypographyThemer.applyTypographyScheme(typographyScheme, to: cell)
```

#### Objective-C

```objc
// Step 1: Import the Typography extension
#import "MaterialList+TypographyThemer.h"

// Step 2: Create or get a color scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the typography scheme to your component from within `-collectionView:cellForItemAtIndexPath:`
[MDCListTypographyThemer applyTypographyScheme:self.typographyScheme
                                    toBaseCell:cell];
```
<!--</div>-->


<!-- Extracted from docs/accessibility.md -->

## Accessibility

To help ensure your Lists are accessible to as many users as possible, please be sure to review the following
recommendations:

### Setting `-isAccessibilityElement`

It is generally recommended to set UICollectionViewCells (and UITableViewCells) as accessibilityElements. That way, VoiceOver doesn't traverse the entire cell and articulate an overwhelming amount of accessibility information for each of its subviews.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
cell.isAccessibilityElement = true
```

#### Objective-C

```objc
cell.isAccessibilityElement = YES;
```
<!--</div>-->


## How to implement your own List Cell

<!-- Extracted from docs/create-your-own.md -->

The example files can be found <a href="examples/">here</a>

<img src="docs/assets/listcellexample.gif" alt="List Cell Example" width="300">

Our example consists of a custom `UICollectionViewController`: <a href="examples/CollectionListCellExampleTypicalUse.m">examples/CollectionListCellExampleTypicalUse.m</a>
and also of a custom `UICollectionViewCell`: <a href="examples/supplemental/CollectionViewListCell.m">examples/supplemental/CollectionViewListCell.m</a>.

The main focus will be on the custom cell as that's where all the logic goes in, whereas the collection view and its controller are using mostly boilerplate code of setting up a simple example and collection view.

### Layout
For our example we will have a layout consisting of a left aligned `UIImageView`, a title text `UILabel` and a details text `UILabel`. The title text will have a max of 1 line whereas the details text can be up to 3 lines. It is important to note that neither the image nor the labels need to be set. To see more of the spec guidelines for Lists please see here: <a href="https://material.io/go/design-lists">https://material.io/go/design-lists</a>

To create our layout we used auto layout constraints that are all set up in the `(void)setupConstraints` method in our custom cell. It is important to make sure we set `translatesAutoresizingMaskIntoConstraints` to `NO` for all the views we are applying constraints on.

### Ink Ripple
Interactable Material components and specifically List Cells have an ink ripple when tapped on. To add ink to your cells there are a few steps you need to take:

1. Add an `MDCInkView` property to your custom cell.

2. Initialize `MDCInkView` on init and add it as a subview:

```objc
_inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
_inkView.usesLegacyInkRipple = NO;
[self addSubview:_inkView];
```

3. Initialize a `CGPoint` property in your cell (`CGPoint _lastTouch;`) to indicate where the last tap was in the cell.

4. Override the `UIResponder`'s `touchesBegan` method in your cell to identify and save where the touches were so we can then start the ripple animation from that point:

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;

  [super touchesBegan:touches withEvent:event];
}
```

5. Override the `setHighlighted` method for your cell and apply the start and stop ripple animations:

```objc
- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [_inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [_inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}
```

6. When the cell is reused we must make sure no outstanding ripple animations stay on the cell so we need to clear the ink before:

```objc
- (void)prepareForReuse {
  [_inkView cancelAllAnimationsAnimated:NO];
  [super prepareForReuse];
}
```

Now there is ink in our cells!

### Self Sizing
In order to have cells self-size based on content and not rely on magic number constants to decide how big they should be, we need to follow these steps:

1. apply autoulayout constraints of our added subviews relative to each other and their superview (the cell's `contentView`). We need to make sure our constraints don't define static heights or widths but rather constraints that are relative or our cell won't calculate itself based on the dynamically sized content.

You can see how it is achieved in the `(void)setupConstraints` method in our example. If you'll notice there are some constraints that are set up to be accessible throughout the file:

```objc
NSLayoutConstraint *_imageLeftPaddingConstraint;
NSLayoutConstraint *_imageRightPaddingConstraint;
NSLayoutConstraint *_imageWidthConstraint;
``` 
This is in order to support the changing layout if an image is set or not.

2. Because our list cells need to fill the entire width of the collection view, we want to expose the cell's width to be settable by the view controller when the cell is set up. For that we expose a `setCellWidth` method that sets the width constraint of the `contentView`:

```objc
- (void)setCellWidth:(CGFloat)width {
  _cellWidthConstraint.constant = width;
  _cellWidthConstraint.active = YES;
}
```

and then in the collection view's `cellForItemAtIndexPath` delegate method we set the width:

```objc
CGFloat cellWidth = CGRectGetWidth(collectionView.bounds);
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
if (@available(iOS 11.0, *)) {
  cellWidth -=
    (collectionView.adjustedContentInset.left + collectionView.adjustedContentInset.right);
}
#endif
[cell setCellWidth:cellWidth];
```


3. In our collection view's flow layout we must set an `estimatedItemSize` so the collection view will defer the size calculations to its content.

Note: It is better to set the size smaller rather than larger or constraints might break in runtime.

```objc
_flowLayout.estimatedItemSize = CGSizeMake(kSmallArbitraryCellWidth, kSmallestCellHeight);
```

### Typography

For our example we use a typography scheme to apply the fonts to our cell's `UILabel`'s. Please see <a href="../schemes/Typography">Typography Scheme</a> for more info.

### Dynamic Type

<a href="https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/">Dynamic Type</a> allows users to indicate a system-wide preferred text size. To support it in our cells we need to follow these steps:

1. Set each of the label fonts to use the dynamically sized MDC fonts in their set/update methods:
```objc
- (void)updateTitleFont {
  if (!_titleFont) {
    _titleFont = defaultTitleFont();
  }
  _titleLabel.font =
    [_titleFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                             scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  [self setNeedsLayout];
}
```

2. Add an observer in the cell to check for the `UIContentSizeCategoryDidChangeNotification` which tells us the a system-wide text size has been changed.

```objc
[[NSNotificationCenter defaultCenter]
    addObserver:self
       selector:@selector(contentSizeCategoryDidChange:)
           name:UIContentSizeCategoryDidChangeNotification
         object:nil];
```

In the selector update the font sizes to reflect the change:
```objc
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateTitleFont];
  [self updateDetailsFont];
}
```

3. Add an observer also in the `UIViewController` so we can reload the collection view once there is a change:

```objc
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self.collectionView reloadData];
}
``` 

### iPhone X Safe Area Support

Our collection view needs to be aware of the safe areas when being presented on iPhone X. To do so need to set its `contentInsetAdjustmentBehavior` to be aware of the safe area:

```objc
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
if (@available(iOS 11.0, *)) {
  self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
}
#endif
```

Lastly, as seen in the self-sizing section on step 2, when setting the width of the cell we need to set it to be the width of the collection view bounds minus the adjustedContentInset that now insets based on the safe area.

### Landscape Support

In your view controller you need to invalidate the layout of your collection view when there is an orientation change. Please see below for the desired code changes to achieve that:

```objc
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self.collectionView.collectionViewLayout invalidateLayout];
  [self.collectionView reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [self.collectionView.collectionViewLayout invalidateLayout];

  [coordinator animateAlongsideTransition:nil completion:^(__unused id context) {
    [self.collectionView.collectionViewLayout invalidateLayout];
  }];
}
```

### Right to Left Text Support

To support right to left text we need to import `MDFInternationalization`:

```objc
#import <MDFInternationalization/MDFInternationalization.h>
```

and for each of our cell's subviews me need to update the `autoResizingMask`:

```objc
_titleLabel.autoresizingMask =
    MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);
``` 

