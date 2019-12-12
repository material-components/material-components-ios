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

#import "BottomSheetSupplemental.h"

@implementation BottomSheetAutolayoutExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Autolayout Content" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation BottomSheetAutolayoutSafeAreaExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Autolayout Safe Area Content" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation BottomSheetPresentationExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom Sheet", @"Presentation from Modal" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end

@implementation BottomSheetWebViewPresentationExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Bottom Sheet", @"Presentation from Modal (WebView)" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

+ (BOOL)catalogIsPresentable {
  return NO;
}

@end

@implementation BottomSheetShortCollectionExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Collection View (Short)" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation BottomSheetSimpleExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Static Content" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation BottomSheetTallExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Preferred Content Size" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation BottomSheetTypicalUseExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Bottom Sheet" ],
    @"description" : @"Bottom sheets are surfaces anchored to the bottom of the screen "
                     @"containing supplementary content, actions, or navigation.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end

@implementation BottomSheetShapedExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Bottom Sheet", @"Shaped Bottom Sheet" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
