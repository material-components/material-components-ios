### Typical use: View controller containment, as a child

When an `MDCAppBarViewController` instance is added as a child to another view controller. In this
case, the parent view controller is often the object that creates and manages the
`MDCAppBarViewController` instance. This allows the parent view controller to configure the app bar
directly.

You'll typically push the parent onto a navigation controller, in which case you will also hide the
navigation controller's navigation bar using `UINavigationController`'s
`-setNavigationBarHidden:animated:`.

#### Example

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let appBarViewController = MDCAppBarViewController()

override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
  super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

  self.addChildViewController(appBarViewController)
}

override func viewDidLoad() {
  super.viewDidLoad()

  view.addSubview(appBarViewController.view)
  appBarViewController.didMove(toParentViewController: self)
}
```

#### Objective-C

```objc
@interface MyViewController ()
@property(nonatomic, strong, nonnull) MDCAppBarViewController *appBarViewController;
@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _appBarViewController = [[MDCAppBarViewController alloc] init];

    [self addChildViewController:_appBarViewController];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.appBarViewController.view];
  [self.appBarViewController didMoveToParentViewController:self];
}

@end
```
<!--</div>-->
