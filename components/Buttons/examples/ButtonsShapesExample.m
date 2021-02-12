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

#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

#import "supplemental/ButtonsTypicalUseSupplemental.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

@interface ButtonsShapesExample ()
@property(nonatomic, strong) MDCFloatingButton *floatingButton;
@end

@implementation ButtonsShapesExample

- (id)init {
  self = [super init];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
    self.containerScheme = [[MDCContainerScheme alloc] init];
    self.containerScheme.colorScheme = self.colorScheme;
    self.containerScheme.shapeScheme =
        [[MDCShapeScheme alloc] initWithDefaults:MDCShapeSchemeDefaultsMaterial201809];
    self.containerScheme.typographyScheme = self.typographyScheme;
  }
  return self;
}

- (MDCButton *)buildCustomOutlinedButton {
  MDCButton *button = [[MDCButton alloc] init];
  [button setBorderWidth:1.0 forState:UIControlStateNormal];
  [button setBorderColor:[UIColor colorWithWhite:(CGFloat)0.1 alpha:1]
                forState:UIControlStateNormal];
  return button;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.9 alpha:1];
  UIColor *titleColor = [UIColor whiteColor];

  // Raised button

  MDCButton *containedButton = [[MDCButton alloc] init];
  [containedButton setTitle:@"Add To Cart" forState:UIControlStateNormal];
  [containedButton applyContainedThemeWithScheme:self.containerScheme];

  UIImage *plusImage = [UIImage imageNamed:@"ic_add"];
  plusImage = [plusImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [containedButton setImage:plusImage forState:UIControlStateNormal];

  MDCRectangleShapeGenerator *raisedShapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  [raisedShapeGenerator setCorners:[[MDCCutCornerTreatment alloc] initWithCut:8]];
  containedButton.shapeGenerator = raisedShapeGenerator;

  [containedButton sizeToFit];
  [containedButton addTarget:self
                      action:@selector(didTap:)
            forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:containedButton];

  // Disabled raised button

  MDCButton *disabledContainedButton = [[MDCButton alloc] init];
  [disabledContainedButton setTitle:@"Curved Cut" forState:UIControlStateNormal];
  [disabledContainedButton applyContainedThemeWithScheme:self.containerScheme];

  MDCRectangleShapeGenerator *disabledRaisedShapeGenerator =
      [[MDCRectangleShapeGenerator alloc] init];
  MDCCurvedCornerTreatment *curvedCorners = [[MDCCurvedCornerTreatment alloc] init];
  curvedCorners.size = CGSizeMake(10, 30);
  [disabledRaisedShapeGenerator setCorners:curvedCorners];
  disabledContainedButton.shapeGenerator = disabledRaisedShapeGenerator;

  [disabledContainedButton sizeToFit];
  [disabledContainedButton addTarget:self
                              action:@selector(didTap:)
                    forControlEvents:UIControlEventTouchUpInside];
  [disabledContainedButton setEnabled:NO];
  [self.view addSubview:disabledContainedButton];

  // Flat button

  MDCButton *flatButton = [[MDCButton alloc] init];
  [flatButton setTitle:@"Oval Flat" forState:UIControlStateNormal];
  [flatButton applyTextThemeWithScheme:self.containerScheme];

  MDCPillShapeGenerator *flatShapeGenerator = [[MDCPillShapeGenerator alloc] init];
  flatButton.shapeGenerator = flatShapeGenerator;

  [flatButton sizeToFit];
  [flatButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:flatButton];

  // Custom outlined button

  MDCButton *outlinedButton = [self buildCustomOutlinedButton];
  [outlinedButton setTitle:@"Triangular" forState:UIControlStateNormal];
  [outlinedButton applyOutlinedThemeWithScheme:self.containerScheme];

  MDCSlantedRectShapeGenerator *outlinedShapeGenerator =
      [[MDCSlantedRectShapeGenerator alloc] init];
  outlinedShapeGenerator.slant = 10;
  outlinedButton.shapeGenerator = outlinedShapeGenerator;

  [outlinedButton sizeToFit];
  [outlinedButton addTarget:self
                     action:@selector(didTap:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:outlinedButton];

  // Disabled custom outlined button

  MDCButton *disabledOutlinedButton = [self buildCustomOutlinedButton];
  [disabledOutlinedButton setTitle:@"Freeform" forState:UIControlStateNormal];
  [disabledOutlinedButton applyOutlinedThemeWithScheme:self.containerScheme];

  MDCRectangleShapeGenerator *disabledOutlinedShapeGenerator =
      [[MDCRectangleShapeGenerator alloc] init];
  [disabledOutlinedShapeGenerator
      setTopEdge:[[MDCTriangleEdgeTreatment alloc] initWithSize:5 style:MDCTriangleEdgeStyleCut]];
  [disabledOutlinedShapeGenerator setTopLeftCorner:[[MDCCutCornerTreatment alloc] initWithCut:10]];
  [disabledOutlinedShapeGenerator
      setTopRightCorner:[[MDCCurvedCornerTreatment alloc] initWithSize:CGSizeMake(5, 20)]];
  [disabledOutlinedShapeGenerator
      setBottomEdge:[[MDCTriangleEdgeTreatment alloc] initWithSize:5
                                                             style:MDCTriangleEdgeStyleHandle]];
  [disabledOutlinedShapeGenerator
      setBottomRightCorner:[[MDCCutCornerTreatment alloc] initWithCut:5]];
  [disabledOutlinedShapeGenerator
      setBottomLeftCorner:[[MDCCurvedCornerTreatment alloc] initWithSize:CGSizeMake(10, 5)]];
  disabledOutlinedButton.shapeGenerator = disabledOutlinedShapeGenerator;

  [disabledOutlinedButton sizeToFit];
  [disabledOutlinedButton addTarget:self
                             action:@selector(didTap:)
                   forControlEvents:UIControlEventTouchUpInside];
  [disabledOutlinedButton setEnabled:NO];
  [self.view addSubview:disabledOutlinedButton];

  // Floating action button

  self.floatingButton = [[MDCFloatingButton alloc] init];
  [self.floatingButton setTitleColor:titleColor forState:UIControlStateNormal];
  [self.floatingButton setImageTintColor:UIColor.whiteColor forState:UIControlStateNormal];
  [self.floatingButton setImage:plusImage forState:UIControlStateNormal];
  self.floatingButton.accessibilityLabel = @"Floating Action Diamond";
  [self.floatingButton sizeToFit];

  MDCRectangleShapeGenerator *floatingShapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
  [floatingShapeGenerator
      setCorners:[[MDCCutCornerTreatment alloc]
                     initWithCut:CGRectGetWidth(self.floatingButton.bounds) / 2]];
  self.floatingButton.shapeGenerator = floatingShapeGenerator;
  [self.floatingButton applySecondaryThemeWithScheme:self.containerScheme];

  [self.floatingButton addTarget:self
                          action:@selector(didTap:)
                forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.floatingButton];

  self.buttons = @[
    containedButton, disabledContainedButton, flatButton, outlinedButton, disabledOutlinedButton,
    self.floatingButton
  ];

  [self setupShapeExampleViews];
}

- (void)setupShapeExampleViews {
  UILabel *raisedButtonLabel = [self addLabelWithText:@"Contained: Cut Corners"];
  UILabel *disabledRaisedButtonLabel = [self addLabelWithText:@"Disabled Contained: Curved Cut"];
  UILabel *flatButtonLabel = [self addLabelWithText:@"Flat: Oval Ink"];
  UILabel *outlinedButtonLabel = [self addLabelWithText:@"Outlined: Triangular"];
  UILabel *disabledOutlinedButtonLabel = [self addLabelWithText:@"Outlined Disabled: Freeform"];
  UILabel *floatingDiamondLabel = [self addLabelWithText:@"Floating Action: Diamond"];

  self.labels = @[
    raisedButtonLabel, disabledRaisedButtonLabel, flatButtonLabel, outlinedButtonLabel,
    disabledOutlinedButtonLabel, floatingDiamondLabel
  ];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
  if (sender == self.floatingButton) {
    [self.floatingButton
          collapse:YES
        completion:^{
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                         dispatch_get_main_queue(), ^{
                           [self.floatingButton expand:YES completion:nil];
                         });
        }];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (animated) {
    [self.floatingButton collapse:NO completion:nil];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (animated) {
    [self.floatingButton expand:YES completion:nil];
  }
}

@end
