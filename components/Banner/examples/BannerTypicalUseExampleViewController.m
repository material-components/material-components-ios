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

#import "BannerTypicalUseExampleViewController.h"

#import "MDCButton.h"
#import "MDCTypography.h"
#import "MaterialColorScheme.h"
#import "supplemental/MDCBannerView.h"

static const CGFloat exampleListTableViewHeight = 300.0f;
static const CGFloat exampleBannerContentMultiLineWidth = 320.0f;
static const CGFloat exampleBannerContentSingleLineWidth = 350.0f;
static NSString *const exampleShortText = @"tristique senectus et";
static NSString *const exampleLongText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.";
static NSString *const exampleExtraLongText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
    @"labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat. Non pulvinar neque "
    @"laoreet suspendisse interdum.";

@interface BannerExampleUseInfo : NSObject

@property(nonatomic, readonly, copy) NSString *identifier;
@property(nonatomic, readonly, copy) NSString *displayName;
@property(nonatomic, readonly, weak) id exampleUseTarget;
@property(nonatomic, readonly, assign) SEL exampleUseSelector;

- (instancetype)init NS_UNAVAILABLE;

+ (BannerExampleUseInfo *)infoWithIdentifier:(NSString *)identifier
                                 displayName:(NSString *)displayName
                            exampleUseTarget:(id)exampleUseTarget
                          exampleUseSelector:(SEL)exampleUseSelector;

@end

@implementation BannerExampleUseInfo

- (instancetype)initWithIdentifier:(NSString *)identifier
                       displayName:(NSString *)displayName
                  exampleUseTarget:(id)exampleUseTarget
                exampleUseSelector:(SEL)exampleUseSelector {
  self = [super init];
  if (self) {
    _identifier = identifier;
    _displayName = displayName;
    _exampleUseTarget = exampleUseTarget;
    _exampleUseSelector = exampleUseSelector;
  }
  return self;
}

+ (BannerExampleUseInfo *)infoWithIdentifier:(NSString *)identifier
                                 displayName:(NSString *)displayName
                            exampleUseTarget:(id)exampleUseTarget
                          exampleUseSelector:(SEL)exampleUseSelector {
  return [[BannerExampleUseInfo alloc] initWithIdentifier:identifier
                                              displayName:displayName
                                         exampleUseTarget:exampleUseTarget
                                       exampleUseSelector:exampleUseSelector];
}

@end

@interface BannerTypicalUseExampleViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *exampleListTableView;
@property(nonatomic, strong) NSArray<BannerExampleUseInfo *> *exampleList;
@property(nonatomic, weak) UIView *bannerViewContainer;
@property(nonatomic, weak) MDCBannerView *bannerView;

@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;

@end

@implementation BannerTypicalUseExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.colorScheme = [[MDCSemanticColorScheme alloc] init];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Set up example content view
  UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
  contentView.backgroundColor = self.colorScheme.secondaryColor;
  UILabel *contentViewLabel = [[UILabel alloc] init];
  [contentView addSubview:contentViewLabel];
  contentViewLabel.text = @"Content View";
  [contentViewLabel sizeToFit];
  contentViewLabel.center = contentView.center;
  [self.view addSubview:contentView];

  // Set up example list table view
  self.exampleList = [self getBannerExampleList];
  CGRect exampleListTableViewFrame =
      CGRectMake(0, self.view.bounds.size.height - exampleListTableViewHeight,
                 self.view.bounds.size.width, exampleListTableViewHeight);
  UITableView *exampleListTableView = [[UITableView alloc] initWithFrame:exampleListTableViewFrame
                                                                   style:UITableViewStylePlain];
  [self.view addSubview:exampleListTableView];
  self.exampleListTableView = exampleListTableView;
  exampleListTableView.dataSource = self;
  exampleListTableView.delegate = self;
  [self.exampleListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Banner", @"Banner" ],
    @"primaryDemo" : @YES,
    @"presentable" : @NO,
  };
}

#pragma mark - Internal helpers

- (NSArray<BannerExampleUseInfo *> *)getBannerExampleList {
  NSMutableArray *bannerExampleList = [[NSMutableArray alloc] init];
  BannerExampleUseInfo *exampleUseInfo1 =
      [BannerExampleUseInfo infoWithIdentifier:@"example1"
                                   displayName:@"Single Line"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showSingleLineStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo1];

  BannerExampleUseInfo *exampleUseInfo2 =
      [BannerExampleUseInfo infoWithIdentifier:@"example2"
                                   displayName:@"MultiLine Aligned Button"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultiLineAlignedButtonStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo2];

  BannerExampleUseInfo *exampleUseInfo3 =
      [BannerExampleUseInfo infoWithIdentifier:@"example3"
                                   displayName:@"MultiLine Stacked Button"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultiLineStackedButtonStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo3];

  return [bannerExampleList copy];
}

