---
title:  "Collections"
layout: detail
section: components
excerpt: "Collection view classes that adhere to Material design layout and styling."
---
# Collections

![Collections](docs/assets/collections_screenshot.png)
<!--{: .ios-screenshot .right }-->

Collection view classes that adhere to Material design layout and styling.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/components/lists.html#lists-specs">Collection List Specs</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="apidocs/Classes/MDCCollectionViewController.html">MDCCollectionViewController</a></li>
  <li class="icon-link"><a href="apidocs/Protocols/MDCCollectionViewEditing.html">MDCCollectionViewEditing</a></li>
  <li class="icon-link"><a href="apidocs/Protocols/MDCCollectionViewEditingDelegate.html">MDCCollectionViewEditingDelegate</a></li>
  <li class="icon-link"><a href="apidocs/Classes.html#/c:objc(cs)MDCCollectionViewFlowLayout">MDCCollectionViewFlowLayout</a></li>
  <li class="icon-link"><a href="apidocs/Protocols/MDCCollectionViewStyling.html">MDCCollectionViewStyling</a></li>
  <li class="icon-link"><a href="apidocs/Protocols/MDCCollectionViewStylingDelegate.html">MDCCollectionViewStylingDelegate</a></li>
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
pod install
~~~

- - -

## Overview

The Collections component consists of a set of collection view related classes that adhere to
Material Design layout and styling. Typically you will subclass the `MDCCollectionViewController`,
which in turn subclasses `UICollectionViewController`. This controller provides the collection view
used as its content.

In addition, `MDCCollectionViewController` also provides two key properties used to style and
interact with the collection view. Firstly, the `styler` property, which conforms to the
`MDCCollectionViewStyling` protocol, provides methods and properties to change the styling of the
collection view. The default `styler` values will provide a look and feel consistent with Material
Design principles, however it is also customizable. Secondly, the `editor` property, which conforms
to the `MDCCollectionViewEditing` protocol, allows putting the collection view into various editing
modes. Some of the available editing interactions are swipe-to-dismiss sections and/or index paths,
multi-select rows for deletion, and reordering of rows.

The `MDCCollectionViewController` conforms to both the `MDCCollectionViewStylingDelegate` and
`MDCCollectionViewEditingDelegate` protocols which provide a mechanism for your subclasses to
set styling and editing properties both at index paths as well as for the entire collection view.
By implementing the editing delegate methods, you may receive notifications of editing state changes
allowing your data to stay in sync with any edits.

### Links to documentation

The collections documentation is broken down into the following three sections:

  - [**Usage**](#usage)
  - [**Styling** the collection view](#styling-the-collection-view)
  - [**Editing** the collection view](#editing-the-collection-view)

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
import MaterialComponents.MaterialCollections
~~~
<!--</div>-->

### Use `MDCCollectionViewController` as a view controller

The following four steps will allow you to get a basic example of a `MDCCollectionViewController`
subclass up and running.

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
import MaterialComponents.MaterialCollections

class MyCollectionsExample: MDCCollectionViewController {
}
~~~
<!--</div>-->

Step 2: **Setup your data**.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
colors = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];
~~~

#### Swift
~~~ swift
let colors = [ "red", "blue", "green", "black", "yellow", "purple" ]
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
self.collectionView?.registerClass(MDCCollectionViewTextCell.self,
                                   forCellWithReuseIdentifier: reusableIdentifierItem)
~~~
<!--</div>-->

Step 4: **Override `UICollectionViewDataSource` protocol required methods**.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = colors[indexPath.item];
  return cell;
}
~~~

#### Swift
~~~ swift
override func collectionView(collectionView: UICollectionView,
                             numberOfItemsInSection section: Int) -> Int {
  return colors.count
}

override func collectionView(collectionView: UICollectionView,
                             cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
  var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableIdentifierItem,
                                                                   forIndexPath: indexPath)
  if let cell = cell as? MDCCollectionViewTextCell {
    cell.textLabel?.text = colors[indexPath.item]
  }

  return cell
}
~~~
<!--</div>-->

- - -

## Styling the collection view

