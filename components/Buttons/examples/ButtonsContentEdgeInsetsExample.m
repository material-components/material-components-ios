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
#import "MaterialButtons+ButtonThemer.h"

@interface ButtonsContentEdgeInsetsExample : UIViewController
@property(weak, nonatomic) IBOutlet MDCButton *textButton;
@property(weak, nonatomic) IBOutlet MDCButton *containedButton;
@property(weak, nonatomic) IBOutlet MDCFloatingButton *floatingActionButton;
@property(weak, nonatomic) IBOutlet UISwitch *inkBoundingSwitch;
@end

@implementation ButtonsContentEdgeInsetsExample

#pragma mark - Catalog by Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Buttons", @"Buttons (Content Edge Insets)" ],
    @"primaryDemo": @NO,
    @"presentable": @NO,
    @"storyboardName": @"ButtonsContentEdgeInsets",
  };
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:self.containedButton];
  [MDCTextButtonThemer applyScheme:buttonScheme toButton:self.textButton];

  self.textButton.contentEdgeInsets = UIEdgeInsetsMake(64, 64, 0, 0);
  self.containedButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 64, 64);
  [self.floatingActionButton setContentEdgeInsets:UIEdgeInsetsMake(40, 40, 0, 0)
                                         forShape:MDCFloatingButtonShapeDefault
                                           inMode:MDCFloatingButtonModeNormal];

  [self updateInkStyle:self.inkBoundingSwitch.isOn ? MDCInkStyleBounded : MDCInkStyleUnbounded];
}

- (void)updateInkStyle:(MDCInkStyle)inkStyle {
  self.textButton.inkStyle = inkStyle;
  self.containedButton.inkStyle = inkStyle;
  self.floatingActionButton.inkStyle = inkStyle;
}

- (IBAction)didChangeInkStyle:(UISwitch *)sender {
  [self updateInkStyle:sender.isOn ? MDCInkStyleBounded : MDCInkStyleUnbounded];
}

@end
