/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFlexibleHeaderViewController.h"

#import "MaterialApplication.h"
#import "MaterialUIMetrics.h"
#import "MDCFlexibleHeaderContainerViewController.h"
#import "MDCFlexibleHeaderView.h"
#import "private/MDCFlexibleHeaderView+Private.h"
#import <MDFTextAccessibility/MDFTextAccessibility.h>

@interface UIView ()
- (UIEdgeInsets)safeAreaInsets; // For pre-iOS 11 SDK targets.
@end

static inline BOOL ShouldUseLightStatusBarOnBackgroundColor(UIColor *color) {
  if (CGColorGetAlpha(color.CGColor) < 1) {
    return NO;
  }

  // We assume that the light iOS status text is white and not big enough to be considered "large"
  // text according to the W3CAG 2.0 spec.
  return [MDFTextAccessibility textColor:[UIColor whiteColor]
                 passesOnBackgroundColor:color
                                 options:MDFTextAccessibilityOptionsNone];
}

static NSString *const MDCFlexibleHeaderViewControllerHeaderViewKey =
    @"MDCFlexibleHeaderViewControllerHeaderViewKey";
static NSString *const MDCFlexibleHeaderViewControllerLayoutDelegateKey =
    @"MDCFlexibleHeaderViewControllerLayoutDelegateKey";

// KVO contexts
static char *const kKVOContextMDCFlexibleHeaderViewController =
    "kKVOContextMDCFlexibleHeaderViewController";

@interface MDCFlexibleHeaderViewController () <MDCFlexibleHeaderViewDelegate>

/*
 This is the target top layout guide that we will modify such that it includes the flexible header's
 height and any top safe area insets we were able to infer.

 We hold a strong reference to it because on pre-iOS 11 devices UIKit will attempt to reset the
 top layout guide. We observe (using KVO) any changes made to the constraint and reset the
 constraint's length when a modification outside of our awareness occurs.
*/
@property(nonatomic, strong) NSLayoutConstraint *topLayoutGuideConstraint;

/*
 For avoiding re-entrant recursion while modifying the top layout guide.
 */
@property(nonatomic) BOOL isUpdatingTopLayoutGuide;

/*
 On pre-iOS 11 devices, we use this layout constraint to extract the top safe area inset from the
 root ancestor view controller.
 */
@property(nonatomic, strong) NSLayoutConstraint *topSafeAreaConstraint;

@end

@implementation MDCFlexibleHeaderViewController

@synthesize preferredStatusBarStyle = _preferredStatusBarStyle;

