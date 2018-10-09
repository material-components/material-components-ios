### Typical use

Integrating the page control requires two steps. First, add a page control with companion scroll
view, and second, forward the scroll view delegate methods to the page control.

**Step 1: Add the page control to a view**

Add the page control to a view and set the desired page control properties. This step is done
similarly to a native `UIPageControl`. In addition, provide a tap gesture handler for the control to
to fire off the `UIControlEventValueChanged` events in which the scroll view would typically be
notified of page changes.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let pageControl = MDCPageControl()
let scrollView = UIScrollView()
let pages = NSMutableArray()

override func viewDidLoad() {
  super.viewDidLoad()

  scrollView.delegate = self
  view.addSubview(scrollView)

  pageControl.numberOfPages = 3

  let pageControlSize = pageControl.sizeThatFits(view.bounds.size)
  pageControl.frame = CGRect(x: 0, y: view.bounds.height - pageControlSize.height, width: view.bounds.width, height: pageControlSize.height)

  pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
  pageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
  view.addSubview(pageControl)
}

func didChangePage(sender: MDCPageControl){
  var offset = scrollView.contentOffset
  offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
  scrollView.setContentOffset(offset, animated: true)
}
```

#### Objective-C

```objc
- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];

  self.pageControl.numberOfPages = 3;

  CGSize pageControlSize = [self.pageControl sizeThatFits:self.view.bounds.size];
  self.pageControl.frame = CGRectMake(0, self.view.bounds.size.height - pageControlSize.height, self.view.bounds.size.width, pageControlSize.height);

  [self.pageControl addTarget:self action:@selector(didChangePage:) forControlEvents: UIControlEventValueChanged];
  self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  [self.view addSubview:self.pageControl];

}

- (void)didChangePage:(MDCPageControl*)sender {
  CGPoint offset = self.scrollView.contentOffset;
  offset.x = (CGFloat)sender.currentPage * self.scrollView.bounds.size.width;
  [self.scrollView setContentOffset:offset animated: true];
}
```
<!--</div>-->

**Step 2: Forwarding the required scroll view delegate methods**

This page control is designed to be used in conjunction with a scroll view. To achieve the desired
page control animation effects, there are three scroll view delegate methods that must be forwarded
to the page control (`-scrollViewDidScroll`, `-scrollViewDidEndDecelerating`, and
`-scrollViewDidEndScrollingAnimation`). This allows the page control to keep in sync with the
scrolling movement of the designated scroll view.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
  pageControl.scrollViewDidScroll(scrollView)
}

func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
  pageControl.scrollViewDidEndDecelerating(scrollView)
}

func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
  pageControl.scrollViewDidEndScrollingAnimation(scrollView)
}
```

#### Objective-C

```objc
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.pageControl scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [self.pageControl scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [self.pageControl scrollViewDidEndScrollingAnimation:scrollView];
}
```
<!--</div>-->
