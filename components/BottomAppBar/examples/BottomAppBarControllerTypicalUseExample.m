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

#import "BottomAppBarControllerTypicalUseExample.h"
#import "MDCButtonColorThemer.h"

@implementation BottomAppBarControllerTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom App Bar Controller";
    [self commonBottomAppBarControllerTypicalUseExampleInit];
  }
  return self;
}

- (void)commonBottomAppBarControllerTypicalUseExampleInit {
  // Set the image on the floating button.
  UIImage *addImage = [UIImage imageNamed:@"Add"];
  [self.bottomBarView.floatingButton setImage:addImage forState:UIControlStateNormal];

  // Add touch handler to the floating button.
  [self.bottomBarView.floatingButton addTarget:self
                                        action:@selector(didTapFloatingButton:)
                              forControlEvents:UIControlEventTouchUpInside];

  // Theme the floating button.
  MDCBasicColorScheme *colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:[UIColor whiteColor]];
  [MDCButtonColorThemer applyColorScheme:colorScheme toButton:self.bottomBarView.floatingButton];

  // Configure the navigation buttons to be shown on the bottom app bar.
  UIBarButtonItem *barButtonLeadingItem =
      [[UIBarButtonItem alloc] initWithTitle:nil
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapBack:)];
  UIImage *menuImage = [UIImage imageNamed:@"Back"];
  [barButtonLeadingItem setImage:menuImage];

  UIBarButtonItem *barButtonTrailingItem =
      [[UIBarButtonItem alloc] initWithTitle:nil
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapSearch:)];
  UIImage *searchImage = [UIImage imageNamed:@"Search"];
  [barButtonTrailingItem setImage:searchImage];

  [self.bottomBarView setLeadingBarButtonItems:@[ barButtonLeadingItem ]];
  [self.bottomBarView setTrailingBarButtonItems:@[ barButtonTrailingItem ]];
}

- (void)didTapFloatingButton:(id)sender {
  UIViewController *viewController = [[UIViewController alloc] init];
  CGFloat rand = (arc4random() % 100) / 100.0f;
  viewController.view.backgroundColor = [UIColor colorWithWhite:rand alpha:1];
  [self pushViewController:viewController animated:YES];
  if (self.viewControllers.count == 2) {
    [self.bottomBarView setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionTrailing
                                         animated:YES];
  }
}

- (void)didTapBack:(id)sender {
  if (self.viewControllers.count == 1) {
    [self.navigationController popViewControllerAnimated:YES];
  } else {
    [self popViewControllerAnimated:YES];
  }

  if (self.viewControllers.count == 1) {
    [self.bottomBarView setFloatingButtonPosition:MDCBottomAppBarFloatingButtonPositionCenter
                                         animated:YES];
  }
}

- (void)didTapSearch:(id)sender {
  [self presentBottomSheet];
}

@end

@implementation BottomAppBarControllerTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom App Bar", @"Bottom App Bar Controller" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
