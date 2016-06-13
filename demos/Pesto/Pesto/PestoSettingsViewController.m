/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "PestoSettingsViewController.h"

#import "MaterialAppBar.h"
#import "MaterialSwitch.h"
#import "MaterialTypography.h"

static NSString *const kPestoSettingsTableViewCellReuseIdentifier = @"PestoSettingsTableViewCell";
static NSString *const kPestoSettingsTableViewHeaderViewReuseIdentifier =
    @"PestoSettingsTableViewHeaderView";

static CGFloat kPestoSettingsTableViewHeaderSeparatorWidth = 1.f;

@interface PestoSettingsTableViewCell : UITableViewCell

@property(nonatomic, copy) NSString *labelText;
@property(nonatomic) BOOL on;

@end

@interface PestoSettingsTableViewCell ()

@property(nonatomic) MDCSwitch *switchView;

@end

@implementation PestoSettingsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.font = [MDCTypography body1Font];
    self.textLabel.alpha = [MDCTypography body1FontOpacity];

    _switchView = [[MDCSwitch alloc] initWithFrame:CGRectZero];
    _switchView.onTintColor = [UIColor colorWithRed:0.09f green:0.54f blue:0.44f alpha:1.f];
    self.accessoryView = _switchView;
  }
  return self;
}

- (void)setLabelText:(NSString *)labelText {
  _labelText = [labelText copy];
  self.textLabel.text = _labelText;
}

- (void)setOn:(BOOL)on {
  _on = on;
  self.switchView.on = on;
}

@end

@interface PestoSettingsTableViewHeaderView : UITableViewHeaderFooterView

@property(nonatomic) UIColor *separatorColor;

@end

@interface PestoSettingsTableViewHeaderView ()

@property(nonatomic) CALayer *separator;

@end

@implementation PestoSettingsTableViewHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithReuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.font = [MDCTypography headlineFont];
    self.textLabel.alpha = [MDCTypography headlineFontOpacity];
    self.textLabel.textColor = [UIColor colorWithRed:0.09f green:0.54f blue:0.44f alpha:1.f];

    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor whiteColor];

    _separator = [CALayer layer];
    [self.contentView.layer addSublayer:_separator];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat borderBottomYPos =
      CGRectGetMaxY(self.contentView.bounds) - kPestoSettingsTableViewHeaderSeparatorWidth;
  self.separator.frame = CGRectMake(0, borderBottomYPos, CGRectGetWidth(self.contentView.bounds),
                                    kPestoSettingsTableViewHeaderSeparatorWidth);
  self.backgroundView.frame = self.bounds;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
  _separatorColor = separatorColor;
  self.separator.backgroundColor = self.separatorColor.CGColor;
}

@end

@interface PestoSettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) MDCAppBar *appBar;
@property(nonatomic) NSArray *dummySettingHeaders;
@property(nonatomic) NSArray *dummySettingTitles;
@property(nonatomic) NSArray *dummySettingVals;
@property(nonatomic) UITableView *settingsTableView;

@end

@implementation PestoSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _appBar = [[MDCAppBar alloc] init];

    [self addChildViewController:_appBar.headerViewController];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  self.dummySettingHeaders = @[ @"Account", @"Notification" ];
  self.dummySettingTitles = @[
    @[ @"Public Profile", @"Subscribe to Daily Digest" ],
    @[ @"Get email notifications", @"Get text notifications" ]
  ];
  self.dummySettingVals = @[ @[ @YES, @NO ], @[ @NO, @YES ] ];

  CGRect settingsTableViewFrame =
      CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
  self.settingsTableView =
      [[UITableView alloc] initWithFrame:settingsTableViewFrame style:UITableViewStylePlain];
  self.settingsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.settingsTableView.allowsSelection = NO;
  self.settingsTableView.backgroundColor = self.view.backgroundColor;
  self.settingsTableView.dataSource = self;
  self.settingsTableView.delegate = self;
  self.settingsTableView.separatorColor = [[self class] tableViewSeparatorColor];
  // Ensure empty rows are not shown.
  self.settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

  [self.settingsTableView registerClass:[PestoSettingsTableViewCell class]
                 forCellReuseIdentifier:kPestoSettingsTableViewCellReuseIdentifier];
  [self.settingsTableView registerClass:[PestoSettingsTableViewHeaderView class]
      forHeaderFooterViewReuseIdentifier:kPestoSettingsTableViewHeaderViewReuseIdentifier];

  [self.settingsTableView reloadData];

  [self.view addSubview:self.settingsTableView];

  [self.appBar addSubviewsToParent];
  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1.f];
  self.appBar.headerViewController.view.backgroundColor = teal;
  self.appBar.headerViewController.headerView.trackingScrollView = self.settingsTableView;
  self.appBar.headerViewController.headerView.tintColor = [UIColor whiteColor];
}

+ (UIColor *)tableViewSeparatorColor {
  return [UIColor colorWithWhite:0 alpha:0.1f];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return (NSInteger)[self.dummySettingHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return (NSInteger)[(NSArray *)self.dummySettingTitles[(NSUInteger)section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *settingLabel =
      self.dummySettingTitles[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];

  PestoSettingsTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:kPestoSettingsTableViewCellReuseIdentifier
                                      forIndexPath:indexPath];
  cell.labelText = settingLabel;
  cell.on =
      [self.dummySettingVals[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row] boolValue];

  return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  NSString *reuseId = kPestoSettingsTableViewHeaderViewReuseIdentifier;
  PestoSettingsTableViewHeaderView *header =
      [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
  header.textLabel.text = _dummySettingHeaders[(NSUInteger)section];
  header.separatorColor = [[self class] tableViewSeparatorColor];
  return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 50;
}

- (void)tableView:(UITableView *)tableView
      willDisplayCell:(nonnull UITableViewCell *)cell
    forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    [cell setSeparatorInset:UIEdgeInsetsZero];
  }

  if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.preservesSuperviewLayoutMargins = NO;
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidScroll];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView trackingScrollViewDidEndDecelerating];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView
        trackingScrollViewDidEndDraggingWillDecelerate:decelerate];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  if (scrollView == self.appBar.headerViewController.headerView.trackingScrollView) {
    [self.appBar.headerViewController.headerView
        trackingScrollViewWillEndDraggingWithVelocity:velocity
                                  targetContentOffset:targetContentOffset];
  }
}
@end
