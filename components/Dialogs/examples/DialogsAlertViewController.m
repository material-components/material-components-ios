// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialDialogs+DialogThemer.h"
#import "MaterialButtons.h"
#import "MaterialDialogs.h"
#import "supplemental/DialogsAlertViewControllerSupplemental.h"

@implementation DialogsAlertViewController

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self loadCollectionView:@[
    @"Show Alert", @"Show Long Alert", @"Non-Dismissable Alert", @"Alert (Dynamic Type enabled)",
    @"Overpopulated Alert", @"Style Alert", @"Un-style Alert", @"Low elevation Alert"
  ]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
      [self didTapShowAlert];
      break;
    case 1:
      [self didTapShowLongAlert];
      break;
    case 2:
      [self didTapNondismissingAlert];
      break;
    case 3:
      [self didTapDynamicAlert];
      break;
    case 4:
      [self didTapOverpopulatedAlert];
      break;
    case 5:
      [self didTapStyleAlert];
      break;
    case 6:
      [self didTapUnstyleAlert];
      break;
    case 7:
      [self didTapLowElevationAlert];
      break;
  }
}

- (void)themeAlertController:(MDCAlertController *)alertController {
  MDCAlertScheme *alertScheme = [[MDCAlertScheme alloc] init];
  alertScheme.colorScheme = self.colorScheme;
  alertScheme.typographyScheme = self.typographyScheme;
  [MDCAlertControllerThemer applyScheme:alertScheme toAlertController:alertController];
}

- (IBAction)didTapShowAlert {

  NSString *titleString = @"Using Material alert controller?";
  NSString *messageString = @"Be careful with modal alerts as they can be annoying if over-used.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  [self themeAlertController:materialAlertController];

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

- (IBAction)didTapShowLongAlert {
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
  [self themeAlertController:materialAlertController];

  MDCAlertAction *okAction = [MDCAlertAction actionWithTitle:@"OK"
                                                     handler:^(MDCAlertAction *action) {
                                                     NSLog(@"%@", @"OK pressed");
                                                   }];
  [materialAlertController addAction:okAction];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

- (IBAction)didTapNondismissingAlert {
  NSString *titleString = @"This alert requires an action.";
  NSString *messageString = @"You can't dismiss it by tapping the background. You must choose "
                             "one of the actions available.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  [self themeAlertController:materialAlertController];

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

- (IBAction)didTapDynamicAlert {
  // The following strings are extra verbose to better demonstrate the dynamic handling of an alert.
  NSString *titleString = @"This alert supports Dynamic Type font sizing.";
  NSString *messageString =
      @"You can adjust to size of the font used in the Settings App. Navigate to General -> "
       "Accessibility -> Larger Text. Yout can drag the slider left and right to adjust the size "
       "of your fonts to be larger or smaller. We will update the fonts used in this alert to "
       "match your preference";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  [self themeAlertController:materialAlertController];
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

- (IBAction)didTapOverpopulatedAlert {
  NSString *titleString = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur";
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
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  [self themeAlertController:materialAlertController];
  materialAlertController.mdc_adjustsFontForContentSizeCategory = YES;

  MDCAlertAction *okAction = [MDCAlertAction actionWithTitle:@"OK"
                                                     handler:^(MDCAlertAction *action) {
                                                       NSLog(@"%@", @"OK pressed");
                                                     }];
  [materialAlertController addAction:okAction];

  MDCAlertAction *action2 = [MDCAlertAction actionWithTitle:@"OK - 2"
                                                   handler:^(MDCAlertAction *action) {
                                                     NSLog(@"%@", @"OK pressed");
                                                   }];
  [materialAlertController addAction:action2];

  MDCAlertAction *action3 = [MDCAlertAction actionWithTitle:@"OK - 3"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action3];

  MDCAlertAction *action4 = [MDCAlertAction actionWithTitle:@"OK - 4"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action4];

  MDCAlertAction *action5 = [MDCAlertAction actionWithTitle:@"OK - 5"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action5];

  MDCAlertAction *action6 = [MDCAlertAction actionWithTitle:@"OK - 6"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action6];

  MDCAlertAction *action7 = [MDCAlertAction actionWithTitle:@"OK - 7"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action7];

  MDCAlertAction *action8 = [MDCAlertAction actionWithTitle:@"OK - 8"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action8];

  MDCAlertAction *action9 = [MDCAlertAction actionWithTitle:@"OK - 9"
                                                    handler:^(MDCAlertAction *action) {
                                                      NSLog(@"%@", @"OK pressed");
                                                    }];
  [materialAlertController addAction:action9];

  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

- (IBAction)didTapStyleAlert {
  [MDCAlertControllerView appearance].titleFont = [UIFont fontWithName:@"American Typewriter" size:16];
  [MDCAlertControllerView appearance].titleColor = [UIColor greenColor];
  [MDCAlertControllerView appearance].messageFont = [UIFont fontWithName:@"Chalkduster" size:14];
  [MDCAlertControllerView appearance].messageColor = [UIColor blueColor];
  [MDCAlertControllerView appearance].buttonFont = [UIFont fontWithName:@"Chalkduster" size:16];
  [MDCAlertControllerView appearance].buttonColor = [UIColor purpleColor];
  [MDCAlertControllerView appearance].mdc_adjustsFontForContentSizeCategory = YES;

  NSString *titleString = @"Style an alert controller?";
  NSString *messageString = @"Be careful with modal alerts as they can be annoying if over-used.";

  MDCAlertController *materialAlertController =
    [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  [self themeAlertController:materialAlertController];

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

- (IBAction)didTapUnstyleAlert {
  [MDCAlertControllerView appearance].titleFont = nil;
  [MDCAlertControllerView appearance].titleColor = nil;
  [MDCAlertControllerView appearance].messageFont = nil;
  [MDCAlertControllerView appearance].messageColor = nil;
  [MDCAlertControllerView appearance].buttonFont = nil;
  // We must explicitly set the color to black since setting it to nil doesn't reset the color to
  // black, but sets it to white
  [MDCAlertControllerView appearance].buttonColor = [UIColor blackColor];
  [MDCAlertControllerView appearance].mdc_adjustsFontForContentSizeCategory = NO;

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

- (IBAction)didTapLowElevationAlert {
  NSString *titleString = @"Using Material alert controller?";
  NSString *messageString = @"This is an alert controller with a low elevation.";

  MDCAlertController *materialAlertController =
      [MDCAlertController alertControllerWithTitle:titleString message:messageString];
  [self themeAlertController:materialAlertController];

  MDCAlertAction *okAction = [MDCAlertAction actionWithTitle:@"OK"
                                                     handler:^(MDCAlertAction *action) {
                                                       NSLog(@"%@", @"OK pressed");
                                                     }];
  [materialAlertController addAction:okAction];
  materialAlertController.elevation = 2;
  [self presentViewController:materialAlertController animated:YES completion:NULL];
}

@end
