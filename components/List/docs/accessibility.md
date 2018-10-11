## Accessibility

To help ensure your Lists are accessible to as many users as possible, please be sure to review the following
recommendations:

### Setting `-isAccessibilityElement`

It is generally recommended to set UICollectionViewCells (and UITableViewCells) as accessibilityElements. That way, VoiceOver doesn't traverse the entire cell and articulate an overwhelming amount of accessibility information for each of its subviews.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
cell.isAccessibilityElement = true
```

#### Objective-C

```objc
cell.isAccessibilityElement = YES;
```
<!--</div>-->
