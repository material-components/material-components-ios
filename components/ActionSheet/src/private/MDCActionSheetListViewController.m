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

@interface MDCActionSheetAction ()

@end

@interface MDCActionSheetListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, nullable) NSString *title;
@property (nonatomic, nullable) NSString *message;

@end

@implementation MDCActionSheetListViewController {
  NSArray<MDCActionSheetAction *> *_actions;
}

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                      actions:(NSArray<MDCActionSheetAction *> *)actions {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    _title = title;
    _message = message;
    _actions = actions;
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

-(void)commonMDCActionSheetListInit {
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.scrollEnabled = NO;
  self.tableView.dataSource = self;
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.tableView.estimatedRowHeight = 56;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedSectionHeaderHeight = 56;
  [self updateFonts];
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  MDCActionSheetHeaderView *header = [[MDCActionSheetHeaderView alloc] initWithTitle:_title];
  header.font = _titleFont;
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

+ (UIFont *)font {
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
  [self.view setNeedsLayout];
}

/*-(void)updateFonts {
  UIFont *finalFont = _font ?: [[self class] font];
  if (_mdc_adjustsFontForContentSizeCategory) {
    finalFont =
        [finalFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                              scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  _font = finalFont;
  [self.view setNeedsLayout];
}*/

- (void)setTitle:(NSString *)title {
  if (_title != title) {
    _title = title;
    _header.title = title;
    [self.view setNeedsLayout];
  }
}

- (NSString *)title {
  return _header.title;
}

@end
