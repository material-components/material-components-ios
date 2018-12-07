// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomNavigationBarController.h"

@interface MDCBottomNavigationBarController ()

/** The view that hosts the content for the selected view controller **/
@property(nonatomic, strong) UIView *content;

/** Constrains the navigation bar's height to the constant value of this property **/
@property(nonatomic, strong) NSLayoutConstraint *navigationBarHeightConstraint;

@end

@implementation MDCBottomNavigationBarController

- (instancetype)init {
  self = [super init];
  if (self) {
    _navigationBar = [[MDCBottomNavigationBar alloc] init];
    _content = [[UIView alloc] init];
    _viewControllers = @[];
    _selectedIndex = NSNotFound;
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _navigationBar.delegate = self;

  // Add subviews and create their constraints
  [self.view addSubview:_navigationBar];
  [self.view addSubview:_content];
  [self loadConstraints];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self updateNavigationBarHeight];
}

- (void)viewSafeAreaInsetsDidChange {
  [super viewSafeAreaInsetsDidChange];
  [self updateNavigationBarHeight];
}

- (void)setSelectedViewController:(nullable UIViewController *)selectedViewController {
  // Assert that the given VC is one of our view controllers or it is nil (we are unselecting)
  NSAssert(
      selectedViewController == nil || [self.viewControllers containsObject:selectedViewController],
      @"Attempting to set BottomBarViewControllers to a view controller it does not contain");

  // Early return if we are already set to the given VC
  if (_selectedViewController == selectedViewController) {
    return;
  }

  // Remove current VC and add new one.
  [self removeContentViewController:self.selectedViewController];
  [self addContentViewController:selectedViewController];

  // Set the iVar and update selected index
  _selectedViewController = selectedViewController;
  self.selectedIndex = [self.viewControllers indexOfObject:selectedViewController];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
  // If we are setting to NSNotFound deselect the items
  if (selectedIndex == NSNotFound) {
    [self deselectCurrentItem];
    return;
  }

  BOOL outOfBounds = selectedIndex >= [self.viewControllers count] ||
                     selectedIndex >= [_navigationBar.items count];

  NSAssert(!outOfBounds,
           @"Attempting to set BottomBarViewController's selectedIndex to %li. This"
            " value is not within the bounds of the navigation bar's items and/or view controllers",
           (unsigned long)selectedIndex);

  // Early return if we are out of bounds or if the the index is already selected.
  if (outOfBounds || selectedIndex == _selectedIndex) {
    return;
  }

  // Update the selected index value and views.
  _selectedIndex = selectedIndex;
  [self updateViewsForSelectedIndex:selectedIndex];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
  [self deselectCurrentItem];
  NSArray *viewControllersCopy = [viewControllers copy];
  _navigationBar.items = [self tabBarItemsForViewControllers:viewControllersCopy];
  _viewControllers = viewControllersCopy;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.selectedViewController;
}

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(UITabBarItem *)item {
  // Early return if we cannot find the view controller.
  NSUInteger index = [_navigationBar.items indexOfObject:item];
  if (index >= [self.viewControllers count] || index == NSNotFound) {
    return;
  }

  // Update selected view controller
  UIViewController *selectedViewController = [self.viewControllers objectAtIndex:index];
  self.selectedViewController = selectedViewController;

  // Notify the delegate.
  if ([_delegate respondsToSelector:@selector(bottomNavigationBarController:
                                                    didSelectViewController:)]) {
    [_delegate bottomNavigationBarController:self didSelectViewController:selectedViewController];
  }
}

- (BOOL)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar
           shouldSelectItem:(UITabBarItem *)item {
  NSUInteger index = [_navigationBar.items indexOfObject:item];
  if (index >= [self.viewControllers count] || index == NSNotFound) {
    return NO;
  }

  // Pass the response to the delegate if they want to handle this request.
  if ([_delegate respondsToSelector:@selector(bottomNavigationBarController:
                                                    didSelectViewController:)]) {
    UIViewController *viewControllerToSelect = [self.viewControllers objectAtIndex:index];
    return [_delegate bottomNavigationBarController:self
                         shouldSelectViewController:viewControllerToSelect];
  }

  return YES;
}

#pragma mark - Private Methods

/**
 * Removes the given view controller from its parent view controller and its view from its superview
 */
- (void)removeContentViewController:(UIViewController *)viewController {
  [viewController removeFromParentViewController];
  [viewController.view removeFromSuperview];
}

