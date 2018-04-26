/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialButtons.h"
#import "MDCButtonScheme.h"
#import "MDCContainedButtonThemer.h"

@interface ButtonsContentEdgeInsetsExample : UIViewController
@property(weak, nonatomic) IBOutlet MDCFlatButton *flatButton;
@property(weak, nonatomic) IBOutlet MDCButton *containedButton;
@property(weak, nonatomic) IBOutlet MDCFloatingButton *floatingActionButton;
@property(weak, nonatomic) IBOutlet UISwitch *inkBoundingSwitch;
@end

@implementation ButtonsContentEdgeInsetsExample

#pragma mark - Catalog by Convention

+ (NSArray<NSString *> *)catalogBreadcrumbs {
  return @[ @"Buttons", @"Buttons (Content Edge Insets)" ];
}

+ (NSString *)catalogStoryboardName {
  return @"ButtonsContentEdgeInsets";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:self.containedButton];

  // Force a darker background color to show the button frame
  [self.flatButton setBackgroundColor:[UIColor colorWithWhite:0.2f alpha:1.0f]
                             forState:UIControlStateNormal];
  self.flatButton.inkColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
  self.flatButton.contentEdgeInsets = UIEdgeInsetsMake(64, 64, 0, 0);
  self.containedButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 64, 64);
  [self.floatingActionButton setContentEdgeInsets:UIEdgeInsetsMake(40, 40, 0, 0)
                                         forShape:MDCFloatingButtonShapeDefault
                                           inMode:MDCFloatingButtonModeNormal];

  [self updateInkStyle:self.inkBoundingSwitch.isOn ? MDCInkStyleBounded : MDCInkStyleUnbounded];
}

- (void)updateInkStyle:(MDCInkStyle)inkStyle {
  self.flatButton.inkStyle = inkStyle;
  self.containedButton.inkStyle = inkStyle;
  self.floatingActionButton.inkStyle = inkStyle;
}

- (IBAction)didChangeInkStyle:(UISwitch *)sender {
  [self updateInkStyle:sender.isOn ? MDCInkStyleBounded : MDCInkStyleUnbounded];
}

@end
