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

#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialTypography.h"
#import "supplemental/MDCBannerView.h"

static const CGFloat exampleListTableViewHeight = 160.0f;
static const CGFloat exampleBannerContentWidth = 350.0f;
static NSString *const exampleShortText = @"tristique senectus et";
static NSString *const exampleLongText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do incididunt.";
static NSString *const exampleExtraLongText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
    @"labore et dolore.";

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
@property(nonatomic, weak) UIView *contentView;
@property(nonatomic, weak) UILabel *contentViewLabel;
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
  self.contentViewLabel = contentViewLabel;
  self.contentView = contentView;
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

#pragma mark - UIViewController

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.contentView.frame = self.view.bounds;
  self.contentViewLabel.center = self.contentView.center;
  CGRect exampleListTableViewFrame =
      CGRectMake(0, self.view.bounds.size.height - exampleListTableViewHeight,
                 self.view.bounds.size.width, exampleListTableViewHeight);
  self.exampleListTableView.frame = exampleListTableViewFrame;

  [self.bannerView sizeToFit];

  // Adjust bannerViewContainer's frame
  CGFloat topAreaInset = 0.0f;
  if (@available(iOS 11.0, *)) {
    topAreaInset = self.view.safeAreaInsets.top;
  }

  self.bannerView.frame = CGRectMake(0.0f, topAreaInset, self.bannerView.frame.size.width,
                                     self.bannerView.frame.size.height);
}

#pragma mark - Internal helpers

- (NSArray<BannerExampleUseInfo *> *)getBannerExampleList {
  NSMutableArray *bannerExampleList = [[NSMutableArray alloc] init];
  BannerExampleUseInfo *exampleUseInfo1 =
      [BannerExampleUseInfo infoWithIdentifier:@"example1"
                                   displayName:@"Short Text with One Action"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showSingleLineStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo1];

  BannerExampleUseInfo *exampleUseInfo4 =
      [BannerExampleUseInfo infoWithIdentifier:@"example4"
                                   displayName:@"Short Text with One Action (Icon)"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showSingleLineStyleBannerWithIcon)];
  [bannerExampleList addObject:exampleUseInfo4];

  BannerExampleUseInfo *exampleUseInfo5 =
      [BannerExampleUseInfo infoWithIdentifier:@"example5"
                                   displayName:@"Long Text with Two Short Actions"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultiLineAlignedButtonStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo5];

  BannerExampleUseInfo *exampleUseInfo2 = [BannerExampleUseInfo
      infoWithIdentifier:@"example2"
             displayName:@"Long Text with Two Short Actions (Icon)"
        exampleUseTarget:self
      exampleUseSelector:@selector(showMultiLineAlignedButtonStyleBannerWithIcon)];
  [bannerExampleList addObject:exampleUseInfo2];

  BannerExampleUseInfo *exampleUseInfo6 =
      [BannerExampleUseInfo infoWithIdentifier:@"example6"
                                   displayName:@"Long Text with Two Long Actions"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultiLineStackedButtonStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo6];
  BannerExampleUseInfo *exampleUseInfo3 = [BannerExampleUseInfo
      infoWithIdentifier:@"example3"
             displayName:@"Long Text with Two Long Actions (Icon)"
        exampleUseTarget:self
      exampleUseSelector:@selector(showMultiLineStackedButtonStyleBannerWithIcon)];
  [bannerExampleList addObject:exampleUseInfo3];

  return [bannerExampleList copy];
}

#pragma mark - Example handlers

