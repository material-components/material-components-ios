#import "MainViewController.h"

@implementation MainViewController {
  UILabel *_label;
}

- (void)loadView {
  [super loadView];

  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.text = @"This project is used to verify that Material Components iOS runs on tvOS";
  [self.view addSubview:_label];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [_label sizeToFit];
  _label.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
}

@end