/**
 * Adds the given view controller to the view controller hierarchy and its view to the content
 * view.
 */
- (void)addContentViewController:(UIViewController *)viewController {
  BOOL doesNotContainViewController = ![self.childViewControllers containsObject:viewController];
  if (viewController && doesNotContainViewController) {
    [self addChildViewController:viewController];
    [self.content addSubview:viewController.view];
    [self addConstraintsForContentView:viewController.view];
    [viewController didMoveToParentViewController:self];
  }
}

/**
 * Deselects the currently set item.  Sets the selectedIndex to NSNotFound, the naviagation bar's
 * selected item to nil, and the selectedViewController to nil.
 */
- (void)deselectCurrentItem {
  _selectedIndex = NSNotFound;
  _navigationBar.selectedItem = nil;

  // Force removal of the currently selected viewcontroller if there is one.
  self.selectedViewController = nil;
}

/**
 * Sets the selected view controller to the corresponding index and updates the navigation bar's
 * selected item.
 */
- (void)updateViewsForSelectedIndex:(NSUInteger)index {
  // Update the selected view controller
  UIViewController *selectedViewController = [self.viewControllers objectAtIndex:index];
  self.selectedViewController = selectedViewController;

  // Update the navigation bar's selected item.
  _navigationBar.selectedItem = selectedViewController.tabBarItem;
  [self setNeedsStatusBarAppearanceUpdate];
}

/**
 * Hooks up the constraints for the subviews of this controller.  Namely the content view and the
 * navigation bar.
 */
- (void)loadConstraints {
  _content.translatesAutoresizingMaskIntoConstraints = NO;
  _navigationBar.translatesAutoresizingMaskIntoConstraints = NO;

  // Navigation Bar Constraints
  [self.view.leftAnchor constraintEqualToAnchor:_navigationBar.leftAnchor].active = YES;
  [self.view.rightAnchor constraintEqualToAnchor:_navigationBar.rightAnchor].active = YES;

  _navigationBarHeightConstraint =
      [_navigationBar.heightAnchor constraintEqualToConstant:[self calculateNavigationBarHeight]];
  _navigationBarHeightConstraint.active = YES;

  [_navigationBar.topAnchor constraintEqualToAnchor:_content.bottomAnchor].active = YES;
  [_navigationBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

  // Content View Constraints
  [self.view.leftAnchor constraintEqualToAnchor:_content.leftAnchor].active = YES;
  [self.view.rightAnchor constraintEqualToAnchor:_content.rightAnchor].active = YES;

  [self.view.topAnchor constraintEqualToAnchor:_content.topAnchor].active = YES;
}

/**
 * Pins the given view to the edges of the content view.
 */
- (void)addConstraintsForContentView:(UIView *)view {
  view.translatesAutoresizingMaskIntoConstraints = NO;
  [view.leadingAnchor constraintEqualToAnchor:_content.leadingAnchor].active = YES;
  [view.trailingAnchor constraintEqualToAnchor:_content.trailingAnchor].active = YES;
  [view.topAnchor constraintEqualToAnchor:_content.topAnchor].active = YES;
  [view.bottomAnchor constraintEqualToAnchor:_content.bottomAnchor].active = YES;
}

/** Returns the desired height of the navigation bar. **/
- (CGFloat)calculateNavigationBarHeight {
  CGSize fitSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
  return [_navigationBar sizeThatFits:fitSize].height;
}

/** Sets the navigation bar's height based on its desired size **/
- (void)updateNavigationBarHeight {
  _navigationBarHeightConstraint.constant = [self calculateNavigationBarHeight];
}

/** Maps an array of view controllers to their corrisponding tab bar items **/
- (NSArray<UITabBarItem *> *)tabBarItemsForViewControllers:
    (NSArray<UIViewController *> *)viewControllers {
  NSMutableArray<UITabBarItem *> *tabBarItems = [NSMutableArray array];
  for (UIViewController *viewController in viewControllers) {
    UITabBarItem *tabBarItem = viewController.tabBarItem;
    NSAssert(tabBarItem != nil,
             @"%@'s tabBarItem is nil. Please ensure that each view controller "
              "added to %@ has set its tab bar item property",
             viewController, NSStringFromClass([self class]));

    if (tabBarItem) {
      [tabBarItems addObject:tabBarItem];
    }
  }

  return tabBarItems;
}

@end