- (void)showSingleLineStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.preferredContentWidth = exampleBannerContentWidth;
  bannerView.text = exampleShortText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  [self.view addSubview:bannerView];
  self.bannerView = bannerView;

  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  [button setTitle:@"DISMISS" forState:UIControlStateNormal];
  [button setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  [button sizeToFit];
  button.backgroundColor = self.colorScheme.surfaceColor;
  NSMutableArray *buttons = [NSMutableArray arrayWithObject:button];
  bannerView.buttons = buttons;

  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
  [bannerView sizeToFit];

  // Adjust bannerViewContainer's frame
  CGFloat topAreaInset = 0.0f;
  if (@available(iOS 11.0, *)) {
    topAreaInset = self.view.safeAreaInsets.top;
  }

  bannerView.frame = CGRectMake(0.0f, topAreaInset, CGRectGetWidth(bannerView.frame),
                                CGRectGetHeight(bannerView.frame));
}

- (void)showSingleLineStyleBannerWithIcon {
  [self showSingleLineStyleBanner];
  self.bannerView.icon = [UIImage imageNamed:@"Email"];
}

- (void)showMultiLineAlignedButtonStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.preferredContentWidth = exampleBannerContentWidth;
  bannerView.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  [self.view addSubview:bannerView];
  self.bannerView = bannerView;

  MDCButton *dismissButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [dismissButton setTitle:@"DISMISS" forState:UIControlStateNormal];
  [dismissButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  dismissButton.backgroundColor = self.colorScheme.surfaceColor;
  [dismissButton sizeToFit];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [changeTextButton setTitle:@"LONG DISMISS" forState:UIControlStateNormal];
  [changeTextButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  changeTextButton.backgroundColor = self.colorScheme.surfaceColor;
  [changeTextButton sizeToFit];
  [changeTextButton addTarget:self
                       action:@selector(dismissBanner)
             forControlEvents:UIControlEventTouchUpInside];
  NSMutableArray *buttons = [NSMutableArray arrayWithObjects:dismissButton, changeTextButton, nil];
  bannerView.buttons = buttons;

  // Adjust bannerViewContainer's frame
  CGFloat topAreaInset = 0.0f;
  if (@available(iOS 11.0, *)) {
    topAreaInset = self.view.safeAreaInsets.top;
  }
  bannerView.frame = CGRectMake(0.0f, topAreaInset, CGRectGetWidth(bannerView.frame),
                                CGRectGetHeight(bannerView.frame));
}

- (void)showMultiLineAlignedButtonStyleBannerWithIcon {
  [self showMultiLineAlignedButtonStyleBanner];
  self.bannerView.icon = [UIImage imageNamed:@"Email"];
}

- (void)showMultiLineStackedButtonStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.preferredContentWidth = exampleBannerContentWidth;
  bannerView.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  [self.view addSubview:bannerView];
  self.bannerView = bannerView;

  MDCButton *dismissButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [dismissButton setTitle:@"DISMISS" forState:UIControlStateNormal];
  [dismissButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  dismissButton.backgroundColor = self.colorScheme.surfaceColor;
  [dismissButton sizeToFit];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  [changeTextButton setTitle:@"EXTRA LONG LONG LONG DISMISS" forState:UIControlStateNormal];
  [changeTextButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  changeTextButton.backgroundColor = self.colorScheme.surfaceColor;
  [changeTextButton sizeToFit];
  [changeTextButton addTarget:self
                       action:@selector(dismissBanner)
             forControlEvents:UIControlEventTouchUpInside];
  NSMutableArray *buttons = [NSMutableArray arrayWithObjects:dismissButton, changeTextButton, nil];
  bannerView.buttons = buttons;

  // Adjust bannerViewContainer's frame
  CGFloat topAreaInset = 0.0f;
  if (@available(iOS 11.0, *)) {
    topAreaInset = self.view.safeAreaInsets.top;
  }
  bannerView.frame = CGRectMake(0.0f, topAreaInset, CGRectGetWidth(bannerView.frame),
                                CGRectGetHeight(bannerView.frame));
}

- (void)showMultiLineStackedButtonStyleBannerWithIcon {
  [self showMultiLineStackedButtonStyleBanner];
  self.bannerView.icon = [UIImage imageNamed:@"Email"];
}

- (void)dismissBanner {
  [self.bannerView removeFromSuperview];
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
