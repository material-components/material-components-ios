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

#import "FeatureHighlightExampleSupplemental.h"

#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

static NSString *const reuseIdentifier = @"Cell";

@implementation FeatureHighlightTypicalUseViewController (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  self.infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.infoLabel.text = @"Tap anywhere to move the button.";
  self.infoLabel.font = [MDCTypography subheadFont];
  self.infoLabel.textColor =
      [self.infoLabel.textColor colorWithAlphaComponent:[MDCTypography captionFontOpacity]];
  [self.view addSubview:self.infoLabel];

  MDCButton *button = [[MDCButton alloc] init];
  self.button = button;
  [self.button setTitle:@"Feature" forState:UIControlStateNormal];
  [self.button sizeToFit];
  [self.view addSubview:self.button];

  MDCButton *actionButton = [[MDCButton alloc] init];
  self.actionButton = actionButton;
  [self.actionButton setTitle:@"Show Feature Highlight" forState:UIControlStateNormal];
  [self.actionButton sizeToFit];
  [self.actionButton addTarget:self
                        action:@selector(didTapButton:)
              forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.actionButton];

  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:button];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:actionButton];

  UITapGestureRecognizer *tapRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackground:)];
  [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.button sizeToFit];
  CGRect frame = self.button.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
  self.button.frame = frame;

  [self.actionButton sizeToFit];
  frame = self.actionButton.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height - 60;
  self.actionButton.frame = frame;

  CGSize labelSize = [self.infoLabel sizeThatFits:self.view.frame.size];
  self.infoLabel.frame =
      MDCRectAlignToScale(CGRectMake(self.view.frame.size.width / 2 - labelSize.width / 2, 20,
                                     labelSize.width, labelSize.height),
                          [UIScreen mainScreen].scale);
}

- (void)didTapBackground:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:recognizer.view];
  location.x -= self.button.frame.size.width / 2;
  location.y -= self.button.frame.size.height / 2;
  self.button.frame = (CGRect){location, self.button.frame.size};
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Feature Highlight", @"Feature Highlight" ],
    @"description": @"The Feature Highlight component is used to introduce users to new features "
    @"and functionality at contextually relevant moments.",
    @"primaryDemo": @YES,
    @"presentable": @YES,
  };
}

@end

@implementation FeatureHighlightColorExample (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:reuseIdentifier];

  self.colors = @[
    MDCPalette.redPalette.tint500,        MDCPalette.pinkPalette.tint500,
    MDCPalette.purplePalette.tint500,     MDCPalette.deepPurplePalette.tint500,
    MDCPalette.indigoPalette.tint500,     MDCPalette.bluePalette.tint500,
    MDCPalette.lightBluePalette.tint500,  MDCPalette.cyanPalette.tint500,
    MDCPalette.tealPalette.tint500,       MDCPalette.greenPalette.tint500,
    MDCPalette.lightGreenPalette.tint500, MDCPalette.limePalette.tint500,
    MDCPalette.yellowPalette.tint500,     MDCPalette.amberPalette.tint500,
    MDCPalette.orangePalette.tint500,     MDCPalette.deepOrangePalette.tint500,
    MDCPalette.brownPalette.tint500,      MDCPalette.greyPalette.tint500,
    MDCPalette.blueGreyPalette.tint500,
  ];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                forIndexPath:indexPath];

  UIView *accessory = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  accessory.backgroundColor = self.colors[indexPath.row];
  cell.accessoryView = accessory;

  return cell;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Feature Highlight", @"Colors" ],
    @"primaryDemo": @NO,
    @"presentable": @NO,
  };
}

@end


@implementation FeatureHighlightCustomFontsExample (CatalogByConvention)

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.button sizeToFit];
  CGRect frame = self.button.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
  self.button.frame = frame;

  CGSize labelSize = [self.infoLabel sizeThatFits:self.view.frame.size];
  self.infoLabel.frame =
  MDCRectAlignToScale(CGRectMake(self.view.frame.size.width / 2 - labelSize.width / 2, 20,
                                 labelSize.width, labelSize.height),
                      [UIScreen mainScreen].scale);
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Feature Highlight", @"Custom Fonts" ],
    @"primaryDemo": @NO,
    @"presentable": @NO,
  };
}

@end

@implementation FeatureHighlightShownViewExample (CatalogByConvention)

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  MDCFloatingButton *fab = [[MDCFloatingButton alloc] init];
  [fab setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [fab sizeToFit];
  self.button = fab;
  [self.view addSubview:self.button];

  [MDCFloatingActionButtonThemer applyScheme:buttonScheme toButton:fab];


  MDCButton *actionButton = [[MDCButton alloc] init];
  self.actionButton = actionButton;
  [self.actionButton setTitle:@"Show Feature Highlight" forState:UIControlStateNormal];
  [self.actionButton sizeToFit];
  [self.actionButton addTarget:self
                        action:@selector(didTapButton:)
              forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.actionButton];

  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:actionButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  [self.button sizeToFit];
  CGRect frame = self.button.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
  self.button.frame = frame;

  [self.actionButton sizeToFit];
  frame = self.actionButton.frame;
  frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
  frame.origin.y = self.view.frame.size.height - 60;
  self.actionButton.frame = frame;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Feature Highlight", @"Shown Views" ],
    @"primaryDemo": @NO,
    @"presentable": @YES,
  };
}

@end
