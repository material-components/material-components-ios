---
title:  "Collections"
layout: detail
section: components
excerpt: "Collection view classes that adhere to Material design layout and animation styling."
---
# Collections

![Collections](docs/assets/appbar_screenshot.png)
<!--{: .ios-screenshot .right }-->

Collection view classes that adhere to Material design layout and animation styling.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/components/lists.html#lists-specs">Collection List Specs</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/components/Collections/apidocs/Classes/MDCCollectionViewController.html">MDCCollectionViewController</a></li>
  <li class="icon-link"><a href="/components/Collections/apidocs/Classes/MDCCollectionViewEditingManager.html">MDCCollectionViewEditingManager</a></li>
  <li class="icon-link"><a href="/components/Collections/apidocs/Protocols/MDCCollectionViewEditingManagerDelegate.html">MDCCollectionViewEditingManagerDelegate</a></li>
  <li class="icon-link"><a href="/components/Collections/apidocs/Classes/MDCCollectionViewFlowLayout.html">MDCCollectionViewFlowLayout</a></li>
  <li class="icon-link"><a href="/components/Collections/apidocs/Classes/MDCCollectionViewStyleManager.html">MDCCollectionViewStyleManager</a></li>
  <li class="icon-link"><a href="/components/Collections/apidocs/Protocols/MDCCollectionViewStyleManagerDelegate.html">MDCCollectionViewStyleManagerDelegate</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/Collections'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~

- - -

## Usage

### Importing

Before using Collections, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialCollections.h"
~~~

#### Swift
~~~ swift
import MaterialCollections
~~~
<!--</div>-->

### Use `MDCCollectionViewController` as a view controller

The following four steps will allow you to get a basic example to get a MDCCollectionViewController
up and running.

Step 1: **Subclass `MDCCollectionViewController` in your view controller interface**.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
#import "MaterialCollections.h"

@interface MyCollectionsExample : MDCCollectionViewController
@end
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

Step 2: **Setup your data**.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
_colors = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

Step 3: **Register a cell class**.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
[self.collectionView registerClass:[MDCCollectionViewTextCell class]
        forCellWithReuseIdentifier:kReusableIdentifierItem];
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

Step 4: **Override `UICollectionViewDataSource` protocol required methods**.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = _colors[indexPath.item];
  return cell;
}
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

- - -

### Styling the collection view

The `MDCCollectionViewStyleManager` class provides methods and properties for styling the
collection view. Styling can be set for the entire collection view, or by using the
`MDCCollectionViewStyleManagerDelegate` protocol methods to define styles at specific
sections and rows.

### Cell Styles

The style manager allows setting the cell style as Default, Grouped, or Card Style. Choose to
either set the style manager `cellStyle` property directly, or use the protocol method
`collectionView:cellStyleForSection:` to style per section.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
// Set for entire collection view.
self.styleManager.cellStyle = MDCCollectionViewCellStyleCard;

// Or set for specific sections.
- (MDCCollectionViewCellStyle)collectionView:(UICollectionView *)collectionView
                         cellStyleForSection:(NSInteger)section {
  if (section == 2) {
    return MDCCollectionViewCellStyleCard;
  }
  return MDCCollectionViewCellStyleGrouped;
}
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

### Cell Height

The style manager delegate protocol can be used to override the default cell height of 48.0f.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == 0) {
    return 80.0f;
  }
  return 48.0f;
}
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

### Cell Layout

The style manager allows setting the cell layout as List, Grid, or Custom.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
// Set as list layout.
self.styleManager.cellLayoutType = MDCCollectionViewCellLayoutTypeList;

// Or set as grid layout.
self.styleManager.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
self.styleManager.gridPadding = 8;
self.styleManager.gridColumnCount = 2;
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->

### Cell Separators

The style manager allows customizing cell separators for the entire collection view. Individual
cell customization can is available by using a cell subclassed from MDCCollectionViewCell. Learn
more by reading the section on [Cell Separators](../CollectionCells/#cell-separators) in the
[CollectionCells](../CollectionCells) component.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C

~~~ objc
// Set separator color.
self.styleManager.separatorColor = [UIColor redColor];

// Set separator insets.
self.styleManager.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);

// Set separator line height.
self.styleManager.separatorLineHeight = 1.0f;

// Whether to hide separators.
self.styleManager.shouldHideSeparators = NO;
~~~

#### Swift
~~~ swift
~~~
<!--</div>-->
