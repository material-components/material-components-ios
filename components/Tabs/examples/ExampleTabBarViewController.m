// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialColorScheme.h"
#import "MaterialSlider.h"
#import "MaterialTabs+ColorThemer.h"
#import "MaterialTabs.h"
#import "ExampleTabBarViewController.h"
#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialAppBar.h"
#import "MaterialButtons.h"
#import "MaterialPalettes.h"

@interface TBVCSampleView : UIView
@end

@implementation TBVCSampleView

// Draw a frame inset around our content area, to show that view are being resized correctly.
- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  // In this example, it happens to be the appBarViewController.headerView
  UIView *header = self.subviews.firstObject;
  CGRect bounds = self.bounds;
  CGRect dontCare;
  CGRectDivide(bounds, &dontCare, &bounds, header.bounds.size.height, CGRectMinYEdge);
  bounds = CGRectInset(bounds, 4, 4);
  [UIColor.whiteColor set];
  UIRectFrame(bounds);
}

@end


@interface TBVCSampleViewController : UIViewController

@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) CGRect buttonFrame;  // The desired frame of the button
@property(nonatomic) MDCButton *button;
@property(nonatomic, copy) MDCButtonActionBlock buttonActionBlock;

@property(nonatomic, nullable) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, nullable) MDCTypographyScheme *typographyScheme;

+ (nonnull instancetype)sampleWithTitle:(nonnull NSString *)title color:(nonnull UIColor *)color;

- (void)setMDCButtonWithFrame:(CGRect)frame
                 buttonScheme:(nonnull id<MDCButtonScheming>)buttonScheme
                        title:(nonnull NSString *)title
                  actionBlock:(nullable MDCButtonActionBlock)actionBlock;

@end

@implementation TBVCSampleViewController

- (void)loadView {
  self.view = [[TBVCSampleView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  _titleLabel.center = self.view.center;
  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    safeAreaInsets = self.view.safeAreaInsets;
  }
  CGRect buttonFrame = self.buttonFrame;
  self.button.frame = CGRectOffset(buttonFrame, safeAreaInsets.left, safeAreaInsets.top);
  [self.button sizeToFit];

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

- (void)setMDCButtonWithFrame:(CGRect)frame
                 buttonScheme:(nonnull id<MDCButtonScheming>)buttonScheme
                        title:(nonnull NSString *)title
                  actionBlock:(nullable MDCButtonActionBlock)actionBlock {
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [button setTitle:title forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:button];
  [self.view addSubview:button];
  self.button = button;
  self.buttonFrame = CGRectStandardize(frame);
  self.buttonActionBlock = actionBlock;
  [button addTarget:self
             action:@selector(triggerButtonActionHandler)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)triggerButtonActionHandler {
  if (self.buttonActionBlock) {
    self.buttonActionBlock();
  }
}

@end



@implementation ExampleTabBarViewController

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.whiteColor;

  [self setupTabBarColors];

  [self loadTabBar];
}

#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
  return UIBarPositionTop;
}

#pragma mark - Private

- (void)loadTabBar {
  NSArray *viewControllers = [self constructExampleViewControllers];
  self.viewControllers = viewControllers;
  self.selectedViewController = self.viewControllers.firstObject;
  [MDCTabBarColorThemer applySemanticColorScheme:self.colorScheme toTabs:self.tabBar];
}

- (void)setupTabBarColors {
  self.tabBar.unselectedItemTintColor = MDCPalette.greyPalette.tint900;
  self.tabBar.selectedItemTintColor = MDCPalette.bluePalette.tint500;
}

- (nonnull NSArray *)constructExampleViewControllers {
  NSBundle *bundle = [NSBundle bundleForClass:[ExampleTabBarViewController class]];
  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  TBVCSampleViewController *child1 = [TBVCSampleViewController sampleWithTitle:@"One"
                                                                         color:UIColor.redColor];

  UIColor *blue = [UIColor colorWithRed:0x3A / 255.f green:0x56 / 255.f blue:0xFF / 255.f alpha:1];
  TBVCSampleViewController *child2 = [TBVCSampleViewController sampleWithTitle:@"Two" color:blue];
  __weak ExampleTabBarViewController *weakSelf = self;
  [child2 setMDCButtonWithFrame:CGRectMake(10, 120, 300, 40)
                   buttonScheme:buttonScheme
                          title:@"Push and Hide Tab"
                    actionBlock:^{
                      ExampleTabBarViewController *strongSelf = weakSelf;
                      TBVCSampleViewController *vc =
                      [TBVCSampleViewController sampleWithTitle:@"Push&Hide"
                                                          color:UIColor.grayColor];
                      vc.colorScheme = strongSelf.colorScheme;
                      vc.typographyScheme = strongSelf.typographyScheme;
                      [strongSelf.navigationController pushViewController:vc animated:YES];
                    }];

  UIImage *starImage = [UIImage imageNamed:@"TabBarDemo_ic_star"
                                  inBundle:bundle
             compatibleWithTraitCollection:nil];
  TBVCSampleViewController *child3 = [TBVCSampleViewController sampleWithTitle:@"Three"
                                                                         color:UIColor.blueColor
                                                                          icon:starImage];
  [child3 setMDCButtonWithFrame:CGRectMake(10, 120, 300, 40)
                   buttonScheme:buttonScheme
                          title:@"Toggle Tab Bar"
                    actionBlock:^{
                      ExampleTabBarViewController *strongSelf = weakSelf;
                      [strongSelf setTabBarHidden:!strongSelf.tabBarHidden animated:YES];
                    }];

  NSArray *viewControllers = @[ child1, child2, child3 ];
  for (TBVCSampleViewController *vc in viewControllers) {
    vc.colorScheme = self.colorScheme;
    vc.typographyScheme = self.typographyScheme;
  }
  return viewControllers;
}

// MARK: CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
           @"breadcrumbs" : @[ @"Tab Bar", @"TabBarViewController" ],
           @"primaryDemo" : @NO,
           @"presentable" : @NO,
           @"debug": @YES,
           };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
