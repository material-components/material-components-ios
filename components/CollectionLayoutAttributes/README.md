<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/CollectionLayoutAttributes/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/material-components/material-components-ios/tree/develop/components/CollectionLayoutAttributes">GitHub</a> for README documentation.{% endif %}-->

# Collection Layout Attributes

Allows passing layout attributes to the cells and supplementary views.
<!--{: .intro :}-->

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="https://material-ext.appspot.com/mdc-ios-preview/components/CollectionLayoutAttributes/apidocs/Classes/MDCCollectionViewLayoutAttributes.html">MDCCollectionViewLayoutAttributes</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~
pod 'MaterialComponents/CollectionLayoutAttributes'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Usage

### Importing

Before using Collection Layout Attributes, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
#import "MaterialCollectionLayoutAttributes.h"
~~~

#### Swift
~~~ swift
import MaterialComponents.MaterialCollectionLayoutAttributes
~~~
<!--</div>-->

The `MDCCollectionViewLayoutAttributes` class allows passing properties to a cell from a collection
view layout. Override the `-applyLayoutAttributes` method of any `UICollectionReusableView` or
`UICollectionViewCell` subclasses, then apply any of the properties of the attributes class.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
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
~~~

#### Swift
~~~ swift
override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
  super.applyLayoutAttributes(layoutAttributes)
  if let attr = layoutAttributes as? MDCCollectionViewLayoutAttributes {
    if (attr.representedElementCategory == .Cell) {

      // Example to set a background image to the cell background view.
      self.backgroundView = UIImageView(image: attr.backgroundImage)
    }
  }
}
~~~
<!--</div>-->
