// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialFlexibleHeader.h"
#import "MaterialFlexibleHeader+CanAlwaysExpandToMaximumHeight.h"

#import "supplemental/FlexibleHeaderConfiguratorControlItem.h"

typedef enum : NSUInteger {
  FlexibleHeaderConfiguratorFieldCanOverExtend,
  FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent,
  FlexibleHeaderConfiguratorFieldHideStatusBar,

  FlexibleHeaderConfiguratorFieldContentImportance,
  FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled,
  FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar,
  FlexibleHeaderConfiguratorFieldShiftBehaviorHideable,
  FlexibleHeaderConfiguratorFieldShiftOffscreen,
  FlexibleHeaderConfiguratorFieldShiftOnscreen,

  FlexibleHeaderConfiguratorFieldMinimumHeight,
  FlexibleHeaderConfiguratorFieldMaximumHeight,
  FlexibleHeaderConfiguratorFieldMinMaxHeightIncludeSafeArea,
  FlexibleHeaderConfiguratorFieldCanAlwaysExpandToMaximumHeight,
} FlexibleHeaderConfiguratorField;

static const UITableViewStyle kStyle = UITableViewStyleGrouped;

@interface FlexibleHeaderConfiguratorExample
    : UITableViewController <MDCFlexibleHeaderViewLayoutDelegate>

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) MDCFlexibleHeaderViewController *fhvc;
@property(nonatomic, assign) CGFloat minimumHeaderHeight;

// Supplemental properties

@property(nonatomic, copy) NSArray *sections;
@property(nonatomic, copy) NSArray *sectionTitles;

@property(nonatomic, assign) BOOL overrideStatusBarHidden;

@end

@implementation FlexibleHeaderConfiguratorExample

#pragma mark - MDCFlexibleHeaderViewLayoutDelegate

- (void)flexibleHeaderViewController:(MDCFlexibleHeaderViewController *)flexibleHeaderViewController
    flexibleHeaderViewFrameDidChange:(MDCFlexibleHeaderView *)flexibleHeaderView {
  NSLog(@"Scroll phase: %@ percentage: %@ value: %@", @(flexibleHeaderView.scrollPhase),
        @(flexibleHeaderView.scrollPhasePercentage), @(flexibleHeaderView.scrollPhaseValue));
}

// Invoked when the user has changed a control's value.
- (void)field:(FlexibleHeaderConfiguratorField)field didChangeValue:(NSNumber *)value {
  MDCFlexibleHeaderView *headerView = self.fhvc.headerView;
  switch (field) {
      // Basic behavior

    case FlexibleHeaderConfiguratorFieldCanOverExtend:
      headerView.canOverExtend = [value boolValue];
      break;

    case FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent:
      headerView.inFrontOfInfiniteContent = [value boolValue];
      break;

    case FlexibleHeaderConfiguratorFieldHideStatusBar: {
      self.overrideStatusBarHidden = [value boolValue];

      BOOL statusBarCanBeVisible = !self.overrideStatusBarHidden;
      headerView.statusBarHintCanOverlapHeader = statusBarCanBeVisible;

      [UIView animateWithDuration:0.4
                       animations:^{
                         [self setNeedsStatusBarAppearanceUpdate];
                       }];
      break;
    }

      // Shift behavior

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled: {
      BOOL isOn = [value boolValue];
      if (!isOn) {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorDisabled;
        [self
            didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar
                          animated:YES];
      } else {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
        [self didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorHideable
                            animated:YES];
      }
      break;
    }

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar: {
      BOOL isOn = [value boolValue];
      if (!isOn) {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabled;
      } else {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
        [self didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled
                            animated:YES];
        [self didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorHideable
                            animated:YES];
      }
      break;
    }

    case FlexibleHeaderConfiguratorFieldShiftBehaviorHideable: {
      BOOL isOn = [value boolValue];
      if (!isOn) {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorDisabled;
      } else {
        headerView.shiftBehavior = MDCFlexibleHeaderShiftBehaviorHideable;
        [self didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled
                            animated:YES];
        [self
            didChangeValueForField:FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar
                          animated:YES];
      }
      break;
    }

    case FlexibleHeaderConfiguratorFieldContentImportance:
      headerView.headerContentImportance =
          ([value boolValue] ? MDCFlexibleHeaderContentImportanceHigh
                             : MDCFlexibleHeaderContentImportanceDefault);
      break;

    case FlexibleHeaderConfiguratorFieldShiftOffscreen: {
      [headerView shiftHeaderOffScreenAnimated:YES];
      break;
    }

    case FlexibleHeaderConfiguratorFieldShiftOnscreen: {
      [headerView shiftHeaderOnScreenAnimated:YES];
      break;
    }

      // Header height

    case FlexibleHeaderConfiguratorFieldMinimumHeight:
      headerView.minimumHeight = [self heightDenormalized:[value floatValue]];
      break;

    case FlexibleHeaderConfiguratorFieldMaximumHeight:
      headerView.maximumHeight = [self heightDenormalized:[value floatValue]];
      break;

    case FlexibleHeaderConfiguratorFieldMinMaxHeightIncludeSafeArea:
      headerView.minMaxHeightIncludesSafeArea = [value boolValue];
      break;

    case FlexibleHeaderConfiguratorFieldCanAlwaysExpandToMaximumHeight:
      headerView.canAlwaysExpandToMaximumHeight = [value boolValue];
      break;
  }
}

