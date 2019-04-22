### Typical use

`MDCButton` is a subclass of UIButton, but with more options for customizing the button's style and
behavior. To initialize an MDCButton, you must alloc/init an instance directly instead of using
`buttonWithType:`, which has been marked unavailable.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let button = MDCButton()
```

#### Objective-C

```objc
MDCButton *button = [[MDCButton alloc] init];
```
<!--</div>-->

See the
[MDCButton API docs](https://material.io/develop/ios/components/buttons/api-docs/Classes/MDCButton.html)
for a complete list of features that MDCButton provides in addition to UIButton's features.
