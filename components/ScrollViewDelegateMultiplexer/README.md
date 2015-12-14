# ScrollViewDelegateMultiplexer

This class acts as a proxy object for UIScrollViewDelegate events and forwards all received
events to an ordered list of registered observers.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```objectivec
#import "MaterialScrollViewDelegateMultiplexer.h"

_multiplexer = [[MDCScrollViewDelegateMultiplexer alloc] init];
myScrollView.delegate = _multiplexer;
[_multiplexer addObservingDelegate:myControl];
[_multiplexer addObservingDelegate:anotherControl];
```
