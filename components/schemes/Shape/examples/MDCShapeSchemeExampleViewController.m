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

#import "supplemental/MDCBottomSheetControllerShapeThemerDefaultMapping.h"
#import "supplemental/MDCShapeExamplesDummyCollectionViewController.h"

#import "MaterialAppBar+ColorThemer.h"
#import "MaterialAppBar.h"
#import "MaterialAppBar+TypographyThemer.h"
#import "MaterialBottomSheet.h"
#import "MaterialBottomSheet+ShapeThemer.h"
#import "MaterialButtons.h"
#import "MaterialButtons+ShapeThemer.h"
#import "MaterialButtons+Theming.h"
#import "MaterialCards.h"
#import "MaterialCards+Theming.h"
#import "MaterialChips.h"
#import "MaterialChips+Theming.h"
#import "MaterialFlexibleHeader.h"
#import "MaterialShapes.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

@interface MDCShapeSchemeExampleViewController ()
@property(strong, nonatomic) MDCSemanticColorScheme *colorScheme;
@property(strong, nonatomic) MDCShapeScheme *shapeScheme;
@property(strong, nonatomic) MDCTypographyScheme *typographyScheme;
@property(strong, nonatomic) id<MDCContainerScheming> containerScheme;

@property(weak, nonatomic) IBOutlet MDCShapedView *smallComponentShape;
@property(weak, nonatomic) IBOutlet MDCShapedView *mediumComponentShape;
@property(weak, nonatomic) IBOutlet MDCShapedView *largeComponentShape;
@property(weak, nonatomic) IBOutlet UISegmentedControl *smallComponentType;
@property(weak, nonatomic) IBOutlet UISegmentedControl *mediumComponentType;
@property(weak, nonatomic) IBOutlet UISegmentedControl *largeComponentType;
@property(weak, nonatomic) IBOutlet UISlider *smallComponentValue;
@property(weak, nonatomic) IBOutlet UISlider *mediumComponentValue;
@property(weak, nonatomic) IBOutlet UISlider *largeComponentValue;
@property(weak, nonatomic) IBOutlet UISegmentedControl *includeBaselineOverridesToggle;
@property(weak, nonatomic) IBOutlet UIView *componentContentView;

@property(strong, nonatomic) MDCButton *containedButton;
@property(strong, nonatomic) MDCButton *outlinedButton;
@property(strong, nonatomic) MDCChipView *chipView;
@property(strong, nonatomic) MDCCard *card;
@property(strong, nonatomic) MDCButton *presentBottomSheetButton;
@property(strong, nonatomic) MDCBottomSheetController *bottomSheetController;
@end

@implementation MDCShapeSchemeExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonShapeSchemeExampleInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonShapeSchemeExampleInit];
  }
  return self;
}

- (void)commonShapeSchemeExampleInit {
  _colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  _shapeScheme = [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
  _typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
  containerScheme.colorScheme = _colorScheme;
  containerScheme.shapeScheme = _shapeScheme;
  containerScheme.typographyScheme = _typographyScheme;
  _containerScheme = containerScheme;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _smallComponentShape.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  _mediumComponentShape.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  _largeComponentShape.shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];

  [self applySchemeColors];
  [self initializeComponentry];
}

