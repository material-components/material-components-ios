/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MDCActionSheetListViewController.h"

#import "MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetController.h"
#import "MaterialTypography.h"

NSString *const kReuseIdentifier = @"BaseCell";
static const CGFloat kActionItemLabelPadding = 18.f;
static const CGFloat kActionItemTrailingPadding = 16.f;

@interface MDCActionSheetListViewController () <UITableViewDataSource>
@end

@implementation MDCActionSheetListViewController {
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                      actions:(NSArray<MDCActionSheetAction *> *)actions {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.actions = [NSMutableArray arrayWithArray:[actions copy]];
    [self commonMDCActionSheetListInit];
  }
  return self;
}

- (instancetype)initWithTitle:(nullable NSString *) title
                      actions:(NSArray<MDCActionSheetAction *> *)actions {
  return [[MDCActionSheetListViewController alloc] initWithTitle:title
                                                         message:nil
                                                         actions:actions];
}

- (void)commonMDCActionSheetListInit {
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.scrollEnabled = NO;
  self.tableView.dataSource = self;
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.actionsFont = [[self class] actionsFontDefault];
  [self.tableView registerClass:[MDCActionSheetItemTableViewCell class]
         forCellReuseIdentifier:kReuseIdentifier];
  self.backgroundColor = [UIColor whiteColor];
}

- (void)addAction:(MDCActionSheetAction *)action {
  [self.actions addObject:action];
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetItemTableViewCell *cell =
  [[MDCActionSheetItemTableViewCell alloc] initWithAction:self.actions[indexPath.row]
                                 reuseIdentifier:kReuseIdentifier];
  cell.backgroundColor = self.backgroundColor;
  cell.actionsFont = _actionsFont;
  return cell;
}

#pragma mark - Dynamic type

+ (UIFont *)actionsFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  }
  return [MDCTypography subheadFont];
}

- (BOOL)mdc_adjustFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateFonts];
}


- (void)updateFonts {
  UIFont *finalFont = _actionsFont ?: [[self class] actionsFontDefault];
  if (_mdc_adjustsFontForContentSizeCategory) {
    finalFont =
        [finalFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                              scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  _actionsFont = finalFont;
  [self.tableView reloadData];
  [self.view setNeedsLayout];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  self.view.backgroundColor = backgroundColor;
  self.tableView.backgroundColor = backgroundColor;
  [self.view setNeedsLayout];
}

- (UIColor *)backgroundColor {
  return self.view.backgroundColor;
}

#pragma mark - Setters / Getters

- (void)setActionsFont:(UIFont *)actionsFont {
  _actionsFont = actionsFont;
  [self updateFonts];
}

- (CGFloat)tableHeightForWidth:(CGFloat)width {
  CGFloat height = 0.f;
  UILabel *mockLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  mockLabel.font = _actionsFont;
  for (MDCActionSheetAction *action in _actions) {
    CGFloat leadingPadding = (action.image == nil) ? 16.f : 72.f;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.hyphenationFactor = 1.f;
    NSDictionary<NSAttributedStringKey, id> *attributes =
        @{ NSParagraphStyleAttributeName : paragraphStyle };
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:action.title attributes:attributes];
    mockLabel.attributedText = attributedString;
    CGSize labelSize = CGRectInfinite.size;
    labelSize.width = width - kActionItemTrailingPadding - leadingPadding;

    CGFloat labelHeight = [mockLabel sizeThatFits:labelSize].height;
    height = height + labelHeight + (2 * kActionItemLabelPadding);
  }
  return height;
}

@end
