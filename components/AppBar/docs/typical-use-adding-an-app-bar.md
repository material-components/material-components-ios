### Typical use: Adding an app bar to your app

Each view controller in your app that intends to use an App Bar will follow these instructions.
You'll typically add the App Bar to the same view controllers that you'd push onto a
UINavigationController, hiding the UINavigationController's `navigationBar` accordingly.

The result of following these steps will be that:

1. an App Bar is registered as a child view controller of your view controller,
2. you have access to the App Bar's Flexible Header view via the headerViewController property, and
   that
3. you have access to the Navigation Bar and Header Stack View views via the corresponding
   properties.

Step 1: **Create an instance of MDCAppBar**.

You must also add the `headerViewController` as a child view controller.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let appBar = MDCAppBar()

override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
  super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

  self.addChildViewController(appBar.headerViewController)
}
```

#### Objective-C

```objc
@interface ObjcViewController ()
@property(nonatomic, strong, nonnull) MDCAppBar *appBar;
@end

@implementation ObjcViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _appBar = [[MDCAppBar alloc] init];

    [self addChildViewController:_appBar.headerViewController];
  }
  return self;
}

@end
```
<!--</div>-->

Step 2: **Inform the App Bar that your view controller's view has loaded**.

Ideally you will do this after all views have been added to your controller's view in order to
ensure that the App Bar's Flexible Header is in front of all other views.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
override func viewDidLoad() {
  super.viewDidLoad()

  // After all other views have been registered.
  appBar.addSubviewsToParent()
}
```

#### Objective-C
```objc
- (void)viewDidLoad {
  [super viewDidLoad];

  ...

  // After all other views have been registered.
  [self.appBar addSubviewsToParent];
}
```
<!--</div>-->
