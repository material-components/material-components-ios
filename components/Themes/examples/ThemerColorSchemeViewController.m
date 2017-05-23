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

@property(nonatomic, strong, nullable) NSArray *modes;
@property(nonatomic, strong) NSObject<MDCColorScheme> *colorScheme;

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
      NSObject<MDCColorScheme> *blueScheme = [[MDCBasicColorScheme alloc] init];
      blueScheme.primaryColor = [MDCPalette bluePalette].tint500;
      blueScheme.primaryLightColor = [MDCPalette bluePalette].tint100;
      blueScheme.primaryDarkColor = [MDCPalette bluePalette].tint700;
      self.colorScheme = blueScheme;
      break;
    }
    case 1: {
      NSObject<MDCColorScheme> *redScheme = [[MDCBasicColorScheme alloc] init];
      redScheme.primaryColor = [MDCPalette redPalette].tint500;
      redScheme.primaryLightColor = [MDCPalette redPalette].tint100;
      redScheme.primaryDarkColor = [MDCPalette redPalette].tint700;
      self.colorScheme = redScheme;
      break;
    }
    case 2: {
      NSObject<MDCColorScheme> *greenScheme = [[MDCBasicColorScheme alloc] init];
      greenScheme.primaryColor = [MDCPalette greenPalette].tint500;
      greenScheme.primaryLightColor = [MDCPalette greenPalette].tint100;
      greenScheme.primaryDarkColor = [MDCPalette greenPalette].tint700;
      self.colorScheme = greenScheme;
      break;
    }
    case 3: {
      NSObject<MDCColorScheme> *amberScheme = [[MDCBasicColorScheme alloc] init];
      amberScheme.primaryColor = [MDCPalette amberPalette].tint500;
      amberScheme.primaryLightColor = [MDCPalette amberPalette].tint100;
      amberScheme.primaryDarkColor = [MDCPalette amberPalette].tint700;
      self.colorScheme = amberScheme;
      break;
    }
    case 4: {
      NSObject<MDCColorScheme> *pinkScheme = [[MDCBasicColorScheme alloc] init];
      pinkScheme.primaryColor = [MDCPalette pinkPalette].tint500;
      pinkScheme.primaryLightColor = [MDCPalette pinkPalette].tint100;
      pinkScheme.primaryDarkColor = [MDCPalette pinkPalette].tint700;
      self.colorScheme = pinkScheme;
      break;
    }
    case 5: {
      NSObject<MDCColorScheme> *orangeScheme = [[MDCBasicColorScheme alloc] init];
      orangeScheme.primaryColor = [MDCPalette orangePalette].tint500;
      orangeScheme.primaryLightColor = [MDCPalette orangePalette].tint100;
      orangeScheme.primaryDarkColor = [MDCPalette orangePalette].tint700;
      self.colorScheme = orangeScheme;
      break;
    }
    case 6: {
      NSObject<MDCColorScheme> *purpleScheme = [[MDCBasicColorScheme alloc] init];
      purpleScheme.primaryColor = [MDCPalette purplePalette].tint500;
      purpleScheme.primaryLightColor = [MDCPalette purplePalette].tint100;
      purpleScheme.primaryDarkColor = [MDCPalette purplePalette].tint700;
      self.colorScheme = purpleScheme;
      break;
    }
    case 7: {
      NSObject<MDCColorScheme> *tealScheme = [[MDCBasicColorScheme alloc] init];
      tealScheme.primaryColor = [MDCPalette tealPalette].tint500;
      tealScheme.primaryLightColor = [MDCPalette tealPalette].tint100;
      tealScheme.primaryDarkColor = [MDCPalette tealPalette].tint700;
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
