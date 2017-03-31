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

#import "ViewController.h"

#import "MaterialShadowedView.h"
#import "VanillaShadowedView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MaterialShadowedView *greenTappable;
@property (weak, nonatomic) IBOutlet MaterialShadowedView *greenBanner;

@property (weak, nonatomic) IBOutlet VanillaShadowedView *blueTappable;
@property (weak, nonatomic) IBOutlet VanillaShadowedView *blueBanner;

@property (nonatomic) NSLayoutConstraint *greenBannerLeadingConstraintCollapsed;
@property (nonatomic) NSLayoutConstraint *blueBannerLeadingConstraintCollapsed;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.greenBannerLeadingConstraintCollapsed =
      [[self.greenBanner trailingAnchor] constraintEqualToAnchor:self.greenTappable.trailingAnchor];
  self.greenBannerLeadingConstraintCollapsed.active = NO;

  self.blueBannerLeadingConstraintCollapsed =
      [[self.blueBanner trailingAnchor] constraintEqualToAnchor:self.blueTappable.trailingAnchor];
  self.blueBannerLeadingConstraintCollapsed.active = NO;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)viewTapped:(id)sender {
  self.greenBannerLeadingConstraintCollapsed.active = !self.greenBannerLeadingConstraintCollapsed.active;
  self.blueBannerLeadingConstraintCollapsed.active = !self.blueBannerLeadingConstraintCollapsed.active;

  [UIView animateWithDuration:5 animations:^{
    [self.view layoutIfNeeded];
  }];
}

@end
