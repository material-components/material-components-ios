/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "MaterialFlexibleHeader.h"

#import "FlexibleHeaderConfiguratorSupplemental.h"

@interface FlexibleHeaderConfiguratorExample ()

@property(nonatomic) MDCFlexibleHeaderViewController *fhvc;

@end

@implementation FlexibleHeaderConfiguratorExample

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonFlexibleHeaderConfiguratorExampleInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonFlexibleHeaderConfiguratorExampleInit];
  }
  return self;
}

- (void)commonFlexibleHeaderConfiguratorExampleInit {
  _fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];
  [self addChildViewController:_fhvc];

  self.title = @"Header Configuration";
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.scrollView = [[UIScrollView alloc] init];
  [self.view addSubview:self.scrollView];

  // If a tableView was being used instead of a scrollView, you would set the trackingScrollView
  // to be that tableView and either set the MDCFlexibleHeaderViewController to be the
  // UITableViewDelegate or forward the UIScrollViewDelegate methods to
  // MDCFlexibleHeaderViewController from the UITableViewDelegate.
  self.scrollView.delegate = self.fhvc;
  self.fhvc.headerView.trackingScrollView = self.scrollView;

  self.fhvc.view.frame = self.view.bounds;

  [self.view addSubview:self.fhvc.view];

  [self.fhvc didMoveToParentViewController:self];

  UIColor *lightBlue500 = [UIColor colorWithRed:0.012
                                          green:0.663
                                           blue:0.957
                                          alpha:1];
  self.fhvc.headerView.backgroundColor = lightBlue500;
  [self setupExampleViews:self.fhvc];

  // Add Back button
  UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectZero];
  bar.translatesAutoresizingMaskIntoConstraints = NO;
  bar.barTintColor = lightBlue500;
  bar.translucent = NO;
  bar.clipsToBounds = YES;

  [self.fhvc.headerView addSubview:bar];

  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(didTapButton:)];
  backButton.tintColor = [UIColor whiteColor];

  // Add a title label
  UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                           target:nil
                           action:nil];

  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  titleLabel.text = @"Configurator";
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle2];
  [titleLabel sizeToFit];

  UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];

  bar.items = @[ backButton, spacer, titleItem, spacer ];

  NSDictionary *viewBindings = @{ @"bar" : bar };
  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints = [NSMutableArray array];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"H:|-[bar]-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"V:[bar]-8-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];

  [self.view addConstraints:arrayOfConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // If the MDCFlexibleHeaderViewController's view is not going to replace a navigation bar,
  // comment this line:
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

// This method must be implemented for MDCFlexibleHeaderViewController's
// MDCFlexibleHeaderView to properly support MDCFlexibleHeaderShiftBehavior should you choose
// to customize it.
- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.fhvc;
}

#pragma mark - Target Action

- (void)sliderDidSlide:(UISlider *)sender {
  if (sender == self.exampleView.minHeightSlider) {
    self.fhvc.headerView.minimumHeight = sender.value;
  } else if (sender == self.exampleView.maxHeightSlider) {
    self.fhvc.headerView.maximumHeight = sender.value;
  }
}

- (void)switchDidToggle:(UISwitch *)sender {
  if (sender == self.exampleView.overExtendSwitch) {
    self.fhvc.headerView.canOverExtend = sender.isOn;
  } else if (sender == self.exampleView.shiftSwitch) {
    if (!self.exampleView.shiftSwitch.isOn) {
      self.exampleView.shiftStatusBarSwitch.on = NO;
      self.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorDisabled;
    } else {
      if (self.fhvc.headerView.shiftBehavior != MDCFlexibleHeaderShiftBehaviorEnabled ||
          self.fhvc.headerView.shiftBehavior != MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar) {
        self.fhvc.headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
      }
    }
  } else if (sender == self.exampleView.shiftStatusBarSwitch) {
    if (sender.isOn) {
      self.exampleView.shiftSwitch.on = YES;
    }

    self.fhvc.headerView.shiftBehavior =
        sender.isOn ? MDCFlexibleHeaderShiftBehaviorEnabled : MDCFlexibleHeaderShiftBehaviorDisabled;
  } else if (sender == self.exampleView.infiniteContentSwitch) {
    self.fhvc.headerView.inFrontOfInfiniteContent = sender.isOn;
  }
}

- (void)didTapButton:(id)button {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
