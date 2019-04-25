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

#import <CoreGraphics/CoreGraphics.h>

#import "private/MDCBottomNavigationBar+Private.h"
#import "private/MDCBottomNavigationLargeItemDialogView.h"

// A context for Key Value Observing
static void *const kObservationContext = (void *)&kObservationContext;
static const CGFloat kLargeItemViewHeight = 210;
static const CGFloat kLargeItemViewWidth = 210;
static const CGFloat kMinimumLargeFontSize = 28;
static const NSTimeInterval kLargeItemViewAnimationDuration = 0.1;
static const NSTimeInterval kLongPressMinimumPressDuration = 0.2;
static const NSUInteger kLongPressNumberOfTouchesRequired = 1;

/**
 * The transform of the large item view when it is in a transitional state (appearing or
 * dismissing).
 */
static CGAffineTransform MDCLargeItemViewAnimationTransitionTransform() {
  return CGAffineTransformScale(CGAffineTransformIdentity, (CGFloat)0.97, (CGFloat)0.97);
}

@interface MDCBottomNavigationBarController ()

/** The view that hosts the content for the selected view controller **/
@property(nonatomic, strong) UIView *content;

/** The gesture recognizer for detecting long presses on tab bar items. */
@property(nonatomic, strong, nonnull)
    UILongPressGestureRecognizer *navigationBarLongPressRecognizer;

/** The dialog view to display a large item view. */
@property(nonatomic, strong, nullable) MDCBottomNavigationLargeItemDialogView *largeItemDialog;

/** Indicates if the large item view is in the process of dismissing. */
@property(nonatomic, getter=isDismissingLargeItemDialog) BOOL dismissingLargeItemView;

@end

@implementation MDCBottomNavigationBarController

- (instancetype)init {
  self = [super init];
  if (self) {
    _navigationBar = [[MDCBottomNavigationBar alloc] init];
    _content = [[UIView alloc] init];
    _viewControllers = @[];
    _selectedIndex = NSNotFound;
    _dismissingLargeItemView = NO;
    _dynamicTypeSupportEnabled = NO;

    [_navigationBar addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(items))
                        options:NSKeyValueObservingOptionNew
                        context:kObservationContext];
  }

  return self;
}

- (void)dealloc {
  [_navigationBar removeObserver:self forKeyPath:NSStringFromSelector(@selector(items))];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationBar.delegate = self;

  // Add subviews and create their constraints
  [self.view addSubview:self.content];
  [self.view addSubview:self.navigationBar];
  [self loadConstraints];

  if ([self isDynamicTypeSupportEnabled] && ![self isNavigationBarLongPressRecognizerRegistered]) {
    [self.navigationBar addGestureRecognizer:self.navigationBarLongPressRecognizer];
  }
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.navigationBarLongPressRecognizer.allowableMovement =
      CGRectGetWidth(self.navigationBar.bounds);
}

- (void)setSelectedViewController:(nullable UIViewController *)selectedViewController {
  // Assert that the given VC is one of our view controllers or it is nil (we are unselecting)
  NSAssert(
      selectedViewController == nil || [self.viewControllers containsObject:selectedViewController],
      @"Attempting to set BottomBarViewControllers to a view controller it does not contain");

  // Early return if we are already set to the given VC
  if (self.selectedViewController == selectedViewController) {
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

  BOOL outOfBounds = selectedIndex >= self.viewControllers.count ||
                     selectedIndex >= self.navigationBar.items.count;

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
  _viewControllers = viewControllersCopy;
  self.navigationBar.items = [self tabBarItemsForViewControllers:viewControllersCopy];

  self.selectedViewController = viewControllersCopy.firstObject;
}

- (void)setDynamicTypeSupportEnabled:(BOOL)dynamicTypeSupportEnabled {
  _dynamicTypeSupportEnabled = dynamicTypeSupportEnabled;

  BOOL isNavigationBarLongPressRegistered = [self isNavigationBarLongPressRecognizerRegistered];
  if (dynamicTypeSupportEnabled && !isNavigationBarLongPressRegistered) {
    [self.navigationBar addGestureRecognizer:self.navigationBarLongPressRecognizer];
  } else if (!dynamicTypeSupportEnabled && isNavigationBarLongPressRegistered) {
    [self.navigationBar removeGestureRecognizer:self.navigationBarLongPressRecognizer];
  }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.selectedViewController;
}

- (UILongPressGestureRecognizer *)navigationBarLongPressRecognizer {
  if (!_navigationBarLongPressRecognizer) {
    _navigationBarLongPressRecognizer = [[UILongPressGestureRecognizer alloc]
        initWithTarget:self
                action:@selector(handleNavigationBarLongPress:)];
    _navigationBarLongPressRecognizer.numberOfTouchesRequired = kLongPressNumberOfTouchesRequired;
    _navigationBarLongPressRecognizer.minimumPressDuration = kLongPressMinimumPressDuration;
  }

  return _navigationBarLongPressRecognizer;
}

#pragma mark - MDCBottomNavigationBarDelegate

- (void)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar
              didSelectItem:(UITabBarItem *)item {
  // Early return if we cannot find the view controller.
  NSUInteger index = [self.navigationBar.items indexOfObject:item];
  if (index >= [self.viewControllers count] || index == NSNotFound) {
    return;
  }

  // Update selected view controller
  UIViewController *selectedViewController = [self.viewControllers objectAtIndex:index];
  self.selectedViewController = selectedViewController;

  // Notify the delegate.
  if ([self.delegate respondsToSelector:@selector(bottomNavigationBarController:
                                                        didSelectViewController:)]) {
    [self.delegate bottomNavigationBarController:self
                         didSelectViewController:selectedViewController];
  }
}

- (BOOL)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar
           shouldSelectItem:(UITabBarItem *)item {
  NSUInteger index = [self.navigationBar.items indexOfObject:item];
  if (index >= [self.viewControllers count] || index == NSNotFound) {
    return NO;
  }

  // Pass the response to the delegate if they want to handle this request.
  if ([self.delegate respondsToSelector:@selector(bottomNavigationBarController:
                                                        didSelectViewController:)]) {
    UIViewController *viewControllerToSelect = [self.viewControllers objectAtIndex:index];
    return [self.delegate bottomNavigationBarController:self
                             shouldSelectViewController:viewControllerToSelect];
  }

  return YES;
}

#pragma mark - Key Value Observation Methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if (context != kObservationContext) {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    return;
  }

  id newValue = [change objectForKey:NSKeyValueChangeNewKey];
  if (object == self.navigationBar &&
      [keyPath isEqualToString:NSStringFromSelector(@selector(items))] &&
      [newValue isKindOfClass:[NSArray class]]) {
    [self didUpdateNavigationBarItemsWithNewValue:(NSArray *)newValue];
  }
}

