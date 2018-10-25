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

#import "supplemental/MDCBannerView.h"
#import "supplemental/MDCBannerViewController.h"

static const CGFloat exampleListTableViewHeight = 300.0f;

@interface BannerExampleUseInfo : NSObject

@property(nonatomic, readwrite, copy) NSString *identifier;
@property(nonatomic, readwrite, copy) NSString *displayName;
@property(nonatomic, readwrite, weak) id exampleUseTarget;
@property(nonatomic, readwrite, assign) SEL exampleUseSelector;

- (instancetype)initWithIdentifier:(NSString *)identifier
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

@end

@interface BannerTypicalUseExampleViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, readwrite, strong) UITableView *exampleListTableView;
@property(nonatomic, readwrite, strong) NSArray<BannerExampleUseInfo *> *exampleList;

@end

@implementation BannerTypicalUseExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Set up example content view
  UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
  contentView.backgroundColor = [UIColor grayColor];
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
      [[BannerExampleUseInfo alloc] initWithIdentifier:@"example1"
                                           displayName:@"Single Line (No Image)"
                                      exampleUseTarget:self
                                    exampleUseSelector:@selector(showSingleLineNonImageBanner)];
  [bannerExampleList addObject:exampleUseInfo1];

  return [bannerExampleList copy];
}

#pragma mark - Example handlers

- (void)showSingleLineNonImageBanner {
  MDCBannerViewController *bannerViewController =
      [[MDCBannerViewController alloc] initWithBannerContentWidth:300];
  [self.view addSubview:bannerViewController.view];
  [self addChildViewController:bannerViewController];
  __weak MDCBannerViewController *weakBannerViewController = bannerViewController;
  MDCBannerAction *bannerAction = [[MDCBannerAction alloc]
      initWithName:@"Dismiss"
       actionBlock:^{
         __strong MDCBannerViewController *strongBannerViewController = weakBannerViewController;
         [strongBannerViewController.view removeFromSuperview];
         [strongBannerViewController removeFromParentViewController];
       }];
  [bannerViewController addBannerAction:bannerAction];
  MDCBannerAction *bannerAction2 = [[MDCBannerAction alloc]
      initWithName:@"longlonglonglong action"
       actionBlock:^{
         __strong MDCBannerViewController *strongBannerViewController = weakBannerViewController;
         [strongBannerViewController.view removeFromSuperview];
         [strongBannerViewController removeFromParentViewController];
       }];
  [bannerViewController addBannerAction:bannerAction2];
  bannerViewController.text = @"longlonglonglonglonglonglonglonglonglonglongText";
  //  bannerViewController.text = @"short";
}

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.exampleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.exampleListTableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"cell"];
  }
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
