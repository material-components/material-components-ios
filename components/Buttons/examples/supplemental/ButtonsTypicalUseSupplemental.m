/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components iOS.
 */

#import <Foundation/Foundation.h>

#import "ButtonsTypicalUseSupplemental.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"

#pragma mark - ButtonsTypicalUseViewController

@implementation ButtonsTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Buttons", @"Buttons" ];
}

+ (NSString *)catalogDescription {
  return @"Buttons is a collection of material design buttons, including a flat button, a raised"
          " button and a floating action button.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation ButtonsTypicalUseViewController (Supplemental)

- (void)addLabels {
  UILabel *raisedButtonLabel = [[UILabel alloc] init];
  raisedButtonLabel.text = @"Raised";
  raisedButtonLabel.font = [MDCTypography captionFont];
  raisedButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [raisedButtonLabel sizeToFit];
  raisedButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButtonLabel];

  UILabel *disabledRaisedButtonLabel = [[UILabel alloc] init];
  disabledRaisedButtonLabel.text = @"Disabled Raised";
  disabledRaisedButtonLabel.font = [MDCTypography captionFont];
  disabledRaisedButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [disabledRaisedButtonLabel sizeToFit];
  disabledRaisedButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledRaisedButtonLabel];

  UILabel *flatButtonLabel = [[UILabel alloc] init];
  flatButtonLabel.text = @"Flat";
  flatButtonLabel.font = [MDCTypography captionFont];
  flatButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [flatButtonLabel sizeToFit];
  flatButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:flatButtonLabel];

  UILabel *disabledFlatButtonLabel = [[UILabel alloc] init];
  disabledFlatButtonLabel.text = @"Disabled Flat";
  disabledFlatButtonLabel.font = [MDCTypography captionFont];
  disabledFlatButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [disabledFlatButtonLabel sizeToFit];
  disabledFlatButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledFlatButtonLabel];

  UILabel *floatingButtonLabel = [[UILabel alloc] init];
  floatingButtonLabel.text = @"Floating Action";
  floatingButtonLabel.font = [MDCTypography captionFont];
  floatingButtonLabel.alpha = [MDCTypography captionFontOpacity];
  [floatingButtonLabel sizeToFit];
  floatingButtonLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:floatingButtonLabel];

  NSDictionary *views = @{
    @"raisedLabel" : raisedButtonLabel,
    @"disabledRaisedLabel" : disabledRaisedButtonLabel,
    @"flatLabel" : flatButtonLabel,
    @"disabledFlatLabel" : disabledFlatButtonLabel,
    @"floatingLabel" : floatingButtonLabel
  };
  [self.views addEntriesFromDictionary:views];
}

