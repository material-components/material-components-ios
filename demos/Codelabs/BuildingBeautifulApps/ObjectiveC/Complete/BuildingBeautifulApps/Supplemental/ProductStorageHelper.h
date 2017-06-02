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

#import <Foundation/Foundation.h>
#import "Product.h"

@class Product;

typedef NS_ENUM(NSUInteger, ProductCategory) {
  ProductCategoryHome,
  ProductCategoryClothing,
  ProductCategoryPopsicles,
};

static inline NSArray <Product *> *productsFor(ProductCategory category) {
  NSString *const pngExtension = @"png";
  NSString *folderPath;
  NSMutableArray <NSString *> *files = [NSMutableArray array];

  switch (category) {
    case ProductCategoryPopsicles: {
      // 16 popsicles
      for (int i = 0; i < 16; ++i) {
        [files addObject:[[NSBundle mainBundle] pathForResource:@"popsicle" ofType:pngExtension]];
      }
    }
      break;
    case ProductCategoryClothing:
      folderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Clothing"];
      // Fallthru
    case ProductCategoryHome:
      folderPath = folderPath ?: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Home"];
      
      NSError *error;
      NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error];
      for (NSString *fileName in fileNames) {
        [files addObject:[folderPath stringByAppendingPathComponent:fileName]];
      }
      break;
  }

  NSMutableArray *mutableProducts = [NSMutableArray array];
  for (NSString *path in files) {
    Product *product = [[Product alloc] init];
    product.imagePath = path;
    [mutableProducts addObject:product];
  }
  return [NSArray arrayWithArray:mutableProducts];
}
