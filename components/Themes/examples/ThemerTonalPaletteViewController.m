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

#import "MaterialThemes.h"
#import "MaterialPalettes.h"

#import "ThemerTypicalUseSupplemental.h"

@import MaterialComponents.MaterialCollections;

static NSString *const kReusableIdentifierItem = @"cell";

@interface ThemerTonalPaletteViewController : MDCCollectionViewController

@property(nonatomic, strong) NSObject<MDCColorScheme> *colorScheme;
@property(nonatomic, strong, nullable) NSArray<NSString *> *modes;

- (void)loadCollectionView:(nullable NSArray<NSString *> *)modes;

@end

@implementation ThemerTonalPaletteViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCollectionView: @[ @"Tonal Color Scheme Theme" ]];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];

  switch (indexPath.item) {
    case 0: {
      NSArray<UIColor *> *primaryTonalColors = @[ [MDCPalette purplePalette].tint50,
                                                  [MDCPalette purplePalette].tint100,
                                                  [MDCPalette purplePalette].tint200,
                                                  [MDCPalette purplePalette].tint300,
                                                  [MDCPalette purplePalette].tint400,
                                                  [MDCPalette purplePalette].tint500,
                                                  [MDCPalette purplePalette].tint600,
                                                  [MDCPalette purplePalette].tint700,
                                                  [MDCPalette purplePalette].tint800,
                                                  [MDCPalette purplePalette].tint900 ];
      MDCTonalPalette *primaryTonalPalette =
          [[MDCTonalPalette alloc] initWithColors:primaryTonalColors
                                   mainColorIndex:5
                                  lightColorIndex:1
                                   darkColorIndex:7];
      
      NSArray<UIColor *> *secondaryTonalColors = @[ [MDCPalette orangePalette].tint50,
                                                    [MDCPalette orangePalette].tint100,
                                                    [MDCPalette orangePalette].tint200,
                                                    [MDCPalette orangePalette].tint300,
                                                    [MDCPalette orangePalette].tint400,
                                                    [MDCPalette orangePalette].tint500,
                                                    [MDCPalette orangePalette].tint600,
                                                    [MDCPalette orangePalette].tint700,
                                                    [MDCPalette orangePalette].tint800,
                                                    [MDCPalette orangePalette].tint900 ];
      MDCTonalPalette *secondaryTonalPalette =
           [[MDCTonalPalette alloc] initWithColors:secondaryTonalColors
                                    mainColorIndex:5
                                   lightColorIndex:1
                                    darkColorIndex:7];
      
      MDCTonalColorScheme *tonalColorScheme =
           [[MDCTonalColorScheme alloc] initWithPrimaryTonalPalette:primaryTonalPalette
                                              secondaryTonalPalette:secondaryTonalPalette];
      self.colorScheme = tonalColorScheme;
      break;
    }
  }

  [self didTapShowAlert:nil];
}

- (void)didTapShowAlert:(id)sender {
  ThemerTypicalUseViewController *themerController =
      [[ThemerTypicalUseViewController alloc] initWithColorScheme:self.colorScheme];
  [self.navigationController pushViewController:themerController animated:YES];
}

- (void)loadCollectionView:(nullable NSArray<NSString *> *)modes {
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];
  self.modes = modes;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.modes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  cell.textLabel.text = self.modes[indexPath.row];
  return cell;
}

@end

@implementation ThemerTonalPaletteViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Themes", @"Tonal Palette Example" ];
}

+ (NSString *)catalogDescription {
  return @"Tonal palettes applied to a variety of components for theming.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
