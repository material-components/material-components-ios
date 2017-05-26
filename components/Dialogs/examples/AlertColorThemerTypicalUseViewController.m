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
#import "MDCAlertColorThemer.h"

@implementation AlertColorThemerTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCollectionView:
    @[ @"Blue Themed Alert", @"Red Themed Alert", @"Green Themed Alert" ]];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];

  switch (indexPath.item) {
    case 0: {
      MDCColorScheme *blueScheme = [[MDCColorScheme alloc] init];
      blueScheme.primaryColor = [MDCPalette bluePalette].tint500;
      [MDCAlertColorThemer applyColorScheme:blueScheme];
      break;
    }
    case 1: {
      MDCColorScheme *redScheme = [[MDCColorScheme alloc] init];
      redScheme.primaryColor = [MDCPalette redPalette].tint500;
      [MDCAlertColorThemer applyColorScheme:redScheme];
      break;
    }
    case 2: {
      MDCColorScheme *greenScheme = [[MDCColorScheme alloc] init];
      greenScheme.primaryColor = [MDCPalette greenPalette].tint500;
      [MDCAlertColorThemer applyColorScheme:greenScheme];
      break;
    }
  }

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

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

@end
