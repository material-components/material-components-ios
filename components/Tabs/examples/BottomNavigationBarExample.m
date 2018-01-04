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

#import "MaterialTabs.h"

@interface BottomNavigationBarExample : UIViewController <MDCTabBarDelegate>
@end

@implementation BottomNavigationBarExample {
  MDCTabBar *_bottomNavigationBar;
  NSArray<UIColor *> *_colors;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _bottomNavigationBar = [[MDCTabBar alloc] initWithFrame:CGRectZero];
  _bottomNavigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  _bottomNavigationBar.delegate = self;

  _bottomNavigationBar.barTintColor = [UIColor whiteColor];
  _bottomNavigationBar.selectedItemTintColor = nil;
  _bottomNavigationBar.unselectedItemTintColor = [UIColor colorWithWhite:0 alpha:0.50];
  _bottomNavigationBar.tintColor = [UIColor colorWithRed:0 green:0.5f blue:0 alpha:1];
  _bottomNavigationBar.inkColor = [UIColor colorWithRed:0 green:0.5f blue:0 alpha:0.15f];

  NSBundle *bundle = [NSBundle bundleForClass:[BottomNavigationBarExample class]];
  UIImage *infoImage =
      [UIImage imageNamed:@"TabBarDemo_ic_info" inBundle:bundle compatibleWithTraitCollection:nil];
  UIImage *starImage =
      [UIImage imageNamed:@"TabBarDemo_ic_star" inBundle:bundle compatibleWithTraitCollection:nil];
  _bottomNavigationBar.items = @[
    [[UITabBarItem alloc] initWithTitle:@"Red" image:infoImage tag:0],
    [[UITabBarItem alloc] initWithTitle:@"Blue" image:starImage tag:0]
  ];

  _colors = @[
    [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1],
    [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1]
  ];

  [self.view addSubview:_bottomNavigationBar];
  [self updateDisplay];

  [NSLayoutConstraint constraintWithItem:_bottomNavigationBar
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_bottomNavigationBar
                               attribute:NSLayoutAttributeLeft
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeLeft
                              multiplier:1
                                constant:0].active = YES;
  [NSLayoutConstraint constraintWithItem:_bottomNavigationBar
                               attribute:NSLayoutAttributeRight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.view
                               attribute:NSLayoutAttributeRight
                              multiplier:1
                                constant:0].active = YES;
}

#pragma mark - MDCTabBarDelegate

- (void)tabBar:(MDCTabBar *)tabBar didSelectItem:(UITabBarItem *)item {
  [self updateDisplay];
}

#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  return UIBarPositionBottom;
}

#pragma mark - Private

- (void)updateDisplay {
  UITabBarItem *selectedItem = _bottomNavigationBar.selectedItem;
  if (!selectedItem) {
    return;
  }

  NSUInteger selectedIndex = [_bottomNavigationBar.items indexOfObject:selectedItem];
  if (selectedIndex == NSNotFound) {
    return;
  }

  self.view.backgroundColor = _colors[selectedIndex];
}

@end

@implementation BottomNavigationBarExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"Bottom Navigation" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

@end
