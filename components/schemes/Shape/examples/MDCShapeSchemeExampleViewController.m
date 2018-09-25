// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCShapeSchemeExampleViewController.h"

#import "../../../BottomSheet/examples/supplemental/BottomSheetDummyCollectionViewController.h"
#import "supplemental/MDCChipViewShapeThemerDefaultMapping.h"
#import "supplemental/MDCFloatingButtonShapeThemerDefaultMapping.h"
#import "supplemental/MDCBottomSheetControllerShapeThemerDefaultMapping.h"

#import "MaterialAppBar.h"
#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialBottomSheet.h"
#import "MaterialBottomSheet+ShapeThemer.h"
#import "MaterialButtons.h"
#import "MaterialButtons+ButtonThemer.h"
#import "MaterialButtons+ShapeThemer.h"
#import "MaterialCards.h"
#import "MaterialCards+CardThemer.h"
#import "MaterialCards+ShapeThemer.h"
#import "MaterialChips.h"
#import "MaterialChips+ChipThemer.h"
#import "MaterialChips+ShapeThemer.h"
#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialShapeLibrary.h"
#import "MaterialTypographyScheme.h"

@interface MDCShapeSchemeExampleViewController ()
@property (strong, nonatomic) MDCSemanticColorScheme *colorScheme;
@property (strong, nonatomic) MDCShapeScheme *shapeScheme;
@property (strong, nonatomic) MDCTypographyScheme *typographyScheme;

@property (weak, nonatomic) IBOutlet MDCShapedView *smallSurfaceShape;
@property (weak, nonatomic) IBOutlet MDCShapedView *mediumSurfaceShape;
@property (weak, nonatomic) IBOutlet MDCShapedView *largeSurfaceShape;
@property (weak, nonatomic) IBOutlet UISegmentedControl *smallSurfaceType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mediumSurfaceType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *largeSurfaceType;
@property (weak, nonatomic) IBOutlet UISlider *smallSurfaceValue;
@property (weak, nonatomic) IBOutlet UISlider *mediumSurfaceValue;
@property (weak, nonatomic) IBOutlet UISlider *largeSurfaceValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *includeBaselineOverridesToggle;
@property (weak, nonatomic) IBOutlet UIView *componentContentView;

@property (strong, nonatomic) MDCButton *containedButton;
@property (strong, nonatomic) MDCButton *outlinedButton;
@property (strong, nonatomic) MDCFloatingButton *floatingButton;
@property (strong, nonatomic) MDCChipView *chipView;
@property (strong, nonatomic) MDCCard *card;
@property (strong, nonatomic) MDCButton *presentBottomSheetButton;
@property (strong, nonatomic) MDCBottomSheetController *bottomSheetController;
@end

@implementation MDCShapeSchemeExampleViewController

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self commonShapeSchemeExampleInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self commonShapeSchemeExampleInit];
  }
  return self;
}