- (void)didUpdateNavigationBarItemsWithNewValue:(NSArray *)items {
  // Verify tab bar items correspond with the view controllers tab bar items.
  if (items.count != self.viewControllers.count) {
    [[self unauthorizedItemsChangedException] raise];
  }

  // Verify each new and the view controller's tab bar items are equal.
  for (NSUInteger i = 0; i < self.viewControllers.count; i++) {
    UITabBarItem *viewControllerTabBarItem = [self.viewControllers objectAtIndex:i].tabBarItem;
    UITabBarItem *newTabBarItem = [items objectAtIndex:i];
    if (![viewControllerTabBarItem isEqual:newTabBarItem]) {
      [[self unauthorizedItemsChangedException] raise];
    }
  }
}

#pragma mark - Touch Events

/** Handles long press gesture recognizer event updates. */
- (void)handleNavigationBarLongPress:(UIGestureRecognizer *)recognizer {
  CGPoint touchPoint = [recognizer locationInView:self.navigationBar];
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan:
    case UIGestureRecognizerStateChanged:
      [self handleNavigationBarLongPressUpdatedForPoint:touchPoint];
      break;
    default:
      [self handleNavigationBarLongPressEndedForPoint:touchPoint];
      break;
  }
}

/**
 * Handles when the navigation bar long press gesture recognizer gesture has been initiated or the
 * touch point was updated.
 * @param point CGPoint The point within @c navigationBar coordinate space.
 */
- (void)handleNavigationBarLongPressUpdatedForPoint:(CGPoint)point {
  UIFont *preferredFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  if (preferredFont.pointSize < kMinimumLargeFontSize) {
    return;
  }

  UITabBarItem *item = [self.navigationBar tabBarItemForPoint:point];
  if (!item && CGRectContainsPoint(self.navigationBar.bounds, point)) {
    // The item may be nil when the touch is still within the frame of the navigation bar, but not
    // within the frame of an item view. In this case the large item view should still display the
    // last long pressed item.
    return;
  } else if (!item) {
    [self handleNavigationBarLongPressEndedForPoint:point];
    return;
  }

  if (!self.largeItemDialog) {
    self.largeItemDialog = [[MDCBottomNavigationLargeItemDialogView alloc] init];
  }
  [self.largeItemDialog updateWithTabBarItem:item];
  [self showLargeItemDialog];
}

/**
 * Handles when the navigation bar long press gesture recognizer gesture has concluded.
 * @param point CGPoint The point within @c navigationBar coordinate space.
 */
- (void)handleNavigationBarLongPressEndedForPoint:(CGPoint)point {
  UITabBarItem *item = [self.navigationBar tabBarItemForPoint:point];
  NSUInteger index = [self.navigationBar.items indexOfObject:item];
  if (index != NSNotFound && index < self.viewControllers.count) {
    self.selectedIndex = index;
  }
  [self dismissLargeItemDialog];
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
  self.navigationBar.selectedItem = nil;

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
  self.navigationBar.selectedItem = selectedViewController.tabBarItem;
  [self setNeedsStatusBarAppearanceUpdate];
}

/**
 * Hooks up the constraints for the subviews of this controller.  Namely the content view and the
 * navigation bar.
 */