- (void)initializeComponentry {
  self.containedButton = [[MDCButton alloc] init];
  [self.containedButton setTitle:@"Button" forState:UIControlStateNormal];
  [self.containedButton applyContainedThemeWithScheme:self.containerScheme];
  self.containedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.componentContentView addSubview:self.containedButton];

  self.card = [[MDCCard alloc] init];
  self.card.translatesAutoresizingMaskIntoConstraints = NO;
  [self.card applyThemeWithScheme:self.containerScheme];
  self.card.backgroundColor = _colorScheme.primaryColor;
  [self.componentContentView addSubview:self.card];

  self.chipView = [[MDCChipView alloc] init];
  self.chipView.titleLabel.text = @"Material";
  self.chipView.imageView.image = [self faceImage];
  self.chipView.accessoryView = [self deleteButton];
  self.chipView.minimumSize = CGSizeMake(140, 33);
  self.chipView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.chipView applyThemeWithScheme:self.containerScheme];
  [self.componentContentView addSubview:self.chipView];

  NSArray<NSLayoutConstraint *> *cardConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[card]-|"
                                              options:0
                                              metrics:nil
                                                views:@{@"card" : self.card}];
  [self.view addConstraints:cardConstraints];

  self.presentBottomSheetButton = [[MDCButton alloc] init];
  [self.presentBottomSheetButton setTitle:@"Present Bottom Sheet" forState:UIControlStateNormal];
  [self.presentBottomSheetButton applyOutlinedThemeWithScheme:self.containerScheme];
  self.presentBottomSheetButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.componentContentView addSubview:self.presentBottomSheetButton];
  [self.presentBottomSheetButton addTarget:self
                                    action:@selector(presentBottomSheet)
                          forControlEvents:UIControlEventTouchUpInside];

  NSArray<NSLayoutConstraint *> *bottomSheetConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|-[presentBottomSheetButton]-|"
                          options:0
                          metrics:nil
                            views:@{@"presentBottomSheetButton" : self.presentBottomSheetButton}];
  [self.view addConstraints:bottomSheetConstraints];

  NSArray<NSLayoutConstraint *> *componentConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|-(30)-[containedButton]-(20)-["
                                  @"chipView]-(20)-[card(80)]-(20)-[presentBottomSheetButton]"
                          options:NSLayoutFormatAlignAllCenterX
                          metrics:nil
                            views:@{
                              @"containedButton" : self.containedButton,
                              @"chipView" : self.chipView,
                              @"card" : self.card,
                              @"presentBottomSheetButton" : self.presentBottomSheetButton
                            }];
  [self.view addConstraints:componentConstraints];
}

- (void)presentBottomSheet {
  MDCShapeExamplesDummyCollectionViewController *viewController =
      [[MDCShapeExamplesDummyCollectionViewController alloc] initWithNumItems:102];
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
  [self updateComponentShapesWithBaselineOverrides:self.includeBaselineOverridesToggle
                                                       .selectedSegmentIndex == 0];
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
  button.tintColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.7];
  [button setImage:image forState:UIControlStateNormal];

  return button;
}

- (void)applySchemeColors {
  _smallComponentShape.backgroundColor = _colorScheme.primaryColor;
  _mediumComponentShape.backgroundColor = _colorScheme.primaryColor;
  _largeComponentShape.backgroundColor = _colorScheme.primaryColor;

  [_smallComponentType setTintColor:_colorScheme.primaryColor];
  [_mediumComponentType setTintColor:_colorScheme.primaryColor];
  [_largeComponentType setTintColor:_colorScheme.primaryColor];
  [_includeBaselineOverridesToggle setTintColor:_colorScheme.primaryColor];
}

- (void)updateShapeSchemeValues {
  MDCRectangleShapeGenerator *smallRect =
      (MDCRectangleShapeGenerator *)_smallComponentShape.shapeGenerator;
  smallRect.topLeftCorner = _shapeScheme.smallComponentShape.topLeftCorner;
  smallRect.topRightCorner = _shapeScheme.smallComponentShape.topRightCorner;
  smallRect.bottomLeftCorner = _shapeScheme.smallComponentShape.bottomLeftCorner;
  smallRect.bottomRightCorner = _shapeScheme.smallComponentShape.bottomRightCorner;
  _smallComponentShape.shapeGenerator = smallRect;

  MDCRectangleShapeGenerator *mediumRect =
      (MDCRectangleShapeGenerator *)_mediumComponentShape.shapeGenerator;
  mediumRect.topLeftCorner = _shapeScheme.mediumComponentShape.topLeftCorner;
  mediumRect.topRightCorner = _shapeScheme.mediumComponentShape.topRightCorner;
  mediumRect.bottomLeftCorner = _shapeScheme.mediumComponentShape.bottomLeftCorner;
  mediumRect.bottomRightCorner = _shapeScheme.mediumComponentShape.bottomRightCorner;
  _mediumComponentShape.shapeGenerator = mediumRect;

  MDCRectangleShapeGenerator *largeRect =
      (MDCRectangleShapeGenerator *)_largeComponentShape.shapeGenerator;
  largeRect.topLeftCorner = _shapeScheme.largeComponentShape.topLeftCorner;
  largeRect.topRightCorner = _shapeScheme.largeComponentShape.topRightCorner;
  largeRect.bottomLeftCorner = _shapeScheme.largeComponentShape.bottomLeftCorner;
  largeRect.bottomRightCorner = _shapeScheme.largeComponentShape.bottomRightCorner;
  _largeComponentShape.shapeGenerator = largeRect;

  [self updateComponentShapes];
}

