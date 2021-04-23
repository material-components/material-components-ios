// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "FlexibleHeaderTopSafeAreaTestsFakeViewController.h"

@interface FlexibleHeaderTopSafeAreaTestsFakeView : UIView
@property(nonatomic) CGFloat topSafeAreaInset;
@end

@interface FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide : NSObject <UILayoutSupport>
@property(nonatomic) CGFloat topSafeAreaInset;
@end

@interface FlexibleHeaderTopSafeAreaTestsFakeViewController ()
@property(nonatomic, strong) FlexibleHeaderTopSafeAreaTestsFakeView *view;
@end

@implementation FlexibleHeaderTopSafeAreaTestsFakeViewController {
  FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide *_topLayoutGuide;
}

@dynamic view;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _topLayoutGuide = [[FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide alloc] init];
  }
  return self;
}

- (void)loadView {
  [super loadView];

  self.view = [[FlexibleHeaderTopSafeAreaTestsFakeView alloc] initWithFrame:self.view.bounds];
}

- (id<UILayoutSupport>)topLayoutGuide {
  return _topLayoutGuide;
}

- (FlexibleHeaderTopSafeAreaTestsFakeView *)view {
  return (FlexibleHeaderTopSafeAreaTestsFakeView *)[super view];
}

- (void)setTopSafeAreaInset:(CGFloat)topSafeAreaInset {
  self.view.topSafeAreaInset = topSafeAreaInset;
  _topLayoutGuide.topSafeAreaInset = topSafeAreaInset;
}

- (CGFloat)topSafeAreaInset {
  return self.view.topSafeAreaInset;
}

@end

@implementation FlexibleHeaderTopSafeAreaTestsFakeLayoutGuide

- (NSLayoutYAxisAnchor *)bottomAnchor API_AVAILABLE(ios(9.0)) {
  return nil;
}

- (NSLayoutDimension *)heightAnchor API_AVAILABLE(ios(9.0)) {
  return nil;
}

- (NSLayoutYAxisAnchor *)topAnchor API_AVAILABLE(ios(9.0)) {
  return nil;
}

- (CGFloat)length {
  return self.topSafeAreaInset;
}

@end

@implementation FlexibleHeaderTopSafeAreaTestsFakeView

- (UIEdgeInsets)safeAreaInsets {
  UIEdgeInsets safeAreaInsets = [super safeAreaInsets];
  safeAreaInsets.top = self.topSafeAreaInset;
  return safeAreaInsets;
}

@end
