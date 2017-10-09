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

#import "MDCBottomNavigationView.h"

#import "MaterialMath.h"
#import "MaterialRTL.h"
#import "private/MDCBottomNavigationCell.h"

static NSString *const kMDCBottomNavigationViewBadgeColorString = @"badgeColor";
static NSString *const kMDCBottomNavigationViewBadgeValueString = @"badgeValue";
static NSString *const kMDCBottomNavigationViewImageString = @"image";
static NSString *const kMDCBottomNavigationViewTitleString = @"title";
static NSString *const kMDCBottomNavigationViewNewString = @"new";

@interface MDCBottomNavigationView ()

@property(nonatomic, strong) NSMutableArray<MDCBottomNavigationCell *> *navBarCells;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;
@property(nonatomic, strong) UIView *navBarContainerView;

@end

@implementation MDCBottomNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationViewInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationViewInit {
  self.backgroundColor = [UIColor whiteColor];
  self.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
  
  _selectedColor = [UIColor blackColor];
  _unselectedColor = [UIColor grayColor];
  _layoutDirection = self.mdc_effectiveUserInterfaceLayoutDirection;
  _titleHideState = MDCBottomNavigationViewTitleHideStateUnselect;

  // Content in bottom navigation always uses the width of the device portrait orientation width.
  CGSize appSize = [[UIScreen mainScreen] applicationFrame].size;
  CGFloat minDimension = MIN(appSize.width, appSize.height);
  CGRect adjustedFrame = CGRectMake(0, 0, minDimension, self.frame.size.height);
  _navBarContainerView = [[UIView alloc] initWithFrame:adjustedFrame];
  _navBarContainerView.autoresizingMask = (UIViewAutoresizingFlexibleHeight |
                                           UIViewAutoresizingFlexibleLeftMargin |
                                           UIViewAutoresizingFlexibleRightMargin );
  [self addSubview:_navBarContainerView];
  _navBarCells = [NSMutableArray array];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self layoutCellsWithLayoutDirection:self.layoutDirection];
  self.navBarContainerView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                CGRectGetMidY(self.bounds));
}

- (void)layoutCellsWithLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  NSInteger numItems = self.navBarItems.count;
  NSInteger i = 0;
  CGSize navBarSize = self.navBarContainerView.bounds.size;
  CGFloat itemWidth = navBarSize.width / numItems;
  if (layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    for (MDCBottomNavigationCell *cell in self.navBarCells) {
      cell.frame = CGRectMake(navBarSize.width - (i + 1) * itemWidth,
                              0,
                              itemWidth,
                              navBarSize.height);
      i++;
    }
  } else {
    for (MDCBottomNavigationCell *cell in self.navBarCells) {
      cell.frame = CGRectMake(i * itemWidth,
                              0,
                              itemWidth,
                              navBarSize.height);
      i++;
    }
  }
}

- (void)setNavBarItems:(NSArray<UITabBarItem *> *)navBarItems {
  if (_navBarItems == navBarItems) {
    return;
  }
  NSAssert(navBarItems.count > 2, @"Need to have at least 3 items in navBarItems.");
  NSAssert(navBarItems.count < 6, @"navBarItems has a maximum of 5 items.");

  _navBarItems = navBarItems;
  
  [self removeBottomNavigationCells];
  [self removeObserversFromTabBarItems];

  for (UITabBarItem *tabBarItem in navBarItems) {
    MDCBottomNavigationCell *bottomNavCell =
        [[MDCBottomNavigationCell alloc] initWithFrame:CGRectZero];
    bottomNavCell.title = tabBarItem.title;
    bottomNavCell.selectedColor = self.selectedColor;
    bottomNavCell.unselectedColor = self.unselectedColor;
    bottomNavCell.titleHideState = self.titleHideState;

    if (tabBarItem.image) {
      bottomNavCell.image = tabBarItem.image;
    }
    if (tabBarItem.badgeValue) {
      bottomNavCell.badgeValue = tabBarItem.badgeValue;
    }
    if (tabBarItem.badgeColor) {
      bottomNavCell.badgeColor = tabBarItem.badgeColor;
    }
    bottomNavCell.selected = NO;
    [bottomNavCell.button addTarget:self
                             action:@selector(didTapButton:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.navBarCells addObject:bottomNavCell];
    [self.navBarContainerView addSubview:bottomNavCell];
  }
  [self addObserversToTabBarItems];

  // Select the first item by default.
  [self.navBarCells.firstObject setSelected:YES];
}

- (void)dealloc {
  [self removeObserversFromTabBarItems];
}

- (void)addObserversToTabBarItems {
  for (UITabBarItem *tabBarItem in self.navBarItems) {
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewBadgeColorString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewBadgeValueString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewImageString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    [tabBarItem addObserver:self
                 forKeyPath:kMDCBottomNavigationViewTitleString
                    options:NSKeyValueObservingOptionNew
                    context:nil];
  }
}

- (void)removeObserversFromTabBarItems {
  for (UITabBarItem *tabBarItem in self.navBarItems) {
    @try {
      [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewBadgeColorString];
      [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewBadgeValueString];
      [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewImageString];
      [tabBarItem removeObserver:self forKeyPath:kMDCBottomNavigationViewTitleString];
    }
    @catch (NSException *exception) {
      if (exception) {
        // No need to do anything if there are no observers.
      }
    }
  }
}

- (void)removeBottomNavigationCells {
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    [cell removeFromSuperview];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  if (!context) {
    NSInteger i = 0;
    NSInteger selectedItemNum = 0;
    for (UITabBarItem *tabBarItem in self.navBarItems) {
      if (object == tabBarItem) {
        selectedItemNum = i;
        break;
      }
      i++;
    }
    MDCBottomNavigationCell *cell = _navBarCells[selectedItemNum];
    if ([keyPath isEqualToString:kMDCBottomNavigationViewBadgeColorString]) {
      [cell setBadgeColor:change[kMDCBottomNavigationViewNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationViewBadgeValueString]) {
      [cell setBadgeValue:change[kMDCBottomNavigationViewNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationViewImageString]) {
      [cell setImage:change[kMDCBottomNavigationViewNewString]];
    } else if ([keyPath isEqualToString:kMDCBottomNavigationViewTitleString]) {
      [cell setTitle:change[kMDCBottomNavigationViewNewString]];
    }
  }
}

- (void)didTapButton:(UIButton *)button {
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    if (cell.button != button) {
      [cell setSelected:NO animated:YES];
    }
  }
  MDCBottomNavigationCell *cell = (MDCBottomNavigationCell *)button.superview;
  [cell setSelected:YES animated:YES];
}

- (void)selectItem:(UITabBarItem *)item {
  NSInteger i = 0;
  for (UITabBarItem *tabBarItem in self.navBarItems) {
    if (item == tabBarItem) {
      [self.navBarCells[i] setSelected:YES];
    } else {
      [self.navBarCells[i] setSelected:NO];
    }
    i++;
  }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
  _selectedColor = selectedColor;
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    cell.selectedColor = selectedColor;
  }
}

- (void)setUnselectedColor:(UIColor *)unselectedColor {
  _unselectedColor = unselectedColor;
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    cell.unselectedColor = unselectedColor;
  }
}

- (void)setTitleHideState:(MDCBottomNavigationViewTitleHideState)titleHideState {
  _titleHideState = titleHideState;
  for (MDCBottomNavigationCell *cell in self.navBarCells) {
    cell.titleHideState = titleHideState;
  }
}

@end
