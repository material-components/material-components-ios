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
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "TabBarViewControllerExampleSupplemental.h"

@import MaterialComponents.MaterialAppBar;
@import MaterialComponents.MaterialButtons;
@import MaterialComponents.MaterialPalettes;
@import MaterialComponents.MaterialTabs;

@interface TBVCSampleView : UIView
@end

@implementation TBVCSampleView

// Draw a frame inset around our content area, to show that view are being resized correctly.
- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  // In this example, it happens to be the appBar.headerViewController.headerView
  UIView *header = self.subviews.firstObject;
  CGRect bounds = self.bounds;
  CGRect dontCare;
  CGRectDivide(bounds, &dontCare, &bounds, header.bounds.size.height, CGRectMinYEdge);
  bounds = CGRectInset(bounds, 4, 4);
  [UIColor.whiteColor set];
  UIRectFrame(bounds);
}
@end

@interface TBVCSampleViewController ()
@property(nonatomic) MDCAppBar *appBar;
@property(nonatomic) UILabel *titleLabel;
@end

@implementation TBVCSampleViewController
- (void)loadView {
  self.view = [[TBVCSampleView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.appBar = [[MDCAppBar alloc] init];
  [self addChildViewController:self.appBar.headerViewController];
  [self.appBar addSubviewsToParent];
  self.appBar.navigationBar.tintColor = UIColor.blackColor;
  self.appBar.navigationBar.titleTextAttributes =
      @{NSForegroundColorAttributeName : UIColor.blackColor};
  self.appBar.headerViewController.headerView.backgroundColor = UIColor.whiteColor;
  self.appBar.headerViewController.headerView.tintColor = UIColor.blackColor;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  _titleLabel.center = self.view.center;
  [self.view setNeedsDisplay];
}

+ (nonnull instancetype)sampleWithTitle:(nonnull NSString *)title color:(nonnull UIColor *)color {
  return [self sampleWithTitle:title color:color icon:nil];
}

+ (nonnull instancetype)sampleWithTitle:(nonnull NSString *)title
                                  color:(nonnull UIColor *)color
                                   icon:(nullable UIImage *)icon {
  TBVCSampleViewController *sample = [[TBVCSampleViewController alloc] init];
  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.text = title;
  titleLabel.textColor = UIColor.whiteColor;
  [titleLabel sizeToFit];
  TBVCSampleView *sampleView = (TBVCSampleView *)sample.view;
  sample.titleLabel = titleLabel;
  [sampleView addSubview:titleLabel];
  sampleView.backgroundColor = color;
  sample.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:icon tag:0];
  sample.title = title;
  return sample;
}

@end

@implementation TabBarViewControllerExample (Supplemental)

- (void)setupTabBarColors {
  self.tabBar.unselectedItemTintColor = MDCPalette.greyPalette.tint900;
  self.tabBar.selectedItemTintColor = MDCPalette.bluePalette.tint500;
}

- (nonnull NSArray *)constructExampleViewControllers {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  UIViewController *child1 =
      [TBVCSampleViewController sampleWithTitle:@"One" color:UIColor.redColor];
  UIColor *blue = [UIColor colorWithRed:0x3A / 255. green:0x56 / 255. blue:0xFF / 255. alpha:1];
  UIViewController *child2 = [TBVCSampleViewController sampleWithTitle:@"Two" color:blue];
  UIImage *starImage =
      [UIImage imageNamed:@"TabBarDemo_ic_star" inBundle:bundle compatibleWithTraitCollection:nil];
  UIViewController *child3 =
      [TBVCSampleViewController sampleWithTitle:@"Three" color:UIColor.blueColor icon:starImage];
  return @[ child1, child2, child3 ];
}

@end

@implementation TabBarViewControllerExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"TabBarViewController" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (NSString *)catalogDescription {
  return @"The tab bar controller is a view controller for switching between views of "
          "grouped content.";
}

@end
