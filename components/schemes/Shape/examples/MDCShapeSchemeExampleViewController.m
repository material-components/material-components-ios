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

#import "MDCShapeSchemeExampleViewController.h"

#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

@interface MDCShapeSchemeExampleViewController ()
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation MDCShapeSchemeExampleViewController

@end

#pragma mark - Catalog by convention
@implementation MDCShapeSchemeExampleViewController (CatlogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Shape", @"ShapeScheme" ],
    @"description": @"The Shape scheme and theming allows components to be shaped on a theme level",
    @"primaryDemo": @YES,
    @"presentable": @NO,
    @"storyboardName": @"MDCShapeSchemeExampleViewController",
  };
}

@end
