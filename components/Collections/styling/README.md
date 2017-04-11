---
title: "Styling the collection view"
layout: detail
section: components
iconId: list
---
# Styling the collection view

`MDCCollectionViewController` provides a `styler` property that conforms to the
`MDCCollectionViewStyling` protocol. By using this property, styling can be easily set for the
collection view items/sections. In addition, by overriding `MDCCollectionViewStyleDelegate`
protocol methods in a collection view controller subclass, specific cells/sections can be styled
differently.

## Table of Contents
- [Cell Styles](#cell-styles)
- [Cell Height](#cell-height)
- [Cell Layout](#cell-layout)
- [Cell Separators](#cell-separators)
- [Background colors](#background-colors)

- - -

### Cell Styles

The `styler` allows setting the cell style as Default, Grouped, or Card Style. Choose to
either set the `styler.cellStyle` property directly, or use the protocol method
`collectionView:cellStyleForSection:` to style per section.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~swift
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

#### Objective-C
~~~objc
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
<!--</div>-->

### Cell Height

The styling delegate protocol can be used to override the default cell height of `48.0f`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~swift
override func collectionView(collectionView: UICollectionView,
                             cellHeightAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  if indexPath.item == 0 {
    return 80.0
  }
  return 48.0
}
~~~

#### Objective-C
~~~objc
- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == 0) {
    return 80.0f;
  }
  return 48.0f;
}
~~~
<!--</div>-->

### Cell Layout

The styler allows setting the cell layout as List, Grid, or Custom.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~swift
// Set as list layout.
self.styler.cellLayoutType = .List

// Or set as grid layout.
self.styler.cellLayoutType = .Grid
self.styler.gridPadding = 8
self.styler.gridColumnCount = 2
~~~

#### Objective-C
~~~objc
// Set as list layout.
self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeList;

// Or set as grid layout.
self.styler.cellLayoutType = MDCCollectionViewCellLayoutTypeGrid;
self.styler.gridPadding = 8;
self.styler.gridColumnCount = 2;
~~~
<!--</div>-->

### Cell Separators

The styler allows customizing cell separators for the entire collection view. Individual
cell customization is also available by using an `MDCCollectionViewCell` cell or a subclass of it.
Learn more by reading the section on [Cell Separators](../CollectionCells/#cell-separators) in the
[CollectionCells](../CollectionCells/) component.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~swift
// Set separator color.
self.styler.separatorColor = UIColor.redColor()

// Set separator insets.
self.styler.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16)

// Set separator line height.
self.styler.separatorLineHeight = 1.0

// Whether to hide separators.
self.styler.shouldHideSeparators = false
~~~

#### Objective-C
~~~objc
// Set separator color.
self.styler.separatorColor = [UIColor redColor];

// Set separator insets.
self.styler.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);

// Set separator line height.
self.styler.separatorLineHeight = 1.0f;

// Whether to hide separators.
self.styler.shouldHideSeparators = NO;
~~~
<!--</div>-->

### Background colors

A background color can be set on the collection view. Also, individual cell background colors can be
set by using the protocol method `collectionView:cellBackgroundColorAtIndexPath:`. The default
background colors are `#EEEEEE` for the collection view and `#FFFFFF` for the cells.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~swift
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

#### Objective-C
~~~objc
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
<!--</div>-->
