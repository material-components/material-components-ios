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

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor systemGrayColor];

  MDCDotBadgeView *dotBadge = [[MDCDotBadgeView alloc] init];
  dotBadge.innerRadius = 4;
  dotBadge.backgroundColor = [UIColor systemRedColor];
  dotBadge.borderWidth = 2;
  dotBadge.borderColor = [UIColor whiteColor];
  [dotBadge sizeToFit];
  [self.view addSubview:dotBadge];

  MDCBadgeView *singleDigitBadge = [[MDCBadgeView alloc] init];
  singleDigitBadge.text = @"1";
  singleDigitBadge.backgroundColor = [UIColor systemRedColor];
  singleDigitBadge.textColor = [UIColor whiteColor];
  singleDigitBadge.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
  singleDigitBadge.borderWidth = 2;
  singleDigitBadge.borderColor = [UIColor whiteColor];
  [singleDigitBadge sizeToFit];
  [self.view addSubview:singleDigitBadge];

  MDCBadgeView *multiDigitBadge = [[MDCBadgeView alloc] init];
  multiDigitBadge.text = @"99+";
  multiDigitBadge.backgroundColor = [UIColor systemRedColor];
  multiDigitBadge.textColor = [UIColor whiteColor];
  multiDigitBadge.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
  multiDigitBadge.borderWidth = 2;
  multiDigitBadge.borderColor = [UIColor whiteColor];
  [multiDigitBadge sizeToFit];
  [self.view addSubview:multiDigitBadge];

  dotBadge.translatesAutoresizingMaskIntoConstraints = NO;
  singleDigitBadge.translatesAutoresizingMaskIntoConstraints = NO;
  multiDigitBadge.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [dotBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [singleDigitBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [multiDigitBadge.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],

    // Why the y offset by .borderWidth?
    // Adding a border causes the badge's content to appear to be offset on its x and y axis by
    // borderWidth units, so we compensate for that in order to keep the badge in the same position
    // it otherwise would have been in without a border.
    // Note that we don't need this for the x position because we're centering the badge around the
    // Y axis and the x position is, as a result, unaffected by borderWidth.
    [singleDigitBadge.topAnchor
        constraintEqualToAnchor:dotBadge.bottomAnchor
                       constant:16 - dotBadge.borderWidth - singleDigitBadge.borderWidth],
    [singleDigitBadge.topAnchor constraintEqualToAnchor:self.view.centerYAnchor
                                               constant:-singleDigitBadge.borderWidth],
    [multiDigitBadge.topAnchor
        constraintEqualToAnchor:singleDigitBadge.bottomAnchor
                       constant:16 - multiDigitBadge.borderWidth - singleDigitBadge.borderWidth],
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
