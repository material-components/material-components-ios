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

#import <UIKit/UIKit.h>

#import "MaterialNavigationBar.h"
#import "MaterialNavigationBar+ColorThemer.h"
#import "supplemental/NavigationBarTypicalUseExampleSupplemental.h"

@implementation NavigationBarWithBarItemsExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  self.title = @"With Items";

  // The action selector we are using has a signature of id:UIEvent:UIButton to demonstrate how to
  // identify the underlying UIView of the UIBarButtonItem. This is required because we don't have
  // access to the necessary private ivars to associate the item with the button.
  self.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Leading"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(itemTapped:withEvent:fromButton:)];
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Trailing"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(itemTapped:withEvent:fromButton:)];

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  [self.navBar observeNavigationItem:self.navigationItem];

  MDCNavigationBarTextColorAccessibilityMutator *mutator =
      [[MDCNavigationBarTextColorAccessibilityMutator alloc] init];
  [mutator mutate:self.navBar];

  [MDCNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toNavigationBar:self.navBar];

  [self.view addSubview:self.navBar];

  self.navBar.translatesAutoresizingMaskIntoConstraints = NO;

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.navBar.topAnchor].active = YES;
  } else {
#endif
    [NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.navBar
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  }
#endif

  NSDictionary *viewsBindings = @{@"navBar": self.navBar};

  [NSLayoutConstraint
   activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navBar]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:viewsBindings]];

  [self setupExampleViews];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)itemTapped:(id)sender withEvent:(UIEvent *)event fromButton:(UIButton *)button {
  NSAssert([sender respondsToSelector:@selector(title)], @"");
  NSLog(@"%@ : %@", [sender title], button);
}

@end

@implementation NavigationBarWithBarItemsExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Navigation Bar", @"Navigation Bar with Items" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end
