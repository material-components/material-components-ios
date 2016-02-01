#import "PestoSettingsViewController.h"

#import "MaterialSwitch.h"
#import "MaterialTypography.h"

static CGFloat kPestoSettingsTableViewOffsetTop = 10.f;

static NSString *const kPestoSettingsTableViewCellReuseIdentifier = @"PestoSettingsTableViewCell";
static NSString *const kPestoSettingsTableViewHeaderViewReuseIdentifier =
    @"PestoSettingsTableViewHeaderView";

static CGFloat kPestoSettingsTableViewHeaderSeparatorWidth = 1.f;

@interface PestoSettingsTableViewCell : UITableViewCell

@property(nonatomic) NSString *labelText;
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
  _labelText = labelText;
  self.textLabel.text = _labelText;
}

- (void)setOn:(BOOL)on {
  _on = on;
  _switchView.on = on;
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
  CGFloat borderBottomYPos = CGRectGetMaxY(self.contentView.bounds) -
                             kPestoSettingsTableViewHeaderSeparatorWidth;
  _separator.frame = CGRectMake(0,
                                borderBottomYPos,
                                CGRectGetWidth(self.contentView.bounds),
                                kPestoSettingsTableViewHeaderSeparatorWidth);
  self.backgroundView.frame = self.bounds;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
  _separatorColor = separatorColor;
  _separator.backgroundColor = _separatorColor.CGColor;
}

@end

@interface PestoSettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) NSArray *dummySettingHeaders;
@property(nonatomic) NSArray *dummySettingTitles;
@property(nonatomic) NSArray *dummySettingVals;
@property(nonatomic) UITableView *settingsTableView;

@end

@implementation PestoSettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _dummySettingHeaders = @[ @"Account", @"Notification" ];
  _dummySettingTitles = @[ @[ @"Public Profile", @"Subscribe to Daily Digest" ],
                           @[ @"Get email notifications", @"Get text notifications" ] ];
  _dummySettingVals = @[ @[ @YES, @NO ], @[ @NO, @YES ] ];

  CGRect settingsTableViewFrame =
      CGRectMake(0,
                 kPestoSettingsTableViewOffsetTop,
                 self.view.bounds.size.width,
                 self.view.bounds.size.height - kPestoSettingsTableViewOffsetTop);
  _settingsTableView = [[UITableView alloc] initWithFrame:settingsTableViewFrame
                                                    style:UITableViewStylePlain];
  _settingsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _settingsTableView.allowsSelection = NO;
  _settingsTableView.backgroundColor = self.view.backgroundColor;
  _settingsTableView.dataSource = self;
  _settingsTableView.delegate = self;
  _settingsTableView.separatorColor = [[self class] tableViewSeparatorColor];
  // Ensure empty rows are not shown.
  _settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

  [_settingsTableView registerClass:[PestoSettingsTableViewCell class]
             forCellReuseIdentifier:kPestoSettingsTableViewCellReuseIdentifier];
  [_settingsTableView registerClass:[PestoSettingsTableViewHeaderView class]
      forHeaderFooterViewReuseIdentifier:kPestoSettingsTableViewHeaderViewReuseIdentifier];

  [_settingsTableView reloadData];

  [self.view addSubview:_settingsTableView];
}

+ (UIColor *)tableViewSeparatorColor {
  return [UIColor colorWithWhite:0.f alpha:0.1f];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [_dummySettingHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [(NSArray *)_dummySettingTitles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *settingLabel = _dummySettingTitles[indexPath.section][indexPath.row];
  PestoSettingsTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:kPestoSettingsTableViewCellReuseIdentifier
                                      forIndexPath:indexPath];
  cell.labelText = settingLabel;
  cell.on = [_dummySettingVals[indexPath.section][indexPath.row] boolValue];

  return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  NSString *reuseId = kPestoSettingsTableViewHeaderViewReuseIdentifier;
  PestoSettingsTableViewHeaderView *header =
      [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
  header.textLabel.text = _dummySettingHeaders[section];
  header.separatorColor = [[self class] tableViewSeparatorColor];
  return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 50.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell
forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    [cell setSeparatorInset:UIEdgeInsetsZero];
  }

  if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.preservesSuperviewLayoutMargins = NO;
  }
}

@end