#pragma mark - Example handlers

- (void)showSingleLineStyleBanner {
  if (self.bannerViewContainer) {
    [self.bannerViewContainer removeFromSuperview];
  }
  // Set up banner view container
  UIView *bannerViewContainer = [[UIView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:bannerViewContainer];
  bannerViewContainer.backgroundColor = [UIColor whiteColor];
  self.bannerViewContainer = bannerViewContainer;

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.image = [UIImage imageNamed:@"Email"];
  bannerView.text = exampleShortText;

  MDCButton *button = [bannerView.buttons firstObject];
  [button setTitle:@"DISMISS" forState:UIControlStateNormal];
  UIFont *buttonFont = [MDCTypography body2Font];
  [button setTitleFont:buttonFont forState:UIControlStateNormal];
  [button setTitleFont:buttonFont forState:UIControlStateHighlighted];
  [button setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  button.backgroundColor = self.colorScheme.surfaceColor;

  [self.bannerViewContainer addSubview:bannerView];
  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
  CGSize bannerViewSize =
      [bannerView sizeThatFits:CGSizeMake(exampleBannerContentSingleLineWidth, CGFLOAT_MAX)];
  bannerView.frame = CGRectMake(0.0f, 0.0f, bannerViewSize.width, bannerViewSize.height);

  // Adjust bannerViewContainer's frame
  self.bannerViewContainer.frame =
      CGRectMake(0.0f, self.view.safeAreaInsets.top, [UIScreen mainScreen].bounds.size.width,
                 bannerViewSize.height);
  bannerView.center = CGPointMake(self.bannerViewContainer.frame.size.width / 2,
                                  self.bannerViewContainer.frame.size.height / 2);
}

- (void)showMultiLineAlignedButtonStyleBanner {
  if (self.bannerViewContainer) {
    [self.bannerViewContainer removeFromSuperview];
  }
  // Set up banner view container
  UIView *bannerViewContainer = [[UIView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:bannerViewContainer];
  bannerViewContainer.backgroundColor = [UIColor whiteColor];
  self.bannerViewContainer = bannerViewContainer;

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.text = exampleLongText;
  bannerView.image = [UIImage imageNamed:@"Email"];
  bannerView.numberOfButtons = 2;

  UIFont *buttonFont = [MDCTypography body2Font];
  MDCButton *dismissButton = bannerView.buttons[0];
  [dismissButton setTitle:@"DISMISS" forState:UIControlStateNormal];
  [dismissButton setTitleFont:buttonFont forState:UIControlStateNormal];
  [dismissButton setTitleFont:buttonFont forState:UIControlStateHighlighted];
  [dismissButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  dismissButton.backgroundColor = self.colorScheme.surfaceColor;
  [dismissButton sizeToFit];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = bannerView.buttons[1];
  [changeTextButton setTitle:@"CHANGE TEXT" forState:UIControlStateNormal];
  [changeTextButton setTitleFont:buttonFont forState:UIControlStateNormal];
  [changeTextButton setTitleFont:buttonFont forState:UIControlStateHighlighted];
  [changeTextButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  changeTextButton.backgroundColor = self.colorScheme.surfaceColor;
  [changeTextButton sizeToFit];
  [changeTextButton addTarget:self
                       action:@selector(changeText)
             forControlEvents:UIControlEventTouchUpInside];

  self.bannerView = bannerView;
  [self.bannerViewContainer addSubview:bannerView];
  CGSize bannerViewSize =
      [bannerView sizeThatFits:CGSizeMake(exampleBannerContentMultiLineWidth, CGFLOAT_MAX)];
  bannerView.frame = CGRectMake(0.0f, 0.0f, bannerViewSize.width, bannerViewSize.height);

  // Adjust bannerViewContainer's frame
  self.bannerViewContainer.frame =
      CGRectMake(0.0f, self.view.safeAreaInsets.top, [UIScreen mainScreen].bounds.size.width,
                 bannerViewSize.height);
  bannerView.center = CGPointMake(self.bannerViewContainer.frame.size.width / 2,
                                  self.bannerViewContainer.frame.size.height / 2);
}

- (void)showMultiLineStackedButtonStyleBanner {
  if (self.bannerViewContainer) {
    [self.bannerViewContainer removeFromSuperview];
  }
  UIView *bannerViewContainer = [[UIView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:bannerViewContainer];
  bannerViewContainer.backgroundColor = [UIColor whiteColor];
  self.bannerViewContainer = bannerViewContainer;

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.text = exampleExtraLongText;
  bannerView.image = [UIImage imageNamed:@"Email"];
  bannerView.numberOfButtons = 2;

  UIFont *buttonFont = [MDCTypography body2Font];
  MDCButton *dismissButton = bannerView.buttons[0];
  [dismissButton setTitle:@"DISMISS" forState:UIControlStateNormal];
  [dismissButton setTitleFont:buttonFont forState:UIControlStateNormal];
  [dismissButton setTitleFont:buttonFont forState:UIControlStateHighlighted];
  [dismissButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  dismissButton.backgroundColor = self.colorScheme.surfaceColor;
  [dismissButton sizeToFit];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = bannerView.buttons[1];
  [changeTextButton setTitle:@"CHANGE EXTRA LONG TEXT" forState:UIControlStateNormal];
  [changeTextButton setTitleFont:buttonFont forState:UIControlStateNormal];
  [changeTextButton setTitleFont:buttonFont forState:UIControlStateHighlighted];
  [changeTextButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  changeTextButton.backgroundColor = self.colorScheme.surfaceColor;
  [changeTextButton sizeToFit];
  [changeTextButton addTarget:self
                       action:@selector(changeExtraLongText)
             forControlEvents:UIControlEventTouchUpInside];

  self.bannerView = bannerView;
  [self.bannerViewContainer addSubview:bannerView];
  CGSize bannerViewSize =
      [bannerView sizeThatFits:CGSizeMake(exampleBannerContentMultiLineWidth, CGFLOAT_MAX)];
  bannerView.frame = CGRectMake(0.0f, 0.0f, bannerViewSize.width, bannerViewSize.height);

  // Adjust bannerViewContainer's frame
  self.bannerViewContainer.frame =
      CGRectMake(0.0f, self.view.safeAreaInsets.top, [UIScreen mainScreen].bounds.size.width,
                 bannerViewSize.height);
  bannerView.center = CGPointMake(self.bannerViewContainer.frame.size.width / 2,
                                  self.bannerViewContainer.frame.size.height / 2);
}

- (void)dismissBanner {
  [self.bannerViewContainer removeFromSuperview];
}

- (void)changeText {
  if ([self.bannerView.text isEqualToString:exampleLongText]) {
    self.bannerView.text = exampleShortText;
  } else {
    self.bannerView.text = exampleLongText;
  }

  CGSize bannerViewSize =
      [self.bannerView sizeThatFits:CGSizeMake(exampleBannerContentMultiLineWidth, CGFLOAT_MAX)];
  self.bannerView.frame = CGRectMake(0.0f, 0.0f, bannerViewSize.width, bannerViewSize.height);

  self.bannerViewContainer.frame =
      CGRectMake(0.0f, self.view.safeAreaInsets.top, [UIScreen mainScreen].bounds.size.width,
                 bannerViewSize.height);
  self.bannerView.center = CGPointMake(self.bannerViewContainer.frame.size.width / 2,
                                       self.bannerViewContainer.frame.size.height / 2);
}

- (void)changeExtraLongText {
  if ([self.bannerView.text isEqualToString:exampleExtraLongText]) {
    self.bannerView.text = exampleShortText;
  } else {
    self.bannerView.text = exampleExtraLongText;
  }

  CGSize bannerViewSize =
      [self.bannerView sizeThatFits:CGSizeMake(exampleBannerContentMultiLineWidth, CGFLOAT_MAX)];
  self.bannerView.frame = CGRectMake(0.0f, 0.0f, bannerViewSize.width, bannerViewSize.height);

  self.bannerViewContainer.frame =
      CGRectMake(0.0f, self.view.safeAreaInsets.top, [UIScreen mainScreen].bounds.size.width,
                 bannerViewSize.height);
  self.bannerView.center = CGPointMake(self.bannerViewContainer.frame.size.width / 2,
                                       self.bannerViewContainer.frame.size.height / 2);
}

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.exampleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.exampleListTableView dequeueReusableCellWithIdentifier:@"cell"];
  BannerExampleUseInfo *bannerExampleUseInfo = self.exampleList[indexPath.row];
  cell.textLabel.text = bannerExampleUseInfo.displayName;
  return cell;
}

#pragma mark - UITableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  BannerExampleUseInfo *bannerExampleUseInfo = self.exampleList[indexPath.row];
  id target = bannerExampleUseInfo.exampleUseTarget;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  if ([target respondsToSelector:bannerExampleUseInfo.exampleUseSelector]) {
    [target performSelector:bannerExampleUseInfo.exampleUseSelector];
  }
#pragma clang diagnostic pop
}

@end
