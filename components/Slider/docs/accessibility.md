## Accessibility {a11y}

To help ensure your slider is accessible to as many users as possible, please be sure to review the following recommendations:

### Set `-accessibilityLabel`

Set an appropriate `accessibilityLabel` value for your slider. This should reflect what the slider affects.

#### Objective - C
```objc
slider.accessibilityLabel = @"Volume Slider";
``` 

#### Swift
```swift
slider.accessibilityLabel = "Volume Slider"
```

### Using `accessibilityIncrement` or `accessibilityDecrement`

When you need to set custom increment or decrement levels use the `accessibilityIncrement` property to affect how much the slider will increment on an upward swipe and `accessibilityDecrement` property to affect how much the slider will decrement on a downward swipe.

By default these values are set to 10%.

#### Objective - C
```objc
slider.accessibilityIncrementAmount = 0.25f;
slider.accessibilityDecrementAmount = 0.35f;
```

#### Swift
```swift
slider.accessibilityIncrementAmount = CGFloat(0.25)
slider.accessibilityDecrementAmount = CGFloat(0.35)
```


### Minimum touch size

Sliders currently respect the minimum touch size recomended by the Google Material spec [touch areas should be at least 48 points high and 48 wide](https://material.io/design/layout/spacing-methods.html#touch-click-targets). The height of the slider is set to 27 points so make sure there is sufficient space so that touches don't affect other elements.
