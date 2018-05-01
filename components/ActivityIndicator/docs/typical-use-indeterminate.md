### Typical use: Indeterminate

MDCActivityIndicator instances are indeterminate by default.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let activityIndicator = MDCActivityIndicator()
activityIndicator.sizeToFit()
view.addSubview(activityIndicator)

// To make the activity indicator appear:
activityIndicator.startAnimating()

// To make the activity indicator disappear:
activityIndicator.stopAnimating()
```

#### Objective-C

```objc
MDCActivityIndicator *activityIndicator = [[MDCActivityIndicator alloc] init];
[activityIndicator sizeToFit];
[view addSubview:activityIndicator];

// To make the activity indicator appear:
[activityIndicator startAnimating];

// To make the activity indicator disappear:
[activityIndicator stopAnimating];
```
<!--</div>-->


