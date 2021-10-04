// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MDCTextControlContentViewController.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

#import "MDCTextControlConfiguratorExample.h"

@interface MDCTextControlConfiguratorExample ()

/**
All the content size categories that this view controller supports.
 */
@property(nonatomic, strong) NSArray *contentSizeCategories;
@end

@implementation MDCTextControlConfiguratorExample

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setUpChildViewController];
  [self setUpContentSizeCategories];
  [self setUpContainerScheme];
  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGFloat viewWidth = CGRectGetWidth(self.view.frame);
  CGFloat viewHeight = CGRectGetHeight(self.view.frame);
  self.contentViewController.view.frame =
      CGRectMake(0, self.preferredContentMinY, viewWidth, viewHeight - self.preferredContentMinY);
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.contentViewController.view setNeedsLayout];
}

#pragma mark Setup

- (void)setUpChildViewController {
  [self initializeContentViewController];
  if (self.contentViewController) {
    [self addChildViewController:self.contentViewController];
    self.contentViewController.traitEnvironmentChangeDelegate = self;
    [self.view addSubview:self.contentViewController.view];
  }
}

- (void)initializeContentViewController {
}

- (void)setUpContainerScheme {
  if (!self.containerScheme) {
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    containerScheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
    self.containerScheme = containerScheme;
  }
}

- (void)setUpContentSizeCategories {
  self.contentSizeCategories = @[
    UIContentSizeCategoryExtraSmall, UIContentSizeCategorySmall, UIContentSizeCategoryMedium,
    UIContentSizeCategoryLarge, UIContentSizeCategoryExtraLarge,
    UIContentSizeCategoryExtraExtraLarge, UIContentSizeCategoryExtraExtraExtraLarge,
    UIContentSizeCategoryAccessibilityMedium, UIContentSizeCategoryAccessibilityLarge,
    UIContentSizeCategoryAccessibilityExtraLarge, UIContentSizeCategoryAccessibilityExtraExtraLarge,
    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge
  ];
}

- (void)increaseContentSizeForChildViewController:(UIViewController *)childViewController
                                   decreaseButton:(MDCButton *)decreaseButton
                                   increaseButton:(MDCButton *)increaseButton {
  UIContentSizeCategory contentSizeCategory =
      [self contentSizeCategoryForViewController:childViewController];
  if (contentSizeCategory) {
    NSInteger idx = [self.contentSizeCategories indexOfObject:contentSizeCategory];
    if (idx < (NSInteger)self.contentSizeCategories.count - 1) {
      idx += 1;
      UIContentSizeCategory newContentSizeCategory = self.contentSizeCategories[idx];
      [self setContentSizeCategory:newContentSizeCategory
             onChildViewController:childViewController];
      increaseButton.enabled = idx != (NSInteger)self.contentSizeCategories.count - 1;
      decreaseButton.enabled = idx > 0;
    }
  }
}

- (void)decreaseContentSizeForChildViewController:(UIViewController *)childViewController
                                   decreaseButton:(MDCButton *)decreaseButton
                                   increaseButton:(MDCButton *)increaseButton {
  UIContentSizeCategory contentSizeCategory =
      [self contentSizeCategoryForViewController:childViewController];
  if (contentSizeCategory) {
    NSInteger idx = [self.contentSizeCategories indexOfObject:contentSizeCategory];
    if (idx > (NSInteger)0) {
      idx -= 1;
      UIContentSizeCategory newContentSizeCategory = self.contentSizeCategories[idx];
      [self setContentSizeCategory:newContentSizeCategory
             onChildViewController:childViewController];
      increaseButton.enabled = idx != (NSInteger)self.contentSizeCategories.count - 1;
      decreaseButton.enabled = idx > 0;
    }
  }
}

#pragma mark Accessors

- (void)setContentSizeCategory:(UIContentSizeCategory)contentSizeCategory
         onChildViewController:(UIViewController *)viewController {
  UITraitCollection *contentSizeCategoryTraitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:contentSizeCategory];
  UITraitCollection *currentTraitCollection = viewController.traitCollection;
  NSArray *traitCollections = @[ currentTraitCollection, contentSizeCategoryTraitCollection ];
  UITraitCollection *traitCollection =
      [UITraitCollection traitCollectionWithTraitsFromCollections:traitCollections];
  [self setOverrideTraitCollection:traitCollection forChildViewController:viewController];
  [self.view setNeedsLayout];
}

- (UIContentSizeCategory)contentSizeCategoryForViewController:(UIViewController *)viewController {
  return viewController.traitCollection.preferredContentSizeCategory;
}

- (void)setContainerScheme:(id<MDCContainerScheming>)containerScheme {
  self.contentViewController.containerScheme = containerScheme;
}

- (id<MDCContainerScheming>)containerScheme {
  return self.contentViewController.containerScheme;
}

- (CGFloat)preferredContentMinY {
  return (CGFloat)(self.view.safeAreaInsets.top);
}

- (void)setTraitCollection:(UITraitCollection *)traitCollection
     onChildViewController:(UIViewController *)childViewController {
  NSArray *traitCollections = @[ childViewController.traitCollection, traitCollection ];
  UITraitCollection *newTraitCollection =
      [UITraitCollection traitCollectionWithTraitsFromCollections:traitCollections];
  [self setOverrideTraitCollection:newTraitCollection forChildViewController:childViewController];
}

#pragma mark - MDCTraitEnvironmentChangeDelegate

- (void)
    childViewControllerDidRequestPreferredContentSizeCategoryDecrement:
        (UIViewController *)childViewController
                                                        decreaseButton:(MDCButton *)decreaseButton
                                                        increaseButton:(MDCButton *)increaseButton {
  [self decreaseContentSizeForChildViewController:childViewController
                                   decreaseButton:decreaseButton
                                   increaseButton:increaseButton];
}
- (void)
    childViewControllerDidRequestPreferredContentSizeCategoryIncrement:
        (UIViewController *)childViewController
                                                        decreaseButton:(MDCButton *)decreaseButton
                                                        increaseButton:(MDCButton *)increaseButton {
  [self increaseContentSizeForChildViewController:childViewController
                                   decreaseButton:decreaseButton
                                   increaseButton:increaseButton];
}

- (void)childViewControllerDidRequestUserInterfaceStyle:(UIViewController *)childViewController
                                     userInterfaceStyle:(UIUserInterfaceStyle)userInterfaceStyle
    API_AVAILABLE(ios(12.0)) {
  UITraitCollection *userInterfaceStyleTraitCollection =
      [UITraitCollection traitCollectionWithUserInterfaceStyle:userInterfaceStyle];
  [self setTraitCollection:userInterfaceStyleTraitCollection
      onChildViewController:childViewController];
}

- (void)childViewControllerDidRequestLayoutDirection:(UIViewController *)childViewController
                                     layoutDirection:
                                         (UITraitEnvironmentLayoutDirection)layoutDirection
    API_AVAILABLE(ios(10.0)) {
  UITraitCollection *layoutDirectionTraitCollection =
      [UITraitCollection traitCollectionWithLayoutDirection:layoutDirection];
  [self setTraitCollection:layoutDirectionTraitCollection
      onChildViewController:childViewController];
}

@end