- (void)commonShapeSchemeExampleInit {
  _colorScheme = [[MDCSemanticColorScheme alloc] init];
  _shapeScheme = [[MDCShapeScheme alloc] init];
  _typographyScheme = [[MDCTypographyScheme alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _smallSurfaceShape.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  _mediumSurfaceShape.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  _largeSurfaceShape.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  [self applySchemeColors];
  [self initializeComponentry];
}

- (void)initializeComponentry {
  MDCButtonScheme *buttonScheme = [[MDCButtonScheme alloc] init];
  buttonScheme.colorScheme = self.colorScheme;
  buttonScheme.shapeScheme = self.shapeScheme;
  buttonScheme.typographyScheme = self.typographyScheme;

  self.containedButton = [[MDCButton alloc] init];
  [self.containedButton setTitle:@"Button" forState:UIControlStateNormal];
  [MDCContainedButtonThemer applyScheme:buttonScheme toButton:self.containedButton];
  self.containedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.componentContentView addSubview:self.containedButton];

  self.floatingButton = [[MDCFloatingButton alloc] init];
  UIImage *plusImage =
      [[UIImage imageNamed:@"Plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.floatingButton setImage:plusImage forState:UIControlStateNormal];
  [MDCFloatingActionButtonThemer applyScheme:buttonScheme toButton:self.floatingButton];
  [self.floatingButton sizeToFit];
  self.floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.componentContentView addSubview:self.floatingButton];

  MDCChipViewScheme *chipViewScheme = [[MDCChipViewScheme alloc] init];
  chipViewScheme.colorScheme = self.colorScheme;
  chipViewScheme.shapeScheme = self.shapeScheme;
  chipViewScheme.typographyScheme = self.typographyScheme;

  self.chipView = [[MDCChipView alloc] init];
  self.chipView.titleLabel.text = @"Material";
  self.chipView.imageView.image = [self faceImage];
  self.chipView.accessoryView = [self deleteButton];
  self.chipView.minimumSize = CGSizeMake(140, 33);
  self.chipView.translatesAutoresizingMaskIntoConstraints = NO;
  [MDCChipViewThemer applyScheme:chipViewScheme toChipView:self.chipView];
  [self.componentContentView addSubview:self.chipView];

  MDCCardScheme *cardScheme = [[MDCCardScheme alloc] init];
  cardScheme.colorScheme = self.colorScheme;
  cardScheme.shapeScheme = self.shapeScheme;

  self.card = [[MDCCard alloc] init];
  self.card.translatesAutoresizingMaskIntoConstraints = NO;
  [MDCCardThemer applyScheme:cardScheme toCard:self.card];
  self.card.backgroundColor = _colorScheme.primaryColor;
  [self.componentContentView addSubview:self.card];

  NSArray<NSLayoutConstraint *> *cardConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[card]-|" options:0
                                                                                           metrics:nil
                                                                                             views:@{
                                                                                                     @"card" : self.card
                                                                                                     }];
  [self.view addConstraints:cardConstraints];

  self.presentBottomSheetButton = [[MDCButton alloc] init];
  [self.presentBottomSheetButton setTitle:@"Present Bottom Sheet" forState:UIControlStateNormal];
  [MDCOutlinedButtonThemer applyScheme:buttonScheme toButton:self.presentBottomSheetButton];
  self.presentBottomSheetButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.componentContentView addSubview:self.presentBottomSheetButton];
  [self.presentBottomSheetButton addTarget:self action:@selector(presentBottomSheet)
                    forControlEvents:UIControlEventTouchUpInside];

  NSArray<NSLayoutConstraint *> *bottomSheetConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[presentBottomSheetButton]-|" options:0
                                                                                           metrics:nil
                                                                                             views:@{
                                                                                                     @"presentBottomSheetButton" : self.presentBottomSheetButton
                                                                                                     }];
  [self.view addConstraints:bottomSheetConstraints];

  NSArray<NSLayoutConstraint *> *componentConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[containedButton]-(20)-[floatingButton]-(20)-[chipView]-(20)-[card(80)]-(20)-[presentBottomSheetButton]" options:NSLayoutFormatAlignAllCenterX
                                                                                        metrics:nil
                                                                                          views:@{
                                                                                                  @"containedButton": self.containedButton,
                                                                                                  @"floatingButton": self.floatingButton,
                                                                                                  @"chipView": self.chipView,
                                                                                                  @"card": self.card,
                                                                                                  @"presentBottomSheetButton" : self.presentBottomSheetButton
                                                                                                  }];
  [self.view addConstraints:componentConstraints];

}

