---
layout: post
title:  "Community"
date:   2016-03-01 20:15:01 -0500
categories: community
---
**Community is a one-pager long article**

# Title

## Subtitle

This is a paragraph with a [link](http://www.google.com).

- bullet point 1
- bullet point 2
- bullet point 3


The following code will be rendered in simple format

```
pod 'Material component, '>= 2.5.0' #Simple format for command line code
```

The following code will be rendered in switchable code snippet

<div class="material-code-render">
	<textarea data-mode="text/x-objectivec" data-language="Objective-C">
	  MDCButton* flatButton = [MDCFlatButton button];
		[flatButton setTitle:@"Tap Me" forState:UIControlStateNormal];
		[flatButton addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubView:flatButton];
	</textarea>
	<textarea data-mode="text/x-swift" data-language="Swift">
	  var flatButton = MDCFlatButton.button()
		flatButton.setTitle("Tap Me", forState: .Normal)
		flatButton.addTarget(self, action: "tap:", forControlEvents: .TouchUpInside)
		self.view.addSubview(flatButton)
	</textarea>
</div> 