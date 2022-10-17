// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialPalettes.h"
#import "MaterialProgressView.h"
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

static const CGFloat MDCProgressViewAnimationDuration = 1;
static const CGFloat MDCProgressViewIndeterminateAnimationDuration = 4;

@interface ProgressViewExample : UIViewController

@property(nonatomic, strong) UIView *container;

@property(nonatomic, strong) MDCProgressView *stockProgressView;
@property(nonatomic, strong) UILabel *stockProgressLabel;

@property(nonatomic, strong) MDCProgressView *tintedProgressView;
@property(nonatomic, strong) UILabel *tintedProgressLabel;

@property(nonatomic, strong) MDCProgressView *fullyColoredProgressView;
@property(nonatomic, strong) UILabel *fullyColoredProgressLabel;

@property(nonatomic, strong) MDCProgressView *gradientColoredProgressView;
@property(nonatomic, strong) UILabel *gradientColoredProgressLabel;

@property(nonatomic, strong) MDCProgressView *backwardProgressResetView;
@property(nonatomic, strong) UILabel *backwardProgressResetLabel;

@property(nonatomic, strong) MDCProgressView *backwardProgressAnimateView;
@property(nonatomic, strong) UILabel *backwardProgressAnimateLabel;

@property(nonatomic, strong) MDCProgressView *indeterminateProgressView;
@property(nonatomic, strong) UILabel *indeterminateProgressLabel;

@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;

@end

@implementation ProgressViewExample

- (void)setupProgressViews {
  _stockProgressView = [[MDCProgressView alloc] init];
  _stockProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_stockProgressView];
  // Hide the progress view at setup time.
  _stockProgressView.hidden = YES;

  _tintedProgressView = [[MDCProgressView alloc] init];
  _tintedProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_tintedProgressView];
  _tintedProgressView.progressTintColor = self.colorScheme.primaryColor;
  _tintedProgressView.trackTintColor =
      [self.colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.24];
  // Hide the progress view at setup time.
  _tintedProgressView.hidden = YES;

  _fullyColoredProgressView = [[MDCProgressView alloc] init];
  _fullyColoredProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_fullyColoredProgressView];
  _fullyColoredProgressView.progressTintColor = MDCPalette.greenPalette.tint500;
  _fullyColoredProgressView.trackTintColor = MDCPalette.yellowPalette.tint500;
  // Hide the progress view at setup time.
  _fullyColoredProgressView.hidden = YES;

  _gradientColoredProgressView = [[MDCProgressView alloc] init];
  _gradientColoredProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_gradientColoredProgressView];
  _gradientColoredProgressView.progressTintColors = @[
    MDCPalette.greenPalette.tint500, MDCPalette.bluePalette.tint500, MDCPalette.redPalette.tint500
  ];
  _gradientColoredProgressView.trackTintColor = MDCPalette.yellowPalette.tint500;
  _gradientColoredProgressView.progress = 0.33f;

  _backwardProgressResetView = [[MDCProgressView alloc] init];
  _backwardProgressResetView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_backwardProgressResetView];
  // Have a non-zero progress at setup time.
  _backwardProgressResetView.progress = (float)0.33;

  _backwardProgressAnimateView = [[MDCProgressView alloc] init];
  _backwardProgressAnimateView.translatesAutoresizingMaskIntoConstraints = NO;
  _backwardProgressAnimateView.backwardProgressAnimationMode =
      MDCProgressViewBackwardAnimationModeAnimate;
  [self.container addSubview:_backwardProgressAnimateView];
  // Have a non-zero progress at setup time.
  _backwardProgressAnimateView.progress = (float)0.33;

  _indeterminateProgressView = [[MDCProgressView alloc] init];
  _indeterminateProgressView.mode = MDCProgressViewModeIndeterminate;
  _indeterminateProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  _indeterminateProgressView.progressTintColor = self.colorScheme.primaryColor;
  _indeterminateProgressView.trackTintColor =
      [self.colorScheme.primaryColor colorWithAlphaComponent:(CGFloat)0.24];
  [self.container addSubview:_indeterminateProgressView];
}

@end

@implementation ProgressViewExample (Supplemental)

- (void)dealloc {
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.colorScheme) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  if (!self.typographyScheme) {
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }

  self.title = @"Progress View";
  self.view.backgroundColor = self.colorScheme.backgroundColor;

  [self setupContainer];
  [self setupProgressViews];
  [self setupLabels];
  [self setupConstraints];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Animate"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didPressAnimateButton:)];
  self.navigationItem.rightBarButtonItem.accessibilityIdentifier = @"animate_button";
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self positionContainer];
}

