# Switch

A material design on/off switch UIControl.

It has an interface similar to UISwitch. Note that MDCSwitch objects have an intrinsic size
and are not resizable.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objectivec

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect switchFrame = CGRectMake(120.0, 44.0, 36.0, 27.0); // The size component is ignored
  _switch = [[MDCSwitch alloc] initWithFrame:switchFrame];
  _switch.onTintColor = [UIColor greenColor];
  [_switch addTarget:self
              action:@selector(switchChanged:)
    forControlEvents:UIControlEventValueChanged];
  _switch.on = YES;  // No UIControlEventValueChanged sent by this property or [setOn:animated:].
  _switch.offThumbTintColor = [UIColor redColor];  // Make the thumb red if it’s turned off.
}

```
