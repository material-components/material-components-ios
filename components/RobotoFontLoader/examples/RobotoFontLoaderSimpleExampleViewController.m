/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "RobotoFontLoaderSimpleExampleViewController.h"
#import "MaterialRobotoFontLoader.h"

@implementation RobotoFontLoaderSimpleExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];
  UIViewAutoresizing flexibleMargins =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

  // Consider using the named styles provided by the Typography component instead of specific font
  // sizes. See https://github.com/material-components/material-components-ios/tree/develop/components/Typography
  UILabel *label = [[UILabel alloc] init];
  label.text = @"This is Roboto regular 16";
  label.font = [[MDCRobotoFontLoader sharedInstance] regularFontOfSize:16];

  [label sizeToFit];
  label.autoresizingMask = flexibleMargins;
  label.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
  [self.view addSubview:label];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Typography and Fonts", @"Roboto Font Loader" ];
}

@end
