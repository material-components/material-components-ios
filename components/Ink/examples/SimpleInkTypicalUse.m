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

#import <UIKit/UIKit.h>

#import "MaterialInk.h"

@interface SimpleInkTypicalUseViewController : UIViewController

@property(nonatomic, strong) MDCSimpleInkView *inkView;

@end

@implementation SimpleInkTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor lightGrayColor];

  CGRect inkViewRect = CGRectMake(0, 0, 200, 200);
  self.inkView = [[MDCSimpleInkView alloc] initWithFrame:inkViewRect];
  self.inkView.center = self.view.center;
  self.inkView.backgroundColor = [UIColor whiteColor];
  self.inkView.clipsToBounds = YES;
  self.inkView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
                                   UIViewAutoresizingFlexibleBottomMargin |
                                   UIViewAutoresizingFlexibleLeftMargin |
                                   UIViewAutoresizingFlexibleRightMargin);
  self.inkView.completionBlock = ^{
    NSLog(@"Ink spread ended");
  };
  [self.inkView addInkGestureRecognizer];
  [self.view addSubview:self.inkView];
}

@end

#pragma mark - SimpleInkTypicalUseViewController

@implementation SimpleInkTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Ink", @"Simple Ink" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
