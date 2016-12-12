# Collections

<!--{% if site.link_to_site == "true" %}-->
[![Collections](docs/assets/collections.png)](docs/assets/collections.mp4)
<!--{% else %}<div class="ios-animation right" markdown="1"><video src="docs/assets/collections.mp4" autoplay loop></video></div>{% endif %}-->

Collection view classes that adhere to Material design layout and styling.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/components/lists.html#lists-specs">Collection List Specs</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Collections/apidocs/Classes/MDCCollectionViewController.html">MDCCollectionViewController</a></li>
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Collections/apidocs/Protocols/MDCCollectionViewEditing.html">MDCCollectionViewEditing</a></li>
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Collections/apidocs/Protocols/MDCCollectionViewEditingDelegate.html">MDCCollectionViewEditingDelegate</a></li>
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Collections/apidocs/Classes.html#/c:objc(cs)MDCCollectionViewFlowLayout">MDCCollectionViewFlowLayout</a></li>
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Collections/apidocs/Protocols/MDCCollectionViewStyling.html">MDCCollectionViewStyling</a></li>
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/Collections/apidocs/Protocols/MDCCollectionViewStylingDelegate.html">MDCCollectionViewStylingDelegate</a></li>
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
material design layout and styling. Typically you will subclass the `MDCCollectionViewController`,
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

## Table of Contents
- [Importing](#importing)
- [Use `MDCCollectionViewController` as a view controller](#use-mdccollectionviewcontroller-as-a-view-controller)
- [Provide own UICollectionView](#provide-own-uicollectionview)
- [Styling the collection view](styling/)
- [Editing the collection view](editing/)

- - -

## Usage

### Importing

Before using Collections, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
import MaterialComponents.MaterialCollections
~~~

#### Objective-C
~~~ objc
#import "MaterialCollections.h"
~~~
<!--</div>-->

### Use `MDCCollectionViewController` as a view controller

The following four steps will allow you to get a basic example of a `MDCCollectionViewController`
subclass up and running.

Step 1: **Subclass `MDCCollectionViewController` in your view controller interface**.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
import MaterialComponents.MaterialCollections

class MyCollectionsExample: MDCCollectionViewController {
}
~~~

#### Objective-C
~~~ objc
#import "MaterialCollections.h"

@interface MyCollectionsExample : MDCCollectionViewController
@end
~~~
<!--</div>-->

Step 2: **Setup your data**.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
let colors = [ "red", "blue", "green", "black", "yellow", "purple" ]
~~~

#### Objective-C
~~~ objc
colors = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];
~~~
<!--</div>-->

Step 3: **Register a cell class**.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
self.collectionView?.registerClass(MDCCollectionViewTextCell.self,
                                   forCellWithReuseIdentifier: reusableIdentifierItem)
~~~

#### Objective-C
~~~ objc
[self.collectionView registerClass:[MDCCollectionViewTextCell class]
        forCellWithReuseIdentifier:kReusableIdentifierItem];
~~~
<!--</div>-->

Step 4: **Override `UICollectionViewDataSource` protocol required methods**.

<!--<div class="material-code-render" markdown="1">-->
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
<!--</div>-->

### Provide own UICollectionView

It is possible to use the `MDCCollectionViewController` class while providing your own
`UICollectionView` subclass. That provided collection view may still receive styling and editing
capabilities that the `MDCCollectionViewController` class provides.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
~~~ swift
override func viewDidLoad() {
  super.viewDidLoad()

  // Here we are setting a custom collection view.
  self.collectionView = CustomCollectionView(frame: (self.collectionView?.frame)!,
                                             collectionViewLayout: (self.collectionViewLayout))
  ...
}
~~~

#### Objective-C
~~~ objc
- (void)viewDidLoad {
  [super viewDidLoad];

  // Here we are setting a custom collection view.
  self.collectionView = [[CustomCollectionView alloc] initWithFrame:self.collectionView.frame
                                               collectionViewLayout:self.collectionViewLayout];
  ...
}
~~~
<!--</div>-->
