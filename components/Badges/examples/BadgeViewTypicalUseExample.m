// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBadgeAppearance.h"
#import "MDCDotBadgeAppearance.h"
#import "MDCBadgeView.h"
#import "MDCDotBadgeView.h"

API_AVAILABLE(ios(13.0))
@interface BadgeViewTypicalUseExample : UIViewController
@end

@implementation BadgeViewTypicalUseExample

- (instancetype)init {
  self = [super init];
  if (self) {
    self.title = @"Badges";
  }
  return self;
}

- (MDCDotBadgeAppearance *)defaultDotBadgeAppearance {
  MDCDotBadgeAppearance *config = [[MDCDotBadgeAppearance alloc] init];
  config.innerRadius = 4;
  config.backgroundColor = [UIColor systemRedColor];
  config.borderWidth = 2;
  config.borderColor = [UIColor whiteColor];
  return config;
}

- (MDCBadgeAppearance *)defaultBadgeAppearance {
  MDCBadgeAppearance *config = [[MDCBadgeAppearance alloc] init];
  config.backgroundColor = [UIColor systemRedColor];
  config.textColor = [UIColor whiteColor];
  config.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
  config.borderWidth = 2;
  config.borderColor = [UIColor whiteColor];
  return config;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor systemGrayColor];

  MDCDotBadgeView *dotBadge = [[MDCDotBadgeView alloc] init];
  dotBadge.appearance = [self defaultDotBadgeAppearance];
  [dotBadge sizeToFit];
  [self.view addSubview:dotBadge];

  MDCBadgeView *singleDigitBadge = [[MDCBadgeView alloc] init];
  singleDigitBadge.text = @"1";
  singleDigitBadge.appearance = [self defaultBadgeAppearance];
  [singleDigitBadge sizeToFit];
  [self.view addSubview:singleDigitBadge];

  MDCBadgeView *multiDigitBadge = [[MDCBadgeView alloc] init];
  multiDigitBadge.text = @"99+";
  multiDigitBadge.appearance = [self defaultBadgeAppearance];
  [multiDigitBadge sizeToFit];
  [self.view addSubview:multiDigitBadge];

  MDCBadgeView *systemTintedBadge = [[MDCBadgeView alloc] init];
  systemTintedBadge.text = @"system tint";
  MDCBadgeAppearance *systemTintAppearance = [self defaultBadgeAppearance];
  systemTintAppearance.backgroundColor = nil;  // nil is treated as tintColor
  systemTintedBadge.appearance = systemTintAppearance;
  [systemTintedBadge sizeToFit];
  [self.view addSubview:systemTintedBadge];

  dotBadge.translatesAutoresizingMaskIntoConstraints = NO;
  singleDigitBadge.translatesAutoresizingMaskIntoConstraints = NO;
  multiDigitBadge.translatesAutoresizingMaskIntoConstraints = NO;
  systemTintedBadge.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [dotBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [singleDigitBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [multiDigitBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [systemTintedBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],

    // Why the y offset by .borderWidth?
    // Adding a border causes the badge's content to appear to be offset on its x and y axis by
    // borderWidth units, so we compensate for that in order to keep the badge in the same position
    // it otherwise would have been in without a border.
    // Note that we don't need this for the x position because we're centering the badge around the
    // Y axis and the x position is, as a result, unaffected by borderWidth.
    [singleDigitBadge.topAnchor constraintEqualToAnchor:dotBadge.bottomAnchor
                                               constant:16 - dotBadge.appearance.borderWidth -
                                                        singleDigitBadge.appearance.borderWidth],
    [singleDigitBadge.topAnchor constraintEqualToAnchor:self.view.centerYAnchor
                                               constant:-singleDigitBadge.appearance.borderWidth],
    [multiDigitBadge.topAnchor constraintEqualToAnchor:singleDigitBadge.bottomAnchor
                                              constant:16 - multiDigitBadge.appearance.borderWidth -
                                                       singleDigitBadge.appearance.borderWidth],
    [systemTintedBadge.topAnchor
        constraintEqualToAnchor:multiDigitBadge.bottomAnchor
                       constant:16 - systemTintedBadge.appearance.borderWidth -
                                multiDigitBadge.appearance.borderWidth],
  ]];
}

@end

@implementation BadgeViewTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Badges", @"Typical use" ],
    @"presentable" : @YES,
  };
}

+ (NSOperatingSystemVersion)minimumOSVersion {
  return (NSOperatingSystemVersion){13, 0, 0};
}

@end
