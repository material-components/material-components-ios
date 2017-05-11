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

#import "AlertColorThemerSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialDialogs.h"
#import "MaterialThemes.h"
#import "MaterialPalettes.h"

@implementation AlertColorThemerTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCollectionView:
    @[ @"Show Alert" ]];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  [self didTapShowAlert:nil];
}

- (IBAction)didTapShowAlert:(id)sender {
  NSString *titleString = @"Themed Alert";
  NSString *messageString = @"Button text color of alert is themed.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  MDCAlertAction *agreeAction = [MDCAlertAction actionWithTitle:@"AGREE"
                                                        handler:^(MDCAlertAction *action) {
                                                          NSLog(@"%@", @"AGREE pressed");
                                                        }];
  [materialAlertController addAction:agreeAction];

  MDCColorScheme *colorScheme = [[MDCColorScheme alloc] init];
  colorScheme.primaryColor = [MDCPalette tealPalette].tint500;
  colorScheme.primaryColorLight = [MDCPalette tealPalette].tint100;
  colorScheme.primaryColorDark = [MDCPalette tealPalette].tint700;
  colorScheme.secondaryColor = [MDCPalette bluePalette].tint500;
  colorScheme.secondaryColorLight = [MDCPalette bluePalette].tint100;
  colorScheme.secondaryColorDark = [MDCPalette bluePalette].tint700;

  [MDCAlertColorThemer applyColorScheme:colorScheme];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

@end
