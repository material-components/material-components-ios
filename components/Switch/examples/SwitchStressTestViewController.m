/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "SwitchStressTestViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "MaterialButtonBar.h"
#import "MaterialSnackbar.h"
#import "MaterialSwitch.h"
#import "MaterialTypography.h"

static const NSInteger kSwitchStressTestNumSwitches = 40;
static const NSInteger kSwitchStressTestNumColumns = 4;
static const CGFloat kSwitchStressTestColumnWidth = 50;

@implementation SwitchStressTestViewController {
  MDCButtonBar *_buttonBar;
  NSMutableArray *_switches;
  NSInteger _switchType;
  CGFloat _switchPosition;
  CGFloat _switchXPos;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Switch", @"Stress Test" ];
}

+ (NSString *)catalogDescription {
  return @"This example is only intended to be used for performance testing and should not be used"
          " as an example of how to use MDCSwitch.";
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _switches = [NSMutableArray array];
  _switchPosition = 0;

  _buttonBar = [[MDCButtonBar alloc] init];
  _buttonBar.backgroundColor = [self buttonBarBackgroundColor];

  // MDCButtonBar ignores the style of UIBarButtonItem.
  UIBarButtonItemStyle ignored = UIBarButtonItemStyleDone;

  UIBarButtonItem *actionItem = [[UIBarButtonItem alloc] initWithTitle:@"Create"
                                                                 style:ignored
                                                                target:self
                                                                action:@selector(addSwitches:)];
  UIBarButtonItem *secondActionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Animate"
                                       style:ignored
                                      target:self
                                      action:@selector(animateSwitches:)];

  NSArray *items = @[ actionItem, secondActionItem ];
  for (UIBarButtonItem *item in items) {
    [item setTitleTextAttributes:[self itemTitleTextAttributes] forState:UIControlStateNormal];
  }

  _buttonBar.items = items;

  // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
  CGSize size = [_buttonBar sizeThatFits:self.view.bounds.size];
  CGFloat x = (self.view.bounds.size.width - size.width) / 2;
  _buttonBar.frame = (CGRect){x, 0, size};
  _buttonBar.autoresizingMask =
      (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin |
       UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:_buttonBar];
}

#pragma mark - User actions

- (void)addSwitches:(id)sender {
  for (MDCSwitch *aSwitch in _switches) {
    [aSwitch removeFromSuperview];
  }
  [_switches removeAllObjects];

  CFTimeInterval now = CFAbsoluteTimeGetCurrent();
  for (NSInteger i = 0; i < kSwitchStressTestNumSwitches; i++) {
    MDCSwitch *aSwitch = [self makeSwitch];
    [self.view addSubview:aSwitch];
    [_switches addObject:aSwitch];
  }
  CFTimeInterval then = CFAbsoluteTimeGetCurrent();

  [self layoutSwitches];

  NSString *message = [NSString
      stringWithFormat:@"Created %d switches in %.2fms", _switches.count, (then - now) * 1000];
  [MDCSnackbarManager showMessage:[MDCSnackbarMessage messageWithText:message]];

  _switchType++;
}

- (void)animateSwitches:(id)sender {
  _switchPosition =
      (_switchPosition == 0)
          ? self.view.frame.size.width - kSwitchStressTestNumColumns * kSwitchStressTestColumnWidth
          : 0;
  [UIView animateWithDuration:2.0
                   animations:^{
                     [self layoutSwitches];
                   }
                   completion:nil];
}

- (void)layoutSwitches {
  NSInteger i = 0;
  for (UIView *view in _switches) {
    NSInteger row = i % (int)ceil(kSwitchStressTestNumSwitches / kSwitchStressTestNumColumns);
    NSInteger column = floor(i * kSwitchStressTestNumColumns / kSwitchStressTestNumSwitches);
    CGRect frame = view.frame;
    frame.origin.x = _switchPosition + column * kSwitchStressTestColumnWidth;
    frame.origin.y = CGRectGetMaxY(_buttonBar.frame) + 10 + frame.size.height * row;
    view.frame = frame;
    i++;
  }
}

- (UIView *)makeSwitch {
  if (_switchType % 2 == 0) {
    return [[MDCSwitch alloc] initWithFrame:CGRectZero];
  } else {
    return [[UISwitch alloc] initWithFrame:CGRectZero];
  }
}

#pragma mark - Visual configuration

- (UIColor *)buttonBarBackgroundColor {
  return [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];
}

- (NSDictionary *)itemTitleTextAttributes {
  UIColor *textColor = [UIColor colorWithWhite:0 alpha:0.8];
  return @{NSForegroundColorAttributeName : textColor};
}

@end
