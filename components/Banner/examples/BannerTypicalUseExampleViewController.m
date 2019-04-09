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

#import "MaterialBanner.h"
#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialTypography.h"

static const CGFloat exampleListTableViewHeight = 160.0f;
static const CGFloat exampleBannerContentPadding = 10.0f;
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
  contentViewLabel.center =
      CGPointMake(CGRectGetMidX(contentView.bounds), CGRectGetMidY(contentView.bounds));
  self.contentViewLabel = contentViewLabel;
  self.contentView = contentView;
  [self.view addSubview:contentView];

  // Set up example list table view
  self.exampleList = [self getBannerExampleList];
  CGRect exampleListTableViewFrame =
      CGRectMake(0, CGRectGetHeight(self.view.bounds) - exampleListTableViewHeight,
                 CGRectGetWidth(self.view.bounds), exampleListTableViewHeight);
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

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGSize bannerViewSize = [self.bannerView sizeThatFits:self.view.bounds.size];
  // Adjust bannerViewContainer's frame
  CGFloat topAreaInset = 0.0f;
  if (@available(iOS 11.0, *)) {
    topAreaInset = self.view.safeAreaInsets.top;
  }
  self.bannerView.frame =
      CGRectMake(0.0f, topAreaInset, bannerViewSize.width, bannerViewSize.height);
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

  BannerExampleUseInfo *exampleUseInfo2 =
      [BannerExampleUseInfo infoWithIdentifier:@"example2"
                                   displayName:@"Short Text with One Action (Icon)"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showSingleLineStyleBannerWithIcon)];
  [bannerExampleList addObject:exampleUseInfo2];

  BannerExampleUseInfo *exampleUseInfo3 =
      [BannerExampleUseInfo infoWithIdentifier:@"example3"
                                   displayName:@"Long Text with Two Short Actions"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultiLineAlignedButtonStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo3];

  BannerExampleUseInfo *exampleUseInfo4 = [BannerExampleUseInfo
      infoWithIdentifier:@"example4"
             displayName:@"Long Text with Two Short Actions (Icon)"
        exampleUseTarget:self
      exampleUseSelector:@selector(showMultiLineAlignedButtonStyleBannerWithIcon)];
  [bannerExampleList addObject:exampleUseInfo4];

  BannerExampleUseInfo *exampleUseInfo5 =
      [BannerExampleUseInfo infoWithIdentifier:@"example5"
                                   displayName:@"Long Text with Two Long Actions"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultiLineStackedButtonStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo5];

  BannerExampleUseInfo *exampleUseInfo6 = [BannerExampleUseInfo
      infoWithIdentifier:@"example6"
             displayName:@"Long Text with Two Long Actions (Icon)"
        exampleUseTarget:self
      exampleUseSelector:@selector(showMultiLineStackedButtonStyleBannerWithIcon)];
  [bannerExampleList addObject:exampleUseInfo6];

  return [bannerExampleList copy];
}

#pragma mark - Example handlers

- (void)showSingleLineStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.textLabel.text = exampleShortText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  [self.view addSubview:bannerView];
  self.bannerView = bannerView;

  MDCButton *button = bannerView.leadingButton;
  [button setTitle:@"Dismiss" forState:UIControlStateNormal];
  button.uppercaseTitle = YES;
  [button setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  button.backgroundColor = self.colorScheme.surfaceColor;
  bannerView.trailingButton.hidden = YES;
  bannerView.imageView.hidden = YES;

  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)showSingleLineStyleBannerWithIcon {
  [self showSingleLineStyleBanner];
  self.bannerView.imageView.hidden = NO;
  NSBundle *bundle = [NSBundle bundleForClass:[BannerTypicalUseExampleViewController class]];
  self.bannerView.imageView.image = [[UIImage imageNamed:@"banner-email"
                                                inBundle:bundle
                           compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.bannerView.imageView.tintColor = self.colorScheme.primaryColor;
}

- (void)showMultiLineAlignedButtonStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.textLabel.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  bannerView.imageView.hidden = YES;
  [self.view addSubview:bannerView];
  self.bannerView = bannerView;

  MDCButton *dismissButton = bannerView.leadingButton;
  [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  dismissButton.uppercaseTitle = YES;
  [dismissButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  dismissButton.backgroundColor = self.colorScheme.surfaceColor;
  [dismissButton sizeToFit];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = bannerView.trailingButton;
  [changeTextButton setTitle:@"Long dismiss" forState:UIControlStateNormal];
  changeTextButton.uppercaseTitle = YES;
  [changeTextButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  changeTextButton.backgroundColor = self.colorScheme.surfaceColor;
  [changeTextButton addTarget:self
                       action:@selector(dismissBanner)
             forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMultiLineAlignedButtonStyleBannerWithIcon {
  [self showMultiLineAlignedButtonStyleBanner];
  self.bannerView.imageView.hidden = NO;
  NSBundle *bundle = [NSBundle bundleForClass:[BannerTypicalUseExampleViewController class]];
  self.bannerView.imageView.image = [[UIImage imageNamed:@"banner-email"
                                                inBundle:bundle
                           compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.bannerView.imageView.tintColor = self.colorScheme.primaryColor;
}

- (void)showMultiLineStackedButtonStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.textLabel.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  bannerView.imageView.hidden = YES;
  [self.view addSubview:bannerView];
  self.bannerView = bannerView;

  MDCButton *dismissButton = bannerView.leadingButton;
  [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  dismissButton.uppercaseTitle = YES;
  [dismissButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  dismissButton.backgroundColor = self.colorScheme.surfaceColor;
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = bannerView.trailingButton;
  [changeTextButton setTitle:@"Extra long long long dismiss" forState:UIControlStateNormal];
  changeTextButton.uppercaseTitle = YES;
  [changeTextButton setTitleColor:self.colorScheme.primaryColor forState:UIControlStateNormal];
  changeTextButton.backgroundColor = self.colorScheme.surfaceColor;
  [changeTextButton addTarget:self
                       action:@selector(dismissBanner)
             forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMultiLineStackedButtonStyleBannerWithIcon {
  [self showMultiLineStackedButtonStyleBanner];
  self.bannerView.imageView.hidden = NO;
  NSBundle *bundle = [NSBundle bundleForClass:[BannerTypicalUseExampleViewController class]];
  self.bannerView.imageView.image = [[UIImage imageNamed:@"banner-email"
                                                inBundle:bundle
                           compatibleWithTraitCollection:nil]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.bannerView.imageView.tintColor = self.colorScheme.primaryColor;
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
