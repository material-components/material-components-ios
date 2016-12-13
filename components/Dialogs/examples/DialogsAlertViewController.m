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

@implementation DialogsAlertViewController

- (IBAction)didTapShowAlert:(id)sender {
  [[MDCButton appearanceWhenContainedIn:[MDCAlertController class], nil]
      setCustomTitleColor:[UIColor purpleColor]];

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

@end
