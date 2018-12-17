### Supported UIBarButtonItem properties

The following properties are taken into consideration when `items` is set and the corresponding
buttons are created.

Changes made to properties marked (observed) will be reflected in the corresponding buttons.

- `title` (observed)
- `image` (observed)
- `enabled` (observed)
- `width`
- `target`
- `action`
- `titleTextAttributesForState:`

TODO(featherless): File bugs to observe the rest of the properties.

Note: in order to make Button Bar reflect changes to not-observed properties you must clear the
MDCButtonBar instance's `items` property and reset it, like so:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
actionItem.target = <some other target>

let items = buttonBar.items
buttonBar.items = nil
buttonBar.items = items
```

#### Objective-C

```objc
actionItem.target = <some other target>;

NSArray *items = buttonBar.items;
buttonBar.items = nil;
buttonBar.items = items;
```
<!--</div>-->