- (void)setupContainer {
  self.container = [[UIView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.container];
}

- (void)positionContainer {
  CGFloat originX = CGRectGetMinX(self.view.bounds) + self.view.layoutMargins.left;
  CGFloat originY = CGRectGetMinY(self.view.bounds) + self.view.layoutMargins.top;
  CGFloat width =
      self.view.bounds.size.width - (self.view.layoutMargins.left + self.view.layoutMargins.right);
  CGFloat height =
      self.view.bounds.size.height - (self.view.layoutMargins.top + self.view.layoutMargins.bottom);
  CGRect frame = CGRectMake(originX, originY, width, height);
  self.container.frame = frame;
}

- (void)setupLabels {
  _stockProgressLabel = [[UILabel alloc] init];
  _stockProgressLabel.text = @"Progress";
  _stockProgressLabel.font = self.typographyScheme.caption;
  _stockProgressLabel.textColor = self.colorScheme.onBackgroundColor;
  _stockProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_stockProgressLabel];

  _tintedProgressLabel = [[UILabel alloc] init];
  _tintedProgressLabel.text = @"Progress with progress tint";
  _tintedProgressLabel.font = self.typographyScheme.caption;
  _tintedProgressLabel.textColor = self.colorScheme.onBackgroundColor;
  _tintedProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_tintedProgressLabel];

  _fullyColoredProgressLabel = [[UILabel alloc] init];
  _fullyColoredProgressLabel.text = @"Progress with custom colors";
  _fullyColoredProgressLabel.font = self.typographyScheme.caption;
  _fullyColoredProgressLabel.textColor = self.colorScheme.onBackgroundColor;
  _fullyColoredProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_fullyColoredProgressLabel];

  _gradientColoredProgressLabel = [[UILabel alloc] init];
  _gradientColoredProgressLabel.text = @"Progress with gradient colors";
  _gradientColoredProgressLabel.font = self.typographyScheme.caption;
  _gradientColoredProgressLabel.textColor = self.colorScheme.onBackgroundColor;
  _gradientColoredProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_gradientColoredProgressLabel];

  _backwardProgressResetLabel = [[UILabel alloc] init];
  _backwardProgressResetLabel.text = @"Backward progress (reset)";
  _backwardProgressResetLabel.font = self.typographyScheme.caption;
  _backwardProgressResetLabel.textColor = self.colorScheme.onBackgroundColor;
  _backwardProgressResetLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_backwardProgressResetLabel];

  _backwardProgressAnimateLabel = [[UILabel alloc] init];
  _backwardProgressAnimateLabel.text = @"Backward progress (animate)";
  _backwardProgressAnimateLabel.font = self.typographyScheme.caption;
  _backwardProgressAnimateLabel.textColor = self.colorScheme.onBackgroundColor;
  _backwardProgressAnimateLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_backwardProgressAnimateLabel];

  _indeterminateProgressLabel = [[UILabel alloc] init];
  _indeterminateProgressLabel.text = @"Indeterminate progress";
  _indeterminateProgressLabel.font = self.typographyScheme.caption;
  _indeterminateProgressLabel.textColor = self.colorScheme.onBackgroundColor;
  _indeterminateProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.container addSubview:_indeterminateProgressLabel];
}

- (void)setupConstraints {
  NSDictionary *views = @{
    @"container" : _container,
    @"stockView" : _stockProgressView,
    @"stockLabel" : _stockProgressLabel,
    @"tintedView" : _tintedProgressView,
    @"tintedLabel" : _tintedProgressLabel,
    @"coloredView" : _fullyColoredProgressView,
    @"coloredLabel" : _fullyColoredProgressLabel,
    @"gradientView" : _gradientColoredProgressView,
    @"gradientLabel" : _gradientColoredProgressLabel,
    @"backwardResetView" : _backwardProgressResetView,
    @"backwardResetLabel" : _backwardProgressResetLabel,
    @"backwardAnimateView" : _backwardProgressAnimateView,
    @"backwardAnimateLabel" : _backwardProgressAnimateLabel,
    @"indeterminateView" : _indeterminateProgressView,
    @"indeterminateLabel" : _indeterminateProgressLabel,
  };
  NSDictionary *metrics = @{
    @"t" : @20,
    @"p" : @0,
    @"s" : @40,
    @"h" : @2,
  };

  NSArray *verticalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|-(t)-"
                                   "[stockView(==h)]-(p)-[stockLabel]-(s)-"
                                   "[tintedView(==h)]-(p)-[tintedLabel]-(s)-"
                                   "[coloredView(==h)]-(p)-[coloredLabel]-(s)-"
                                   "[gradientView(==h)]-(p)-[gradientLabel]-(s)-"
                                   "[backwardResetView(==h)]-(p)-[backwardResetLabel]-(s)-"
                                   "[backwardAnimateView(==h)]-(p)-[backwardAnimateLabel]-(s)-"
                                   "[indeterminateView(==h)]-(p)-[indeterminateLabel]"
                          options:0
                          metrics:metrics
                            views:views];
  [self.view addConstraints:verticalConstraints];

  NSMutableArray *horizontalConstraints = [NSMutableArray array];
  NSArray *horizontalVisualFormats = @[
    @"H:|-(p)-[stockView]-(p)-|",
    @"H:|-(p)-[tintedView]-(p)-|",
    @"H:|-(p)-[coloredView]-(p)-|",
    @"H:|-(p)-[gradientView]-(p)-|",
    @"H:|-(p)-[backwardResetView]-(p)-|",
    @"H:|-(p)-[backwardAnimateView]-(p)-|",
    @"H:|-(p)-[indeterminateView]-(p)-|",
    @"H:|-(p)-[stockLabel]-(p)-|",
    @"H:|-(p)-[tintedLabel]-(p)-|",
    @"H:|-(p)-[coloredLabel]-(p)-|",
    @"H:|-(p)-[gradientLabel]-(p)-|",
    @"H:|-(p)-[backwardResetLabel]-(p)-|",
    @"H:|-(p)-[backwardAnimateLabel]-(p)-|",
    @"H:|-(p)-[indeterminateLabel]-(p)-|",
  ];
  for (NSString *format in horizontalVisualFormats) {
    [horizontalConstraints
        addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:views]];
  }
  [self.view addConstraints:horizontalConstraints];
}

