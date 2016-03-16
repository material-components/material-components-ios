---
title:  "Community"
---
**Community is a one-pager long article**

# Title

## Subtitle

This is a paragraph with a [link](http://www.google.com).

- bullet point 1
- bullet point 2
- bullet point 3


The following code will be rendered in simple format

~~~ shell
pod 'Material component >= 2.5.0' #Simple format for command line code
~~~

~~~ bash
$ pod install
$ open -a Xcode Podfile # opens your Podfile in XCode
$ open your-project.xcworkspace
$ true
~~~

The following code will be rendered in switchable code snippet

<div class="material-code-render" markdown="1">
### Objective-C

~~~ objc
MDCButton* flatButton = [MDCFlatButton button];
[flatButton setTitle:@"Tap Me" forState:UIControlStateNormal];
[flatButton addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubView:flatButton];
~~~

### Swift

~~~swift
var flatButton = MDCFlatButton.button()
flatButton.setTitle("Tap Me", forState: .Normal)
flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
self.view.addSubview(flatButton)
~~~
</div> 

<div class="material-code-render" markdown="1">
### Objective-C

~~~ objc
MDCButton* flatButton = [MDCFlatButton button];
[flatButton setTitle:@"Tap Me" forState:UIControlStateNormal];
[flatButton addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubView:flatButton];
~~~
</div> 

<div class="material-code-render" markdown="1">
### Objective-C

~~~ objc
MDCButton* flatButton = [MDCFlatButton button];
[flatButton setTitle:@"Tap Me" forState:UIControlStateNormal];
[flatButton addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubView:flatButton];
~~~

### Swift

~~~swift
var flatButton = MDCFlatButton.button()
flatButton.setTitle("Tap Me", forState: .Normal)
flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
self.view.addSubview(flatButton)
var flatButton = MDCFlatButton.button()
flatButton.setTitle("Tap Me", forState: .Normal)
flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
self.view.addSubview(flatButton)
var flatButton = MDCFlatButton.button()
flatButton.setTitle("Tap Me", forState: .Normal)
flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
self.view.addSubview(flatButton)
var flatButton = MDCFlatButton.button()
flatButton.setTitle("Tap Me", forState: .Normal)
flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
self.view.addSubview(flatButton)
~~~
</div> 