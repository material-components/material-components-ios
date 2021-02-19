// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialChips.h"
#import "MaterialChips+Theming.h"
#import "MaterialTextFields.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

@interface ChipsInputExampleViewController : UIViewController <MDCChipFieldDelegate>
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;
@property(nonatomic, strong) MDCChipField *chipField;
@end

@implementation ChipsInputExampleViewController

- (id)init {
  self = [super init];
  if (self) {
    _containerScheme = [[MDCContainerScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.containerScheme.colorScheme) {
    self.view.backgroundColor = self.containerScheme.colorScheme.backgroundColor;
  } else {
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.view.backgroundColor = colorScheme.backgroundColor;
  }

  self.chipField = [[MDCChipField alloc] initWithFrame:CGRectZero];
  self.chipField.delegate = self;
  self.chipField.textField.accessibilityIdentifier = @"chip_field_text_field";
  self.chipField.textField.placeholderLabel.text = @"This is a chip field.";
  self.chipField.textField.mdc_adjustsFontForContentSizeCategory = YES;
  if (self.containerScheme.colorScheme) {
    self.chipField.backgroundColor = self.containerScheme.colorScheme.surfaceColor;
  } else {
    MDCSemanticColorScheme *colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.chipField.backgroundColor = colorScheme.surfaceColor;
  }
  [self.view addSubview:self.chipField];

  // When Dynamic Type changes we need to invalidate the collection view layout in order to let the
  // cells change their dimensions because our chips use manual layout.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self updateLayout];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [self updateLayout];
}

- (void)updateLayout {
  CGRect frame = CGRectInset(self.view.bounds, 10, 10);
  if (@available(iOS 11.0, *)) {
    frame = UIEdgeInsetsInsetRect(frame, self.view.safeAreaInsets);
  }
  MDCChipView *chip = self.chipField.chips.lastObject;
  [self recomputeChipFieldChipHeightWithChip:chip];
  frame.size = [self.chipField sizeThatFits:frame.size];
  self.chipField.frame = frame;
}

- (void)chipFieldHeightDidChange:(MDCChipField *)chipField {
  [self.view layoutIfNeeded];
}

- (void)chipField:(MDCChipField *)chipField didAddChip:(MDCChipView *)chip {
  // Every other chip is stroked
  if (chipField.chips.count % 2) {
    [chip applyOutlinedThemeWithScheme:self.containerScheme];
  } else {
    [chip applyThemeWithScheme:self.containerScheme];
  }
  chip.mdc_adjustsFontForContentSizeCategory = YES;
  [self recomputeChipFieldChipHeightWithChip:chip];

  CGFloat chipVerticalInset = MIN(0, (CGRectGetHeight(chip.bounds) - 48) / 2);
  chip.hitAreaInsets = UIEdgeInsetsMake(chipVerticalInset, 0, chipVerticalInset, 0);
}

- (void)recomputeChipFieldChipHeightWithChip:(MDCChipView *)chip {
  [chip sizeToFit];
  if (chip.frame.size.height > 0) {
    self.chipField.chipHeight = chip.frame.size.height;
  }
}

@end

@implementation ChipsInputExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Chips", @"Input" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end
