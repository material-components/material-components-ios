# PageControl

This control is designed to be a drop-in replacement for UIPageControl, but adhering to the
material design specifications for animation and layout.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher. 

## Usage

```objectivec
// Page control configuration.
CGRect frame =
  CGRectMake(0, CGRectGetHeight(self.view.bounds) - 40, CGRectGetWidth(self.view.bounds), 40);
myPageControl = [[MDCPageControl alloc] initWithFrame:frame];
myPageControl.numberOfPages = _myPages.count;
[myPageControl addTarget:self
               action:@selector(didChangePage:)
     forControlEvents:UIControlEventValueChanged];
[self.view addSubview:myPageControl];

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [myPageControl scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [myPageControl scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [myPageControl scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - User events

- (void)didChangePage:(MDCPageControl *)sender {
  CGPoint offset = myScrollView.contentOffset;
  offset.x = sender.currentPage * myScrollView.bounds.size.width;
  [myScrollView setContentOffset:offset animated:YES];
}
```
