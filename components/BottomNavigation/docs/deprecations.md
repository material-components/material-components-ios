### `sizeThatFitsIncludesSafeArea`

The current implementation of `-[MDCBottomNavigationBar sizeThatFits:]` incorrectly uses
`safeAreaInsets` to increase the desired size. Instead, the superview or view controller should be
extending the height of the `MDCBottomNavigationBar` so that it extends out of the safe area and to
the bottom edge of the screen.

Code that currently relies on this behavior must migrate to correct view management. To stop
`MDCBottomNavigationBar` from including `safeAreaInsets` in its calculations, set
`sizeThatFitsIncludesSafeArea = NO`.  At that point, you will likely need to update your layout
code.  If you are using constraints-based layout, `intrinsicContentSize` will not have this error.
However, manually-computing frames and positioning views will likely require an update.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let bottomNavBar = MDCBottomNavigationBar()

override func viewDidLoad() {
  super.viewDidLoad()

  // Disable inclusion of safe area in size calculations.
  bottomNavBar.sizeThatFitsIncludesSafeArea = false
}

func layoutBottomNavBar() {
  let size = bottomNavBar.sizeThatFits(view.bounds.size)
  var bottomNavBarFrame = CGRect(x: 0,
                                 y: view.bounds.height - size.height,
                                 width: size.width,
                                 height: size.height)
  // Extend the Bottom Navigation to the bottom of the screen.
  if #available(iOS 11.0, *) {
    bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
    bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
  }
  bottomNavBar.frame = bottomNavBarFrame
}
```

#### Objective-C

```objc
- (void)viewDidLoad {
  [super viewDidLoad];

  self.bottomNavBar = [[MDCBottomNavigationBar alloc] init];
  
  // Disable inclusion of safe area in size calculations.
  self.bottomNavBar.sizeThatFitsIncludesSafeArea = NO;
}

- (void)layoutBottomNavBar {
  CGRect viewBounds = CGRectStandardize(self.view.bounds);
  CGSize size = [self.bottomNavBar sizeThatFits:viewBounds.size];
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
  // Extend the Bottom Navigation to the bottom of the screen.
  if (@available(iOS 11.0, *)){
    safeAreaInsets = self.view.safeAreaInsets;
  }
  CGRect bottomNavBarFrame = 
      CGRectMake(0, viewBounds.size.height - size.height - safeAreaInsets.bottom, size.width, 
                 size.height + safeAreaInsets.bottom);
  self.bottomNavBar.frame = bottomNavBarFrame;
}
```
<!--</div>-->
