# Collection Layout Attributes

**Notice**: This component will be deprecated over the next few months in favor of the
[Cards](../Cards) and [List](../List) components. See our
[public tracker](https://www.pivotaltracker.com/epic/show/3938766) for more details on timing and
the deprecation plan.

---

Allows passing layout attributes to the cells and supplementary views.

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/collections/collection-layout-attributes/api-docs/Classes/MDCCollectionViewLayoutAttributes.html">API: MDCCollectionViewLayoutAttributes</a></li>
</ul>

- - -

## Installation

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/CollectionLayoutAttributes'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

- - -

## Usage

### Importing

Before using Collection Layout Attributes, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialCollectionLayoutAttributes
```

#### Objective-C
```objc
#import "MaterialCollectionLayoutAttributes.h"
```
<!--</div>-->

The `MDCCollectionViewLayoutAttributes` class allows passing properties to a cell from a collection
view layout. Override the `-applyLayoutAttributes` method of any `UICollectionReusableView` or
`UICollectionViewCell` subclasses, then apply any of the properties of the attributes class.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
  super.apply(layoutAttributes)
  if let attr = layoutAttributes as? MDCCollectionViewLayoutAttributes {
    if (attr.representedElementCategory == .cell) {

      // Example to set a background image to the cell background view.
      self.backgroundView = UIImageView(image: attr.backgroundImage)
    }
  }
}
```
#### Objective-C
```objc
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes:layoutAttributes];
  if ([layoutAttributes isKindOfClass:[MDCCollectionViewLayoutAttributes class]]) {
    MDCCollectionViewLayoutAttributes *attr = (MDCCollectionViewLayoutAttributes *)layoutAttributes;
    if (attr.representedElementCategory == UICollectionElementCategoryCell) {

      // Example to set a background image to the cell background view.
      self.backgroundView = [[UIImageView alloc] initWithImage:attr.backgroundImage];
    }
  }
}
```
<!--</div>-->
