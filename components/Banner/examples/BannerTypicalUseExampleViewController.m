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

#import "MaterialBanner.h"
#import "MaterialBanner+Theming.h"
#import "MaterialButtons.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

static const CGFloat exampleListTableViewHeight = 160.0f;
static const CGFloat exampleBannerContentPadding = 10.0f;
static NSString *const exampleShortText = @"tristique senectus et";
static NSString *const exampleLongText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do incididunt.";
static NSString *const exampleSuperLongText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
    @"labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco "
    @"laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in "
    @"voluptate velit esse cillum dolore eu fugiat nulla pariatur.";

@interface BannerExampleContentView : UIView

@property(nonatomic, readwrite, strong) UILabel *contentLabel;

@end

@implementation BannerExampleContentView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = UIColor.grayColor;
    UILabel *contentLabel = [[UILabel alloc] init];
    [self addSubview:contentLabel];
    contentLabel.text = @"Content View";
    [contentLabel sizeToFit];
    self.contentLabel = contentLabel;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.contentLabel.center = self.center;
}

@end

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

@interface BannerTypicalUseExampleViewController
    : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *exampleListTableView;
@property(nonatomic, strong) NSArray<BannerExampleUseInfo *> *exampleList;
@property(nonatomic, weak) BannerExampleContentView *contentView;
@property(nonatomic, weak) UILabel *contentViewLabel;
@property(nonatomic, weak) MDCBannerView *bannerView;

@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong) id<MDCContainerScheming> containerScheme;

@end

@implementation BannerTypicalUseExampleViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
    _containerScheme = containerScheme;
    _colorScheme = containerScheme.colorScheme;
    _typographyScheme = containerScheme.typographyScheme;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Set up example content view
  BannerExampleContentView *contentView =
      [[BannerExampleContentView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:contentView];
  self.contentView = contentView;

  // Set up example list table view
  self.exampleList = [self getBannerExampleList];
  UITableView *exampleListTableView = [[UITableView alloc] init];
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
    @"presentable" : @YES,
  };
}

#pragma mark - UIViewController

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.contentView.frame = self.view.bounds;
  self.exampleListTableView.frame =
      CGRectMake(0, CGRectGetHeight(self.view.bounds) - exampleListTableViewHeight,
                 CGRectGetWidth(self.view.bounds), exampleListTableViewHeight);

  CGSize bannerViewSize = [self.bannerView sizeThatFits:self.view.bounds.size];
  // Adjust bannerViewContainer's frame
  CGFloat yOrigin = 0.0f;
  if (@available(iOS 11.0, *)) {
    yOrigin = self.view.safeAreaInsets.top;
  } else {
    yOrigin = self.topLayoutGuide.length;
  }

  self.bannerView.frame = CGRectMake(0.0f, yOrigin, bannerViewSize.width, bannerViewSize.height);
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

  BannerExampleUseInfo *exampleUseInfo7 =
      [BannerExampleUseInfo infoWithIdentifier:@"example7"
                                   displayName:@"Long Text with One Action (Single Line Style)"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showSingleLineLongTextStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo7];

  BannerExampleUseInfo *exampleUseInfo8 =
      [BannerExampleUseInfo infoWithIdentifier:@"example8"
                                   displayName:@"Long Text with One Action (Automatic Style)"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showMultilineLongTextStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo8];

  BannerExampleUseInfo *exampleUseInfo9 = [BannerExampleUseInfo
      infoWithIdentifier:@"example9"
             displayName:@"Long Attributed Text with One Action"
        exampleUseTarget:self
      exampleUseSelector:@selector(showMultilineLongAttributedTextStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo9];

  BannerExampleUseInfo *exampleUseInfo10 =
      [BannerExampleUseInfo infoWithIdentifier:@"example10"
                                   displayName:@"Extra Long Text that exceeds 3 lines"
                              exampleUseTarget:self
                            exampleUseSelector:@selector(showExtraLongTextStyleBanner)];
  [bannerExampleList addObject:exampleUseInfo10];

  return [bannerExampleList copy];
}

#pragma mark - Example handlers

