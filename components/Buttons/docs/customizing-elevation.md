### Customizing elevation

The elevation of a button can be changed for a given control state using `setElevation:forState:`.

See the [Material Design shadow guidelines](https://material.io/guidelines/what-is-material/elevation-shadows.html) for a detailed
overview of different shadow elevations.

For example, to make a button elevate on tap like a floating action button:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
button.setElevation(6, for: .normal)
button.setElevation(12, for: .highlighted)
```

#### Objective-C

```objc
[button setElevation:6 forState:UIControlStateNormal];
[button setElevation:12 forState:UIControlStateNormal];
```
<!--</div>-->