`MDCCollectionViewController` provides a `styler` property that conforms to the
`MDCCollectionViewStyling` protocol. By using this property, styling can be easily set for the
collection view items/sections. In addition, by overriding `MDCCollectionViewStyleDelegate`
protocol methods in a collection view controller subclass, specific cells/sections can be styled
differently.


### Cell Styles

The `styler` allows setting the cell style as Default, Grouped, or Card Style. Choose to
either set the `styler.cellStyle` property directly, or use the protocol method
`collectionView:cellStyleForSection:` to style per section.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Set for entire collection view.
self.styler.cellStyle = MDCCollectionViewCellStyleCard;

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
// Set for entire collection view.
self.styler.cellStyle = .Card

// Or set for specific sections.
override func collectionView(collectionView: UICollectionView,
                             cellStyleForSection section: Int) -> MDCCollectionViewCellStyle {
  if section == 2 {
    return .Card
  }
  return .Grouped
}
~~~
<!--</div>-->

### Cell Height

The styling delegate protocol can be used to override the default cell height of `48.0f`.

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
override func collectionView(collectionView: UICollectionView,
                             cellHeightAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  if indexPath.item == 0 {
    return 80.0
  }
  return 48.0
}
~~~
<!--</div>-->

### Cell Layout

The styler allows setting the cell layout as List, Grid, or Custom.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Set as list layout.
self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeList;

// Or set as grid layout.
self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
self.styler.gridPadding = 8;
self.styler.gridColumnCount = 2;
~~~

#### Swift
~~~ swift
// Set as list layout.
self.styler.cellLayoutType = .List

// Or set as grid layout.
self.styler.cellLayoutType = .Grid
self.styler.gridPadding = 8
self.styler.gridColumnCount = 2
~~~
<!--</div>-->

### Cell Separators

The styler allows customizing cell separators for the entire collection view. Individual
cell customization is also available by using an `MDCCollectionViewCell` cell or a subclass of it.
Learn more by reading the section on [Cell Separators](../CollectionCells/#cell-separators) in the
[CollectionCells](../CollectionCells/) component.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Set separator color.
self.styler.separatorColor = [UIColor redColor];

// Set separator insets.
self.styler.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);

// Set separator line height.
self.styler.separatorLineHeight = 1.0f;

// Whether to hide separators.
self.styler.shouldHideSeparators = NO;
~~~

#### Swift
~~~ swift
// Set separator color.
self.styler.separatorColor = UIColor.redColor()

// Set separator insets.
self.styler.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16)

// Set separator line height.
self.styler.separatorLineHeight = 1.0

// Whether to hide separators.
self.styler.shouldHideSeparators = false
~~~
<!--</div>-->


### Background colors

A background color can be set on the collection view. Also, individual cell background colors can be
set by using the protocol method `collectionView:cellBackgroundColorAtIndexPath:`. The default
background colors are `#EEEEEE` for the collection view and `#FFFFFF` for the cells.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Set collection view background color.
self.collectionView.backgroundColor = [UIColor grayColor];

// Set individual cell background colors.
- (UIColor *)collectionView:(UICollectionView *)collectionView
    cellBackgroundColorAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == 0) {
    return [UIColor blueColor];
  }
  return [UIColor redColor];
}
~~~

#### Swift
~~~ swift
// Set collection view background color.
self.collectionView?.backgroundColor = UIColor.grayColor()

// Set individual cell background colors.
override func collectionView(collectionView: UICollectionView,
                             cellBackgroundColorAtIndexPath indexPath: NSIndexPath) -> UIColor? {
  if indexPath.item == 0 {
    return UIColor.blueColor()
  }
  return UIColor.redColor()
}
~~~
<!--</div>-->

- - -

## Editing the collection view

The collection view controller provides an `editor` property that conforms to the
`MDCCollectionViewEditing` protocol. Use this property to set the collection view into editing mode
with/without animation. Override the `MDCCollectionViewEditingDelegate` protocol methods as needed
in a collection view controller subclass to handle editing permissions and notification callbacks.

### Enable editing mode

The `editor` allows putting the collection view into editing mode with/without animation. Override
the protocol method `collectionView:canEditItemAtIndexPath:` to enable/disable editing at specific
index paths. When a collection view has editing enabled, all of the cells will be inlaid. Using the
additional protocol delegate methods, you can override which specific cells allow reordering and
selection for deletion.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Enable editing.
[self.editor setEditing:YES animated:YES];

