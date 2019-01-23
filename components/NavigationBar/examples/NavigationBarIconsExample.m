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

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialIcons+ic_reorder.h"
#import "MaterialNavigationBar+ColorThemer.h"
#import "MaterialNavigationBar+TypographyThemer.h"
#import "MaterialNavigationBar.h"
#import "supplemental/NavigationBarTypicalUseExampleSupplemental.h"

@interface NavigationBarIconsExample ()

@property(nonatomic, strong) MDCNavigationBar *navigationBar;
@property(nonatomic, weak) UIBarButtonItem *trailingBarButtonItem;
@property(nonatomic, weak) UIBarButtonItem *leadingBarButtonItem;

@end
@implementation NavigationBarIconsExample

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

  self.title = @"Title";
  self.view.backgroundColor = UIColor.darkGrayColor;

  self.navigationBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  self.navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.navigationBar observeNavigationItem:self.navigationItem];
  [MDCNavigationBarTypographyThemer applyTypographyScheme:self.typographyScheme
                                          toNavigationBar:self.navigationBar];
  [self.view addSubview:self.navigationBar];

  [MDCNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
                                        toNavigationBar:self.navigationBar];

  UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[[MDCIcons imageFor_ic_arrow_back] mdf_imageWithHorizontallyFlippedOrientation]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(didTapBackButton)];

  UIBarButtonItem *leadingButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_info]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];
  UIBarButtonItem *trailingButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[[MDCIcons imageFor_ic_reorder]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              style:UIBarButtonItemStylePlain
             target:nil
             action:nil];

  self.leadingBarButtonItem = leadingButtonItem;
  self.trailingBarButtonItem = trailingButtonItem;
  self.navigationItem.hidesBackButton = NO;
  self.navigationItem.leftBarButtonItems = @[ leadingButtonItem ];
  self.navigationItem.rightBarButtonItem = trailingButtonItem;
  self.navigationItem.backBarButtonItem = backButtonItem;

  if (@available(iOS 11.0, *)) {
    [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.navigationBar.topAnchor]
        .active = YES;
  } else {
    [NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.navigationBar
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0]
        .active = YES;
  }
  NSDictionary *viewsBindings = NSDictionaryOfVariableBindings(_navigationBar);

  [NSLayoutConstraint
      activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navigationBar]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewsBindings]];
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didTapBackButton {
  [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation NavigationBarIconsExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Navigation Bar", @"Navigation Bar With Icons" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end
