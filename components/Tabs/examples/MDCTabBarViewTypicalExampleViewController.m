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

#import "MDCActionSheetAction.h"
#import "MDCActionSheetController.h"
#import "MDCActionSheetController+MaterialTheming.h"
#import "UIView+MDCTimingFunction.h"
#import "MDCButton.h"
#import "MDCButton+MaterialTheming.h"
#import "MDCTabBarItem.h"
#import "MDCTabBarView.h"
#import "MDCTabBarViewCustomViewable.h"
#import "MDCTabBarViewDelegate.h"
#import "MaterialIcons+ic_check.h"  // PrivateSubtargetImport
#import "MaterialIcons+ic_settings.h"  // PrivateSubtargetImport
#import "MDCMath.h"
#import "MDCSemanticColorScheme.h"
#import "MDCContainerScheme.h"
#import "MDCTypographyScheming.h"

static NSString *const kExampleTitle = @"TabBarView";

/** Accessibility label for the content insets toggle button. */
static NSString *const kToggleContentInsetsAccessibilityLabel = @"Toggle content insets";

/** Accessibility label for the preferred layout menu button. */
static NSString *const kPreferredLayoutMenuAccessibilityLabel = @"Change preferred alignment";

/** A custom view to place in an MDCTabBarView. */
@interface MDCTabBarViewTypicalExampleViewControllerCustomView
    : UIView <MDCTabBarViewCustomViewable>
/** A switch shown in the view. */
@property(nonatomic, strong) UISwitch *aSwitch;
/** Duration for animating changes to the tab bar view. */
@property(nonatomic, assign) CFTimeInterval animationDuration;
/** The timing function for animating changes to the tab bar view. */
@property(nonatomic, strong) CAMediaTimingFunction *animationTimingFunction;
@end

@implementation MDCTabBarViewTypicalExampleViewControllerCustomView

- (instancetype)init {
  self = [super init];
  if (self) {
    _aSwitch = [[UISwitch alloc] init];
    _animationTimingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  }
  return self;
}

- (CGRect)contentFrame {
  return CGRectStandardize(self.aSwitch.frame);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  // This is where a real custom view would handle its selection state change.
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (self.aSwitch.superview != self) {
    [self addSubview:_aSwitch];
    [self.aSwitch addTarget:self
                     action:@selector(switchTapped:)
           forControlEvents:UIControlEventValueChanged];
  }
  self.aSwitch.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)switchTapped:(id)sender {
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
  [UIView mdc_animateWithTimingFunction:self.animationTimingFunction
                               duration:self.animationDuration
                                  delay:0
                                options:0
                             animations:^{
                               [self.superview setNeedsLayout];
                               [self.superview layoutIfNeeded];
                             }
                             completion:nil];
}

- (CGSize)intrinsicContentSize {
  if (self.aSwitch.isOn) {
    return CGSizeMake(self.aSwitch.intrinsicContentSize.width * 2,
                      self.aSwitch.intrinsicContentSize.height * 2);
  }
  return self.aSwitch.intrinsicContentSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self.aSwitch sizeThatFits:size];
}

@end

/**
 Typical use example showing how to place an @c MDCTabBarView within another view.
 */
@interface MDCTabBarViewTypicalExampleViewController
    : UIViewController <MDCTabBarViewDelegate, UIScrollViewDelegate>

/** The tab bar for this example. */
@property(nonatomic, strong) MDCTabBarView *tabBar;

/** The container scheme injected into this example. */
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

/** Titles for the items. */
@property(nonatomic, copy) NSArray<NSString *> *tabBarItemTitles;

/** Images for the items. */
@property(nonatomic, copy) NSArray<UIImage *> *tabBarItemIcons;

/** Tracks the UITabBarItem views that are currently on-screen. */
@property(nonatomic, copy) NSSet<UITabBarItem *> *visibleItems;

/** Image for toggle button when contentInset is non-zero. */
@property(nonatomic, strong) UIImage *contentInsetToggleEnabledImage;

/** Image for toggle button when contentInset is zero. */
@property(nonatomic, strong) UIImage *contentInsetToggleDisabledImage;

/** Tapping this button goes to the next tab. */
@property(nonatomic, strong) MDCButton *forwardButton;

/** Tapping this button goes to the previous tab. */
@property(nonatomic, strong) MDCButton *backwardButton;

