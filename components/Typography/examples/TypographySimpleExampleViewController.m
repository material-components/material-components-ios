// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "TypographySimpleExampleViewController.h"

#import "MaterialTypography.h"

@implementation TypographySimpleExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];

  UILabel *label = [[UILabel alloc] init];
  label.text = @"This is a title";
  label.font = [MDCTypography titleFont];
  label.alpha = [MDCTypography titleFontOpacity];

  [label sizeToFit];

  label.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
  label.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
       UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);

  [self.view addSubview:label];
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Typography and Fonts", @"Read Me Demo" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
