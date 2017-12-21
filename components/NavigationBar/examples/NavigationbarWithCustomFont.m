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
#import "supplemental/NavigationBarTypicalUseExampleSupplemental.h"

@implementation NavigationBarWithCustomFontExample

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  self.title = @"Custom Font";

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  [self.navBar observeNavigationItem:self.navigationItem];

  [self.navBar setBackgroundColor:[UIColor colorWithWhite:0.1f alpha:1.0f]];

  UIFont *font = [UIFont fontWithName:@"Zapfino" size:18.0];

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  NSDictionary<NSAttributedStringKey,id> *titleTextAttributes = @{ NSFontAttributeName : font };
#else
  NSDictionary<NSString *,id> *titleTextAttributes = @{ NSFontAttributeName : font };
#endif

  [self.navBar setTitleTextAttributes:titleTextAttributes];

  MDCNavigationBarTextColorAccessibilityMutator *mutator =
      [[MDCNavigationBarTextColorAccessibilityMutator alloc] init];
  [mutator mutate:self.navBar];

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

- (void)itemTapped:(id)sender {
  NSAssert([sender respondsToSelector:@selector(title)], @"");
  NSLog(@"%@", [sender title]);
}

@end

@implementation NavigationBarWithCustomFontExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Navigation Bar", @"Navigation Bar with Custom Font" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
