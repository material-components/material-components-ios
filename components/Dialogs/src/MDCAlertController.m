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

#import "MDCAlertController.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCDialogTransitionController.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"
#import "MDCAlertControllerView.h"
#import "UIViewController+MaterialDialogs.h"
#import "MDCDialogPresentationController.h"
#import "private/MDCAlertControllerView+Private.h"
#import "private/MaterialDialogsStrings.h"
#import "private/MaterialDialogsStrings_table.h"

// The Bundle for string resources.
static NSString *const kMaterialDialogsBundle = @"MaterialDialogs.bundle";

@interface MDCAlertAction ()

@property(nonatomic, nullable, copy) MDCActionHandler completionHandler;

@end

@implementation MDCAlertAction

+ (instancetype)actionWithTitle:(nonnull NSString *)title
                        handler:(void (^__nullable)(MDCAlertAction *action))handler {
  return [[MDCAlertAction alloc] initWithTitle:title handler:handler];
}

- (instancetype)initWithTitle:(nonnull NSString *)title
                      handler:(void (^__nullable)(MDCAlertAction *action))handler {
  self = [super init];
  if (self) {
    _title = [title copy];
    _completionHandler = [handler copy];
  }
  return self;
}

- (id)copyWithZone:(__unused NSZone *)zone {
  MDCAlertAction *action = [[self class] actionWithTitle:self.title handler:self.completionHandler];
  action.accessibilityIdentifier = self.accessibilityIdentifier;

  return action;
}

@end

@interface MDCAlertController ()

@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message;

@end

@implementation MDCAlertController {
  NSMutableArray<MDCAlertAction *> *_actions;

  // This is because title is overlapping with view controller title, However Apple alertController
  // redefines title as well.
  NSString *_alertTitle;

  CGSize _previousLayoutSize;

  BOOL _mdc_adjustsFontForContentSizeCategory;
}


+ (instancetype)alertControllerWithTitle:(nullable NSString *)alertTitle
                                 message:(nullable NSString *)message {
  MDCAlertController *alertController =
      [[MDCAlertController alloc] initWithTitle:alertTitle message:message];

  return alertController;
}

- (instancetype)init {
  return [self initWithTitle:nil message:nil];
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _transitionController = [[MDCDialogTransitionController alloc] init];

    _alertTitle = [title copy];
    _message = [message copy];
    _actions = [[NSMutableArray alloc] init];

    super.transitioningDelegate = _transitionController;
    super.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:
    (__unused id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCAlertController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCAlertController.modalPresentationStyle cannot be changed.");
  return;
}

- (void)setTitle:(NSString *)title {
  _alertTitle = [title copy];
  if (self.alertView) {
    self.alertView.titleLabel.text = title;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];

  }
}

- (NSString *)title {
  return _alertTitle;
}

- (void)setMessage:(NSString *)message {
  _message = [message copy];
  if (self.alertView) {
    self.alertView.messageLabel.text = message;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (NSArray<MDCAlertAction *> *)actions {
  return [_actions copy];
}

- (void)addAction:(MDCAlertAction *)action {
  [_actions addObject:[action copy]];
  [self addActionToAlertView:action];
}

- (void)addActionToAlertView:(MDCAlertAction *)action {
  if (self.alertView) {
    MDCButton *addedAction = [self.alertView addActionButtonTitle:action.title
                                                           target:self
                                                         selector:@selector(actionButtonPressed:)];
    addedAction.accessibilityIdentifier = action.accessibilityIdentifier;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
    [self.alertView setNeedsLayout];
  }
}

- (void)setTitleFont:(UIFont *)titleFont {
  _titleFont = titleFont;
  if (self.alertView) {
    self.alertView.titleFont = titleFont;
  }
}

- (void)setMessageFont:(UIFont *)messageFont {
  _messageFont = messageFont;
  if (self.alertView) {
    self.alertView.messageFont = messageFont;
  }
}

- (void)setButtonFont:(UIFont *)buttonFont {
  _buttonFont = buttonFont;
  if (self.alertView) {
    self.alertView.buttonFont = buttonFont;
  }
}

- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;
  if (self.alertView) {
    self.alertView.titleColor = titleColor;
  }
}

- (void)setMessageColor:(UIColor *)messageColor {
  _messageColor = messageColor;
  if (self.alertView) {
    self.alertView.messageColor = messageColor;
  }
}

- (void)setButtonTitleColor:(UIColor *)buttonColor {
  _buttonTitleColor = buttonColor;
  if (self.alertView) {
    self.alertView.buttonColor = buttonColor;
  }
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (self.alertView) {
    self.alertView.mdc_adjustsFontForContentSizeCategory = adjusts;
    [self updateFontsForDynamicType];
  }
  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateFontsForDynamicType];
}

