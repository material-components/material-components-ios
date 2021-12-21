// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialContainerScheme.h"

static NSString *const kButtonLabel = @"Create";

@interface FloatingButtonModeAnimationExample : UIViewController
@property(nonatomic, strong) MDCFloatingButton *floatingButton;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@end

@implementation FloatingButtonModeAnimationExample

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];

  UIImage *plusImage = [[UIImage imageNamed:@"system_icons/add"]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton setImage:plusImage forState:UIControlStateNormal];
  self.floatingButton.autoresizingMask =
      (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
       UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
  [self.floatingButton applySecondaryThemeWithScheme:self.containerScheme];
  [self.floatingButton setTitle:kButtonLabel forState:UIControlStateNormal];
  [self.floatingButton addTarget:self
                          action:@selector(didTap:)
                forControlEvents:UIControlEventTouchUpInside];
  [self.floatingButton sizeToFit];
  self.floatingButton.center =
      CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
  [self.view addSubview:self.floatingButton];
}

- (void)didTap:(MDCFloatingButton *)sender {
  void (^animations)(void) = ^{
    self.floatingButton.center =
        CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
  };
  if (sender.mode == MDCFloatingButtonModeExpanded) {
    [sender setMode:MDCFloatingButtonModeNormal
                animated:YES
        animateAlongside:animations
              completion:nil];
  } else {
    [sender setMode:MDCFloatingButtonModeExpanded
                animated:YES
        animateAlongside:animations
              completion:nil];
  }
}

#pragma mark - Catalog by Convention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Buttons", @"Floating Action Button Mode Animation" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