- (void)showSingleLineStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.textView.text = exampleShortText;
  bannerView.textView.font = self.typographyScheme.body2;
  bannerView.mdc_adjustsFontForContentSizeCategory = YES;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  [self addBannerView:bannerView];

  MDCButton *button = bannerView.leadingButton;
  [button setTitle:@"Dismiss" forState:UIControlStateNormal];
  bannerView.trailingButton.hidden = YES;
  bannerView.imageView.hidden = YES;
  bannerView.showsDivider = YES;

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
  bannerView.textView.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  bannerView.imageView.hidden = YES;
  [self addBannerView:bannerView];

  MDCButton *dismissButton = bannerView.leadingButton;
  [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = bannerView.trailingButton;
  [changeTextButton setTitle:@"Long dismiss" forState:UIControlStateNormal];
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
  bannerView.textView.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  bannerView.imageView.hidden = YES;
  [self addBannerView:bannerView];

  MDCButton *dismissButton = bannerView.leadingButton;
  [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [dismissButton addTarget:self
                    action:@selector(dismissBanner)
          forControlEvents:UIControlEventTouchUpInside];
  MDCButton *changeTextButton = bannerView.trailingButton;
  [changeTextButton setTitle:@"Extra long long long dismiss" forState:UIControlStateNormal];
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

- (void)showSingleLineLongTextStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.bannerViewLayoutStyle = MDCBannerViewLayoutStyleSingleRow;
  bannerView.textView.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  [self addBannerView:bannerView];

  MDCButton *button = bannerView.leadingButton;
  [button setTitle:@"Dismiss" forState:UIControlStateNormal];
  bannerView.trailingButton.hidden = YES;
  bannerView.imageView.hidden = YES;
  bannerView.showsDivider = YES;

  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMultilineLongTextStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.textView.text = exampleLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  [self addBannerView:bannerView];

  MDCButton *button = bannerView.leadingButton;
  [button setTitle:@"Dismiss" forState:UIControlStateNormal];
  bannerView.trailingButton.hidden = YES;
  bannerView.imageView.hidden = YES;
  bannerView.showsDivider = YES;

  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)showMultilineLongAttributedTextStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  [self addBannerView:bannerView];
  NSMutableAttributedString *exampleString =
      [[NSMutableAttributedString alloc] initWithString:exampleLongText];
  [exampleString addAttribute:NSFontAttributeName
                        value:self.typographyScheme.body2
                        range:NSMakeRange(6, 5)];
  [exampleString addAttribute:NSForegroundColorAttributeName
                        value:UIColor.redColor
                        range:NSMakeRange(12, 5)];
  [exampleString addAttribute:NSLinkAttributeName
                        value:@"http://www.google.com"
                        range:NSMakeRange([exampleLongText length] - 11, 11)];
  bannerView.textView.attributedText = exampleString;
  bannerView.mdc_adjustsFontForContentSizeCategory = YES;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;

  MDCButton *button = bannerView.leadingButton;
  [button setTitle:@"Dismiss" forState:UIControlStateNormal];
  bannerView.trailingButton.hidden = YES;
  bannerView.imageView.hidden = YES;
  bannerView.showsDivider = YES;

  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)showExtraLongTextStyleBanner {
  if (self.bannerView) {
    [self.bannerView removeFromSuperview];
  }

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.textView.text = exampleSuperLongText;
  bannerView.backgroundColor = self.colorScheme.surfaceColor;
  UIEdgeInsets margins = UIEdgeInsetsZero;
  margins.left = exampleBannerContentPadding;
  margins.right = exampleBannerContentPadding;
  bannerView.layoutMargins = margins;
  [self addBannerView:bannerView];

  MDCButton *button = bannerView.leadingButton;
  [button setTitle:@"Dismiss" forState:UIControlStateNormal];
  bannerView.trailingButton.hidden = YES;
  bannerView.imageView.hidden = YES;
  bannerView.showsDivider = YES;

  [button addTarget:self
                action:@selector(dismissBanner)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBannerView:(MDCBannerView *)bannerView {
  [self.view addSubview:bannerView];
  [bannerView applyThemeWithScheme:self.containerScheme];
  self.bannerView = bannerView;
  UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.bannerView);
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

@implementation BannerTypicalUseExampleViewController (SnapshotTestingByConvention)

- (NSDictionary<NSString *, void (^)(void)> *)testRunners {
  NSMutableDictionary *runners = [NSMutableDictionary dictionary];
  NSArray<BannerExampleUseInfo *> *examples = [self getBannerExampleList];
  for (BannerExampleUseInfo *example in examples) {
    __weak BannerTypicalUseExampleViewController *weakSelf = self;
    NSString *defaultTestName = example.displayName;
    runners[defaultTestName] = ^{
      MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
      weakSelf.containerScheme = containerScheme;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      [example.exampleUseTarget performSelector:example.exampleUseSelector];
#pragma clang diagnostic pop
    };
    NSString *dynamic201907ColorSchemeTestName =
        [NSString stringWithFormat:@"example.displayName_%@", @"dynamic201907ColorScheme"];
    runners[dynamic201907ColorSchemeTestName] = ^{
      MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
      containerScheme.colorScheme =
          [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
      weakSelf.containerScheme = containerScheme;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      [example.exampleUseTarget performSelector:example.exampleUseSelector];
#pragma clang diagnostic pop
    };
  }
  return runners;
}

@end
