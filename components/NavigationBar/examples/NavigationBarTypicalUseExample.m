// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "supplemental/NavigationBarTypicalUseExampleSupplemental.h"
#import "MaterialNavigationBar+ColorThemer.h"
#import "MaterialNavigationBar.h"
#import "MaterialColorScheme.h"

@interface NavigationBarTypicalUseExample ()

@end

@implementation NavigationBarTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  self.title = @"Navigation Bar";

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  [self.navBar observeNavigationItem:self.navigationItem];

  MDCNavigationBarTextColorAccessibilityMutator *mutator =
      [[MDCNavigationBarTextColorAccessibilityMutator alloc] init];
  [mutator mutate:self.navBar];

  [MDCNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toNavigationBar:self.navBar];

  [self.view addSubview:self.navBar];

  self.navBar.translatesAutoresizingMaskIntoConstraints = NO;

  if (@available(iOS 11.0, *)) {
    [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.navBar.topAnchor].active =
        YES;
  } else {
    [NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.navBar
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0]
        .active = YES;
  }

  NSDictionary *viewsBindings = NSDictionaryOfVariableBindings(_navBar);

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsBindings]];

  [self setupExampleViews];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end
