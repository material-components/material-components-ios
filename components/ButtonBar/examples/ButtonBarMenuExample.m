// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialAvailability.h"
#import "MaterialButtonBar.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

@interface ButtonBarMenuExample : UIViewController
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation ButtonBarMenuExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
    self.title = @"Button Bar (Menu)";
  }
  return self;
}

- (MDCContainerScheme *)containerScheme {
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
  scheme.colorScheme = self.colorScheme;
  scheme.typographyScheme = self.typographyScheme;
  return scheme;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  MDCButtonBar *buttonBar = [[MDCButtonBar alloc] init];
  buttonBar.backgroundColor = self.colorScheme.primaryColor;
  buttonBar.tintColor = self.colorScheme.onPrimaryColor;
  [buttonBar setButtonsTitleFont:self.typographyScheme.button forState:UIControlStateNormal];

  // MDCButtonBar ignores the style of UIBarButtonItem.
  UIBarButtonItemStyle ignored = UIBarButtonItemStyleDone;

  UIBarButtonItem *menuAsSecondaryActionItem;
  UIBarButtonItem *menuAsPrimaryActionItem;
  UIBarButtonItem *changingActionItem;
#if MDC_AVAILABLE_SDK_IOS(14_0)
  if (@available(iOS 14.0, *)) {
    UIAction *primaryAction = [UIAction actionWithTitle:@"Menu on hold"
                                                  image:nil
                                             identifier:nil
                                                handler:^(__kindof UIAction *_Nonnull action) {
                                                  NSLog(@"Primary action was tapped.");
                                                }];

    UIMenu *secondaryMenu = [self exampleMenuWithTitle:@"A secondary action menu"];
    menuAsSecondaryActionItem = [[UIBarButtonItem alloc] initWithImage:nil menu:secondaryMenu];
    menuAsSecondaryActionItem.primaryAction = primaryAction;

    UIMenu *primaryMenu = [self exampleMenuWithTitle:@"A primary action menu"];
    menuAsPrimaryActionItem = [[UIBarButtonItem alloc] initWithImage:nil menu:primaryMenu];
    menuAsPrimaryActionItem.title = @"Menu on tap";

    changingActionItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Change to menu"
                                         style:ignored
                                        target:self
                                        action:@selector(didTapChangingActionItem:)];
  } else {
    menuAsSecondaryActionItem = [[UIBarButtonItem alloc] initWithTitle:@"UIMenu"
                                                                 style:ignored
                                                                target:nil
                                                                action:nil];
    menuAsPrimaryActionItem = [[UIBarButtonItem alloc] initWithTitle:@"only works"
                                                               style:ignored
                                                              target:nil
                                                              action:nil];
    changingActionItem = [[UIBarButtonItem alloc] initWithTitle:@"on iOS 14+"
                                                          style:ignored
                                                         target:nil
                                                         action:nil];
  }
#else
  menuAsSecondaryActionItem = [[UIBarButtonItem alloc] initWithTitle:@"UIMenu"
                                                               style:ignored
                                                              target:nil
                                                              action:nil];
  menuAsPrimaryActionItem = [[UIBarButtonItem alloc] initWithTitle:@"only works"
                                                             style:ignored
                                                            target:nil
                                                            action:nil];
  changingActionItem = [[UIBarButtonItem alloc] initWithTitle:@"with Xcode 12+"
                                                        style:ignored
                                                       target:nil
                                                       action:nil];
#endif

  buttonBar.items = @[ menuAsSecondaryActionItem, menuAsPrimaryActionItem, changingActionItem ];

  // MDCButtonBar's sizeThatFits gives a "best-fit" size of the provided items.
  CGSize size = [buttonBar sizeThatFits:self.view.bounds.size];
  CGFloat x = (self.view.bounds.size.width - size.width) / 2;
  CGFloat y = self.view.bounds.size.height / 2 - size.height;
  buttonBar.frame = CGRectMake(x, y, size.width, size.height);
  buttonBar.autoresizingMask =
      (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
       UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:buttonBar];

  // Ensure that the controller's view isn't transparent.
  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];
}

#pragma mark - User actions

- (void)didTapChangingActionItem:(id)sender {
  if (![sender isKindOfClass:UIBarButtonItem.class]) return;
  UIBarButtonItem *item = (UIBarButtonItem *)sender;
#if MDC_AVAILABLE_SDK_IOS(14_0)
  if (@available(iOS 14.0, *)) {
    item.menu = [self exampleMenuWithTitle:@"This menu was added after the first tap"];
    item.title = @"Menu on tap";
  }
#endif
  NSLog(@"Did tap action item: %@", item);
}

#pragma mark - Factory methods

- (UIMenu *)exampleMenuWithTitle:(NSString *)title API_AVAILABLE(ios(14.0)) {
  UIAction *firstAction = [UIAction actionWithTitle:@"An action"
                                              image:nil
                                         identifier:nil
                                            handler:^(__kindof UIAction *_Nonnull action) {
                                              NSLog(@"First element was tapped.");
                                            }];
  UIAction *secondAction = [UIAction actionWithTitle:@"A second action"
                                               image:nil
                                          identifier:nil
                                             handler:^(__kindof UIAction *_Nonnull action) {
                                               NSLog(@"Second element was tapped.");
                                             }];

  NSArray<UIAction *> *menuElements = @[ firstAction, secondAction ];
  return [UIMenu menuWithTitle:title children:menuElements];
}

@end

@implementation ButtonBarMenuExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Button Bar", @"Button Bar (Menu)" ],
    @"description" : @"The Button Bar is a view that represents a list of UIBarButtonItems as "
                     @"horizontally-aligned buttons.",
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
