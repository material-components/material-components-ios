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

#import "DialogsAlertViewControllerSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialDialogs.h"

#import "CatalogStyle.h"

@implementation DialogsAlertViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCollectionView:
    @[ @"Show Alert", @"Show Long Alert", @"Non-Dismissable Alert", @"Dynamic Alert"]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
      [self didTapShowAlert:nil];
      break;
    case 1:
      [self didTapShowLongAlert:nil];
      break;
    case 2:
      [self didTapNondismissingAlert:nil];
      break;
    case 3:
    default:
      [self didTapDynamicAlert:nil];
      break;
  }
}



- (IBAction)didTapShowAlert:(id)sender {
  [[MDCButton appearanceWhenContainedIn:[MDCAlertController class], nil]
      setCustomTitleColor:[CatalogStyle primaryColor]];

  NSString *titleString = @"Using Material alert controller?";
  NSString *messageString = @"Be careful with modal alerts as they can be annoying if over-used.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];

  MDCAlertAction *agreeAaction = [MDCAlertAction actionWithTitle:@"AGREE"
                                                         handler:^(MDCAlertAction *action) {
                                                           NSLog(@"%@", @"AGREE pressed");
                                                         }];
  [materialAlertController addAction:agreeAaction];

  MDCAlertAction *disagreeAaction = [MDCAlertAction actionWithTitle:@"DISAGREE"
                                                            handler:^(MDCAlertAction *action) {
                                                              NSLog(@"%@", @"DISAGREE pressed");
                                                            }];
  [materialAlertController addAction:disagreeAaction];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

- (IBAction)didTapShowLongAlert:(id)sender {
  NSString *messageString =
      @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur "
       "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus "
       "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, "
       "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "
       "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean "
       "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus "
       "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus "
       "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, "
       "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "
       "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean "
       "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus "
       "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus "
       "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, "
       "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "
       "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean "
       "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus "
       "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus "
       "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, "
       "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "
       "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean "
       "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus "
       "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus "
       "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, "
       "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "
       "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean "
       "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus "
       "ultricies diam libero, eget porta arcu feugiat sit amet. Maecenas placerat felis sed risus "
       "maximus tempus. Integer feugiat, augue in pellentesque dictum, justo erat ultricies leo, "
       "quis eleifend nisi eros dictum mi. In finibus vulputate eros, in luctus diam auctor in. "
       "Aliquam fringilla neque at augue dictum iaculis. Etiam ac pellentesque lectus. Aenean "
       "vestibulum, tortor nec cursus euismod, lectus tortor rhoncus massa, eu interdum lectus "
       "urna "
       "ut nulla. Phasellus elementum lorem sit amet sapien dictum, vel cursus est semper. Aenean "
       "vel turpis maximus, accumsan dui quis, cursus turpis. Nunc a tincidunt nunc, ut tempus "
       "libero. Morbi ut orci laoreet, luctus neque nec, rhoncus enim. Cras dui erat, blandit ac "
       "malesuada vitae, fringilla ac ante. Nullam dui diam, condimentum vitae mi et, dictum "
       "euismod libero. Aliquam commodo urna vitae massa convallis aliquet.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:nil message:messageString];

  MDCAlertAction *action = [MDCAlertAction actionWithTitle:@"OK"
                                                   handler:^(MDCAlertAction *action) {
                                                     NSLog(@"%@", @"OK pressed");
                                                   }];
  [materialAlertController addAction:action];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

- (IBAction)didTapNondismissingAlert:(id)sender {
  NSString *titleString = @"This alert requires an action.";
  NSString *messageString = @"You can't dismiss it by tapping the background. You must choose "
                             "one of the actions available.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];

  MDCAlertAction *agreeAction = [MDCAlertAction actionWithTitle:@"AGREE"
                                                        handler:^(MDCAlertAction *action) {
                                                          NSLog(@"%@", @"AGREE pressed");
                                                        }];
  [materialAlertController addAction:agreeAction];

  MDCAlertAction *disagreeAaction = [MDCAlertAction actionWithTitle:@"DISAGREE"
                                                            handler:^(MDCAlertAction *action) {
                                                              NSLog(@"%@", @"DISAGREE pressed");
                                                            }];
  [materialAlertController addAction:disagreeAaction];

  // This code accesses the presentation controller and turns off dismiss on background tap.
  MDCDialogPresentationController *presentationController =
      materialAlertController.mdc_dialogPresentationController;
  presentationController.dismissOnBackgroundTap = NO;

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

- (IBAction)didTapDynamicAlert:(id)sender {
  // The following strings are extra verbose to better demonstrate the dynamic handling of an alert.
  NSString *titleString = @"This alert supports Dynamic Type font sizing.";
  NSString *messageString =
      @"You can adjust to size of the font used in the Settings App. Navigate to General -> "
       "Accessibility -> Larger Text. Yout can drag the slider left and right to adjust the size "
       "of your fonts to be larger or smaller. We will update the fonts used in this alert to "
       "match your preference";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  materialAlertController.mdc_adjustsFontForContentSizeCategory = YES;

  MDCAlertAction *agreeAction = [MDCAlertAction actionWithTitle:@"AGREE"
                                                        handler:^(MDCAlertAction *action) {
                                                          NSLog(@"%@", @"AGREE pressed");
                                                        }];
  [materialAlertController addAction:agreeAction];

  MDCAlertAction *okayAction = [MDCAlertAction actionWithTitle:@"OKAY"
                                                       handler:^(MDCAlertAction *action) {
                                                         NSLog(@"%@", @"OKAY pressed");
                                                       }];
  [materialAlertController addAction:okayAction];

  MDCAlertAction *acceptAction = [MDCAlertAction actionWithTitle:@"ACCEPT"
                                                         handler:^(MDCAlertAction *action) {
                                                           NSLog(@"%@", @"ACCEPT pressed");
                                                         }];
  [materialAlertController addAction:acceptAction];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

@end
