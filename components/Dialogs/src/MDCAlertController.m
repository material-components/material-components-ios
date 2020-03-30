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

#import "MaterialButtons.h"
#import "MDCAlertController+Customize.h"
#import "MDCAlertControllerDelegate.h"
#import "MDCAlertControllerView.h"
#import "MDCDialogPresentationController.h"
#import "MDCDialogTransitionController.h"
#import "UIViewController+MaterialDialogs.h"
#import "MaterialTypography.h"
#import "MaterialMath.h"
#import <MDFInternationalization/MDFInternationalization.h>

#import "private/MDCAlertActionManager.h"
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
  return [[MDCAlertAction alloc] initWithTitle:title emphasis:MDCActionEmphasisLow handler:handler];
}

+ (instancetype)actionWithTitle:(nonnull NSString *)title
                       emphasis:(MDCActionEmphasis)emphasis
                        handler:(void (^__nullable)(MDCAlertAction *action))handler {
  return [[MDCAlertAction alloc] initWithTitle:title emphasis:emphasis handler:handler];
}

- (instancetype)initWithTitle:(nonnull NSString *)title
                     emphasis:(MDCActionEmphasis)emphasis
                      handler:(void (^__nullable)(MDCAlertAction *action))handler {
  self = [super init];
  if (self) {
    _title = [title copy];
    _emphasis = emphasis;
    _completionHandler = [handler copy];
  }
  return self;
}

- (id)copyWithZone:(__unused NSZone *)zone {
  MDCAlertAction *action = [[self class] actionWithTitle:self.title
                                                emphasis:self.emphasis
                                                 handler:self.completionHandler];
  action.accessibilityIdentifier = self.accessibilityIdentifier;

  return action;
}

@end

@interface MDCAlertController ()

@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@property(nonatomic, strong) MDCDialogTransitionController *transitionController;
@property(nonatomic, nonnull, strong) MDCAlertActionManager *actionManager;
@property(nonatomic, nullable, strong) UIView *titleIconView;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message;

@end

@implementation MDCAlertController {
  // This is because title is overlapping with view controller title, However Apple alertController
  // redefines title as well.
  NSString *_alertTitle;
  CGSize _previousLayoutSize;
  BOOL _mdc_adjustsFontForContentSizeCategory;
  NSString *_imageAccessibilityLabel;
  BOOL _alignIconWithTitle;
}

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;
@synthesize adjustsFontForContentSizeCategory = _adjustsFontForContentSizeCategory;
@synthesize titleIconView = _titleIconView;
@synthesize actionsHorizontalAlignment = _actionsHorizontalAlignment;
@synthesize actionsHorizontalAlignmentInVerticalLayout =
    _actionsHorizontalAlignmentInVerticalLayout;
@synthesize orderVerticalActionsByEmphasis = _orderVerticalActionsByEmphasis;
@synthesize imageAccessibilityLabel = _imageAccessibilityLabel;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)alertTitle
                                 message:(nullable NSString *)message {
  MDCAlertController *alertController = [[MDCAlertController alloc] initWithTitle:alertTitle
                                                                          message:message];

  return alertController;
}

+ (nonnull instancetype)alertControllerWithTitle:(nullable NSString *)alertTitle
                               attributedMessage:(nullable NSAttributedString *)attributedMessage {
  MDCAlertController *alertController =
      [[MDCAlertController alloc] initWithTitle:alertTitle attributedMessage:attributedMessage];

  return alertController;
}

