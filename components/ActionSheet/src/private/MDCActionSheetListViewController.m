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
#import "MDCActionSheetItemView.h"
#import "MaterialTypography.h"

static const CGFloat kVerticalLabelPadding = 18.f;

@interface MDCActionSheetAction ()

@end

@interface MDCActionSheetListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MDCActionSheetListViewController {
  NSArray<MDCActionSheetAction *> *_actions;
  NSString *_title;
  UIFont *_font;
}

- (instancetype)initWithTitle:(NSString *) title
                      actions:(NSArray<MDCActionSheetAction *> *)actions {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    _title = title;
    _actions = actions;
    [self commonMDCActionSheetListInit];
  }
  return self;
}

-(void)commonMDCActionSheetListInit {
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.scrollEnabled = NO;
  [self updateFonts];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return floor((kVerticalLabelPadding * 2) + _font.lineHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  MDCACtionSheetHeaderView *header = [[MDCACtionSheetHeaderView alloc] initWithTitle:_title];
  header.font = _font;
  return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetAction *action = _actions[indexPath.row];
  [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void) {
    if (action.completionHandler) {
      action.completionHandler(action);
    }
  }];
}

#pragma mark - Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetItemView *cell = [MDCActionSheetItemView cellWithAction:_actions[indexPath.row]];
  cell.font = _font;
  return cell;
}

#pragma mark - Dynamic type

- (BOOL)mdc_adjustFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateFonts];
  [self.view setNeedsLayout];
}

-(void)updateFonts {
  UIFont *finalFont = _font ?: [[self class] font];
  if (_mdc_adjustsFontForContentSizeCategory) {
    finalFont =
        [finalFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  _font = finalFont;
  [self.view setNeedsLayout];
}

+ (UIFont *)font {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  }
  return [MDCTypography subheadFont];
}


@end
