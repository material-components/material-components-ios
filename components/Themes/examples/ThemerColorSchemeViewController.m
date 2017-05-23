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

@interface ThemersExamplesViewController : MDCCollectionViewController

@property(nonatomic, strong) MDCBasicColorScheme *colorScheme;
@property(nonatomic, strong, nullable) NSArray *modes;

- (void)loadCollectionView:(nullable NSArray *)modes;

@end

@implementation ThemersExamplesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCollectionView: @[ @"Blue Theme",
                               @"Red Theme",
                               @"Green Theme",
                               @"Amber Theme",
                               @"Pink Theme",
                               @"Orange Theme",
                               @"Purple Theme",
                               @"Teal Theme" ]];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];

  switch (indexPath.item) {
    case 0: {
      MDCBasicColorScheme *blueScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette bluePalette].tint500
                                          primaryLightColor:[MDCPalette bluePalette].tint100
                                           primaryDarkColor:[MDCPalette bluePalette].tint700];
      self.colorScheme = blueScheme;
      break;
    }
    case 1: {
      MDCBasicColorScheme *redScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette redPalette].tint500
                                          primaryLightColor:[MDCPalette redPalette].tint100
                                           primaryDarkColor:[MDCPalette redPalette].tint700];
      self.colorScheme = redScheme;
      break;
    }
    case 2: {
      MDCBasicColorScheme *greenScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette greenPalette].tint500
                                          primaryLightColor:[MDCPalette greenPalette].tint100
                                           primaryDarkColor:[MDCPalette greenPalette].tint700];
      self.colorScheme = greenScheme;
      break;
    }
    case 3: {
      MDCBasicColorScheme *amberScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette amberPalette].tint500
                                          primaryLightColor:[MDCPalette amberPalette].tint100
                                           primaryDarkColor:[MDCPalette amberPalette].tint700];
      self.colorScheme = amberScheme;
      break;
    }
    case 4: {
      MDCBasicColorScheme *pinkScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette pinkPalette].tint500
                                          primaryLightColor:[MDCPalette pinkPalette].tint100
                                           primaryDarkColor:[MDCPalette pinkPalette].tint700];
      self.colorScheme = pinkScheme;
      break;
    }
    case 5: {
      MDCBasicColorScheme *orangeScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette orangePalette].tint500
                                          primaryLightColor:[MDCPalette orangePalette].tint100
                                           primaryDarkColor:[MDCPalette orangePalette].tint700];
      self.colorScheme = orangeScheme;
      break;
    }
    case 6: {
      MDCBasicColorScheme *purpleScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette purplePalette].tint500
                                          primaryLightColor:[MDCPalette purplePalette].tint100
                                           primaryDarkColor:[MDCPalette purplePalette].tint700];
      self.colorScheme = purpleScheme;
      break;
    }
    case 7: {
      MDCBasicColorScheme *tealScheme =
          [[MDCBasicColorScheme alloc] initWithPrimaryColor:[MDCPalette tealPalette].tint500
                                          primaryLightColor:[MDCPalette tealPalette].tint100
                                           primaryDarkColor:[MDCPalette tealPalette].tint700];
      self.colorScheme = tealScheme;
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

- (void)loadCollectionView:(nullable NSArray *)modes {
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

@implementation ThemersExamplesViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Themes", @"Theme Examples" ];
}

+ (NSString *)catalogDescription {
  return @"Color schemes applied to a variety of components for theming.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end
