# Switch

A material design on/off switch.

It has an interface similar to UISwitch. Note that MDCSwitch objects have an intrinsic size and are not resizable.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objectivec

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCSwitch *mdcSwitch = [[MDCSwitch alloc] init];
  [mdcSwitch addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:mdcSwitch];
  mdcSwitch.center = CGPointMake(50, 50);
}

- (void)didChangeSliderValue:(id)sender {
  ...
}
```