- (void)setupExampleViews {
  [self addLabels];

  UILabel *raisedButtonLabel = self.views[@"raisedLabel"];
  MDCRaisedButton *raisedButton = self.views[@"raised"];
  UILabel *disabledRaisedButtonLabel = self.views[@"disabledRaisedLabel"];
  MDCRaisedButton *disabledRaisedButton = self.views[@"disabledRaised"];

  UILabel *flatButtonLabel = self.views[@"flatLabel"];
  MDCFlatButton *flatButton = self.views[@"flat"];
  UILabel *disabledFlatButtonLabel = self.views[@"disabledFlatLabel"];
  MDCFlatButton *disabledFlatButton = self.views[@"disabledFlat"];

  UILabel *floatingButtonLabel = self.views[@"floatingLabel"];
  MDCFloatingButton *floatingButton = self.views[@"floating"];

  self.portraitLayoutConstraints = [NSMutableArray array];

  NSDictionary *metrics = @{
    @"smallVMargin" : @24.0,
    @"largeVMargin" : @56.0,
    @"smallHMargin" : @24.0,
    @"buttonHeight" : @(raisedButton.bounds.size.height),
    @"fabHeight" : @(floatingButton.bounds.size.height)
  };

  // Vertical column of buttons
  NSString *buttonLayoutConstraints = @"V:[raised]-smallVMargin-"
                                       "[disabledRaised]-largeVMargin-"
                                       "[flat]-smallVMargin-"
                                       "[disabledFlat]-largeVMargin-"
                                       "[floating]";

  // Vertical column of labels
  NSString *labelLayoutConstraints = @"V:[raisedLabel(buttonHeight)]-smallVMargin-"
                                      "[disabledRaisedLabel(buttonHeight)]-largeVMargin-"
                                      "[flatLabel(buttonHeight)]-smallVMargin-"
                                      "[disabledFlatLabel(buttonHeight)]-largeVMargin-"
                                      "[floatingLabel(fabHeight)]";

  // Horizontal alignment between the two columns
  NSString *columnConstraints = @"[raisedLabel(100)]-smallHMargin-[raised]";

  // Center view horizontally on the left edge of one of the buttons
  NSLayoutConstraint *horizontalConstraint =
      [NSLayoutConstraint constraintWithItem:flatButton
                                   attribute:NSLayoutAttributeLeft
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1.f
                                    constant:12.f];
  [self.portraitLayoutConstraints addObject:horizontalConstraint];

  // Center view vertically on the flat button (it's the middlemost)
  NSLayoutConstraint *verticalConstraint =
      [NSLayoutConstraint constraintWithItem:flatButton
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.f
                                    constant:0.f];
  [self.portraitLayoutConstraints addObject:verticalConstraint];

  // Center buttons in their column
  NSArray<NSLayoutConstraint *> *buttonConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:buttonLayoutConstraints
                                              options:NSLayoutFormatAlignAllCenterX
                                              metrics:metrics
                                                views:self.views];
  [self.portraitLayoutConstraints addObjectsFromArray:buttonConstraints];

  // Left align labels in their column
  NSArray<NSLayoutConstraint *> *labelConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:labelLayoutConstraints
                                              options:NSLayoutFormatAlignAllLeft
                                              metrics:metrics
                                                views:self.views];
  [self.portraitLayoutConstraints addObjectsFromArray:labelConstraints];

  // Vertically align first element in label column to first element in button column
  NSLayoutConstraint *labelColConstraint =
      [NSLayoutConstraint constraintWithItem:raisedButton
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:raisedButtonLabel
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.f
                                    constant:0.f];
  [self.portraitLayoutConstraints addObject:labelColConstraint];

  // Position label column left of button column, wide enough to accommodate label text
  NSArray<NSLayoutConstraint *> *labelLeftColConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:columnConstraints
                                              options:0
                                              metrics:metrics
                                                views:self.views];
  [self.portraitLayoutConstraints addObjectsFromArray:labelLeftColConstraints];

  self.landscapeLayoutConstraints = [NSMutableArray array];

  NSLayoutConstraint *landscapeRaiseButtonConstraint =
      [NSLayoutConstraint constraintWithItem:raisedButtonLabel
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:0.5
                                    constant:0];
  [self.landscapeLayoutConstraints addObject:landscapeRaiseButtonConstraint];

  NSDictionary *views = @{
    @"raisedButtonLabel" : raisedButtonLabel,
    @"raisedButton" : raisedButton,
    @"flatButtonLabel" : flatButtonLabel,
    @"flatButton" : flatButton
  };
  NSString *horizontalConstraints = @"H:|-(50)-[raisedButtonLabel(100)]-[raisedButton]-(50)-"
                                     "[flatButtonLabel(100)]-[flatButton]-(50)-|";
  NSDictionary *horizontalMetrics = @{
    @"raisedButtonLabel" : @(50),
    @"raisedButton" : @(raisedButton.frame.size.width),
    @"flatButtonLabel" : @(200),
    @"flatButton" : @(flatButton.frame.size.width)
  };

  NSArray<NSLayoutConstraint *> *landscapeHorizontalMetricsConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraints
                                              options:NSLayoutFormatAlignAllCenterY
                                              metrics:horizontalMetrics
                                                views:views];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeHorizontalMetricsConstraints];

  NSDictionary *raisedButtonLabelViews = @{
    @"raisedButtonLabel" : raisedButtonLabel,
    @"disabledRaisedButtonLabel" : disabledRaisedButtonLabel
  };
  NSString *raisedButtonLabelConstraints = @"V:[raisedButtonLabel]-[disabledRaisedButtonLabel]";

  NSDictionary *metricsY = @{
    @"raisedButtonLabel" : @(raisedButtonLabel.frame.size.height),
    @"disabledRaisedButtonLabel" : @(disabledRaisedButtonLabel.frame.size.height)
  };

  NSArray<NSLayoutConstraint *> *landscapeRaisedButtonMetricsConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:raisedButtonLabelConstraints
                                              options:NSLayoutFormatAlignAllCenterX
                                              metrics:metricsY
                                                views:raisedButtonLabelViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeRaisedButtonMetricsConstraints];

  NSArray<NSLayoutConstraint *> *landscapeRaisedButtonConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:raisedButtonLabelConstraints
                                              options:NSLayoutFormatAlignAllLeft
                                              metrics:metricsY
                                                views:raisedButtonLabelViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeRaisedButtonConstraints];

  NSLayoutConstraint *landscapeDisabledRaiseButtonConstraint =
      [NSLayoutConstraint constraintWithItem:disabledRaisedButton
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:disabledRaisedButtonLabel
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.f
                                    constant:0.f];
  [self.landscapeLayoutConstraints addObject:landscapeDisabledRaiseButtonConstraint];

  NSDictionary *raisedButtonViews =
      @{ @"raisedButton" : raisedButton,
         @"disabledRaisedButton" : disabledRaisedButton };
  NSString *raisedButtonConstraints = @"V:[raisedButton]-[disabledRaisedButton]";
  NSDictionary *raisedButtonMetrics = @{
    @"raisedButton" : @(raisedButton.frame.size.height),
    @"disabledRaisedButton" : @(disabledRaisedButton.frame.size.height)
  };
  NSArray<NSLayoutConstraint *> *landscapeMetricsY2Constraints =
      [NSLayoutConstraint constraintsWithVisualFormat:raisedButtonConstraints
                                              options:NSLayoutFormatAlignAllCenterX
                                              metrics:raisedButtonMetrics
                                                views:raisedButtonViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeMetricsY2Constraints];

  NSArray<NSLayoutConstraint *> *landscapeMetricsY2LeftConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:raisedButtonConstraints
                                              options:NSLayoutFormatAlignAllLeft
                                              metrics:raisedButtonMetrics
                                                views:raisedButtonViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeMetricsY2LeftConstraints];

  NSDictionary *flatButtonLabelViews = @{
    @"flatButtonLabel" : flatButtonLabel,
    @"disabledFlatButtonLabel" : disabledFlatButtonLabel
  };
  NSString *flatButtonLabelConstraints = @"V:[flatButtonLabel]-[disabledFlatButtonLabel]";
  NSDictionary *flatButtonLabelMetrics = @{
    @"flatButtonLabel" : @(flatButtonLabel.frame.size.height),
    @"disabledFlatButtonLabel" : @(disabledFlatButtonLabel.frame.size.height)
  };
  NSArray<NSLayoutConstraint *> *landscapeMetricsY3Constraints =
      [NSLayoutConstraint constraintsWithVisualFormat:flatButtonLabelConstraints
                                              options:NSLayoutFormatAlignAllCenterX
                                              metrics:flatButtonLabelMetrics
                                                views:flatButtonLabelViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeMetricsY3Constraints];

  NSArray<NSLayoutConstraint *> *landscapeMetricsY3LeftConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:flatButtonLabelConstraints
                                              options:NSLayoutFormatAlignAllLeft
                                              metrics:flatButtonLabelMetrics
                                                views:flatButtonLabelViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeMetricsY3LeftConstraints];

  NSDictionary *flatButtonViews =
      @{ @"flatButton" : flatButton,
         @"disabledFlatButton" : disabledFlatButton };
  NSString *flatButtonConstraints = @"V:[flatButton]-[disabledFlatButton]";
  NSDictionary *flatButtonMetrics = @{
    @"flatButton" : @(flatButton.frame.size.height),
    @"disabledFlatButton" : @(disabledFlatButton.frame.size.height)
  };

  NSArray<NSLayoutConstraint *> *landscapeMetricsY4Constraints =
      [NSLayoutConstraint constraintsWithVisualFormat:flatButtonConstraints
                                              options:NSLayoutFormatAlignAllCenterX
                                              metrics:flatButtonMetrics
                                                views:flatButtonViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeMetricsY4Constraints];

  NSArray<NSLayoutConstraint *> *landscapeMetricsY4LeftConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:flatButtonConstraints
                                              options:NSLayoutFormatAlignAllLeft
                                              metrics:flatButtonMetrics
                                                views:flatButtonViews];
  [self.landscapeLayoutConstraints addObjectsFromArray:landscapeMetricsY4LeftConstraints];

  NSLayoutConstraint *landscapeMetricsCenterConstraint =
      [NSLayoutConstraint constraintWithItem:disabledFlatButton
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:disabledFlatButtonLabel
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.f
                                    constant:0.f];
  [self.landscapeLayoutConstraints addObject:landscapeMetricsCenterConstraint];

  NSLayoutConstraint *landscapeEqualCenterYConstraint =
      [NSLayoutConstraint constraintWithItem:floatingButton
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.5
                                    constant:0];
  [self.landscapeLayoutConstraints addObject:landscapeEqualCenterYConstraint];

  NSLayoutConstraint *landscapeEqualCenterXConstraint =
      [NSLayoutConstraint constraintWithItem:floatingButton
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                    constant:50];
  [self.landscapeLayoutConstraints addObject:landscapeEqualCenterXConstraint];

  NSLayoutConstraint *landscapeFloatingButtonLabelCenterConstraint =
      [NSLayoutConstraint constraintWithItem:floatingButton
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:floatingButtonLabel
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.f
                                    constant:0.f];
  [self.landscapeLayoutConstraints addObject:landscapeFloatingButtonLabelCenterConstraint];

  NSLayoutConstraint *landscapeFloatingButtonCenterEqualConstraint =
      [NSLayoutConstraint constraintWithItem:floatingButtonLabel
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                    constant:-50];
  [self.landscapeLayoutConstraints addObject:landscapeFloatingButtonCenterEqualConstraint];
}

- (void)viewWillLayoutSubviews {
  if (self.view.frame.size.width < self.view.frame.size.height) {
    [self.view removeConstraints:self.landscapeLayoutConstraints];
    [self.view addConstraints:self.portraitLayoutConstraints];
  } else {
    [self.view removeConstraints:self.portraitLayoutConstraints];
    [self.view addConstraints:self.landscapeLayoutConstraints];
  }
}

@end