// Optionally set editing for specific index paths.
- (BOOL)collectionView:(UICollectionView *)collectionView
    canEditItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.item != 0);
}
~~~

#### Swift
~~~ swift
// Enable editing.
self.editor.setEditing(true, animated: true)

// Optionally set editing for specific index paths.
override func collectionView(collectionView: UICollectionView,
                             canEditItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return indexPath.item != 0
}
~~~
<!--</div>-->

### Deleting Cells

Cells can be deleted by first [enabling editing mode](#enable-editing). Next enable cell editing by
overriding the `collectionViewAllowsEditing:` protocol method and returning `YES`. You can disable
specific cells from being able to be deleted by returning `NO` from the
`collectionView:canSelectItemDuringEditingAtIndexPath:` protocol method at the desired index paths.
Once these deletion permissions are set, the UI will display a selector icon at right of cell,
allowing cells to be selected for deletion by user. Upon selecting one or more cells, a Delete
action bar will animate up from bottom of screen. Upon hitting the delete bar, a call to protocol
method `collectionView:willDeleteItemsAtIndexPaths` will allow you to remove the appropriate data
at the specified index paths from your `UICollectionViewDataSource`. As a result, the cells will get
removed with animation, and the Delete action bar will animate away as well.

The following illustrates a simple cell deletion example.

> For this example, we are assuming a simple data source array of strings:
> `data = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];`

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Enable editing.
[self.editor setEditing:YES animated:YES];

// Enable cell deleting.
- (BOOL)collectionViewAllowsEditing:(UICollectionView *)collectionView {
  return YES;
}

// Remove selected index paths from our data.
- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
  // First sort reverse order then remove. This is done because when we delete an index path the
  // higher rows shift down, altering the index paths of those that we would like to delete in the
  // next iteration of this loop.
  NSArray *sortedArray = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
  for (NSIndexPath *indexPath in [sortedArray reverseObjectEnumerator]) {
    [data removeObjectAtIndex:indexPath.item];
  }
}
~~~

#### Swift
~~~ swift
// Enable editing.
self.editor.setEditing(true, animated: true)

// Enable cell deleting.
override func collectionViewAllowsEditing(collectionView: UICollectionView) -> Bool {
  return true
}

// Remove selected index paths from our data.
override func collectionView(collectionView: UICollectionView,
                             willDeleteItemsAtIndexPaths indexPaths: [NSIndexPath]) {
  // First sort reverse order then remove. This is done because when we delete an index path the
  // higher rows shift down, altering the index paths of those that we would like to delete in the
  // next iteration of this loop.
  for indexPath in indexPaths.sort({$0.item > $1.item}) {
    data.removeAtIndex(indexPath.item)
  }
}
~~~
<!--</div>-->

### Reordering Cells

