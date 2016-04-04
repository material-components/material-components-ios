/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import "FlexibleHeaderConfiguratorSupplemental.h"

#import "MaterialFlexibleHeader.h"

@implementation FlexibleHeaderConfiguratorExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Flexible Header", @"Configurator" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation FlexibleHeaderConfiguratorExample (Supplemental)

- (void)setupExampleViews:(MDCFlexibleHeaderViewController *)fhvc {
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *viewBindings = @{ @"scrollView" : self.scrollView };
  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints = [NSMutableArray array];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];

  [self.view addConstraints:arrayOfConstraints];

  self.exampleView = [[ExampleConfigurationsView alloc] initWithFrame:CGRectZero];
  self.exampleView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:self.exampleView];

  [self.exampleView.overExtendSwitch addTarget:self
                                        action:@selector(switchDidToggle:)
                              forControlEvents:UIControlEventValueChanged];
  [self.exampleView.shiftSwitch addTarget:self
                                   action:@selector(switchDidToggle:)
                         forControlEvents:UIControlEventValueChanged];
  [self.exampleView.shiftStatusBarSwitch addTarget:self
                                            action:@selector(switchDidToggle:)
                                  forControlEvents:UIControlEventValueChanged];
  [self.exampleView.infiniteContentSwitch addTarget:self
                                             action:@selector(switchDidToggle:)
                                   forControlEvents:UIControlEventValueChanged];
  [self.exampleView.minHeightSlider addTarget:self
                                       action:@selector(sliderDidSlide:)
                             forControlEvents:UIControlEventValueChanged];
  [self.exampleView.maxHeightSlider addTarget:self
                                       action:@selector(sliderDidSlide:)
                             forControlEvents:UIControlEventValueChanged];

  self.exampleView.minHeightSlider.minimumValue = fhvc.headerView.minimumHeight;
  self.exampleView.minHeightSlider.maximumValue = 300;
  self.exampleView.maxHeightSlider.minimumValue = fhvc.headerView.maximumHeight;
  self.exampleView.maxHeightSlider.maximumValue = 300;

  NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.exampleView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1
                                                            constant:0];

  NSLayoutConstraint *centerX = [self.exampleView.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor];
  NSLayoutConstraint *top = [self.exampleView.topAnchor
      constraintEqualToAnchor:self.scrollView.topAnchor];
  NSLayoutConstraint *bottom = [self.exampleView.bottomAnchor
      constraintEqualToAnchor:self.scrollView.bottomAnchor];
  NSLayoutConstraint *leading = [self.exampleView.leadingAnchor
      constraintEqualToAnchor:self.scrollView.leadingAnchor];
  NSLayoutConstraint *trailing = [self.exampleView.trailingAnchor
      constraintEqualToAnchor:self.scrollView.trailingAnchor];

  [self.view addConstraints:@[ width, centerX, top, bottom, leading, trailing ]];

  self.exampleView.overExtendSwitch.on = fhvc.headerView.canOverExtend;
  self.exampleView.shiftSwitch.on =
      fhvc.headerView.behavior != MDCFlexibleHeaderShiftBehaviorDisabled;
  self.exampleView.shiftStatusBarSwitch.on =
      fhvc.headerView.behavior == MDCFlexibleHeaderShiftBehaviorEnabledWithStatusBar;
  self.exampleView.infiniteContentSwitch.on = fhvc.headerView.inFrontOfInfiniteContent;

  self.exampleView.minHeightSlider.value = fhvc.headerView.minimumHeight;
  self.exampleView.maxHeightSlider.value = fhvc.headerView.maximumHeight;
}

@end

@implementation ExampleConfigurationsView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonExampleConfigurationsViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonExampleConfigurationsViewInit];
  }
  return self;
}

