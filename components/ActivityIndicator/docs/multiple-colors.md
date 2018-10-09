### Showing multiple indeterminate colors

Indeterminate activity indicators support showing multiple colors via the `cycleColors` API.
Consider using this property if your brand consists of more than one primary color.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let activityIndicator = MDCActivityIndicator()
activityIndicator.cycleColors = [.blue, .red, .green, .yellow]
```

#### Objective-C

```objc
MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
activityIndicator.cycleColors =  @[ UIColor.blueColor,
                                    UIColor.redColor,
                                    UIColor.greenColor,
                                    UIColor.yellowColor ];
```
<!--</div>-->
