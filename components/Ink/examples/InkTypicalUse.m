// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialInk.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

@interface ExampleShapes : UIView
@end

@interface InkTypicalUseViewController : UIViewController <MDCInkTouchControllerDelegate>

@property(nonatomic, strong) NSMutableArray *inkTouchControllers;  // MDCInkTouchControllers.
@property(nonatomic, strong) ExampleShapes *shapes;
@property(nonatomic, strong) UIView *legacyShape;
@property(nonatomic, weak) UIView *containerView;

@end

@implementation InkTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *containerView = [[UIView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:containerView];
  self.containerView = containerView;

  UIColor *blueColor = MDCPalette.bluePalette.tint500;
  CGFloat spacing = 16;
  CGRect customFrame = CGRectMake(0, 0, 200, 200);
  CGRect legacyFrame = CGRectMake(spacing / 2, spacing / 2, CGRectGetWidth(customFrame) - spacing,
                                  CGRectGetHeight(customFrame) - spacing);

  // ExampleShapes is a custom UIView with several subviews of various shapes.
  self.shapes = [[ExampleShapes alloc] initWithFrame:customFrame];
  self.legacyShape = [[UIView alloc] initWithFrame:legacyFrame];
  self.legacyShape.isAccessibilityElement = YES;
  self.legacyShape.accessibilityTraits = UIAccessibilityTraitButton;
  self.legacyShape.accessibilityLabel = @"Legacy ink view";

  [self setupExampleViews];

  _inkTouchControllers = [[NSMutableArray alloc] init];

  for (UIView *view in self.shapes.subviews) {
    MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:view];
    inkTouchController.delegate = self;
    inkTouchController.defaultInkView.inkColor = blueColor;
    inkTouchController.defaultInkView.usesLegacyInkRipple = NO;
    [inkTouchController addInkView];
    [_inkTouchControllers addObject:inkTouchController];
  }
  [containerView addSubview:self.shapes];

  MDCInkTouchController *inkTouchController =
      [[MDCInkTouchController alloc] initWithView:self.legacyShape];
  inkTouchController.delegate = self;
  inkTouchController.defaultInkView.inkColor = blueColor;
  [inkTouchController addInkView];
  [_inkTouchControllers addObject:inkTouchController];
  [containerView addSubview:self.legacyShape];
}

#pragma mark - Private

- (void)inkTouchController:(MDCInkTouchController *)inkTouchController
         didProcessInkView:(MDCInkView *)inkView
           atTouchLocation:(CGPoint)location {
  NSLog(@"InkTouchController %p did process ink view: %p at touch location: %@", inkTouchController,
        inkView, NSStringFromCGPoint(location));
}

#pragma mark - Supplemental

- (void)setupExampleViews {
  self.view.backgroundColor = UIColor.whiteColor;

  CGRect boundedTitleLabelFrame =
      CGRectMake(0, CGRectGetHeight(self.shapes.frame), CGRectGetWidth(self.shapes.frame), 24);
  UILabel *boundedTitleLabel = [[UILabel alloc] initWithFrame:boundedTitleLabelFrame];
  boundedTitleLabel.text = @"Ink";
  boundedTitleLabel.textAlignment = NSTextAlignmentCenter;
  boundedTitleLabel.font = [MDCTypography captionFont];
  boundedTitleLabel.alpha = [MDCTypography captionFontOpacity];
  [self.shapes addSubview:boundedTitleLabel];

  self.legacyShape.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

  self.legacyShape.backgroundColor = MDCPalette.greyPalette.tint800;

  CGRect legacyTitleLabelFrame = CGRectMake(0, CGRectGetHeight(self.legacyShape.frame),
                                            CGRectGetWidth(self.legacyShape.frame), 36);
  UILabel *legacyTitleLabel = [[UILabel alloc] initWithFrame:legacyTitleLabelFrame];
  legacyTitleLabel.text = @"Legacy Ink";
  legacyTitleLabel.textAlignment = NSTextAlignmentCenter;
  legacyTitleLabel.font = [MDCTypography captionFont];
  legacyTitleLabel.alpha = [MDCTypography captionFontOpacity];
  [self.legacyShape addSubview:legacyTitleLabel];
}

