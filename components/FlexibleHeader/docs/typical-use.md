### Typical use: Add the flexible header to a view controller

Each view controller in your app that intends to manage its own flexible header will follow these
instructions. You'll typically add the flexible header to the same view controllers that you'd push
onto a UINavigationController, hiding the UINavigationController's `navigationBar` accordingly.

The result of following these steps will be that:

1. a flexible header is registered as a child view controller of your view controller, and that
2. you have access to a MDCFlexibleHeaderView instance via the `headerView` property on your
   MDCFlexibleHeaderViewController instance.

Step 1: **Create an instance of MDCFlexibleHeaderViewController**.

MDCFlexibleHeaderViewController is a UIViewController that manages the relationship of your view
controller to a MDCFlexibleHeaderView instance.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let headerViewController = MDCFlexibleHeaderViewController()

override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
  super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

  addChildViewController(headerViewController)
}

required init?(coder aDecoder: NSCoder) {
  super.init(coder: aDecoder)

  addChildViewController(headerViewController)
}
```

#### Objective-C

```objc
@property(nonatomic) MDCFlexibleHeaderViewController *headerViewController;
...

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _headerViewController = [[MDCFlexibleHeaderViewController alloc] init];
    [self addChildViewController:_headerViewController];
  }
  return self;
}
```
<!--</div>-->

Step 2: **Add the MDCFlexibleHeaderViewController's view to your view controller's view**.

Ideally you will do this after all views have been added to your controller's view in order to
ensure that the flexible header is in front of all other views.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
override func viewDidLoad() {
  super.viewDidLoad()

  headerViewController.view.frame = view.bounds
  view.addSubview(headerViewController.view)
  headerViewController.didMove(toParentViewController: self)
}
```

#### Objective-C

```objc
- (void)viewDidLoad {
  [super viewDidLoad];

  _headerViewController.view.frame = self.view.bounds;
  [self.view addSubview:_headerViewController.view];
  [_headerViewController didMoveToParentViewController:self];
}
```
<!--</div>-->
