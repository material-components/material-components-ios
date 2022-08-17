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

#import <UIKit/UIKit.h>

#import "MDCCollectionViewTextCell.h"
#import "MDCCollectionViewController.h"
#import "MDCAlertController+ButtonForAction.h"
#import "MDCAlertController.h"
#import "MDCSemanticColorScheme.h"
#import "MDCContainerScheme.h"

static NSString *const kReusableIdentifierItem = @"cell";

@interface DialogsAlertExampleViewController : MDCCollectionViewController
@property(nonatomic, strong, nullable) NSArray *modes;
@property(nonatomic, strong, nonnull) id<MDCContainerScheming> containerScheme;
@end

@interface DialogsAlertExampleViewController (Supplemental)
- (void)loadCollectionView:(nullable NSArray *)modes;
@end

@implementation DialogsAlertExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
    scheme.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    _containerScheme = scheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self loadCollectionView:@[
    @"Show Long Alert", @"Alert (Dynamic Type enabled)", @"Overpopulated Alert"
  ]];
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
      [self didTapShowLongAlert];
      break;
    case 1:
      [self didTapDynamicAlert];
      break;
    case 2:
      [self didTapOverpopulatedAlert];
      break;
  }
}

- (void)themeAlertController:(MDCAlertController *)alertController {
  alertController.titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
  alertController.messageFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  for (MDCAlertAction *action in alertController.actions) {
    MDCButton *button = [alertController buttonForAction:action];
    button.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  }

  alertController.titleColor = UIColor.labelColor;
  alertController.messageColor = UIColor.secondaryLabelColor;
  for (MDCAlertAction *action in alertController.actions) {
    MDCButton *button = [alertController buttonForAction:action];
    button.titleLabel.textColor = UIColor.labelColor;
  }
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
  materialAlertController.adjustsFontForContentSizeCategory = YES;

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
  materialAlertController.adjustsFontForContentSizeCategory = YES;

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

@end

@implementation DialogsAlertExampleViewController (Supplemental)

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
  cell.textLabel.isAccessibilityElement = NO;
  cell.isAccessibilityElement = YES;
  cell.accessibilityLabel = cell.textLabel.text;
  cell.accessibilityTraits = cell.accessibilityTraits | UIAccessibilityTraitButton;

  return cell;
}

@end

@implementation DialogsAlertExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Dialogs", @"More Material Alert Examples" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation DialogsAlertExampleViewController (SnapshotTestingByConvention)

- (NSDictionary<NSString *, void (^)(void)> *)testRunners {
  NSMutableDictionary<NSString *, void (^)(void)> *runners = [NSMutableDictionary dictionary];
  NSInteger index = 0;
  for (NSString *mode in self.modes) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    runners[mode] = ^{
      if (self.presentedViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
      }
      [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    };
    index++;
  }
  return runners;
}

@end