- (void)dealloc {
  // Clear KVO observers
  self.topLayoutGuideConstraint = nil;
  self.topSafeAreaConstraint = nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonMDCFlexibleHeaderViewControllerInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    if ([aDecoder containsValueForKey:MDCFlexibleHeaderViewControllerHeaderViewKey]) {
      _headerView = [aDecoder decodeObjectOfClass:[MDCFlexibleHeaderView class]
                                           forKey:MDCFlexibleHeaderViewControllerHeaderViewKey];
    }

    if ([aDecoder containsValueForKey:MDCFlexibleHeaderViewControllerLayoutDelegateKey]) {
      _layoutDelegate =
          [aDecoder decodeObjectForKey:MDCFlexibleHeaderViewControllerLayoutDelegateKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.headerView forKey:MDCFlexibleHeaderViewControllerHeaderViewKey];
  if (_layoutDelegate) {
    [aCoder encodeConditionalObject:self.layoutDelegate
                             forKey:MDCFlexibleHeaderViewControllerLayoutDelegateKey];
  }
}

- (void)commonMDCFlexibleHeaderViewControllerInit {
  _inferPreferredStatusBarStyle = YES;

  MDCFlexibleHeaderView *headerView =
      [[MDCFlexibleHeaderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  headerView.delegate = self;
  _headerView = headerView;
}

- (void)loadView {
  self.view = self.headerView;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
  [super willMoveToParentViewController:parent];

  BOOL shouldDisableAutomaticInsetting = YES;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  // Prior to iOS 11 there was no way to know whether UIKit had injected insets into our
  // UIScrollView, so we disable automatic insetting on these devices. iOS 11 provides
  // the adjustedContentInset API which allows us to respond to changes in the safe area
  // insets, so on iOS 11 we actually expect iOS to manage the safe area insets.
  if (@available(iOS 11.0, *)) {
    shouldDisableAutomaticInsetting = NO;
  }
#endif
  if (shouldDisableAutomaticInsetting) {
    parent.automaticallyAdjustsScrollViewInsets = NO;
  }
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];

  // The header depends on the tracking scroll view to know how tall it should be.
  // If there is no tracking scroll view then we have to poke the header into sizing itself.
  if (!_headerView.trackingScrollView) {
    [_headerView sizeToFit];
  } else if (!_headerView.observesTrackingScrollViewScrollEvents) {
    [_headerView trackingScrollViewDidScroll];
  }

  if (self.topLayoutGuideAdjustmentEnabled) {
    [self updateTopLayoutGuide];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // Querying the top layout guide ensures that the flexible header receives layout event when
  // the status bar visibility changes. This allows the flexible header to animate alongside any
  // status bar visibility changes.
  [self.parentViewController topLayoutGuide];

  [self updateTopLayoutGuide];

#if DEBUG
  NSAssert(![self.parentViewController.parentViewController
               isKindOfClass:[MDCFlexibleHeaderContainerViewController class]],
           @"An instance of %@ has been injected into a view controller (%@) that is already"
           @" wrapped by an instance of %@ - this is not allowed and will cause double headers to"
           @" appear. Choose to either wrap or inject your view controller (preferring injection"
           @" where possible).",
           NSStringFromClass([self class]), NSStringFromClass([self.parentViewController class]),
           NSStringFromClass([MDCFlexibleHeaderContainerViewController class]));
#endif
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  if (self.inferPreferredStatusBarStyle) {
    UIColor *backgroundColor =
        [MDCFlexibleHeaderView appearance].backgroundColor ?: _headerView.backgroundColor;
    return (ShouldUseLightStatusBarOnBackgroundColor(backgroundColor)
                ? UIStatusBarStyleLightContent
                : UIStatusBarStyleDefault);
  } else {
    return _preferredStatusBarStyle;
  }
}

- (void)setPreferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle {
  NSAssert(!self.inferPreferredStatusBarStyle,
           @"You must disable inferPreferredStatusBarStyle prior to setting a status bar style.");

  _preferredStatusBarStyle = preferredStatusBarStyle;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [_headerView viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  if (self.topLayoutGuideAdjustmentEnabled) {
    [self updateTopLayoutGuide];
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == _headerView.trackingScrollView) {
    [_headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                           targetContentOffset:targetContentOffset];
  }
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (context == kKVOContextMDCFlexibleHeaderViewController) {
    void (^mainThreadWork)(void) = ^{
      if (object == self->_topLayoutGuideConstraint
          && self.topLayoutGuideAdjustmentEnabled) {
        [self updateTopLayoutGuide];
      }
    };

    // Ensure that UIKit modifications occur on the main thread.
    if ([NSThread isMainThread]) {
      mainThreadWork();
    } else {
      [[NSOperationQueue mainQueue] addOperationWithBlock:mainThreadWork];
    }

  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark - Top layout guide support

/*
 When the flexible header's height changes, we want to adjust the topLayoutGuide length of the
 content view controller so that its content can adjust accordingly. This is the same behavior that
 UIKit container view controllers provide.

 Unfortunately, topLayoutGuide is a read-only property on UIViewController with no way to
 override it, and no public setter for the length.

 The only known way to modify this property programmatically is to access the view controller's
 view constraints and extract the first constraint that contains the top layout guide (and only
 the top layout guide). Modifying the "constant" property of this constraint has the
 undocumented side effect of also updating the topLayoutGuide's length.
 This approach is discussed here:
 https://stackoverflow.com/questions/19588171/how-to-set-toplayoutguide-position-for-child-view-controller

 Also see this open radar feature request for a mutable top layout guide:
 http://www.openradar.me/19984939
 */
- (void)fhv_extractTopLayoutGuideConstraint {
  UIViewController *topLayoutGuideViewController =
      [self fhv_topLayoutGuideViewControllerWithFallback];
  if (!topLayoutGuideViewController.isViewLoaded) {
    self.topLayoutGuideConstraint = nil;
    return;
  }
  if (self.topLayoutGuideAdjustmentEnabled
      || [topLayoutGuideViewController.view.constraints count] > 0) {
    self.topLayoutGuideConstraint =
        [self fhv_topLayoutGuideConstraintForViewController:topLayoutGuideViewController];
  }
}

- (NSLayoutConstraint *)
      fhv_topLayoutGuideConstraintForViewController:(UIViewController *)viewController {
  // Note: accessing topLayoutGuide has the side effect of setting up all of the view controller
  // constraints. We need to access this property before we enter the for loop, otherwise
  // view.constraints will be empty.
  id<UILayoutSupport> topLayoutGuide = viewController.topLayoutGuide;
  NSLayoutConstraint *foundConstraint = nil;
  for (NSLayoutConstraint *constraint in viewController.view.constraints) {
    if (constraint.firstItem == topLayoutGuide && constraint.secondItem == nil) {
      foundConstraint = constraint;
    }
  }
  return foundConstraint;
}

- (void)setTopLayoutGuideConstraint:(NSLayoutConstraint *)topLayoutGuideConstraint {
  if (_topLayoutGuideConstraint == topLayoutGuideConstraint) {
    return;
  }

  /*
   On pre-iOS 11 devices, the top layout guide's constant gets set by UIKit multiple times on
   call stacks that we have no influence over, meaning it's easy for our custom top layout guide
   value to be lost (being reset to UIKit's default of "20" usually). We want to have final say on
   the value though, so we KVO the property and re-apply our calculated top layout guide any time
   the top layout guide is modified.

   We only do this on pre-iOS 11 devices because iOS 11 and above are less aggressive about setting
   the top layout guide constant (and clients should be relying on additionalSafeAreaInsets anyway).
   */
  BOOL shouldObserveLayoutGuideConstant = YES;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    shouldObserveLayoutGuideConstant = NO;
  }
#endif

  if (shouldObserveLayoutGuideConstant) {
    [_topLayoutGuideConstraint removeObserver:self
                                   forKeyPath:NSStringFromSelector(@selector(constant))
                                      context:kKVOContextMDCFlexibleHeaderViewController];
  }

  _topLayoutGuideConstraint = topLayoutGuideConstraint;

  if (shouldObserveLayoutGuideConstant) {
    [_topLayoutGuideConstraint addObserver:self
                                forKeyPath:NSStringFromSelector(@selector(constant))
                                   options:NSKeyValueObservingOptionNew
                                   context:kKVOContextMDCFlexibleHeaderViewController];
  }
}

- (void)setTopSafeAreaConstraint:(NSLayoutConstraint *)topSafeAreaConstraint {
  if (_topSafeAreaConstraint == topSafeAreaConstraint) {
    return;
  }

  [_topSafeAreaConstraint removeObserver:self
                              forKeyPath:NSStringFromSelector(@selector(constant))
                                 context:kKVOContextMDCFlexibleHeaderViewController];

  _topSafeAreaConstraint = topSafeAreaConstraint;

  [_topSafeAreaConstraint addObserver:self
                           forKeyPath:NSStringFromSelector(@selector(constant))
                              options:NSKeyValueObservingOptionNew
                              context:kKVOContextMDCFlexibleHeaderViewController];
}

- (UIViewController *)fhv_topLayoutGuideViewControllerWithFallback {
  UIViewController *topLayoutGuideViewController = self.topLayoutGuideViewController;
  if (!topLayoutGuideViewController && !self.topLayoutGuideAdjustmentEnabled) {
    topLayoutGuideViewController = self.parentViewController;
  }
  return topLayoutGuideViewController;
}

- (void)fhv_setTopLayoutGuideConstraintConstant:(CGFloat)constant {
  self.isUpdatingTopLayoutGuide = YES;
  self.topLayoutGuideConstraint.constant = constant;
  self.isUpdatingTopLayoutGuide = NO;
}

- (void)updateTopLayoutGuide {
  NSAssert([NSThread isMainThread],
           @"updateTopLayoutGuide must be called from the main thread.");
  // We observe (using KVO) the top layout guide's constant and re-invoke updateTopLayoutGuide
  // whenever it changes. We also change the constant in this method. So, to avoid a recursive
  // infinite loop we bail out early here if we're the ones that initiated the top layout guide
  // constant change.
  if (self.isUpdatingTopLayoutGuide) {
    return;
  }

  if (![self isViewLoaded]) {
    return;
  }
  if (!self.topLayoutGuideConstraint) {
    [self fhv_extractTopLayoutGuideConstraint];
  }
  CGFloat topInset = CGRectGetMaxY(_headerView.frame);
  // Avoid excessive re-calculations.
  if (self.topLayoutGuideConstraint.constant != topInset) {
    [self fhv_setTopLayoutGuideConstraintConstant:topInset];
  }

#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    UIViewController *topLayoutGuideViewController = [self fhv_topLayoutGuideViewControllerWithFallback];
    // If there is a tracking scroll view then the flexible header will manage safe area insets via
    // the tracking scroll view's contentInsets. Some day - in the long distant future when we only
    // support iOS 11 and up - we can probably drop the content inset adjustment behavior in favor
    // of modifying additionalSafeAreaInsets instead.
    if (self.headerView.trackingScrollView != nil) {
      // Reset the additional safe area insets if we are now tracking a scroll view.
      if (topLayoutGuideViewController != nil) {
        UIEdgeInsets additionalSafeAreaInsets =
            topLayoutGuideViewController.additionalSafeAreaInsets;
        additionalSafeAreaInsets.top = 0;
        topLayoutGuideViewController.additionalSafeAreaInsets = additionalSafeAreaInsets;
      }

    } else if (topLayoutGuideViewController != nil) {
      UIEdgeInsets additionalSafeAreaInsets = topLayoutGuideViewController.additionalSafeAreaInsets;
      // We need to avoid double-counting any top safe area amount because this will already be
      // taken into account as part of additionalSafeAreaInsets.
      topInset -= self.headerView.topSafeAreaGuideHeight;
      if (self.headerView.minMaxHeightIncludesSafeArea) {
        topInset = MIN(self.headerView.maximumHeight - MDCDeviceTopSafeAreaInset(), topInset);
      } else {
        topInset = MIN(self.headerView.maximumHeight, topInset);
      }
      additionalSafeAreaInsets.top = topInset;
      topLayoutGuideViewController.additionalSafeAreaInsets = additionalSafeAreaInsets;
    }
  }
#endif
}

- (void)setTopLayoutGuideViewController:(UIViewController *)topLayoutGuideViewController {
  if (topLayoutGuideViewController == _topLayoutGuideViewController) {
    return;
  }
  _topLayoutGuideViewController = topLayoutGuideViewController;
  _topLayoutGuideAdjustmentEnabled = YES;

  if ([self isViewLoaded]) {
    [self fhv_extractTopLayoutGuideConstraint];
    [self updateTopLayoutGuide];
  }
}

#pragma mark - Top safe area inset extraction

- (BOOL)fhv_isViewControllerDescendantOfTopLayoutGuideViewController:(UIViewController *)child {
  // No need to walk the ancestry.
  if (self.topLayoutGuideViewController == nil) {
    return NO;
  }

  UIViewController *ancestorIterator = child;
  while (ancestorIterator != nil) {
    if (ancestorIterator == self.topLayoutGuideViewController) {
      return YES;
    }
    ancestorIterator = ancestorIterator.parentViewController;
  }
  return NO;
}

- (UIViewController *)fhv_rootAncestorOfViewController:(UIViewController *)viewController {
  while (viewController.parentViewController != nil) {
    viewController = viewController.parentViewController;
  }
  return viewController;
}

#pragma mark MDCFlexibleHeaderViewDelegate

- (void)flexibleHeaderViewNeedsStatusBarAppearanceUpdate:
    (__unused MDCFlexibleHeaderView *)headerView {
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)flexibleHeaderViewFrameDidChange:(MDCFlexibleHeaderView *)headerView {
  [self updateTopLayoutGuide];

  [self.layoutDelegate flexibleHeaderViewController:self
                   flexibleHeaderViewFrameDidChange:headerView];
}

@end