- (instancetype)init {
  return [self initWithTitle:nil message:nil];
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message {
  self = [self initWithTitle:title];
  if (self) {
    _message = [message copy];
  }
  return self;
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                    attributedMessage:(nullable NSAttributedString *)attributedMessage {
  self = [self initWithTitle:title];
  if (self) {
    _attributedMessage = [attributedMessage copy];
  }
  return self;
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _transitionController = [[MDCDialogTransitionController alloc] init];

    _alertTitle = [title copy];
    _titleAlignment = NSTextAlignmentNatural;
    _messageAlignment = NSTextAlignmentNatural;
    _titleIconAlignment = _titleAlignment;
    _alignIconWithTitle = YES;
    _actionManager = [[MDCAlertActionManager alloc] init];
    _adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;
    _shadowColor = UIColor.blackColor;
    _mdc_overrideBaseElevation = -1;

    super.transitioningDelegate = _transitionController;
    super.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
  if (@available(iOS 10.0, *)) {
    if (![self.traitCollection.preferredContentSizeCategory
            isEqualToString:previousTraitCollection.preferredContentSizeCategory]) {
      self.preferredContentSize = [self.alertView
          calculatePreferredContentSizeForBounds:CGRectStandardize(self.view.bounds).size];
    }
  }
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

- (void)setTitleAccessibilityLabel:(NSString *)titleAccessibilityLabel {
  _titleAccessibilityLabel = [titleAccessibilityLabel copy];
  if (self.alertView && titleAccessibilityLabel) {
    self.alertView.titleLabel.accessibilityLabel = titleAccessibilityLabel;
  }
}

- (void)setMessage:(NSString *)message {
  _message = [message copy];
  if (self.alertView) {
    [self messageDidChange];
  }
}

- (void)setAttributedMessage:(NSAttributedString *)attributedMessage {
  _attributedMessage = [attributedMessage copy];
  if (self.alertView) {
    [self messageDidChange];
  }
}

- (void)messageDidChange {
  if (self.attributedMessage.length > 0) {
    self.alertView.messageLabel.attributedText = self.attributedMessage;
  } else {
    self.alertView.messageLabel.text = self.message;
  }
  self.preferredContentSize =
      [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
}

- (void)setMessageAccessibilityLabel:(NSString *)messageAccessibilityLabel {
  _messageAccessibilityLabel = [messageAccessibilityLabel copy];
  if (self.alertView && messageAccessibilityLabel) {
    self.alertView.messageLabel.accessibilityLabel = messageAccessibilityLabel;
  }
}

- (void)setImageAccessibilityLabel:(NSString *)imageAccessibilityLabel {
  if ([_imageAccessibilityLabel isEqual:imageAccessibilityLabel]) {
    return;
  }
  _imageAccessibilityLabel = [imageAccessibilityLabel copy];

  if (self.alertView) {
    self.alertView.titleIconImageView.accessibilityLabel = _imageAccessibilityLabel;
    self.alertView.titleIconView.accessibilityLabel = _imageAccessibilityLabel;
  }
}

- (NSString *)imageAccessibilityLabel {
  if (_imageAccessibilityLabel) {
    return _imageAccessibilityLabel;
  }
  if (!self.alertView) {
    return nil;
  }
  return (self.alertView.titleIconImageView != nil)
             ? self.alertView.titleIconImageView.accessibilityLabel
             : self.alertView.titleIconView.accessibilityLabel;
}

- (void)setAccessoryView:(UIView *)accessoryView {
  if (_accessoryView == accessoryView) {
    return;
  }

  _accessoryView = accessoryView;

  if (self.alertView) {
    self.alertView.accessoryView = accessoryView;
    [self setAccessoryViewNeedsLayout];
  }
}

- (void)setAccessoryViewNeedsLayout {
  [self.alertView setNeedsLayout];
  self.preferredContentSize =
      [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
}

- (MDCDialogTransitionController *)dialogTransitionController {
  return (MDCDialogTransitionController *)self.transitioningDelegate;
}

- (NSTimeInterval)presentationOpacityAnimationDuration {
  return [self dialogTransitionController].opacityAnimationDuration;
}

- (void)setPresentationOpacityAnimationDuration:
    (NSTimeInterval)presentationOpacityAnimationDuration {
  [self dialogTransitionController].opacityAnimationDuration = presentationOpacityAnimationDuration;
}

- (NSTimeInterval)presentationScaleAnimationDuration {
  return [self dialogTransitionController].scaleAnimationDuration;
}

- (void)setPresentationScaleAnimationDuration:(NSTimeInterval)presentationScaleAnimationDuration {
  [self dialogTransitionController].scaleAnimationDuration = presentationScaleAnimationDuration;
}

- (CGFloat)presentationInitialScaleFactor {
  return [self dialogTransitionController].dialogInitialScaleFactor;
}

- (void)setPresentationInitialScaleFactor:(CGFloat)presentationInitialScaleFactor {
  [self dialogTransitionController].dialogInitialScaleFactor = presentationInitialScaleFactor;
}

- (NSArray<MDCAlertAction *> *)actions {
  return self.actionManager.actions;
}

- (void)addAction:(MDCAlertAction *)action {
  [self.actionManager addAction:action];
  [self addButtonToAlertViewForAction:action];
}

- (nullable MDCButton *)buttonForAction:(nonnull MDCAlertAction *)action {
  MDCButton *button = [self.actionManager buttonForAction:action];
  if (!button && [self.actionManager hasAction:action]) {
    button = [self.actionManager createButtonForAction:action
                                                target:self
                                              selector:@selector(actionButtonPressed:forEvent:)];
    [MDCAlertControllerView styleAsTextButton:button];
  }
  return button;
}

- (void)addButtonToAlertViewForAction:(MDCAlertAction *)action {
  if (self.alertView) {
    MDCButton *button = [self buttonForAction:action];
    [self.alertView addActionButton:button];
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
    [self.alertView setNeedsLayout];
  }
}

- (void)setActionsHorizontalAlignment:(MDCContentHorizontalAlignment)actionsHorizontalAlignment {
  if (_actionsHorizontalAlignment == actionsHorizontalAlignment) {
    return;
  }
  _actionsHorizontalAlignment = actionsHorizontalAlignment;
  self.alertView.actionsHorizontalAlignment = actionsHorizontalAlignment;
}

- (void)setActionsHorizontalAlignmentInVerticalLayout:(MDCContentHorizontalAlignment)alignment {
  if (_actionsHorizontalAlignmentInVerticalLayout == alignment) {
    return;
  }
  _actionsHorizontalAlignmentInVerticalLayout = alignment;
  self.alertView.actionsHorizontalAlignmentInVerticalLayout = alignment;
}

- (void)setOrderVerticalActionsByEmphasis:(BOOL)orderVerticalActionsByEmphasis {
  if (_orderVerticalActionsByEmphasis == orderVerticalActionsByEmphasis) {
    return;
  }
  _orderVerticalActionsByEmphasis = orderVerticalActionsByEmphasis;
  self.alertView.orderVerticalActionsByEmphasis = orderVerticalActionsByEmphasis;
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

// b/117717380: Will be deprecated
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

// b/117717380: Will be deprecated
- (void)setButtonTitleColor:(UIColor *)buttonColor {
  _buttonTitleColor = buttonColor;
  if (self.alertView) {
    self.alertView.buttonColor = buttonColor;
  }
}

- (void)setTitleAlignment:(NSTextAlignment)titleAlignment {
  _titleAlignment = titleAlignment;
  if (_alignIconWithTitle) {
    _titleIconAlignment = titleAlignment;
  }
  if (self.alertView) {
    self.alertView.titleAlignment = titleAlignment;
    if (_alignIconWithTitle) {
      self.alertView.titleIconAlignment = titleAlignment;
    }
  }
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
  _messageAlignment = messageAlignment;
  if (self.alertView) {
    self.alertView.messageAlignment = messageAlignment;
  }
}

- (void)setTitleIcon:(UIImage *)titleIcon {
  _titleIcon = titleIcon;
  if (self.alertView) {
    self.alertView.titleIcon = titleIcon;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (void)setTitleIconView:(UIView *)titleIconView {
  _titleIconView = titleIconView;
  if (self.alertView) {
    self.alertView.titleIconView = titleIconView;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (void)setTitleIconTintColor:(UIColor *)titleIconTintColor {
  _titleIconTintColor = titleIconTintColor;
  if (self.alertView) {
    self.alertView.titleIconTintColor = titleIconTintColor;
  }
}

- (UIImageView *)titleIconImageView {
  return self.alertView.titleIconImageView;
}

- (void)setTitleIconAlignment:(NSTextAlignment)titleIconAlignment {
  _alignIconWithTitle = NO;
  _titleIconAlignment = titleIconAlignment;
  if (self.alertView) {
    self.alertView.titleIconAlignment = titleIconAlignment;
  }
}

- (void)setScrimColor:(UIColor *)scrimColor {
  _scrimColor = scrimColor;
  self.mdc_dialogPresentationController.scrimColor = scrimColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  _backgroundColor = backgroundColor;
  if (self.alertView) {
    self.alertView.backgroundColor = backgroundColor;
  }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;
  if (self.alertView) {
    self.alertView.cornerRadius = cornerRadius;
  }
  self.mdc_dialogPresentationController.dialogCornerRadius = cornerRadius;
}

- (void)setElevation:(MDCShadowElevation)elevation {
  BOOL shouldNotifyChanges = !MDCCGFloatEqual(elevation, _elevation);
  _elevation = elevation;
  self.mdc_dialogPresentationController.dialogElevation = elevation;
  if (shouldNotifyChanges) {
    [self.view mdc_elevationDidChange];
  }
}

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (void)setShadowColor:(UIColor *)shadowColor {
  UIColor *shadowColorCopy = [shadowColor copy];
  _shadowColor = shadowColorCopy;
  self.mdc_dialogPresentationController.dialogShadowColor = shadowColorCopy;
}

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  _adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  if (@available(iOS 11.0, *)) {
    if (self.viewLoaded) {
      self.alertView.titleLabel.adjustsFontForContentSizeCategory =
          adjustsFontForContentSizeCategory;
      // TODO(https://github.com/material-components/material-components-ios/issues/8673): Add
      // Buttons
      // TODO(https://github.com/material-components/material-components-ios/issues/8671): Add
      // Message
    }
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

- (void)setAdjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable:
    (BOOL)adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable {
  _adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable =
      adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;
  self.alertView.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable =
      adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;
}

- (void)actionButtonPressed:(id)button forEvent:(UIEvent *)event {
  MDCAlertAction *action = [self.actionManager actionForButton:button];

  // We call our action.completionHandler after we dismiss the existing alert in case the handler
  // also presents a view controller. Otherwise we get a warning about presenting on a controller
  // which is already presenting.
  [self.presentingViewController dismissViewControllerAnimated:YES
                                                    completion:^(void) {
                                                      if (action.completionHandler) {
                                                        if ([self.delegate
                                                                respondsToSelector:@selector
                                                                (alertController:
                                                                    didTapAction:withEvent:)]) {
                                                          [self.delegate alertController:self
                                                                            didTapAction:action
                                                                               withEvent:event];
                                                        }
                                                        action.completionHandler(action);
                                                      }
                                                    }];
}

#pragma mark - UIViewController

- (void)loadView {
  self.view = [[MDCAlertControllerView alloc] initWithFrame:CGRectZero];
  self.alertView = (MDCAlertControllerView *)self.view;
  // sharing MDCActionManager with with the alert view
  self.alertView.actionManager = self.actionManager;
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
  NSString *announcement = NSLocalizedStringFromTableInBundle(key, kMaterialDialogsStringsTableName,
                                                              [[self class] bundle], @"Alert");
  UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, announcement);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if ([self.delegate respondsToSelector:@selector(alertController:willAppear:)]) {
    [self.delegate alertController:self willAppear:animated];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if ([self.delegate respondsToSelector:@selector(alertController:didAppear:)]) {
    [self.delegate alertController:self didAppear:animated];
  }
  [self.alertView.titleScrollView flashScrollIndicators];
  [self.alertView.contentScrollView flashScrollIndicators];
  [self.alertView.actionsScrollView flashScrollIndicators];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if ([self.delegate respondsToSelector:@selector(alertController:willDisappear:)]) {
    [self.delegate alertController:self willDisappear:animated];
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  if ([self.delegate respondsToSelector:@selector(alertController:didDisappear:)]) {
    [self.delegate alertController:self didDisappear:animated];
  }
}

- (void)viewDidLayoutSubviews {
  // Recalculate preferredContentSize and potentially the view frame.
  BOOL boundsSizeChanged =
      !CGSizeEqualToSize(CGRectStandardize(self.view.bounds).size, _previousLayoutSize);

  // UIContentSizeCategoryAdjusting behavior only updates fonts after -viewWillLayoutSubviews and
  // before -viewDidLayoutSubviews. Because `preferredContentSize` may have changed as a result,
  // it is necessary to check if it changed here and possibly require a second layout pass.
  CGSize currentPreferredContentSize = self.preferredContentSize;
  CGSize calculatedPreferredContentSize = [self.alertView
      calculatePreferredContentSizeForBounds:CGRectStandardize(self.alertView.bounds).size];
  BOOL preferredContentSizeChanged =
      !CGSizeEqualToSize(currentPreferredContentSize, calculatedPreferredContentSize);
  if (preferredContentSizeChanged) {
    // NOTE: Setting the preferredContentSize can lead to a change to self.view.bounds.
    self.preferredContentSize = calculatedPreferredContentSize;
  }

  if (preferredContentSizeChanged || boundsSizeChanged) {
    _previousLayoutSize = CGRectStandardize(self.alertView.bounds).size;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
  }
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

  [coordinator
      animateAlongsideTransition:^(
          __unused id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        // Reset preferredContentSize on viewWIllTransition to take advantage of additional width
        self.preferredContentSize =
            [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
      }
                      completion:nil];
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

#pragma mark - Setup Alert View

- (void)setupAlertView {
  self.alertView.titleLabel.text = self.title;
  if (@available(iOS 10.0, *)) {
    self.alertView.titleLabel.adjustsFontForContentSizeCategory =
        self.adjustsFontForContentSizeCategory;
  }
  if (self.attributedMessage.length > 0) {
    self.alertView.messageLabel.attributedText = self.attributedMessage;
  } else {
    self.alertView.messageLabel.text = self.message;
  }
  self.alertView.titleLabel.accessibilityLabel = self.titleAccessibilityLabel ?: self.title;
  self.alertView.messageLabel.accessibilityLabel = self.messageAccessibilityLabel ?: self.message;
  self.alertView.titleIconImageView.accessibilityLabel = self.imageAccessibilityLabel;
  self.alertView.titleIconView.accessibilityLabel = self.imageAccessibilityLabel;

  // TODO(https://github.com/material-components/material-components-ios/issues/8671): Update
  // adjustsFontForContentSizeCategory for messageLabel
  self.alertView.accessoryView = self.accessoryView;
  self.alertView.titleFont = self.titleFont;
  self.alertView.messageFont = self.messageFont;
  self.alertView.titleColor = self.titleColor ?: UIColor.blackColor;
  self.alertView.messageColor = self.messageColor ?: UIColor.blackColor;
  self.alertView.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable =
      self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;
  if (self.backgroundColor) {
    // Avoid reset background color to transparent when self.backgroundColor is nil.
    self.alertView.backgroundColor = self.backgroundColor;
  }
  if (self.buttonTitleColor) {
    // Avoid reset title color to white when setting it to nil. only set it for an actual UIColor.
    self.alertView.buttonColor = self.buttonTitleColor;  // b/117717380: Will be deprecated
  }
  self.alertView.buttonFont = self.buttonFont;  // b/117717380: Will be deprecated
  if (self.buttonInkColor) {
    // Avoid reset ink color to white when setting it to nil. only set it for an actual UIColor.
    self.alertView.buttonInkColor = self.buttonInkColor;  // b/117717380: Will be deprecated
  }
  self.alertView.titleAlignment = self.titleAlignment;
  self.alertView.messageAlignment = self.messageAlignment;
  self.alertView.titleIcon = self.titleIcon;
  self.alertView.titleIconTintColor = self.titleIconTintColor;
  self.alertView.titleIconAlignment = self.titleIconAlignment;
  self.alertView.titleIconView = self.titleIconView;
  self.alertView.cornerRadius = self.cornerRadius;
  self.alertView.enableRippleBehavior = self.enableRippleBehavior;
  self.orderVerticalActionsByEmphasis = NO;
  self.actionsHorizontalAlignment = MDCContentHorizontalAlignmentTrailing;
  self.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentCenter;

  // Create buttons for the actions (if not already created) and apply default styling
  for (MDCAlertAction *action in self.actions) {
    [self addButtonToAlertViewForAction:action];
  }
  // Explicitly overwrite the view default if true
  // We set this last to make sure all other properties are set first and no overridden by setting
  // this.
  if (self.mdc_adjustsFontForContentSizeCategory) {
    self.alertView.mdc_adjustsFontForContentSizeCategory = YES;
  }
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