- (void)presentBottomSheet {
  BottomSheetDummyCollectionViewController *viewController =
  [[BottomSheetDummyCollectionViewController alloc] initWithNumItems:102];
  viewController.title = @"Shaped bottom sheet example";

  MDCAppBarContainerViewController *container =
  [[MDCAppBarContainerViewController alloc] initWithContentViewController:viewController];
  container.preferredContentSize = CGSizeMake(500, 200);
  container.appBarViewController.headerView.trackingScrollView = viewController.collectionView;
  container.topLayoutGuideAdjustmentEnabled = YES;

  [MDCAppBarColorThemer applyColorScheme:self.colorScheme
                  toAppBarViewController:container.appBarViewController];
  [MDCAppBarTypographyThemer applyTypographyScheme:self.typographyScheme
                            toAppBarViewController:container.appBarViewController];

  self.bottomSheetController =
      [[MDCBottomSheetController alloc] initWithContentViewController:container];
  self.bottomSheetController.trackingScrollView = viewController.collectionView;
  [self updateComponentShapesWithBaselineOverrides:
      self.includeBaselineOverridesToggle.selectedSegmentIndex == 0];
  [self presentViewController:self.bottomSheetController animated:YES completion:nil];
}

- (UIImage *)faceImage {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCShapeSchemeExampleViewController class]];
  UIImage *image = [UIImage imageNamed:@"ic_mask"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  return image;
}

- (UIButton *)deleteButton {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCShapeSchemeExampleViewController class]];
  UIImage *image = [UIImage imageNamed:@"ic_cancel"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
  button.tintColor = [UIColor colorWithWhite:0 alpha:0.7f];
  [button setImage:image forState:UIControlStateNormal];

  return button;
}


- (void)applySchemeColors {
  _smallSurfaceShape.backgroundColor = _colorScheme.primaryColor;
  _mediumSurfaceShape.backgroundColor = _colorScheme.primaryColor;
  _largeSurfaceShape.backgroundColor = _colorScheme.primaryColor;

  [_smallSurfaceType setTintColor:_colorScheme.primaryColor];
  [_mediumSurfaceType setTintColor:_colorScheme.primaryColor];
  [_largeSurfaceType setTintColor:_colorScheme.primaryColor];
  [_includeBaselineOverridesToggle setTintColor:_colorScheme.primaryColor];
}

- (void)updateShapeSchemeValues {
  MDCRectangleShapeGenerator *smallRect =
      (MDCRectangleShapeGenerator *)_smallSurfaceShape.shapeGenerator;
  smallRect.topLeftCorner = _shapeScheme.smallSurfaceShape.topLeftCorner;
  smallRect.topRightCorner = _shapeScheme.smallSurfaceShape.topRightCorner;
  smallRect.bottomLeftCorner = _shapeScheme.smallSurfaceShape.bottomLeftCorner;
  smallRect.bottomRightCorner = _shapeScheme.smallSurfaceShape.bottomRightCorner;
  _smallSurfaceShape.shapeGenerator = smallRect;

  MDCRectangleShapeGenerator *mediumRect =
      (MDCRectangleShapeGenerator *)_mediumSurfaceShape.shapeGenerator;
  mediumRect.topLeftCorner = _shapeScheme.mediumSurfaceShape.topLeftCorner;
  mediumRect.topRightCorner = _shapeScheme.mediumSurfaceShape.topRightCorner;
  mediumRect.bottomLeftCorner = _shapeScheme.mediumSurfaceShape.bottomLeftCorner;
  mediumRect.bottomRightCorner = _shapeScheme.mediumSurfaceShape.bottomRightCorner;
  _mediumSurfaceShape.shapeGenerator = mediumRect;

  MDCRectangleShapeGenerator *largeRect =
      (MDCRectangleShapeGenerator *)_largeSurfaceShape.shapeGenerator;
  largeRect.topLeftCorner = _shapeScheme.largeSurfaceShape.topLeftCorner;
  largeRect.topRightCorner = _shapeScheme.largeSurfaceShape.topRightCorner;
  largeRect.bottomLeftCorner = _shapeScheme.largeSurfaceShape.bottomLeftCorner;
  largeRect.bottomRightCorner = _shapeScheme.largeSurfaceShape.bottomRightCorner;
  _largeSurfaceShape.shapeGenerator = largeRect;

  [self updateComponentShapes];
}

