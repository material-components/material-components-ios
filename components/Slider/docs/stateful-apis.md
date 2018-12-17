### Stateful APIs

`MDCSlider` exposes stateful APIs to customize the colors for different control states. In order to use this API you must enable `statefulAPIEnabled` on your `MDCSlider` instances.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
 let slider = MDCSlider()
 slider.isStatefulAPIEnabled = true

 // Setting a thumb color for selected state.
 slider.setThumbColor(.red, for: .selected)
```

#### Objective C

```objc
 MDCSlider *slider = [[MDCSlider alloc] init];
 slider.statefulAPIEnabled = YES;
 
 // Setting a thumb color for selected state.
 [slider setThumbColor:[UIColor redColor] forState:UIControlStateSelected];
```
<!--</div>-->
