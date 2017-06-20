/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "BottomSheetDummyCollectionViewController.h"
#import "BottomSheetPresenterViewController.h"
#import "MaterialBottomSheet.h"

@interface BottomSheetTypicalUseExample : BottomSheetPresenterViewController
@end

@implementation BottomSheetTypicalUseExample

- (void)presentBottomSheet {
  UIViewController *viewController =
      [[BottomSheetDummyCollectionViewController alloc] initWithNumItems:100];
  viewController.preferredContentSize = CGSizeMake(500, 200);

  MDCBottomSheetViewController *bottomSheet =
      [[MDCBottomSheetViewController alloc] initWithContentViewController:viewController];
  [self presentViewController:bottomSheet animated:YES completion:nil];
}

@end

@implementation BottomSheetTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom Sheet", @"Bottom Sheet" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The Bottom Sheet is a presentation controller for presenting view controllers as a sheet"
      " that slides up from the bottom of the screen. The sheet can be dismissed by swiping down.";
}

@end
