// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCTypographySchemeFontListExampleViewController.h"

#import "MDCSemanticColorScheme.h"
#import "MDCTypographyScheme.h"

@interface HairlineSeparatorView : UITableViewCell

@end

@implementation HairlineSeparatorView

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect contentBounds = UIEdgeInsetsInsetRect(CGRectStandardize(self.contentView.bounds),
                                               UIEdgeInsetsMake(0, 16, 0, 16));
  self.contentView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  if (CGRectGetHeight(contentBounds) < (CGFloat)0.01) {
    contentBounds = CGRectMake(CGRectGetMinX(contentBounds), CGRectGetMinY(contentBounds),
                               CGRectGetWidth(contentBounds), CGRectGetHeight(self.bounds));
  }
  self.contentView.bounds = contentBounds;
}

@end

@interface MDCTypographySchemeFontListExampleViewController ()
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@implementation MDCTypographySchemeFontListExampleViewController

static NSArray<NSString *> *DemonstrationStrings(void) {
  static NSArray<NSString *> *kDemonstrationStrings;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    kDemonstrationStrings =
        @[ @"The quick brown fox jumps over the lazy dog.", @"1234567890,.';\"´`˜ˆ…" ];
  });
  return kDemonstrationStrings;
}

static NSArray<NSString *> *FontStyleNames(void) {
  static NSArray<NSString *> *kFontStyleNameStrings;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    kFontStyleNameStrings = @[
      @"Headline 1",
      @"Headline 2",
      @"Headline 3",
      @"Headline 4",
      @"Headline 5",
      @"Headline 6",
      @"Subtitle 1",
      @"Subtitle 2",
      @"Body 1",
      @"Body 2",
      @"BUTTON",
      @"Caption",
      @"OVERLINE",
    ];
  });
  return kFontStyleNameStrings;
}

static NSArray<UIFont *> *Fonts(void) {
  static NSArray<UIFont *> *kTypeFonts;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    MDCTypographyScheme *scheme =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
    kTypeFonts = @[
      scheme.headline1,
      scheme.headline2,
      scheme.headline3,
      scheme.headline4,
      scheme.headline5,
      scheme.headline6,
      scheme.subtitle1,
      scheme.subtitle2,
      scheme.body1,
      scheme.body2,
      scheme.button,
      scheme.caption,
      scheme.overline,
    ];
  });
  return kTypeFonts;
}

- (instancetype)init {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return (NSInteger)Fonts().count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return (NSInteger)DemonstrationStrings().count;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 38;
  self.tableView.sectionFooterHeight = 1 / UIScreen.mainScreen.scale;
  self.tableView.backgroundColor = self.colorScheme.backgroundColor;

  [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
  [self.tableView registerClass:[HairlineSeparatorView class] forCellReuseIdentifier:@"footer"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

  cell.textLabel.text = DemonstrationStrings()[indexPath.row];
  cell.textLabel.font = Fonts()[indexPath.section];
  cell.textLabel.numberOfLines = 3;
  MDCTypographyScheme *scheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  if ([cell.textLabel.font isEqual:scheme.button] ||
      [cell.textLabel.font isEqual:scheme.overline]) {
    cell.textLabel.text = [cell.textLabel.text uppercaseString];
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView
      willDisplayCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
  cell.textLabel.textColor = self.colorScheme.onSurfaceColor;
  cell.textLabel.backgroundColor = self.colorScheme.surfaceColor;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return FontStyleNames()[section];
}

- (void)tableView:(UITableView *)tableView
    willDisplayHeaderView:(UIView *)view
               forSection:(NSInteger)section {
  if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textColor = UIColor.blackColor;
    headerView.textLabel.text = FontStyleNames()[section];
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  if (section == (NSInteger)FontStyleNames().count - 1) {
    return nil;
  }
  HairlineSeparatorView *footer =
      (HairlineSeparatorView *)[tableView dequeueReusableCellWithIdentifier:@"footer"];
  footer.contentView.backgroundColor =
      [self.colorScheme.onBackgroundColor colorWithAlphaComponent:(CGFloat)0.12];
  return footer;
}

@end

#pragma mark - Catalog by convention
@implementation MDCTypographySchemeFontListExampleViewController (CatlogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Typography", @"TypographyScheme" ],
    @"description" : @"The Typography component provides methods for displaying text using the "
                     @"type sizes and opacities from the Material Design specifications.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
