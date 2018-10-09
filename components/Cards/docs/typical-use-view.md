### Typical use: as a view

`MDCCard` can be used like a regular UIView.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let card = MDCCard()

// Create, position, and add content views:
let imageView = UIImageView()
card.addSubview(imageView)
```

#### Objective-C

```objc
MDCCard *card = [[MDCCard alloc] init];

// Create, position, and add content views:
UIImageView *imageView = [[UIImageView alloc] init];
[card addSubview:imageView];
```
<!--</div>-->