- (void)loadConstraints {
  self.content.translatesAutoresizingMaskIntoConstraints = NO;
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;

  if (@available(iOS 9.0, *)) {
    [self loadiOS9PlusConstraints];
  } else {
    [self loadPreiOS9Constraints];
  }
}

- (void)loadPreiOS9Constraints {
  // Navigation Bar Constraints
  NSArray<NSLayoutConstraint *> *navigationBarConstraints = @[
    [NSLayoutConstraint constraintWithItem:self.navigationBar
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.navigationBar
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.navigationBar
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.navigationBar
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.content
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0]
  ];

  // Content View Constraints
  NSArray<NSLayoutConstraint *> *contentConstraints = @[
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0]
  ];

  [NSLayoutConstraint activateConstraints:navigationBarConstraints];
  [NSLayoutConstraint activateConstraints:contentConstraints];
}

- (void)loadiOS9PlusConstraints {
  if (@available(iOS 9.0, *)) {
    // Navigation Bar Constraints
    [self.view.leftAnchor constraintEqualToAnchor:self.navigationBar.leftAnchor].active = YES;
    [self.view.rightAnchor constraintEqualToAnchor:self.navigationBar.rightAnchor].active = YES;
    [self.navigationBar.topAnchor constraintEqualToAnchor:self.content.bottomAnchor].active = YES;
    [self.navigationBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
  }

  if (@available(iOS 11.0, *)) {
    [self.navigationBar.barItemsBottomAnchor
        constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
        .active = YES;
  }

  if (@available(iOS 9.0, *)) {
    // Content View Constraints
    [self.view.leftAnchor constraintEqualToAnchor:self.content.leftAnchor].active = YES;
    [self.view.rightAnchor constraintEqualToAnchor:self.content.rightAnchor].active = YES;

    [self.view.topAnchor constraintEqualToAnchor:self.content.topAnchor].active = YES;
  }
}

/**
 * Pins the given view to the edges of the content view.
 */
- (void)addConstraintsForContentView:(UIView *)view {
  view.translatesAutoresizingMaskIntoConstraints = NO;
  if (@available(iOS 9.0, *)) {
    [view.leadingAnchor constraintEqualToAnchor:self.content.leadingAnchor].active = YES;
    [view.trailingAnchor constraintEqualToAnchor:self.content.trailingAnchor].active = YES;
    [view.topAnchor constraintEqualToAnchor:self.content.topAnchor].active = YES;
    [view.bottomAnchor constraintEqualToAnchor:self.content.bottomAnchor].active = YES;
  } else {
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:0]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:0]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0]
        .active = YES;
    [NSLayoutConstraint constraintWithItem:self.content
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0]
        .active = YES;
  }
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

/**
 * Returns an exception for when the navigation bar's items are changed from outside of this class.
 */
- (NSException *)unauthorizedItemsChangedException {
  NSString *reason = [NSString
      stringWithFormat:
          @"Attempting to set %@'s navigation bar items.  Please instead use setViewControllers:",
          NSStringFromClass([self class])];
  return [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:reason
                               userInfo:nil];
}

/** Adds the large item dialog to the view hierarchy and animates its presentation. */
- (void)showLargeItemDialog {
  if (self.largeItemDialog.superview) {
    return;
  }

  self.largeItemDialog.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.largeItemDialog];

  UIWindow *window = self.largeItemDialog.window;
  [self.largeItemDialog.heightAnchor constraintEqualToConstant:kLargeItemViewHeight].active = YES;
  [self.largeItemDialog.widthAnchor constraintEqualToConstant:kLargeItemViewWidth].active = YES;
  [self.largeItemDialog.centerXAnchor constraintEqualToAnchor:window.centerXAnchor].active = YES;
  [self.largeItemDialog.centerYAnchor constraintEqualToAnchor:window.centerYAnchor].active = YES;

  self.largeItemDialog.layer.opacity = 0;
  self.largeItemDialog.transform = MDCLargeItemViewAnimationTransitionTransform();
  [UIView animateWithDuration:kLargeItemViewAnimationDuration
                   animations:^{
                     self.largeItemDialog.layer.opacity = 1;
                     self.largeItemDialog.transform = CGAffineTransformIdentity;
                   }];
}

/** Removes the large item dialog from the view hierarchy and animates its dismissal. */
- (void)dismissLargeItemDialog {
  if (!self.largeItemDialog.superview || [self isDismissingLargeItemDialog]) {
    return;
  }

  self.dismissingLargeItemView = YES;
  [UIView animateWithDuration:kLargeItemViewAnimationDuration
      animations:^{
        self.largeItemDialog.layer.opacity = 0;
        self.largeItemDialog.transform = MDCLargeItemViewAnimationTransitionTransform();
      }
      completion:^(BOOL finished) {
        [self.largeItemDialog removeFromSuperview];
        self.dismissingLargeItemView = NO;
      }];
}

/** Returns if the long press gesture recognizer has been added to the navigation bar. */
- (BOOL)isNavigationBarLongPressRecognizerRegistered {
  return
      [self.navigationBar.gestureRecognizers containsObject:self.navigationBarLongPressRecognizer];
}

@end
