#import "MainViewController.h"

@implementation MainViewController {
  UILabel *_label;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.text = @"This project is used to verify that Material Components iOS runs on tvOS";
  [self.view addSubview:_label];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [_label sizeToFit];
  _label.center =
      CGPointMake(CGRectGetMidX(_label.superview.bounds), CGRectGetMidY(_label.superview.bounds));
}

@end
