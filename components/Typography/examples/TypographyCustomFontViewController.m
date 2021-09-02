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

#import "TypographyCustomFontViewController.h"

#import "MaterialTypography.h"

@implementation TypographyCustomFontViewController {
  NSArray<NSString *> *_strings;
  NSArray<NSString *> *_styleNames;
  NSArray<UIFont *> *_styleFonts;
}

static inline UIFont *customFont(MDCFontTextStyle style) {
  UIFontDescriptor *descriptor =
      [UIFontDescriptor mdc_preferredFontDescriptorForMaterialTextStyle:style];
  descriptor = [descriptor fontDescriptorWithFamily:@"American Typewriter"];
  UIFont *font = [UIFont fontWithDescriptor:descriptor size:descriptor.pointSize];
  return font;
};

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 50.0;
  _strings = @[ @"ABCDEFGHIJKLMNOPQRSTUVWXYZ", @"abcdefghijklmnopqrstuvwxyz", @"0123456789" ];

  _styleNames = @[
    // Common UI fonts.
    @"Headline Font", @"Title Font", @"Subhead Font", @"Body 2 Font", @"Body 1 Font",
    @"Caption Font", @"Button Font",

    // Display fonts (extra large fonts)
    @"Display 1 Font", @"Display 2 Font", @"Display 3 Font", @"Display 4 Font"
  ];

  _styleFonts = @[
    customFont(MDCFontTextStyleHeadline), customFont(MDCFontTextStyleTitle),
    customFont(MDCFontTextStyleSubheadline), customFont(MDCFontTextStyleBody2),
    customFont(MDCFontTextStyleBody1), customFont(MDCFontTextStyleCaption),
    customFont(MDCFontTextStyleButton), customFont(MDCFontTextStyleDisplay1),
    customFont(MDCFontTextStyleDisplay2), customFont(MDCFontTextStyleDisplay3),
    customFont(MDCFontTextStyleDisplay4)
  ];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  // Update font array to reflect new size category
  _styleFonts = @[
    customFont(MDCFontTextStyleHeadline), customFont(MDCFontTextStyleTitle),
    customFont(MDCFontTextStyleSubheadline), customFont(MDCFontTextStyleBody2),
    customFont(MDCFontTextStyleBody1), customFont(MDCFontTextStyleCaption),
    customFont(MDCFontTextStyleButton), customFont(MDCFontTextStyleDisplay1),
    customFont(MDCFontTextStyleDisplay2), customFont(MDCFontTextStyleDisplay3),
    customFont(MDCFontTextStyleDisplay4)
  ];

  [self.tableView reloadData];
}

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
    cell.textLabel.text = @"ABCD";
  }

  cell.detailTextLabel.text = _styleNames[indexPath.row];
  cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];

  cell.selectionStyle = UITableViewCellSelectionStyleNone;

  return cell;
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Typography and Fonts", @"Custom Font Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
