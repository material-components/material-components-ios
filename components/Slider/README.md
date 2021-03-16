<!--docs:
title: "Sliders"
layout: detail
section: components
excerpt: "Sliders allow users to make selections from a range of values."
iconId: slider
path: /catalog/sliders/
-->

# Slider

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BSlider%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BSlider%5D)

[Sliders](https://material.io/components/sliders/) allow users to make
selections from a range of values.

!["Slider with sound icon buttons on each end."](docs/assets/sliders-hero.png)

**Contents**

*   [Using sliders](#using-sliders)
*   [Continuous sliders](#continuous-sliders)
*   [Discrete sliders](#discrete-sliders)
*   [Theming sliders](#theming-sliders)
*   [Differences from UISlider](#differences-from-uislider)

## Using sliders

Sliders reflect a range of values along a bar, from which users may select a single value. They are ideal for adjusting settings such as volume, brightness, or applying image filters.

### Installing sliders

In order to install with [Cocoapods](https://guides.cocoapods.org/using/getting-started.html) first add the component to your `Podfile`:

```bash
pod 'MaterialComponents/Slider'
```
<!--{: .code-renderer.code-renderer--install }-->

Then run the installer:

```bash
pod install
```

Then import the Slider target:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialSlider
```

#### Objective-C

```objc
#import "MaterialSlider.h"
```
<!--</div>-->

### Typical use

`MDCSlider` can be be used like a standard `UIControl`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  let slider = MDCSlider(frame: CGRect(x: 50, y: 50, width: 100, height: 27))
  slider.addTarget(self,
                   action: #selector(didChangeSliderValue(senderSlider:)),
                   for: .valueChanged)
  view.addSubview(slider)
}

func didChangeSliderValue(senderSlider:MDCSlider) {
  print("Did change slider value to: \(senderSlider.value)")
}
```

#### Objective C

```objc
- (void)viewDidLoad {
  MDCSlider *slider = [[MDCSlider alloc] initWithFrame:CGRectMake(50, 50, 100, 27)];
  [slider addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:slider];
}

- (void)didChangeSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}
```
<!--</div>-->

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

### Making sliders accessible

To help ensure your slider is accessible to as many users as possible, please be sure to review the following recommendations:

####  `-accessibilityLabel`

Set an appropriate `accessibilityLabel` value for your slider. This should reflect what the slider affects.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
slider.accessibilityLabel = "Volume level"
```

#### Objective - C
```objc
slider.accessibilityLabel = @"Volume level";
``` 
<!--</div>-->

#### Minimum touch size

Sliders currently respect the minimum touch size recomended by the Material spec [touch areas should be 
at least 44 points high and 44 wide](https://material.io/design/usability/accessibility.html#understanding-accessibility). 
The height of the slider is set to 27 points so make sure there is sufficient space so that touches don't affect other 
elements.

**Types**

There are two types of sliders: 1\. [Continuous slider](#continuous-slider) and 2\.
[Discrete slider](#discrete-slider)

!["Slider examples of both continuous and discrete sliders."](docs/assets/sliders-types.png)

A slider with one thumb is called a single point slider, and a slider with two thumbs is called a range slider.

_**Note:** Range sliders are not supported on iOS._

### Anatomy and key properties

A slider has a track, one or two thumbs, and optional value label. A discrete
slider also has tick marks.

![Slider anatomy diagram](docs/assets/sliders-anatomy.png)

1.  Track
2.  Thumb
3.  Value label (optional)
4.  Tick mark (discrete sliders)

#### Track attributes

&nbsp;                                      | Attribute                | Related method(s)                                         | Default value
------------------------------------------- | ------------------------ | --------------------------------------------------------- | -------------
**Min value**                               | `minimumValue`      | `-setMinimumValue:`<br/>`-minimumValue`                          | 0
**Max value**                               | `maximumValue`        | `-setMaximumValue:`<br/>`-maximumValue`                        | 1
**Number of discrete values**              | `numberOfDiscreteValues` | `-setNumberOfDiscreteValues:`<br/>`-numberOfDiscreteValues`  | N/A
**Is discrete**                   | `discrete` | `-setIsDiscrete:`<br/>`-isDiscrete`  | `NO`
**Height**                                  | `trackHeight`        | `-setTrackHeight:`<br/>`-trackHeight`                     | 2
**Track background color**                  | NA | `-setTrackBackgroundColor:forState:` <br/> `-trackBackgroundColorForState:` | Black at 26% opacity	
**Track fill color**                        | NA | `-setTrackFillColor:forState:`<br/>`-trackFillColorForState:` | Primary color

#### Thumb attributes

&nbsp;           | Attribute              | Related method(s)                                                                 | Default value
---------------- | ---------------------- | --------------------------------------------------------------------------------- | -------------
**Thumb color**  | NA                     | `-setThumbColor:forState:` <br/> `-thumbColorForState:`                           | Primary color	
**Radius**       | `thumbRadius`          | `-setThumbRadius:`<br/>`-thumbRadius`                                             | 6
**Elevation**    | `thumbElevation`   | `-setThumbElevation:`<br/>`thumbElevation`                                            | 0
**Ripple color**   | `rippleColor`        | `-setRippleColor:`<br/>`-rippleColor`                                            | `nil`
**Ripple radius**  | `thumbRippleMaximumRadius`       | `-setThumbRippleMaximumRadius:`<br/>`-thumbRippleMaximumRadius`       | 0

#### Value label attributes

&nbsp;        | Attribute           | Related method(s)                           | Default value
------------- | ------------------- | ------------------------------------------- | -------------
**Background color**     | `valueLabelBackgroundColor`    | `-setValueLabelBackgroundColor:` <br/> `-valueLabelBackgroundColor`   | Blue
**Text color** | `valueLabelTextColor`           | `-valueLabelTextColor:`<br/>`valueLabelTextColor` | White
**Font**  | `discreteValueLabelFont` | `-setDiscreteValueLabelFont:`<br/>`-discreteValueLabelFont`   | N/A

#### Tick mark attributes

&nbsp;                              | Attribute               | Related method(s)                                       | Default value
----------------------------------- | ----------------------- | ------------------------------------------------------- | -------------
**Background tick color**           | N/A         | `-setBackgroundTrackTickColor:forState:`<br/>`-backgroundTrackTickColorForState:` | Black
**Filled tick color**                | N/A         | `-setFilledTrackTickColor:forState:`<br/>`-filledTrackTickColorForState:` | Black

## Continuous sliders

Continuous sliders allow users to make meaningful selections that don’t require
a specific value.

#### Continuous single point slider example

Source code:
*   `MDCSlider`
    *   [Class source](https://github.com/material-components/material-components-ios/tree/develop/components/Slider)

!["Continuous slider from 0 to 100, set at a value of 70."](docs/assets/continuous-slider.png)

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let slider = MDCSlider()
slider.minimumValue = 0
slider.maximumValue = 100
slider.value = 70
```

#### Objective C

```objc
MDCSlider *slider = [[MDCSlider alloc] init];
slider.minimumValue = 0.0f;
slider.maximumValue = 100.0f;
slider.value = 70.0f;
```
<!--</div>-->

## Discrete sliders

#### Discrete single point slider example

Source code:
*   `MDCSlider`
    *   [Class source](https://github.com/material-components/material-components-ios/tree/develop/components/Slider)

!["Discrete slider from 0 to 100, set at a value of 70."](docs/assets/discrete-slider.png)

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let slider = MDCSlider()
slider.minimumValue = 0
slider.maximumValue = 100
slider.value = 70
slider.discrete = true
slider.numberOfDiscreteValues = 10
slider.shouldDisplayDiscreteValueLabel = false
```

#### Objective 
```objc
MDCSlider *slider = [[MDCSlider alloc] init];
slider.minimumValue = 0.0f;
slider.maximumValue = 100.0f;
slider.value = 70.0f;
slider.discrete = YES;
slider.numberOfDiscreteValues = 10;
slider.shouldDisplayDiscreteValueLabel = NO;
```
<!--</div>-->

## Theming sliders

`MDCSlider` has no recommended theming mechanism. Configure colors using the properties and stateful APIs exposed on the slider.

## Differences from UISlider

### UISlider APIs not present in MDCSlider

* Setting the left/right icons via `minimumValueImage` and `maximumValueImage`.
* Setting the thumb image via `setThumbImage:forState:`.
* Setting the right/left track images (for a custom track) via `setMinimumTrackImage:forState:` and `setMaximumTrackImage:forState:`.

### UISlider APIs with different names in MDCSlider

* The UISlider API `minimumTrackTintColor` has an equivalent API `setTrackFillColor:forState:` in MDCSlider. This API must first be enabled by setting `statefulAPIEnabled` to `YES`.
* The UISlider API `maximumTrackTintColor` has an equivalent API `setTrackBackgroundColor:forState:` in MDCSlider. This API must first be enabled by setting `statefulAPIEnabled = YES`.
* The UISlider API `thumbTintColor` has an equivalent API `setThumbColor:forState:` in MDCSlider.  This API must first be enabled by setting `statefulAPIEnabled = YES`.

### MDCSlider enhancements not in MDCSlider

* MDCSlider can behave as a [Material Discrete Slider](https://material.io/components/sliders/#discrete-slider) by setting `discrete = YES` and `numberOfDiscreteValues` to a value greater than or equal to 2. Discrete sliders only allow their calculated discrete values to be selected as the Slider's value. If `numberOfDiscreteValues` is less than 2, then the Slider will behave as a [Material Continuous Slider](https://material.io/components/sliders/#continuous-slider).
* For Discrete Sliders, the track tick color is configured with the `setFilledTrackTickColor:forState:` and `setBackgroundTrackTickColor:forState:` APIs. The filled track ticks are those overlapping the filled/active part of the Slider. The background track ticks are found in any other portions of the track. These APIs must first be enabled by setting `statefulAPIEnabled = YES`.
* Track tick marks can be made shown always, never, or only when dragging via the `trackTickVisibility` API. If `numberOfDiscreteValues` is less than 2, then tick marks will never be shown.
* An anchor point can be set via `filledTrackAnchorValue` to control the starting position of the filled track.
* The track can be made taller (or shorter) by setting the value of `trackHeight`.

### `-accessibilityActivate`

MDCSlider's behavior is very similar to that of UISlider, but it's not exactly the same. On an
`accessibilityActivate` event, the value moves one sixth of the amount between the current value and the 
midpoint value.