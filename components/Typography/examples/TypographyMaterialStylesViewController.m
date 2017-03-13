/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "TypographyMaterialStylesViewController.h"

#import "MaterialTypography.h"

@implementation TypographyMaterialStyleViewController {
  NSArray<NSString *> *_strings;
  NSArray<NSString *> *_styleNames;
  NSArray<UIFont *> *_styleFonts;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 50.0;

  _strings = @[
    @"Material Design Components", @"A quick brown fox jumped over the lazy dog.",
    @"ABCDEFGHIJKLMNOPQRSTUVWXYZ", @"abcdefghijklmnopqrstuvwxyz", @"1234567890",
    @"!@#$%^&*()-=_+[]\\;',./<>?:\""
  ];

  _styleNames = @[
    // Common UI fonts.
    @"Headline Font", @"Title Font", @"Subhead Font", @"Body 2 Font", @"Body 1 Font",
    @"Caption Font", @"Button Font",

    // Display fonts (extra large fonts)
    @"Display 1 Font", @"Display 2 Font", @"Display 3 Font", @"Display 4 Font"
  ];

  _styleFonts = @[
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleHeadline],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleTitle],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleSubheadline],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody2],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleCaption],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleButton],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleDisplay1],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleDisplay2],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleDisplay3],
    [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleDisplay4]
  ];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];

  /*
  UIKIT_EXTERN const CGFloat UIFontWeightUltraLight NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightThin NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightLight NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightRegular NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightMedium NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightSemibold NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightBold NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightHeavy NS_AVAILABLE_IOS(8_2);
  UIKIT_EXTERN const CGFloat UIFontWeightBlack NS_AVAILABLE_IOS(8_2);
*/

  NSLog(@"UIFontWeightUltraLight %f", UIFontWeightUltraLight);
  NSLog(@"UIFontWeightThin %f", UIFontWeightThin);
  NSLog(@"UIFontWeightLight %f", UIFontWeightLight);
  NSLog(@"UIFontWeightRegular %f", UIFontWeightRegular);
  NSLog(@"UIFontWeightMedium %f", UIFontWeightMedium);
  NSLog(@"UIFontWeightSemibold %f", UIFontWeightSemibold);
  NSLog(@"UIFontWeightBold %f", UIFontWeightBold);
  NSLog(@"UIFontWeightHeavy %f", UIFontWeightHeavy);
  NSLog(@"UIFontWeightBlack %f", UIFontWeightBlack);
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  NSString *sizeCategory = notification.userInfo[UIContentSizeCategoryNewValueKey];
  NSLog(@"New size category : %@", sizeCategory);

  [self.tableView beginUpdates];
  [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Typography and Fonts", @"Material Font Styles" ];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return _strings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _styleFonts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"cell"];
  }
  cell.textLabel.text = _strings[indexPath.section];
  cell.textLabel.font = _styleFonts[indexPath.row];
  cell.textLabel.numberOfLines = 0;
  cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

  if (cell.textLabel.font.pointSize > 100 && indexPath.section == 0) {
    cell.textLabel.text = @"MDC";
  }

  cell.detailTextLabel.text = _styleNames[indexPath.row];
  cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];

  cell.selectionStyle = UITableViewCellSelectionStyleNone;

  return cell;
}
@end
