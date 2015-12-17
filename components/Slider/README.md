# Slider

Slider is a Material styled slider.

See the [Slider spec](https://www.google.com/design/spec/components/sliders.html) for more details.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objectivec
- (void)viewDidLoad {
...

  MDCSlider *slider = [[MDCSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 27)];
  [slider addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:slider];
  slider.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 2 * slider.frame.size.height);

...
}

- (void)didChangeSliderValue:(id)sender {
  MDCSlider *slider = sender;
  NSLog(@"did change %@ value: %f", NSStringFromClass([sender class]), slider.value);
}
```

### Differences between UISlider and MDCSlider:

####  Does not have api to

*    set right and left icons
*    set the thumb image
*    set the right and left track images (if you wanted a custom track)
*    set the right (background track) color

####  Same features

*    set color for thumb via @c thumbColor
*    set color of track via @c trackColor

####  New features

*    making the slider a snap to discrete values via property numberOfDiscreteValues.