/** Segmented control. */
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation MDCTabBarViewTypicalExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = kExampleTitle;
  NSBundle *selfBundle = [NSBundle bundleForClass:[self class]];
  self.contentInsetToggleEnabledImage = [[UIImage imageNamed:@"contentInset_enabled"
                                                    inBundle:selfBundle
                               compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.contentInsetToggleDisabledImage = [[UIImage imageNamed:@"contentInset_disabled"
                                                     inBundle:selfBundle
                                compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  [self applyFixForInjectedAppBar];

  if (!self.containerScheme) {
    self.containerScheme = [[MDCContainerScheme alloc] init];
  }

  self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  self.tabBar = [[MDCTabBarView alloc] init];
  self.tabBar.tabBarDelegate = self;
  self.tabBar.delegate = self;
  [self.view addSubview:self.tabBar];

  NSMutableArray<UIImage *> *itemIcons = [NSMutableArray array];
  [itemIcons addObject:[[UIImage imageNamed:@"system_icons/home"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
  [itemIcons addObject:[[UIImage imageNamed:@"system_icons/favorite"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
  [itemIcons addObject:[[UIImage imageNamed:@"system_icons/cake"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
  [itemIcons addObject:[[UIImage imageNamed:@"system_icons/email"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
  [itemIcons addObject:[[UIImage imageNamed:@"system_icons/search"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
  self.tabBarItemIcons = itemIcons;
  self.tabBarItemTitles = @[ @"Home", @"Unselectable", @"Cake", @"Email", @"Search" ];

  UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:self.tabBarItemTitles[0]
                                                      image:itemIcons[0]
                                                        tag:0];
  UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:self.tabBarItemTitles[1]
                                                      image:itemIcons[1]
                                                        tag:1];
  item2.accessibilityTraits = UIAccessibilityTraitStaticText;
  UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:self.tabBarItemTitles[2]
                                                      image:itemIcons[2]
                                                        tag:2];
  UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:self.tabBarItemTitles[3]
                                                      image:itemIcons[3]
                                                        tag:3];
  UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:self.tabBarItemTitles[4]
                                                      image:itemIcons[4]
                                                        tag:4];
  MDCTabBarItem *item6 = [[MDCTabBarItem alloc] initWithTitle:@"A switch" image:nil tag:5];
  MDCTabBarViewTypicalExampleViewControllerCustomView *switchView =
      [[MDCTabBarViewTypicalExampleViewControllerCustomView alloc] init];
  item6.mdc_customView = switchView;
  switchView.aSwitch.onTintColor = self.containerScheme.colorScheme.primaryColor;
  switchView.animationDuration = self.tabBar.selectionChangeAnimationDuration;
  switchView.animationTimingFunction = self.tabBar.selectionChangeAnimationTimingFunction;

  self.tabBar.items = @[ item1, item2, item6, item4, item5, item3 ];
  self.tabBar.selectedItem = item4;

  self.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view.layoutMarginsGuide.topAnchor constraintEqualToAnchor:self.tabBar.topAnchor].active =
      YES;
  [self.view.leftAnchor constraintEqualToAnchor:self.tabBar.leftAnchor].active = YES;
  [self.view.rightAnchor constraintEqualToAnchor:self.tabBar.rightAnchor].active = YES;

  [self applyThemingToTabBarView];
  [self addSegmentedControl];
  [self addButtons];

  UIBarButtonItem *alignmentButton = [[UIBarButtonItem alloc]
      initWithImage:[MDCIcons.imageFor_ic_settings
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(didTapAlignmentButton)];
  alignmentButton.accessibilityLabel = kPreferredLayoutMenuAccessibilityLabel;

  UIBarButtonItem *insetsButton =
      [[UIBarButtonItem alloc] initWithImage:self.contentInsetToggleDisabledImage
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didToggleInsets:)];
  insetsButton.accessibilityLabel = kToggleContentInsetsAccessibilityLabel;

  self.navigationItem.rightBarButtonItems = @[ alignmentButton, insetsButton ];
}

- (void)applyThemingToTabBarView {
  self.tabBar.barTintColor = self.containerScheme.colorScheme.surfaceColor;
  [self.tabBar setTitleColor:[self.containerScheme.colorScheme.onSurfaceColor
                                 colorWithAlphaComponent:(CGFloat)0.6]
                    forState:UIControlStateNormal];
  [self.tabBar setTitleColor:self.containerScheme.colorScheme.primaryColor
                    forState:UIControlStateSelected];
  [self.tabBar setImageTintColor:[self.containerScheme.colorScheme.onSurfaceColor
                                     colorWithAlphaComponent:(CGFloat)0.6]
                        forState:UIControlStateNormal];
  [self.tabBar setImageTintColor:self.containerScheme.colorScheme.primaryColor
                        forState:UIControlStateSelected];
  [self.tabBar setTitleFont:self.containerScheme.typographyScheme.button
                   forState:UIControlStateNormal];
  [self.tabBar setTitleFont:[UIFont systemFontOfSize:16] forState:UIControlStateSelected];
  self.tabBar.selectionIndicatorStrokeColor = self.containerScheme.colorScheme.primaryColor;
  self.tabBar.rippleColor =
      [self.containerScheme.colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.1];
  self.tabBar.bottomDividerColor =
      [self.containerScheme.colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.12];
}

- (void)addButtons {
  self.forwardButton = [[MDCButton alloc] init];
  [self.forwardButton setTitle:@"Next tab" forState:UIControlStateNormal];
  [self.forwardButton addTarget:self
                         action:@selector(forwardButtonTapped:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.forwardButton applyTextThemeWithScheme:self.containerScheme];
  [self.forwardButton sizeToFit];
  [self.view addSubview:self.forwardButton];

  self.backwardButton = [[MDCButton alloc] init];
  [self.backwardButton setTitle:@"Previous tab" forState:UIControlStateNormal];
  [self.backwardButton addTarget:self
                          action:@selector(backwardButtonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
  [self.backwardButton applyTextThemeWithScheme:self.containerScheme];
  [self.backwardButton sizeToFit];
  [self.view addSubview:self.backwardButton];
}

- (void)backwardButtonTapped:(id)sender {
  NSInteger index = [self.tabBar.items indexOfObject:self.tabBar.selectedItem];
  if (index == NSNotFound) {
    return;
  }
  index--;
  if (index < 0) {
    return;
  }
  self.tabBar.selectedItem = self.tabBar.items[index];
}

- (void)forwardButtonTapped:(id)sender {
  NSInteger index = [self.tabBar.items indexOfObject:self.tabBar.selectedItem];
  if (index == NSNotFound) {
    return;
  }
  index++;
  if (index >= (NSInteger)self.tabBar.items.count) {
    return;
  }
  self.tabBar.selectedItem = self.tabBar.items[index];
}

- (void)addSegmentedControl {
  self.segmentedControl =
      [[UISegmentedControl alloc] initWithItems:@[ @"Titles", @"Icons", @"Titles and Icons" ]];
  self.segmentedControl.selectedSegmentIndex = 2;
  [self.segmentedControl addTarget:self
                            action:@selector(segmentedControlChangedValue:)
                  forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.segmentedControl];
  self.segmentedControl.tintColor = self.containerScheme.colorScheme.primaryColor;
  self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view.layoutMarginsGuide.centerXAnchor
      constraintEqualToAnchor:self.segmentedControl.centerXAnchor]
      .active = YES;
  [self.view.layoutMarginsGuide.centerYAnchor
      constraintEqualToAnchor:self.segmentedControl.centerYAnchor]
      .active = YES;
  [self.view.layoutMarginsGuide.leadingAnchor
      constraintLessThanOrEqualToAnchor:self.segmentedControl.leadingAnchor]
      .active = YES;
  [self.view.layoutMarginsGuide.trailingAnchor
      constraintGreaterThanOrEqualToAnchor:self.segmentedControl.trailingAnchor]
      .active = YES;
}

#pragma mark - MDCTabBarViewDelegate

- (BOOL)tabBarView:(MDCTabBarView *)tabBarView shouldSelectItem:(nonnull UITabBarItem *)item {
  // Just to demonstrate preventing selection of an item.
  return [self.tabBar.items indexOfObject:item] != 1;
}

- (void)tabBarView:(MDCTabBarView *)tabBarView didSelectItem:(nonnull UITabBarItem *)item {
  NSLog(@"Item (%@) was selected.", item.title);
}

#pragma mark - Errata

- (void)applyFixForInjectedAppBar {
  // The injected AppBar has a bug where it will attempt to manipulate the Tab bar. To prevent
  // that bug, we need to inject a scroll view into the view hierarchy before the tab bar. The App
  // Bar will manipulate with that one instead.
  UIScrollView *bugFixScrollView = [[UIScrollView alloc] init];
  bugFixScrollView.userInteractionEnabled = NO;
  bugFixScrollView.hidden = YES;
  [self.view addSubview:bugFixScrollView];
}

#pragma mark - Item style variations

- (void)didTapAlignmentButton {
  MDCTabBarViewLayoutStyle currentStyle = self.tabBar.preferredLayoutStyle;
  UIImage *checkIcon =
      [MDCIcons.imageFor_ic_check imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  MDCActionSheetController *actionSheet =
      [MDCActionSheetController actionSheetControllerWithTitle:@"Preferred Layout Style"];
  MDCActionSheetAction *fixedJustifiedAction = [MDCActionSheetAction
      actionWithTitle:@"Fixed"
                image:((currentStyle == MDCTabBarViewLayoutStyleFixed) ? checkIcon : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixed;
              }];
  MDCActionSheetAction *fixedClusteredLeadingAction = [MDCActionSheetAction
      actionWithTitle:@"Fixed Clustered Leading"
                image:((currentStyle == MDCTabBarViewLayoutStyleFixedClusteredLeading) ? checkIcon
                                                                                       : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredLeading;
              }];
  MDCActionSheetAction *fixedClusteredTrailingAction = [MDCActionSheetAction
      actionWithTitle:@"Fixed Clustered Trailing"
                image:((currentStyle == MDCTabBarViewLayoutStyleFixedClusteredTrailing) ? checkIcon
                                                                                        : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredTrailing;
              }];
  MDCActionSheetAction *fixedClusteredCenteredAction = [MDCActionSheetAction
      actionWithTitle:@"Fixed Clustered Centered"
                image:((currentStyle == MDCTabBarViewLayoutStyleFixedClusteredCentered) ? checkIcon
                                                                                        : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle = MDCTabBarViewLayoutStyleFixedClusteredCentered;
              }];
  MDCActionSheetAction *scrollableAction = [MDCActionSheetAction
      actionWithTitle:@"Scrollable"
                image:((currentStyle == MDCTabBarViewLayoutStyleScrollable) ? checkIcon : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollable;
              }];
  MDCActionSheetAction *scrollableCenteredAction = [MDCActionSheetAction
      actionWithTitle:@"Scrollable Centered"
                image:((currentStyle == MDCTabBarViewLayoutStyleScrollableCentered) ? checkIcon
                                                                                    : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle = MDCTabBarViewLayoutStyleScrollableCentered;
              }];
  MDCActionSheetAction *nonFixedClusteredCenteredAction = [MDCActionSheetAction
      actionWithTitle:@"Non-Fixed Clustered Centered"
                image:((currentStyle == MDCTabBarViewLayoutStyleNonFixedClusteredCentered)
                           ? checkIcon
                           : nil)
              handler:^(MDCActionSheetAction *_Nonnull action) {
                self.tabBar.preferredLayoutStyle =
                    MDCTabBarViewLayoutStyleNonFixedClusteredCentered;
              }];
  [actionSheet addAction:fixedJustifiedAction];
  [actionSheet addAction:fixedClusteredLeadingAction];
  [actionSheet addAction:fixedClusteredTrailingAction];
  [actionSheet addAction:fixedClusteredCenteredAction];
  [actionSheet addAction:scrollableAction];
  [actionSheet addAction:scrollableCenteredAction];
  [actionSheet addAction:nonFixedClusteredCenteredAction];
  [actionSheet applyThemeWithScheme:self.containerScheme];
  actionSheet.alwaysAlignTitleLeadingEdges = YES;
  [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)didToggleInsets:(UIBarButtonItem *)sender {
  if (UIEdgeInsetsEqualToEdgeInsets(self.tabBar.contentInset, UIEdgeInsetsZero)) {
    self.tabBar.contentInset = UIEdgeInsetsMake(0, 10, 0, 30);
    sender.image = self.contentInsetToggleEnabledImage;
  } else {
    self.tabBar.contentInset = UIEdgeInsetsZero;
    sender.image = self.contentInsetToggleDisabledImage;
  }
}

- (void)segmentedControlChangedValue:(id)sender {
  if ([sender isKindOfClass:[UISegmentedControl class]]) {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    if (segmentedControl.selectedSegmentIndex == 0) {
      [self changeItemsToTextOnly];
    } else if (segmentedControl.selectedSegmentIndex == 1) {
      [self changeItemsToImageOnly];
    } else {
      [self changeItemsToTextAndImage];
    }
  }
}

- (void)changeItemsToTextOnly {
  NSMutableArray<UITabBarItem *> *newItems = [NSMutableArray array];
  NSUInteger selectedIndex = self.tabBar.selectedItem
                                 ? [self.tabBar.items indexOfObject:self.tabBar.selectedItem]
                                 : NSNotFound;
  for (NSUInteger index = 0; index < self.tabBar.items.count; ++index) {
    UITabBarItem *originalItem = self.tabBar.items[index];
    if ([originalItem isKindOfClass:[MDCTabBarItem class]]) {
      MDCTabBarItem *originalCustomItem = (MDCTabBarItem *)originalItem;
      MDCTabBarItem *newCustomItem = [[MDCTabBarItem alloc] initWithTitle:nil
                                                                    image:nil
                                                                      tag:originalItem.tag];
      newCustomItem.mdc_customView = originalCustomItem.mdc_customView;
      [newItems addObject:newCustomItem];
      continue;
    }
    UITabBarItem *newItem = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:originalItem.tag];
    newItem.title = self.tabBarItemTitles[index % self.tabBarItemTitles.count];
    [newItems addObject:newItem];
  }
  self.tabBar.items = newItems;
  if (selectedIndex != NSNotFound) {
    self.tabBar.selectedItem = self.tabBar.items[selectedIndex];
  }
}

- (void)changeItemsToImageOnly {
  for (NSUInteger index = 0; index < self.tabBar.items.count; ++index) {
    UITabBarItem *item = self.tabBar.items[index];
    item.image = self.tabBarItemIcons[index % self.tabBarItemIcons.count];
    item.title = nil;
  }
}

- (void)changeItemsToTextAndImage {
  for (NSUInteger index = 0; index < self.tabBar.items.count; ++index) {
    UITabBarItem *item = self.tabBar.items[index];
    item.image = self.tabBarItemIcons[index % self.tabBarItemIcons.count];
    item.title = self.tabBarItemTitles[index % self.tabBarItemTitles.count];
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self logItemVisibilityChanges];
}

#pragma mark - UIViewController

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [coordinator
      animateAlongsideTransition:nil
                      completion:^(
                          id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
                        [self logItemVisibilityChanges];
                      }];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self logItemVisibilityChanges];

  CGFloat centerX = self.segmentedControl.center.x;
  CGFloat centerY = CGRectGetMaxY(self.segmentedControl.frame) + 50;
  self.forwardButton.center = CGPointMake(centerX, centerY);
  centerY = centerY + 50;
  self.backwardButton.center = CGPointMake(centerX, centerY);
}

- (void)logItemVisibilityChanges {
  NSMutableSet<UITabBarItem *> *allVisibleItems = [NSMutableSet set];
  NSMutableSet<UITabBarItem *> *itemsThatEnteredTheWindowBounds = [NSMutableSet set];
  NSMutableSet<UITabBarItem *> *itemsThatLeftTheWindowBounds = [NSMutableSet set];
  for (UITabBarItem *item in self.tabBar.items) {
    CGRect itemViewInWindow = [self.tabBar rectForItem:item inCoordinateSpace:self.view.window];
    CGRect overlapRect = CGRectIntersection(self.view.window.bounds, itemViewInWindow);

    // Views that don't intersect (or only at the very edge) the window's bounds
    if (CGRectIsNull(overlapRect) || MDCCGFloatEqual(CGRectGetWidth(itemViewInWindow), 0)) {
      if ([self.visibleItems containsObject:item]) {
        [itemsThatLeftTheWindowBounds addObject:item];
      }
      continue;
    }
    [allVisibleItems addObject:item];
    if (![self.visibleItems containsObject:item]) {
      [itemsThatEnteredTheWindowBounds addObject:item];
    }
  }

  self.visibleItems = allVisibleItems;

  if (itemsThatEnteredTheWindowBounds.count) {
    for (UITabBarItem *item in itemsThatEnteredTheWindowBounds) {
      NSLog(@"(%@) became visible.", item.title ?: @(item.tag));
    }
  }
  if (itemsThatLeftTheWindowBounds.count) {
    for (UITabBarItem *item in itemsThatLeftTheWindowBounds) {
      NSLog(@"(%@) is no longer visible.", item.title ?: @(item.tag));
    }
  }
}

@end

#pragma mark - CatalogByConvention

@implementation MDCTabBarViewTypicalExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Tab Bar", kExampleTitle ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
