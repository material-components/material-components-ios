/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "MaterialPalettes.h"
#import "MaterialProgressView.h"
#import "MaterialTypography.h"

static const CGFloat MDCProgressViewAnimationDuration = 1.f;

@interface ProgressViewExample : UIViewController

@property(nonatomic, strong) MDCProgressView *stockProgressView;
@property(nonatomic, strong) UILabel *stockProgressLabel;

@property(nonatomic, strong) MDCProgressView *tintedProgressView;
@property(nonatomic, strong) UILabel *tintedProgressLabel;

@property(nonatomic, strong) MDCProgressView *fullyColoredProgressView;
@property(nonatomic, strong) UILabel *fullyColoredProgressLabel;

@property(nonatomic, strong) MDCProgressView *backwardProgressResetView;
@property(nonatomic, strong) UILabel *backwardProgressResetLabel;

@property(nonatomic, strong) MDCProgressView *backwardProgressAnimateView;
@property(nonatomic, strong) UILabel *backwardProgressAnimateLabel;

@end

@implementation ProgressViewExample

- (void)setupProgressViews {
  _stockProgressView = [[MDCProgressView alloc] init];
  _stockProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_stockProgressView];
  // Hide the progress view at setup time.
  _stockProgressView.hidden = YES;

  _tintedProgressView = [[MDCProgressView alloc] init];
  _tintedProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_tintedProgressView];
  _tintedProgressView.progressTintColor = MDCPalette.redPalette.tint500;
  // Reset the track tint color to be based off of the progress tint color.
  _tintedProgressView.trackTintColor = nil;
  // Hide the progress view at setup time.
  _tintedProgressView.hidden = YES;

  _fullyColoredProgressView = [[MDCProgressView alloc] init];
  _fullyColoredProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_fullyColoredProgressView];
  _fullyColoredProgressView.progressTintColor = MDCPalette.greenPalette.tint500;
  _fullyColoredProgressView.trackTintColor = MDCPalette.yellowPalette.tint500;
  // Hide the progress view at setup time.
  _fullyColoredProgressView.hidden = YES;

  _backwardProgressResetView = [[MDCProgressView alloc] init];
  _backwardProgressResetView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_backwardProgressResetView];
  // Have a non-zero progress at setup time.
  _backwardProgressResetView.progress = 0.33f;

  _backwardProgressAnimateView = [[MDCProgressView alloc] init];
  _backwardProgressAnimateView.translatesAutoresizingMaskIntoConstraints = NO;
  _backwardProgressAnimateView.backwardProgressAnimationMode =
      MDCProgressViewBackwardAnimationModeAnimate;
  [self.view addSubview:_backwardProgressAnimateView];
  // Have a non-zero progress at setup time.
  _backwardProgressAnimateView.progress = 0.33f;
}

@end

@implementation ProgressViewExample (Supplemental)

- (void)dealloc {
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Progress View";
  self.view.backgroundColor = [UIColor whiteColor];

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

- (void)setupLabels {
  _stockProgressLabel = [[UILabel alloc] init];
  _stockProgressLabel.text = @"Progress";
  _stockProgressLabel.font = [MDCTypography captionFont];
  _stockProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _stockProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_stockProgressLabel];

  _tintedProgressLabel = [[UILabel alloc] init];
  _tintedProgressLabel.text = @"Progress with progress tint";
  _tintedProgressLabel.font = [MDCTypography captionFont];
  _tintedProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _tintedProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_tintedProgressLabel];

  _fullyColoredProgressLabel = [[UILabel alloc] init];
  _fullyColoredProgressLabel.text = @"Progress with custom colors";
  _fullyColoredProgressLabel.font = [MDCTypography captionFont];
  _fullyColoredProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _fullyColoredProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_fullyColoredProgressLabel];

  _backwardProgressResetLabel = [[UILabel alloc] init];
  _backwardProgressResetLabel.text = @"Backward progress (reset)";
  _backwardProgressResetLabel.font = [MDCTypography captionFont];
  _backwardProgressResetLabel.alpha = [MDCTypography captionFontOpacity];
  _backwardProgressResetLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_backwardProgressResetLabel];

  _backwardProgressAnimateLabel = [[UILabel alloc] init];
  _backwardProgressAnimateLabel.text = @"Backward progress (animate)";
  _backwardProgressAnimateLabel.font = [MDCTypography captionFont];
  _backwardProgressAnimateLabel.alpha = [MDCTypography captionFontOpacity];
  _backwardProgressAnimateLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_backwardProgressAnimateLabel];
}

- (void)setupConstraints {
  NSDictionary *views = @{
    @"stockView" : _stockProgressView,
    @"stockLabel" : _stockProgressLabel,
    @"tintedView" : _tintedProgressView,
    @"tintedLabel" : _tintedProgressLabel,
    @"coloredView" : _fullyColoredProgressView,
    @"coloredLabel" : _fullyColoredProgressLabel,
    @"backwardResetView" : _backwardProgressResetView,
    @"backwardResetLabel" : _backwardProgressResetLabel,
    @"backwardAnimateView" : _backwardProgressAnimateView,
    @"backwardAnimateLabel" : _backwardProgressAnimateLabel,
  };
  NSDictionary *metrics = @{
    @"p" : @20,
    @"s" : @40,
    @"h" : @2,
  };

  NSArray *verticalConstraints = [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|-(p)-"
                                   "[stockView(==h)]-(p)-[stockLabel]-(s)-"
                                   "[tintedView(==h)]-(p)-[tintedLabel]-(s)-"
                                   "[coloredView(==h)]-(p)-[coloredLabel]-(s)-"
                                   "[backwardResetView(==h)]-(p)-[backwardResetLabel]-(s)-"
                                   "[backwardAnimateView(==h)]-(p)-[backwardAnimateLabel]"
                          options:0
                          metrics:metrics
                            views:views];
  [self.view addConstraints:verticalConstraints];

  NSMutableArray *horizontalConstraints = [NSMutableArray array];
  NSArray *horizontalVisualFormats = @[
    @"H:|-(p)-[stockView]-(p)-|",
    @"H:|-(p)-[tintedView]-(p)-|",
    @"H:|-(p)-[coloredView]-(p)-|",
    @"H:|-(p)-[backwardResetView]-(p)-|",
    @"H:|-(p)-[backwardAnimateView]-(p)-|",
    @"H:|-(>=p)-[stockLabel]-(>=p)-|",
    @"H:|-(>=p)-[tintedLabel]-(>=p)-|",
    @"H:|-(>=p)-[coloredLabel]-(>=p)-|",
    @"H:|-(>=p)-[backwardResetLabel]-(>=p)-|",
    @"H:|-(>=p)-[backwardAnimateLabel]-(>=p)-|",
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
  [self animateBackwardProgressResetViewWithCountdown:4];
  [self animateBackwardProgressAnimateViewWithCountdown:4 completion:^(BOOL ignored) {
    sender.enabled = YES;
  }];

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
  [progressView setHidden:YES
                 animated:YES
               completion:nil];
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

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Progress View", @"Progress View" ];
}

+ (NSString *)catalogDescription {
  return @"Progress indicators display the length of a process or express an unspecified wait "
          "time.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (BOOL)catalogIsPresentable {
  return YES;
}

@end
