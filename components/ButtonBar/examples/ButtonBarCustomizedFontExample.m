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

#import <UIKit/UIKit.h>

#import "MaterialButtonBar.h"
#import "MaterialContainerScheme.h"

@interface ButtonBarCustomizedFontExample : UIViewController
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation ButtonBarCustomizedFontExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];

    self.title = @"Button Bar";
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
  [buttonBar setButtonsTitleFont:[UIFont fontWithName:@"American Typewriter" size:10]
                        forState:UIControlStateNormal];

  // MDCButtonBar ignores the style of UIBarButtonItem.
  UIBarButtonItemStyle ignored = UIBarButtonItemStyleDone;

  UIBarButtonItem *actionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Disable"
                                       style:ignored
                                      target:self
                                      action:@selector(didTapActionButton:)];
  UIBarButtonItem *secondActionItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Customization"
                                       style:ignored
                                      target:self
                                      action:@selector(didTapActionButton:)];

  buttonBar.items = @[ actionItem, secondActionItem ];

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

- (void)didTapActionButton:(id)sender {
  NSLog(@"Did tap action item: %@", sender);
}

@end

@implementation ButtonBarCustomizedFontExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Button Bar", @"Button Bar (Customized)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