Cells can be dragged to reorder by first [enabling editing mode](#enable-editing). Next enable cell
reordering by overriding the `collectionViewAllowsReordering:` protocol method and returning `YES`.
You can disable specific cells from being able to be reordered by returning `NO` from the
`collectionView:canMoveItemAtIndexPath:` protocol method at the desired index paths. Once these
reordering permissions are set, the UI will display a reordering icon at left of cell, allowing
cells to be dragged for reordering by user. Upon moving a cell, a call to protocol
method `collectionView:willMoveItemAtIndexPath:toIndexPath` will allow you to exchange the
appropriate data at the specified index paths from your `UICollectionViewDataSource`.

The following illustrates a simple cell reorder example.

> For this example, we are assuming a simple data source array of strings:
> `data = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];`

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Enable editing.
[self.editor setEditing:YES animated:YES];

// Enable cell reordering.
- (BOOL)collectionViewAllowsReordering:(UICollectionView *)collectionView {
  return YES;
}

// Reorder moved index paths within our data.
- (void)collectionView:(UICollectionView *)collectionView
    willMoveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath {
  [_content exchangeObjectAtIndex:indexPath.item  withObjectAtIndex:newIndexPath.item];
}
~~~

#### Swift
~~~ swift
// Enable editing.
self.editor.setEditing(true, animated: true)

// Enable cell reordering.
override func collectionViewAllowsReordering(collectionView: UICollectionView) -> Bool {
  return true
}

// Reorder moved index paths within our data.
override func collectionView(collectionView: UICollectionView,
                             willMoveItemAtIndexPath indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
  swap(&data[indexPath.item], &data[newIndexPath.item])
}
~~~
<!--</div>-->

### Swipe to dismiss item at index path

Cells at desired index paths can be swiped left/right for deletion. Enable this functionality by
returning `YES` from the `collectionViewAllowsSwipeToDismissItem` protocol method. Then provide
permissions for specific index paths by overriding the
`collectionView:canSwipeToDismissItemAtIndexPath` method. Note, editing mode is **not** required
to be enabled for swiping-to-dismiss to be allowed. Once a user swipes a cell, a call to protocol
method `collectionView:willDeleteItemsAtIndexPaths` will allow you to remove the appropriate data
at the specified index paths from your `UICollectionViewDataSource`.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Enable swipe-to-dismiss items.
- (BOOL)collectionViewAllowsSwipeToDismissItem:(UICollectionView *)collectionView {
  return YES;
}

// Override permissions at specific index paths.
- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(NSIndexPath *)indexPath {
  // In this example we are allowing all items to be dismissed except this first item.
  return indexPath.item != 0;
}

// Remove swiped index paths from our data.
- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *) *)indexPaths {
  for (NSIndexPath *indexPath in indexPaths) {
    [data removeObjectAtIndex:indexPath.item];
  }
}
~~~

#### Swift
~~~ swift
// Enable swipe-to-dismiss items.
override func collectionViewAllowsSwipeToDismissItem(collectionView: UICollectionView) -> Bool {
  return true
}

// Override permissions at specific index paths.
override func collectionView(collectionView: UICollectionView,
                             canSwipeToDismissItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  // In this example we are allowing all items to be dismissed except this first item.
  return indexPath.item != 0
}

// Remove swiped index paths from our data.
override func collectionView(collectionView: UICollectionView,
                             willDeleteItemsAtIndexPaths indexPaths: [NSIndexPath]) {
  for indexPath in indexPaths {
    data.removeAtIndex(indexPath.item)
  }
}
~~~
<!--</div>-->

### Swipe to dismiss section

Cells at desired sections can be swiped left/right for deletion. Enable this functionality by
returning `YES` from the `collectionViewAllowsSwipeToDismissSection` protocol method. Then provide
permissions for specific section by overriding the `collectionView:canSwipeToDismissSection` method.
Note, editing mode is **not** required to be enabled for swiping-to-dismiss to be allowed. Once a
user swipes a section, a call to protocol method `collectionView:willDeleteSections` will allow you
to remove the appropriate data at the specified section from your `UICollectionViewDataSource`.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
// Enable swipe-to-dismiss sections.
- (BOOL)collectionViewAllowsSwipeToDismissSection:(UICollectionView *)collectionView {
  return YES;
}

// Override permissions at specific section.
- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissSection:(NSInteger)section {
  // In this example we are allowing all sections to be dismissed except this first section.
  return indexPath.section != 0;
}

// Remove swiped sections from our data.
- (void)collectionView:(UICollectionView *)collectionView
    willDeleteSections:(NSIndexSet *)sections {
  [_content removeObjectsAtIndexes:sections];
}
~~~

#### Swift
~~~ swift
// Enable swipe-to-dismiss sections.
override func collectionViewAllowsSwipeToDismissItem(collectionView: UICollectionView) -> Bool {
  return true
}

// Override permissions at specific section.
override func collectionView(collectionView: UICollectionView,
                             canSwipeToDismissSection section: Int) -> Bool {
  // In this example we are allowing all sections to be dismissed except this first section.
  return indexPath.section != 0
}

// Remove swiped sections from our data.
override func collectionView(collectionView: UICollectionView,
                             willDeleteSections sections: NSIndexSet) {
  for (index, item) in sections.reverse().enumerate() {
    data.removeAtIndex(index)
  }
}
~~~
<!--</div>-->
