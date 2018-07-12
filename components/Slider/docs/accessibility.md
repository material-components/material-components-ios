## Accessibility
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

### `-accessibilityActivate`
 
 Our implementation closely resembles what UISlider does but it's not an exact match. On an `accessibilityActivate` we move one sixth of the amount between the current value and the midpoint value.

### Minimum touch size

Sliders currently respect the minimum touch size recomended by the Google Material spec [touch areas should be at least 48 points high and 48 wide](https://material.io/design/layout/spacing-methods.html#touch-click-targets). The height of the slider is set to 27 points so make sure there is sufficient space so that touches don't affect other elements.
