// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialBottomAppBar+ColorThemer.h"
#import "MaterialBottomAppBar.h"
#import "MaterialButtons+ButtonThemer.h"

#import "supplemental/BottomAppBarTypicalUseSupplemental.h"

@implementation BottomAppBarTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom App Bar";
    _colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)commonBottomBarSetup {
  [self setupExampleTableLayout];

  // Add touch handler to the floating button.
  [self.bottomBarView.floatingButton addTarget:self
                                        action:@selector(didTapFloatingButton:)
                              forControlEvents:UIControlEventTouchUpInside];

  // Set the image on the floating button.
  UIImage *addImage =
      [[UIImage imageNamed:@"Add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.bottomBarView.floatingButton setImage:addImage forState:UIControlStateNormal];

  // Configure the navigation buttons to be shown on the bottom app bar.
  UIBarButtonItem *barButtonLeadingItem =
      [[UIBarButtonItem alloc] initWithTitle:nil
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapMenu:)];
  UIImage *menuImage =
      [[UIImage imageNamed:@"Menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [barButtonLeadingItem setImage:menuImage];

  UIBarButtonItem *barButtonTrailingItem =
      [[UIBarButtonItem alloc] initWithTitle:nil
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapSearch:)];
  UIImage *searchImage =
      [[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [barButtonTrailingItem setImage:searchImage];

  [self.bottomBarView setLeadingBarButtonItems:@[ barButtonLeadingItem ]];
  [self.bottomBarView setTrailingBarButtonItems:@[ barButtonTrailingItem ]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self commonBottomBarSetup];

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;
  [MDCFloatingActionButtonThemer applyScheme:buttonScheme
                                    toButton:self.bottomBarView.floatingButton];
  [MDCBottomAppBarColorThemer applySurfaceVariantWithSemanticColorScheme:self.colorScheme
                                                      toBottomAppBarView:self.bottomBarView];
}

- (void)didTapFloatingButton:(id)sender {
  [self.bottomBarView setFloatingButtonHidden:YES animated:YES];
}

- (void)didTapMenu:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapSearch:(id)sender {
  [self.bottomBarView setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionTrailing
                                       animated:YES];
}

@end
