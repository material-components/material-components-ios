// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "TypographyMaterialScalableStylesViewController.h"

#import "MaterialTypography.h"
#import "MaterialTypographyScheme.h"

@implementation TypographyMaterialScalableStyleViewController {
  NSArray<NSString *> *_strings;
  NSArray<NSString *> *_styleNames;
  NSArray<UIFont *> *_styleFonts;
  MDCTypographyScheme *_typography;
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
    // Material Font Styles
    @"Body1",     @"Body1 (Scalable)",     @"Body2",     @"Body2 (Scalable)",
    @"Caption",   @"Caption (Scalable)",   @"Button",    @"Button (Scalable)",
    @"Overline",  @"Overline (Scalable)",  @"Subtitle1", @"Subtitle1 (Scalable)",
    @"Subtitle2", @"Subtitle2 (Scalable)", @"Headline1", @"Headline1 (Scalable)",
    @"Headline2", @"Headline2 (Scalable)", @"Headline3", @"Headline3 (Scalable)",
    @"Headline4", @"Headline4 (Scalable)", @"Headline5", @"Headline5 (Scalable)",
    @"Headline6", @"Headline6 (Scalable)",
  ];

  _typography =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];

  _styleFonts = @[
    [_typography.body1 mdc_scaledFontAtDefaultSize],
    [_typography.body1 mdc_scaledFontForCurrentSizeCategory],
    [_typography.body2 mdc_scaledFontAtDefaultSize],
    [_typography.body2 mdc_scaledFontForCurrentSizeCategory],
    [_typography.caption mdc_scaledFontAtDefaultSize],
    [_typography.caption mdc_scaledFontForCurrentSizeCategory],
    [_typography.button mdc_scaledFontAtDefaultSize],
    [_typography.button mdc_scaledFontForCurrentSizeCategory],
    [_typography.overline mdc_scaledFontAtDefaultSize],
    [_typography.overline mdc_scaledFontForCurrentSizeCategory],
    [_typography.subtitle1 mdc_scaledFontAtDefaultSize],
    [_typography.subtitle1 mdc_scaledFontForCurrentSizeCategory],
    [_typography.subtitle2 mdc_scaledFontAtDefaultSize],
    [_typography.subtitle2 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline1 mdc_scaledFontAtDefaultSize],
    [_typography.headline1 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline2 mdc_scaledFontAtDefaultSize],
    [_typography.headline2 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline3 mdc_scaledFontAtDefaultSize],
    [_typography.headline3 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline4 mdc_scaledFontAtDefaultSize],
    [_typography.headline4 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline5 mdc_scaledFontAtDefaultSize],
    [_typography.headline5 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline6 mdc_scaledFontAtDefaultSize],
    [_typography.headline6 mdc_scaledFontForCurrentSizeCategory],
  ];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  NSString *sizeCategory = notification.userInfo[UIContentSizeCategoryNewValueKey];
  NSLog(@"New size category : %@", sizeCategory);

  // Update font array to reflect new size category
  _styleFonts = @[
    [_typography.body1 mdc_scaledFontAtDefaultSize],
    [_typography.body1 mdc_scaledFontForCurrentSizeCategory],
    [_typography.body2 mdc_scaledFontAtDefaultSize],
    [_typography.body2 mdc_scaledFontForCurrentSizeCategory],
    [_typography.caption mdc_scaledFontAtDefaultSize],
    [_typography.caption mdc_scaledFontForCurrentSizeCategory],
    [_typography.button mdc_scaledFontAtDefaultSize],
    [_typography.button mdc_scaledFontForCurrentSizeCategory],
    [_typography.overline mdc_scaledFontAtDefaultSize],
    [_typography.overline mdc_scaledFontForCurrentSizeCategory],
    [_typography.subtitle1 mdc_scaledFontAtDefaultSize],
    [_typography.subtitle1 mdc_scaledFontForCurrentSizeCategory],
    [_typography.subtitle2 mdc_scaledFontAtDefaultSize],
    [_typography.subtitle2 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline1 mdc_scaledFontAtDefaultSize],
    [_typography.headline1 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline2 mdc_scaledFontAtDefaultSize],
    [_typography.headline2 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline3 mdc_scaledFontAtDefaultSize],
    [_typography.headline3 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline4 mdc_scaledFontAtDefaultSize],
    [_typography.headline4 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline5 mdc_scaledFontAtDefaultSize],
    [_typography.headline5 mdc_scaledFontForCurrentSizeCategory],
    [_typography.headline6 mdc_scaledFontAtDefaultSize],
    [_typography.headline6 mdc_scaledFontForCurrentSizeCategory],
  ];

  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return _strings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _styleNames.count;
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

  NSString *detail = [NSString
      stringWithFormat:@"%@ @ %.0f pt", _styleNames[indexPath.row], cell.textLabel.font.pointSize];
  cell.detailTextLabel.text = detail;
  cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];

  cell.selectionStyle = UITableViewCellSelectionStyleNone;

  return cell;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Typography and Fonts", @"Material Scalable Font Styles" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
