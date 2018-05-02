### Typical use

Add the progress view to your view hierarchy like you would with any other view. Note that it works
best when the progress view is added at the bottom of a view, as showing (resp. hiding) grows up
(resp. shrinks down).

**Step 1: Add the progress view to a view**

Add the progress view to a view and set the desired progress and hidden state.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let progressView = MDCProgressView()
progressView.progress = 0

let progressViewHeight = CGFloat(2)
progressView.frame = CGRect(x: 0, y: view.bounds.height - progressViewHeight, width: view.bounds.width, height: progressViewHeight)
view.addSubview(progressView)
```

#### Objective-C

```objc
@property(nonatomic) MDCProgressView *progressView;
...

// Progress view configuration.
self.progressView = [[MDCProgressView alloc] initWithFrame:myframe];
self.progressView.progress = 0;  // You can also set a greater progress for actions already started.
[self.view addSubview:self.progressView];
```
<!--</div>-->

**Step 2: Change the progress and hidden state**

Both the progress and the hidden state can be animated, with a completion block.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
func startAndShowProgressView() {
  progressView.progress = 0
  progressView.setHidden(false, animated: true)
}

func completeAndHideProgressView() {
  progressView.setProgress(1, animated: true) { (finished) in
    self.progressView.setHidden(true, animated: true)
  }
}
```

#### Objective-C

```objc
- (void)startAndShowProgressView {
  self.progressView.progress = 0;
  [self.progressView setHidden:NO animated:YES completion:nil];
}

- (void)completeAndHideProgressView {
  __weak __typeof__(self) weakSelf = self;
  [self.progressView setProgress:1 animated:YES completion:^(BOOL finished){
    [weakSelf.progressView setHidden:YES animated:YES completion:nil];
  }];
}
```
<!--</div>-->