#pragma mark - Typical Flexible Header implementations

// Required for shiftBehavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar.
- (BOOL)prefersStatusBarHidden {
  return _overrideStatusBarHidden || self.fhvc.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
  return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate

// Note that, unlike the Typical Use example, we are explicitly forwarding the UIScrollViewDelegate
// methods to the header view. This is because this example controller also needs to handle other
// UITableViewDelegate events.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.fhvc.headerView.trackingScrollView) {
    [self.fhvc.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  MDCFlexibleHeaderView *headerView = self.fhvc.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  MDCFlexibleHeaderView *headerView = self.fhvc.headerView;
  if (scrollView == headerView.trackingScrollView) {
    [headerView trackingScrollViewWillEndDraggingWithVelocity:velocity
                                          targetContentOffset:targetContentOffset];
  }
}

#pragma mark - Field data manipulation

static const CGFloat kHeightScalar = 300;

- (CGFloat)normalizedHeight:(CGFloat)height {
  return (height - self.minimumHeaderHeight) / (kHeightScalar - self.minimumHeaderHeight);
}

- (CGFloat)heightDenormalized:(CGFloat)normalized {
  return normalized * (kHeightScalar - self.minimumHeaderHeight) + self.minimumHeaderHeight;
}

- (NSNumber *)valueForField:(FlexibleHeaderConfiguratorField)field {
  switch (field) {
    case FlexibleHeaderConfiguratorFieldCanOverExtend:
      return @(self.fhvc.headerView.canOverExtend);

    case FlexibleHeaderConfiguratorFieldContentImportance:
      return @(
          (self.fhvc.headerView.headerContentImportance == MDCFlexibleHeaderContentImportanceHigh));

    case FlexibleHeaderConfiguratorFieldHideStatusBar:
      return @(self.overrideStatusBarHidden);

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled: {
      MDCFlexibleHeaderShiftBehavior behavior = self.fhvc.headerView.shiftBehavior;
      BOOL enabled = (behavior == MDCFlexibleHeaderShiftBehaviorEnabled ||
                      behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar);
      return @(enabled);
    }

    case FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar: {
      MDCFlexibleHeaderShiftBehavior behavior = self.fhvc.headerView.shiftBehavior;
      BOOL enabled = (behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar);
      return @(enabled);
    }

    case FlexibleHeaderConfiguratorFieldShiftBehaviorHideable: {
      MDCFlexibleHeaderShiftBehavior behavior = self.fhvc.headerView.shiftBehavior;
      BOOL enabled = (behavior == MDCFlexibleHeaderShiftBehaviorHideable);
      return @(enabled);
    }

    // Buttons have no value
    case FlexibleHeaderConfiguratorFieldShiftOffscreen:
    case FlexibleHeaderConfiguratorFieldShiftOnscreen:
      return nil;

    case FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent:
      return @(self.fhvc.headerView.inFrontOfInfiniteContent);

    case FlexibleHeaderConfiguratorFieldMinimumHeight:
      return @([self normalizedHeight:self.fhvc.headerView.minimumHeight]);

    case FlexibleHeaderConfiguratorFieldMaximumHeight:
      return @([self normalizedHeight:self.fhvc.headerView.maximumHeight]);

    case FlexibleHeaderConfiguratorFieldMinMaxHeightIncludeSafeArea:
      return @(self.fhvc.headerView.minMaxHeightIncludesSafeArea);

    case FlexibleHeaderConfiguratorFieldCanAlwaysExpandToMaximumHeight:
      return @(self.fhvc.headerView.canAlwaysExpandToMaximumHeight);
  }
}

- (instancetype)init {
  return [self initWithStyle:kStyle];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    self.fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];

    // Behavioral flags.
    self.fhvc.topLayoutGuideAdjustmentEnabled = YES;
    self.fhvc.inferTopSafeAreaInsetFromViewController = YES;
    self.fhvc.headerView.minMaxHeightIncludesSafeArea = NO;

    [self addChildViewController:self.fhvc];

    self.title = @"Configurator";
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.minimumHeaderHeight = 0;

  self.fhvc.headerView.trackingScrollView = self.tableView;
  self.fhvc.layoutDelegate = self;

  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  self.fhvc.headerView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.1 alpha:1];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.text = self.title;
  self.titleLabel.textColor = [UIColor whiteColor];
  self.titleLabel.font = [UIFont systemFontOfSize:22];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  [self.titleLabel sizeToFit];
  CGRect frame = self.fhvc.headerView.bounds;
  self.titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
  self.titleLabel.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [self.fhvc.headerView addSubview:self.titleLabel];

  self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView.topSafeAreaGuide
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0],
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fhvc.headerView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0]
  ]];

  [self.fhvc.headerView hideViewWhenShifted:self.titleLabel];

  id (^buttonItem)(NSString *, FlexibleHeaderConfiguratorField) = ^(
      NSString *title, FlexibleHeaderConfiguratorField field) {
    FlexibleHeaderConfiguratorControlType type = FlexibleHeaderConfiguratorControlTypeButton;
    return [FlexibleHeaderConfiguratorControlItem itemWithTitle:title controlType:type field:field];
  };
  id (^switchItem)(NSString *, FlexibleHeaderConfiguratorField) = ^(
      NSString *title, FlexibleHeaderConfiguratorField field) {
    FlexibleHeaderConfiguratorControlType type = FlexibleHeaderConfiguratorControlTypeSwitch;
    return [FlexibleHeaderConfiguratorControlItem itemWithTitle:title controlType:type field:field];
  };
  id (^sliderItem)(NSString *, FlexibleHeaderConfiguratorField) = ^(
      NSString *title, FlexibleHeaderConfiguratorField field) {
    FlexibleHeaderConfiguratorControlType type = FlexibleHeaderConfiguratorControlTypeSlider;
    return [FlexibleHeaderConfiguratorControlItem itemWithTitle:title controlType:type field:field];
  };
  id (^filler)(void) = ^{
    return [NSNull null];
  };
  NSMutableArray *sections = [NSMutableArray array];
  NSMutableArray *sectionTitles = [NSMutableArray array];
  void (^createSection)(NSString *, NSArray *) = ^(NSString *title, NSArray *items) {
    [sectionTitles addObject:title ?: @""];
    [sections addObject:items ?: @[]];
  };

  createSection(@"Swipe right from left edge to go back", nil);

  createSection(@"Basic behavior", @[
    switchItem(@"Can over-extend", FlexibleHeaderConfiguratorFieldCanOverExtend),
    switchItem(@"In front of infinite content",
               FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent),
    switchItem(@"Hide status bar", FlexibleHeaderConfiguratorFieldHideStatusBar),
  ]);

  createSection(@"Shift behavior", @[
    switchItem(@"Enabled", FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled),
    switchItem(@"Enabled with status bar",
               FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar),
    switchItem(@"Hideable", FlexibleHeaderConfiguratorFieldShiftBehaviorHideable),
    switchItem(@"Header content is important", FlexibleHeaderConfiguratorFieldContentImportance),
    buttonItem(@"Shift header off-screen", FlexibleHeaderConfiguratorFieldShiftOffscreen),
    buttonItem(@"Shift header on-screen", FlexibleHeaderConfiguratorFieldShiftOnscreen)
  ]);

  createSection(@"Header height", @[
    sliderItem(@"Minimum", FlexibleHeaderConfiguratorFieldMinimumHeight),
    sliderItem(@"Maximum", FlexibleHeaderConfiguratorFieldMaximumHeight),
    switchItem(@"Min / max height includes Safe Area",
               FlexibleHeaderConfiguratorFieldMinMaxHeightIncludeSafeArea),
    switchItem(@"Can always expand to maximum height",
               FlexibleHeaderConfiguratorFieldCanAlwaysExpandToMaximumHeight)
  ]);

  NSMutableArray *fillerItems = [NSMutableArray array];
  for (NSUInteger ix = 0; ix < 100; ++ix) {
    [fillerItems addObject:filler()];
  }
  createSection(nil, fillerItems);

  self.sections = sections;
  self.sectionTitles = sectionTitles;

  self.view.backgroundColor = [UIColor whiteColor];
}