- (void)didPressAnimateButton:(UIButton *)sender {
  sender.enabled = NO;
  [self animateStep1:_stockProgressView];
  [self animateStep1:_tintedProgressView];
  [self animateStep1:_fullyColoredProgressView];
  [self animateStep1:_gradientColoredProgressView];
  [self animateBackwardProgressResetViewWithCountdown:4];
  [self animateBackwardProgressAnimateViewWithCountdown:4
                                             completion:^(BOOL ignored) {
                                               sender.enabled = YES;
                                             }];
  [self animateIndeterminateProgressBarWithCountdown:1];
}

- (void)animateStep1:(MDCProgressView *)progressView {
  progressView.progress = 0;
  __weak MDCProgressView *weakProgressView = progressView;
  [progressView setHidden:NO
                 animated:YES
               completion:^(BOOL finished) {
                 [self performSelector:@selector(animateStep2:)
                            withObject:weakProgressView
                            afterDelay:MDCProgressViewAnimationDuration];
               }];
}

- (void)animateStep2:(MDCProgressView *)progressView {
  [progressView setProgress:0.5 animated:YES completion:nil];
  [self performSelector:@selector(animateStep3:)
             withObject:progressView
             afterDelay:MDCProgressViewAnimationDuration];
}

- (void)animateStep3:(MDCProgressView *)progressView {
  [progressView setProgress:1 animated:YES completion:nil];
  [self performSelector:@selector(animateStep4:)
             withObject:progressView
             afterDelay:MDCProgressViewAnimationDuration];
}

- (void)animateStep4:(MDCProgressView *)progressView {
  [progressView setHidden:YES animated:YES completion:nil];
}

- (void)animateBackwardProgressResetViewWithCountdown:(NSInteger)remainingCounts {
  --remainingCounts;
  __weak ProgressViewExample *weakSelf = self;

  [_backwardProgressResetView setProgress:1 - _backwardProgressResetView.progress
                                 animated:YES
                               completion:nil];
  if (remainingCounts > 0) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(MDCProgressViewAnimationDuration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                     [weakSelf animateBackwardProgressResetViewWithCountdown:remainingCounts];
                   });
  }
}

- (void)animateBackwardProgressAnimateViewWithCountdown:(NSInteger)remainingCounts
                                             completion:(void (^)(BOOL))completion {
  --remainingCounts;
  __weak ProgressViewExample *weakSelf = self;

  [_backwardProgressAnimateView setProgress:1 - _backwardProgressAnimateView.progress
                                   animated:YES
                                 completion:remainingCounts == 0 ? completion : nil];
  if (remainingCounts) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(MDCProgressViewAnimationDuration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                     [weakSelf animateBackwardProgressAnimateViewWithCountdown:remainingCounts
                                                                    completion:completion];
                   });
  }
}

- (void)animateIndeterminateProgressBarWithCountdown:(NSInteger)remainingCounts {
  __weak ProgressViewExample *weakSelf = self;

  if (!_indeterminateProgressView.animating) {
    [_indeterminateProgressView startAnimating];
  }

  if (remainingCounts > 0) {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW,
                      (int64_t)(MDCProgressViewIndeterminateAnimationDuration * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
          [weakSelf animateIndeterminateProgressBarWithCountdown:remainingCounts - 1];
        });
  } else {
    [_indeterminateProgressView stopAnimating];
  }
}

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Progress View", @"Progress View" ],
    @"description" : @"Progress indicators display the length of a process or express an "
                     @"unspecified wait time.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
