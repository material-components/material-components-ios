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

#import "MDCChipField.h"
#import "MDCChipFieldDelegate.h"
#import "MDCChipView.h"
#import "MDCChipView+MaterialTheming.h"
#import "MDCContainerScheme.h"
#import "MDCTypographyScheme.h"

@interface ChipsInputExampleViewController : UIViewController <MDCChipFieldDelegate>
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
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

  MDCTypographyScheme *typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  typographyScheme.useCurrentContentSizeCategoryWhenApplied = YES;
  self.containerScheme.typographyScheme = typographyScheme;

  self.view.backgroundColor = UIColor.systemBackgroundColor;

  self.chipField = [[MDCChipField alloc] initWithFrame:CGRectZero];
  self.chipField.delegate = self;
  self.chipField.textField.accessibilityIdentifier = @"chip_field_text_field";
  NSDictionary<NSString *, id> *placeholderAttributes =
      @{NSForegroundColorAttributeName : UIColor.placeholderTextColor};
  self.chipField.placeholderAttributes = placeholderAttributes;
  self.chipField.placeholder = @"This is a chip field.";
  self.chipField.textField.adjustsFontForContentSizeCategory = YES;
  self.chipField.backgroundColor = UIColor.systemBackgroundColor;
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
  frame = UIEdgeInsetsInsetRect(frame, self.view.safeAreaInsets);
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