- (UIControl *)controlForControlType:(FlexibleHeaderConfiguratorControlType)controlType {
  switch (controlType) {
    case FlexibleHeaderConfiguratorControlTypeButton:
      return nil;

    case FlexibleHeaderConfiguratorControlTypeSwitch:
      return [[UISwitch alloc] init];

    case FlexibleHeaderConfiguratorControlTypeSlider:
      return [[UISlider alloc] init];
  }
}

- (NSNumber *)valueForControl:(UIControl *)control {
  if ([control isKindOfClass:[UISwitch class]]) {
    return @([(UISwitch *)control isOn]);
  } else if ([control isKindOfClass:[UISlider class]]) {
    return @([(UISlider *)control value]);
  }
  return nil;
}

- (void)setValue:(NSNumber *)value onControl:(UIControl *)control animated:(BOOL)animated {
  if ([control isKindOfClass:[UISwitch class]]) {
    [(UISwitch *)control setOn:[value boolValue] animated:animated];
  } else if ([control isKindOfClass:[UISlider class]]) {
    [(UISlider *)control setValue:[value floatValue] animated:animated];
  }
}

- (void)didChangeValueForField:(FlexibleHeaderConfiguratorField)field animated:(BOOL)animated {
  UIControl *control = [self.tableView viewWithTag:field];
  NSNumber *value = [self valueForField:field];
  [self setValue:value onControl:control animated:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [(NSArray *)self.sections[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return self.sectionTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"cell"];
  }
  id item = self.sections[indexPath.section][indexPath.row];
  if ([item isKindOfClass:[FlexibleHeaderConfiguratorControlItem class]]) {
    FlexibleHeaderConfiguratorControlItem *fieldItem =
        (FlexibleHeaderConfiguratorControlItem *)item;

    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];

    cell.textLabel.text = fieldItem.title;

    UIControl *control = [self controlForControlType:fieldItem.controlType];
    control.tag = fieldItem.field;
    [control addTarget:self
                  action:@selector(didChangeControl:)
        forControlEvents:UIControlEventValueChanged];
    [self setValue:[self valueForField:fieldItem.field] onControl:control animated:NO];
    cell.accessoryView = control;

  } else {
    cell.textLabel.text = nil;
    cell.accessoryView = nil;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  id item = self.sections[indexPath.section][indexPath.row];
  if ([item isKindOfClass:[FlexibleHeaderConfiguratorControlItem class]]) {
    FlexibleHeaderConfiguratorControlItem *fieldItem =
        (FlexibleHeaderConfiguratorControlItem *)item;
    if (fieldItem.controlType == FlexibleHeaderConfiguratorControlTypeButton) {
      [self field:(FlexibleHeaderConfiguratorField)fieldItem.field didChangeValue:nil];
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
  }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
  id item = self.sections[indexPath.section][indexPath.row];
  if ([item isKindOfClass:[FlexibleHeaderConfiguratorControlItem class]]) {
    FlexibleHeaderConfiguratorControlItem *fieldItem =
        (FlexibleHeaderConfiguratorControlItem *)item;
    if (fieldItem.controlType == FlexibleHeaderConfiguratorControlTypeButton) {
      return YES;
    }
  }
  return NO;
}

#pragma mark - User actions

- (void)didChangeControl:(UIControl *)sender {
  NSNumber *value = [self valueForControl:sender];
  [self field:(FlexibleHeaderConfiguratorField)sender.tag didChangeValue:value];
}

- (void)didTapBackButton:(id)button {
  [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation FlexibleHeaderConfiguratorExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Flexible Header", @"Configurator" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
