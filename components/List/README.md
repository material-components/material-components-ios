<!--docs:
title: "Lists"
layout: detail
section: components
excerpt: "Material Design Lists are a continuous group of text or images. They are composed of items containing primary and supplemental actions, which are represented by icons and text."
api_doc_root: true
-->

# Lists

Material Design Lists are a continuous group of text or images. They are composed of items containing primary and supplemental actions, which are represented by icons and text.

## Status

The [Lists component](https://material.io/go/design-lists) is yet to be completed, please follow the [tracking issue](https://www.pivotaltracker.com/epic/show/3950586) for more information.

In the meanwhile, we are offering a fully featured example on how to implement a list cell that is self-sizing, supports dynamic type, and right-to-left using pure UIKit classes. 
We will walk through the example and discuss things needed to achieve a list cell implementation of your own.

## Example Walkthrough / How to implement your own List Cell

The example files can be found <a href="examples/">here</a>

Our example consists of a `UICollectionViewController` class: <a href="examples/CollectionListCellExampleTypicalUse.m">examples/CollectionListCellExampleTypicalUse.m</a>
and also of a custom `UICollectionViewCell` class: <a href="examples/supplemental/CollectionViewListCell.m">examples/supplemental/CollectionViewListCell.m</a>.

Our main focus will be on the custom cell as that where all the logic goes in, whereas the collection view and its controller are using mostly boilerplate code of setting up a simple example and collection view.

### Layout

### Ink

### Self Sizing

### Typography

### Dynamic Type


