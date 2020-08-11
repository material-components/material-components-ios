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

#if !TARGET_OS_MACCATALYST

#import "supplemental/BottomSheetDummyStaticViewController.h"
#import "BottomSheetPresenterViewController.h"
#import "MaterialBottomSheet.h"

@interface BottomSheetAutolayoutExample : BottomSheetPresenterViewController
@end

@implementation BottomSheetAutolayoutExample

- (void)presentBottomSheet {
  NSBundle *bundle = [NSBundle bundleForClass:[BottomSheetAutolayoutExample class]];
  UIStoryboard *storyboard =
      [UIStoryboard storyboardWithName:@"BottomSheetAutolayoutDummyViewController" bundle:bundle];
  NSString *identifier = @"BottomSheetAutolayoutID";
  UIViewController *viewController =
      [storyboard instantiateViewControllerWithIdentifier:identifier];

  MDCBottomSheetController *bottomSheet =
      [[MDCBottomSheetController alloc] initWithContentViewController:viewController];
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end

@implementation BottomSheetAutolayoutExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Autolayout Content" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

#endif