- (void)viewWillLayoutSubviews {
  if (@available(iOS 11.0, *)) {
    UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
    self.containerView.frame =
        CGRectMake(safeAreaInsets.left, safeAreaInsets.top,
                   CGRectGetWidth(self.view.frame) - safeAreaInsets.left - safeAreaInsets.right,
                   CGRectGetHeight(self.view.frame) - safeAreaInsets.top - safeAreaInsets.bottom);
  } else {
    self.containerView.frame =
        CGRectMake(0, self.topLayoutGuide.length, CGRectGetWidth(self.view.frame),
                   CGRectGetHeight(self.view.frame) - self.topLayoutGuide.length);
  }

  CGFloat offset = 8;
  CGFloat shapeDimension = 200;
  CGFloat spacing = 16;
  if (CGRectGetHeight(self.containerView.frame) > CGRectGetWidth(self.containerView.frame)) {
    self.shapes.center = CGPointMake(self.containerView.center.x,
                                     self.containerView.center.y - shapeDimension - offset);
    self.legacyShape.center = CGPointMake(self.containerView.center.x,
                                          self.containerView.center.y + spacing * 2 + offset);
  } else {
    self.shapes.center = CGPointMake(self.containerView.center.x - shapeDimension / 2 - spacing * 2,
                                     self.containerView.center.y / 2 + spacing * 2);
    self.legacyShape.center =
        CGPointMake(self.containerView.center.x + shapeDimension / 2 + spacing * 2,
                    self.containerView.center.y / 2 + spacing * 2);
  }
}

@end

@interface ExampleShapes ()
@end

@implementation ExampleShapes

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGFloat padding = 8;
    CGFloat bigViewFrameHeight = 130;
    CGRect bigViewFrame =
        CGRectMake(padding, padding, CGRectGetWidth(frame) - 2 * padding, bigViewFrameHeight);
    UIView *bigView = [[UIView alloc] initWithFrame:bigViewFrame];
    bigView.backgroundColor = MDCPalette.greyPalette.tint800;
    bigView.isAccessibilityElement = YES;
    bigView.accessibilityTraits = UIAccessibilityTraitButton;
    bigView.accessibilityLabel = @"Large ink view";
    [self addSubview:bigView];

    CGFloat buttonViewDim = 50;
    CGFloat pseudoButtonViewHeight = 40;
    CGFloat fabPadding = 6;
    CGRect pseudoButtonViewFrame = CGRectMake(
        padding, padding + bigViewFrameHeight + fabPadding + padding,
        frame.size.width - 2 * padding - buttonViewDim - fabPadding * 3, pseudoButtonViewHeight);
    UIView *pseudoButtonView = [[UIView alloc] initWithFrame:pseudoButtonViewFrame];
    pseudoButtonView.backgroundColor = MDCPalette.greyPalette.tint800;
    pseudoButtonView.layer.cornerRadius = 5;
    pseudoButtonView.clipsToBounds = YES;
    pseudoButtonView.isAccessibilityElement = YES;
    pseudoButtonView.accessibilityTraits = UIAccessibilityTraitButton;
    pseudoButtonView.accessibilityLabel = @"Button-shaped ink view";
    [self addSubview:pseudoButtonView];

    CGFloat pseudoFABViewFrameLeft =
        padding + CGRectGetWidth(frame) - 2 * padding - buttonViewDim + padding - fabPadding * 2;
    CGRect pseudoFABViewFrame =
        CGRectMake(pseudoFABViewFrameLeft, padding + bigViewFrameHeight + padding,
                   buttonViewDim + fabPadding, buttonViewDim + fabPadding);
    UIView *pseudoFABView = [[UIView alloc] initWithFrame:pseudoFABViewFrame];
    pseudoFABView.backgroundColor = MDCPalette.greyPalette.tint800;
    pseudoFABView.layer.cornerRadius = 28;
    pseudoFABView.clipsToBounds = YES;
    pseudoFABView.isAccessibilityElement = YES;
    pseudoFABView.accessibilityTraits = UIAccessibilityTraitButton;
    pseudoFABView.accessibilityLabel = @"Floating action button-shaped ink view";
    [self addSubview:pseudoFABView];

    self.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  }
  return self;
}

@end

#pragma mark - InkTypicalUseViewController

@implementation InkTypicalUseViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Ink", @"Ink" ],
    @"description" : @"The Ink component provides a radial action in the form of a visual ripple "
                     @"of ink expanding outward from the user's touch.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