- (void)updateComponentShapes {
  [MDCButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.containedButton];
  [MDCButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.outlinedButton];
  [MDCCardsShapeThemer applyShapeScheme:_shapeScheme toCard:self.card];
  [MDCButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.presentBottomSheetButton];
  [self updateComponentShapesWithBaselineOverrides:
      self.includeBaselineOverridesToggle.selectedSegmentIndex == 0];
}

- (MDCShapeCategory *)changedCategoryFromType:(UISegmentedControl *)sender
                                     andValue:(UISlider *)slider {
  MDCShapeCategory *changedCategory;
  if ([[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] isEqualToString:@"Cut"]) {
    // Cut Corner
    changedCategory = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyAngled
                                                              andSize:slider.value];
  } else {
    // Rounded Corner
    changedCategory = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                              andSize:slider.value];
  }
  return changedCategory;
}

- (IBAction)smallSurfaceTypeChanged:(UISegmentedControl *)sender {
  _shapeScheme.smallSurfaceShape = [self changedCategoryFromType:sender
                                                        andValue:_smallSurfaceValue];
  [self updateShapeSchemeValues];
}

- (IBAction)smallSurfaceValueChanged:(UISlider *)sender {
  _shapeScheme.smallSurfaceShape = [self changedCategoryFromType:_smallSurfaceType andValue:sender];

  [self updateShapeSchemeValues];
}

- (IBAction)mediumSurfaceTypeChanged:(UISegmentedControl *)sender {
  _shapeScheme.mediumSurfaceShape = [self changedCategoryFromType:sender
                                                         andValue:_mediumSurfaceValue];
  [self updateShapeSchemeValues];
}

- (IBAction)mediumSurfaceValueChanged:(UISlider *)sender {
  _shapeScheme.mediumSurfaceShape = [self changedCategoryFromType:_mediumSurfaceType
                                                         andValue:sender];

  [self updateShapeSchemeValues];
}

- (IBAction)largeSurfaceTypeChanged:(UISegmentedControl *)sender {
  _shapeScheme.largeSurfaceShape = [self changedCategoryFromType:sender
                                                        andValue:_largeSurfaceValue];
  [self updateShapeSchemeValues];
}

- (IBAction)largeSurfaceValueChanged:(UISlider *)sender {
  _shapeScheme.largeSurfaceShape = [self changedCategoryFromType:_largeSurfaceType andValue:sender];

  [self updateShapeSchemeValues];
}

- (IBAction)baselineOverrideValueChanged:(UISegmentedControl *)sender {
  [self updateComponentShapesWithBaselineOverrides:sender.selectedSegmentIndex == 0];
}

- (void)updateComponentShapesWithBaselineOverrides:(BOOL)baselineOverrides {
  if (!baselineOverrides) {
    // We don't want baseline overrides.
    [MDCBottomSheetControllerShapeThemerDefaultMapping applyShapeScheme:_shapeScheme
                                                toBottomSheetController:self.bottomSheetController];
    [MDCChipViewShapeThemerDefaultMapping applyShapeScheme:_shapeScheme toChipView:self.chipView];
    [MDCFloatingButtonShapeThemerDefaultMapping applyShapeScheme:_shapeScheme
                                                        toButton:self.floatingButton];
  } else {
    // We do want baseline overrides.
    [MDCBottomSheetControllerShapeThemer applyShapeScheme:_shapeScheme
                                  toBottomSheetController:self.bottomSheetController];
    [MDCChipViewShapeThemer applyShapeScheme:_shapeScheme toChipView:self.chipView];
    [MDCFloatingButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.floatingButton];
  }
}

@end

#pragma mark - Catalog by convention
@implementation MDCShapeSchemeExampleViewController (CatlogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Shape", @"ShapeScheme" ],
    @"description": @"The Shape scheme and theming allows components to be shaped on a theme level",
    @"primaryDemo": @YES,
    @"presentable": @NO,
    @"storyboardName": @"MDCShapeSchemeExampleViewController",
    @"debug": @YES,
  };
}

@end
