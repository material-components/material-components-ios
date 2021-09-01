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

@implementation NavigationBarWithCustomFontExample

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

  self.title = @"Custom Font";

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  [self.navBar observeNavigationItem:self.navigationItem];

  UIFont *font = [UIFont fontWithName:@"Zapfino" size:18.0];

  NSDictionary<NSAttributedStringKey, id> *titleTextAttributes = @{NSFontAttributeName : font};

  [self.navBar setTitleTextAttributes:titleTextAttributes];

  MDCNavigationBarTextColorAccessibilityMutator *mutator =
      [[MDCNavigationBarTextColorAccessibilityMutator alloc] init];
  [mutator mutate:self.navBar];

  [MDCNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toNavigationBar:self.navBar];

  [self.view addSubview:self.navBar];

  self.navBar.translatesAutoresizingMaskIntoConstraints = NO;

  [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.navBar.topAnchor].active =
      YES;

  NSDictionary *viewsBindings = @{@"navBar" : self.navBar};

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

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Navigation Bar", @"Navigation Bar with Custom Font" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