- (void)commonExampleConfigurationsViewInit {
  self.overExtendSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
  self.overExtendSwitch.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.overExtendSwitch];

  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
  NSDictionary *textAttributes = @{NSFontAttributeName : font};

  self.overExtendSwitchLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.overExtendSwitchLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSAttributedString *overExtendText =
      [[NSAttributedString alloc] initWithString:@"Can Over-Extend"
                                      attributes:textAttributes];
  self.overExtendSwitchLabel.attributedText = overExtendText;
  [self addSubview:self.overExtendSwitchLabel];

  self.shiftSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
  self.shiftSwitch.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.shiftSwitch];

  self.shiftSwitchLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.shiftSwitchLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSAttributedString *shiftSwitchText =
      [[NSAttributedString alloc] initWithString:@"Hides when collapsed"
                                      attributes:textAttributes];
  self.shiftSwitchLabel.attributedText = shiftSwitchText;
  [self addSubview:self.shiftSwitchLabel];

  self.shiftStatusBarSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
  self.shiftStatusBarSwitch.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.shiftStatusBarSwitch];

  self.shiftStatusBarSwitchLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.shiftStatusBarSwitchLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSAttributedString *shiftStatusBarSwitchText =
      [[NSAttributedString alloc] initWithString:@"Hides status bar when collapsed"
                                      attributes:textAttributes];
  self.shiftStatusBarSwitchLabel.attributedText = shiftStatusBarSwitchText;
  [self addSubview:self.shiftStatusBarSwitchLabel];

  self.infiniteContentSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
  self.infiniteContentSwitch.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.infiniteContentSwitch];

  self.infiniteContentSwitchLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.infiniteContentSwitchLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSAttributedString *infiniteContentSwitchText =
      [[NSAttributedString alloc] initWithString:@"In front of infinite content"
                                      attributes:textAttributes];
  self.infiniteContentSwitchLabel.attributedText = infiniteContentSwitchText;
  [self addSubview:self.infiniteContentSwitchLabel];

  self.minHeightSlider = [[UISlider alloc] initWithFrame:CGRectZero];
  self.minHeightSlider.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.minHeightSlider];

  self.minHeightSliderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.minHeightSliderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSAttributedString *minHeightSliderText =
      [[NSAttributedString alloc] initWithString:@"Minimum Height"
                                      attributes:textAttributes];
  self.minHeightSliderLabel.attributedText = minHeightSliderText;
  [self addSubview:self.minHeightSliderLabel];

  self.maxHeightSlider = [[UISlider alloc] initWithFrame:CGRectZero];
  self.maxHeightSlider.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:self.maxHeightSlider];

  self.maxHeightSliderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.maxHeightSliderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  NSAttributedString *maxHeightSliderText =
      [[NSAttributedString alloc] initWithString:@"Maximum Height"
                                      attributes:textAttributes];
  self.maxHeightSliderLabel.attributedText = maxHeightSliderText;
  [self addSubview:self.maxHeightSliderLabel];

  NSDictionary *viewBindings = @{ @"overExtendSwitch" : self.overExtendSwitch,
                                  @"overExtendSwitchLabel" : self.overExtendSwitchLabel,
                                  @"shiftSwitch" : self.shiftSwitch,
                                  @"shiftSwitchLabel" : self.shiftSwitchLabel,
                                  @"shiftStatusBarSwitch" : self.shiftStatusBarSwitch,
                                  @"shiftStatusBarSwitchLabel" : self.shiftStatusBarSwitchLabel,
                                  @"infiniteContentSwitch" : self.infiniteContentSwitch,
                                  @"infiniteContentSwitchLabel" : self.infiniteContentSwitchLabel,
                                  @"minHeightSlider" : self.minHeightSlider,
                                  @"minHeightSliderLabel" : self.minHeightSliderLabel,
                                  @"maxHeightSlider" : self.maxHeightSlider,
                                  @"maxHeightSliderLabel" : self.maxHeightSliderLabel };

  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints =
      [NSMutableArray array];
  // clang-format off
  [arrayOfConstraints addObjectsFromArray:
   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[overExtendSwitch]"
                                           options:NSLayoutFormatAlignAllCenterX
                                           metrics:nil
                                             views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[overExtendSwitchLabel]-[overExtendSwitch]-8-|"
                        options:NSLayoutFormatAlignAllCenterY
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[overExtendSwitch]-8-[shiftSwitch]"
                        options:NSLayoutFormatAlignAllCenterX
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[shiftSwitchLabel]-[shiftSwitch]-8-|"
                        options:NSLayoutFormatAlignAllCenterY
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[shiftSwitch]-8-[shiftStatusBarSwitch]"
                        options:NSLayoutFormatAlignAllCenterX
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[shiftStatusBarSwitchLabel]-[shiftStatusBarSwitch]-8-|"
                        options:NSLayoutFormatAlignAllCenterY
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[shiftStatusBarSwitch]-8-[infiniteContentSwitch]"
                        options:NSLayoutFormatAlignAllCenterX
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[infiniteContentSwitchLabel]-[infiniteContentSwitch]-8-|"
                        options:NSLayoutFormatAlignAllCenterY
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[infiniteContentSwitchLabel]-16-[minHeightSliderLabel]"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[minHeightSliderLabel]-8-|"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[minHeightSliderLabel]-8-[minHeightSlider]"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[minHeightSlider]-8-|"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[minHeightSlider]-8-[maxHeightSliderLabel]"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[maxHeightSliderLabel]-8-|"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"V:[maxHeightSliderLabel]-8-[maxHeightSlider]"
                        options:0
                        metrics:nil
                          views:viewBindings]];

  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
    constraintsWithVisualFormat:@"H:|-8-[maxHeightSlider]-8-|"
                        options:0
                        metrics:nil
                          views:viewBindings]];
  // clang-format on
  [self addConstraints:arrayOfConstraints];
}
@end
