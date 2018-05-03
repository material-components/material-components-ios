### Typical use

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let buttonBar = MDCButtonBar()

let actionItem = UIBarButtonItem(
  title: "<# title #>",
  style: .done, // ignored
  target: self,
  action: "<# selector #>"
)

buttonBar.items = [actionItem]

let size = buttonBar.sizeThatFits(self.view.bounds.size)
buttonBar.frame = CGRect(x: <# x #>, y: <# y #>, width: size.width, height: size.height)
self.view.addSubview(buttonBar)
```

#### Objective-C

```objc
MDCButtonBar *buttonBar = [[MDCButtonBar alloc] init];

UIBarButtonItem *actionItem =
    [[UIBarButtonItem alloc] initWithTitle:@"<# title #>"
                                     style:UIBarButtonItemStyleDone // ignored
                                    target:self
                                    action:@selector(<# selector #>)];

buttonBar.items = @[ actionItem ];

CGSize size = [buttonBar sizeThatFits:self.view.bounds.size];
CGPoint origin = CGPointZero;
buttonBar.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
[self.view addSubview:buttonBar];

```
<!--</div>-->
