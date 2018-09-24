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

#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialShapeLibrary.h"
#import "MaterialTypographyScheme.h"

@interface MDCShapeSchemeExampleViewController ()
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
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
}

- (MDCShapeCategory *)changedCategoryFromType:(UISegmentedControl *)sender
                                     andValue:(UISlider *)slider {
  MDCShapeCategory *changedCategory;
  if ([[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] isEqualToString:@"Cut"]) {
    changedCategory = [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyAngled
                                                              andSize:slider.value];
  } else {
    // Rounded
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