- (void)updateComponentShapes {
  [MDCButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.containedButton];
  [MDCButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.outlinedButton];
  [MDCButtonShapeThemer applyShapeScheme:_shapeScheme toButton:self.presentBottomSheetButton];
  [self updateComponentShapesWithBaselineOverrides:self.includeBaselineOverridesToggle
                                                       .selectedSegmentIndex == 0];

  [self.card applyThemeWithScheme:self.containerScheme];
}

- (MDCShapeCategory *)changedCategoryFromType:(UISegmentedControl *)sender
                                     andValue:(UISlider *)slider {
  MDCShapeCategory *changedCategory;
  if ([[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] isEqualToString:@"Cut"]) {
    // Cut Corner
    changedCategory = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut
                                                              andSize:slider.value];
  } else {
    // Rounded Corner
    changedCategory = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                                              andSize:slider.value];
  }
  return changedCategory;
}

- (IBAction)smallComponentTypeChanged:(UISegmentedControl *)sender {
  _shapeScheme.smallComponentShape = [self changedCategoryFromType:sender
                                                          andValue:_smallComponentValue];
  [self updateShapeSchemeValues];
}

- (IBAction)smallComponentValueChanged:(UISlider *)sender {
  _shapeScheme.smallComponentShape = [self changedCategoryFromType:_smallComponentType
                                                          andValue:sender];

  [self updateShapeSchemeValues];
}

- (IBAction)mediumComponentTypeChanged:(UISegmentedControl *)sender {
  _shapeScheme.mediumComponentShape = [self changedCategoryFromType:sender
                                                           andValue:_mediumComponentValue];
  [self updateShapeSchemeValues];
}

- (IBAction)mediumComponentValueChanged:(UISlider *)sender {
  _shapeScheme.mediumComponentShape = [self changedCategoryFromType:_mediumComponentType
                                                           andValue:sender];

  [self updateShapeSchemeValues];
}

- (IBAction)largeComponentTypeChanged:(UISegmentedControl *)sender {
  _shapeScheme.largeComponentShape = [self changedCategoryFromType:sender
                                                          andValue:_largeComponentValue];
  [self updateShapeSchemeValues];
}

- (IBAction)largeComponentValueChanged:(UISlider *)sender {
  _shapeScheme.largeComponentShape = [self changedCategoryFromType:_largeComponentType
                                                          andValue:sender];

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
    [MDCShapeSchemeExampleViewController applyShapeScheme:_shapeScheme toChipView:self.chipView];
  } else {
    // We do want baseline overrides.
    [MDCBottomSheetControllerShapeThemer applyShapeScheme:_shapeScheme
                                  toBottomSheetController:self.bottomSheetController];
    [self.chipView applyThemeWithScheme:self.containerScheme];
  }
}

#pragma mark - Support

+ (void)applyShapeScheme:(nonnull id<MDCShapeScheming>)shapeScheme
              toChipView:(nonnull MDCChipView *)chipView {
  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  rectangleShape.topLeftCorner = shapeScheme.smallComponentShape.topLeftCorner;
  rectangleShape.topRightCorner = shapeScheme.smallComponentShape.topRightCorner;
  rectangleShape.bottomLeftCorner = shapeScheme.smallComponentShape.bottomLeftCorner;
  rectangleShape.bottomRightCorner = shapeScheme.smallComponentShape.bottomRightCorner;
  chipView.shapeGenerator = rectangleShape;
}

@end

#pragma mark - Catalog by convention
@implementation MDCShapeSchemeExampleViewController (CatlogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Shape", @"ShapeScheme" ],
    @"description" :
        @"The Shape scheme and theming allows components to be shaped on a theme level",
    @"primaryDemo" : @YES,
    @"presentable" : @NO,
    @"storyboardName" : @"MDCShapeSchemeExampleViewController",
  };
}

@end
