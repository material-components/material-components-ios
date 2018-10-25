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

#import "MDCBannerViewController.h"

#import "MDCBannerParams.h"
#import "MDCBannerView.h"
#import "MDCButton.h"
#import "MaterialTypography.h"

@implementation MDCBannerAction

- (instancetype)initWithName:(NSString *)name actionBlock:(MDCBannerActionBlock)actionBlock {
  self = [super init];
  if (self) {
    _name = name;
    _actionBlock = actionBlock;
  }
  return self;
}

@end

// A temp UIView for touch detection, will be removed after adding the Banner to UIWindow

@interface MDCBannerTouchView : UIView
@end

@implementation MDCBannerTouchView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *hitView = [super hitTest:point withEvent:event];
  return hitView == self ? nil : hitView;
}

@end

@interface MDCBannerViewController () <MDCBannerViewDelegate>

// TODO: change to preferredContentWidth
@property(nonatomic, readwrite, assign) CGFloat bannerContentWidth;
@property(nonatomic, readwrite, strong) NSArray<MDCBannerAction *> *bannerActions;
@property(nonatomic, readwrite, strong)
    NSMutableDictionary<NSNumber *, MDCBannerAction *> *buttonTagToBannerActionDictionary;
@property(nonatomic, readwrite, weak) UIView *bannerContainerView;
@property(nonatomic, readwrite, weak) MDCBannerView *bannerView;

@end

@implementation MDCBannerViewController

- (instancetype)initWithBannerContentWidth:(CGFloat)bannerContentWidth {
  self = [super init];
  if (self) {
    _bannerActions = [[NSArray alloc] init];
    _buttonTagToBannerActionDictionary = [[NSMutableDictionary alloc] init];
    _bannerContentWidth = bannerContentWidth;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.opaque = NO;

  UIView *bannerContainerView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100)];
  bannerContainerView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:bannerContainerView];
  self.bannerContainerView = bannerContainerView;

  MDCBannerView *bannerView = [[MDCBannerView alloc] init];
  bannerView.delegate = self;
  [bannerContainerView addSubview:bannerView];
  self.bannerView = bannerView;
}

- (void)loadView {
  self.view = [[MDCBannerTouchView alloc] initWithFrame:UIScreen.mainScreen.bounds];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGRect originalFrame = self.bannerContainerView.frame;
  self.bannerContainerView.frame = CGRectMake(0, self.view.safeAreaInsets.top,
                                              originalFrame.size.width, originalFrame.size.height);

  CGSize adjustedBannerViewSize =
      [self.bannerView sizeThatFits:CGSizeMake(self.bannerContentWidth, 0.0f)];
  self.bannerView.frame = CGRectMake(self.bannerView.frame.origin.x, self.bannerView.frame.origin.y,
                                     adjustedBannerViewSize.width, adjustedBannerViewSize.height);
  self.bannerView.center = CGPointMake(self.bannerContainerView.bounds.size.width / 2,
                                       self.bannerContainerView.bounds.size.height / 2);
}

#pragma mark - Properties setter and getter

- (void)setText:(NSString *)text {
  self.bannerView.text = text;
}

- (NSString *)text {
  return self.bannerView.text;
}

- (void)setImage:(UIImage *)image {
  self.bannerView.image = image;
}

- (UIImage *)image {
  return self.bannerView.image;
}

#pragma mark - APIs

- (void)addBannerAction:(MDCBannerAction *)bannerAction {
  if ([self.bannerActions containsObject:bannerAction]) {
    return;
  }

  NSMutableArray *bannerActionsToUpdate = [self.bannerActions mutableCopy];
  [bannerActionsToUpdate addObject:bannerAction];
  self.bannerActions = [bannerActionsToUpdate copy];

  NSInteger buttonTag = (NSInteger)self.bannerActions.count;
  MDCButton *button = [[MDCButton alloc] initWithFrame:CGRectZero];
  button.tag = buttonTag;
  [button setTitle:bannerAction.name forState:UIControlStateNormal];
  UIFont *buttonFont = [MDCTypography body2Font];
  [button setTitleFont:buttonFont forState:UIControlStateNormal];
  [button setTitleFont:buttonFont forState:UIControlStateHighlighted];
  button.backgroundColor = [UIColor grayColor];
  [button sizeToFit];
  self.buttonTagToBannerActionDictionary[@(buttonTag)] = bannerAction;
  [self.bannerView addButton:button];
}

#pragma mark - Delegate methods

- (void)didTapButtonOnMDCBannerView:(MDCButton *)button {
  MDCBannerAction *bannerAction = self.buttonTagToBannerActionDictionary[@(button.tag)];
  if (bannerAction.actionBlock) {
    bannerAction.actionBlock();
  }
}

@end
