# Ink

The Ink component provides classes related to displaying and controlling the material design
ink splashes. Ink splashes provide visual feedback as the user touches views and controls.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objectivec
// Add ink splashes to customView, a custom view of your own.
MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:customView];
[inkTouchController addInkView];
```