// Update the fonts used based on mdc_preferredFontForMaterialTextStyle and recalculate the
// preferred content size.
- (void)updateFontsForDynamicType {
  if (self.alertView) {
    [self.alertView updateFonts];

    // Our presentation controller reacts to changes to preferredContentSize to determine our
    // frame at the presented controller.
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (void)actionButtonPressed:(id)sender {
  NSInteger actionIndex = [self.alertView.actionButtons indexOfObject:sender];
  MDCAlertAction *action = self.actions[actionIndex];
  // We call our action.completionHandler after we dismiss the existing alert in case the handler
  // also presents a view controller. Otherwise we get a warning about presenting on a controller
  // which is already presenting.
  [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void){
    if (action.completionHandler) {
      action.completionHandler(action);
    }
  }];
}

#pragma mark - UIViewController

- (void)loadView {
  self.view = [[MDCAlertControllerView alloc] initWithFrame:CGRectZero];
  self.alertView = (MDCAlertControllerView *)self.view;

}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupAlertView];

  _previousLayoutSize = CGSizeZero;
  CGSize idealSize = [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  self.preferredContentSize = idealSize;

  self.preferredContentSize =
      [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];

  [self.view setNeedsLayout];

  NSString *key =
      kMaterialDialogsStringTable[kStr_MaterialDialogsPresentedAccessibilityAnnouncement];
  NSString *announcement = NSLocalizedStringFromTableInBundle(key,
                                                              kMaterialDialogsStringsTableName,
                                                              [[self class] bundle],
                                                              @"Alert");
  UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,
                                  announcement);
}

- (void)setupAlertView {
  // Explicitly overwrite the view default if true
  if (_mdc_adjustsFontForContentSizeCategory) {
    self.alertView.mdc_adjustsFontForContentSizeCategory = YES;
  }
  self.alertView.titleLabel.text = self.title;
  self.alertView.messageLabel.text = self.message;
  self.alertView.titleFont = self.titleFont;
  self.alertView.messageFont = self.messageFont;
  self.alertView.titleColor = self.titleColor;
  self.alertView.messageColor = self.messageColor;
  self.alertView.buttonColor = self.buttonTitleColor;
  self.alertView.buttonFont = self.buttonFont;
  self.alertView.buttonInkColor = self.buttonInkColor;

  for (MDCAlertAction *action in self.actions) {
    [self addActionToAlertView:action];
  }
}

- (void)viewDidLayoutSubviews {
  // Recalculate preferredSize, which is based on width available, if the viewSize has changed.
  if (CGRectGetWidth(self.view.bounds) != _previousLayoutSize.width ||
      CGRectGetHeight(self.view.bounds) != _previousLayoutSize.height) {
    CGSize currentPreferredContentSize = self.preferredContentSize;
    CGSize calculatedPreferredContentSize =
    [self.alertView calculatePreferredContentSizeForBounds:CGRectStandardize(self.alertView.bounds).size];

    if (!CGSizeEqualToSize(currentPreferredContentSize, calculatedPreferredContentSize)) {
      // NOTE: Setting the preferredContentSize can lead to a change to self.view.bounds.
      self.preferredContentSize = calculatedPreferredContentSize;
    }

    _previousLayoutSize = CGRectStandardize(self.alertView.bounds).size;
  }
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialDialogsBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCAlertController class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  // Recalculate preferredSize, which is based on width available, if the viewSize has changed.
  if (CGRectGetWidth(self.view.bounds) != _previousLayoutSize.width ||
      CGRectGetHeight(self.view.bounds) != _previousLayoutSize.height) {
    CGSize currentPreferredContentSize = self.preferredContentSize;
    CGSize contentSize = CGRectStandardize(self.alertView.bounds).size;
    CGSize calculatedPreferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:contentSize];

    if (!CGSizeEqualToSize(currentPreferredContentSize, calculatedPreferredContentSize)) {
      // NOTE: Setting the preferredContentSize can lead to a change to self.view.bounds.
      self.preferredContentSize = calculatedPreferredContentSize;
    }

    _previousLayoutSize = CGRectStandardize(self.alertView.bounds).size;
  }
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        // Reset preferredContentSize on viewWIllTransition to take advantage of additional width
        self.preferredContentSize =
            [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
      }
                               completion:nil];
}

#pragma mark - UIAccessibilityAction

- (BOOL)accessibilityPerformEscape {
  MDCDialogPresentationController *dialogPresentationController =
      self.mdc_dialogPresentationController;
  if (dialogPresentationController.dismissOnBackgroundTap) {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    return YES;
  }
  return NO;
}

@end
