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
#import <UIKit/UIKit.h>
#import "MDCAlertController+Customize.h"

#import "private/MDCAlertActionManager.h"
#import "private/MDCAlertControllerView+Private.h"
#import "private/MaterialDialogsStrings.h"
#import "private/MaterialDialogsStrings_table.h"
#import "MDCButton.h"
#import "MDCAlertControllerDelegate.h"
#import "MDCAlertControllerView.h"
#import "MDCDialogPresentationController.h"
#import "MDCDialogPresentationControllerDelegate.h"
#import "MDCDialogTransitionController.h"
#import "UIViewController+MaterialDialogs.h"
#import "UIView+MaterialElevationResponding.h"
#import "M3CButton.h"
#import "MDCShadowElevations.h"
#import "MDCMath.h"

NS_ASSUME_NONNULL_BEGIN

const int MAX_LAYOUT_PASSES = 10;

// The Bundle for string resources.
static NSString *const kMaterialDialogsBundle = @"MaterialDialogs.bundle";

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
    _dismissOnAction = YES;
    _emphasis = emphasis;
    _tapHandler = [handler copy];
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(__unused NSZone *_Nullable)zone {
  MDCAlertAction *action = [[self class] actionWithTitle:self.title
                                                emphasis:self.emphasis
                                                 handler:self.tapHandler];
  action.accessibilityIdentifier = self.accessibilityIdentifier;

  return action;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[MDCAlertAction class]]) {
    return NO;
  }

  MDCAlertAction *anotherAction = (MDCAlertAction *)object;
  if (self == anotherAction) {
    return YES;
  }

  return
      [self.title isEqualToString:anotherAction.title] && self.emphasis == anotherAction.emphasis;
}

@end

@interface MDCAlertController () <UITextViewDelegate>

/**
 A flag to determine whether to use `M3CButton` in place of `MDCButton`.

 Defaults to NO, but we eventually want to default it to YES and remove this property altogether.
 */
@property(nonatomic) BOOL enableM3CButton;
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;
@property(nonatomic, strong) MDCDialogTransitionController *transitionController;
@property(nonatomic, nonnull, strong) MDCAlertActionManager *actionManager;
@property(nonatomic, nullable, strong) UIView *titleIconView;

/**
 This counter caps the maximum number of layout passes that can be done in a single layout cycle.

 This variable is added as a direct fix for b/345505157.
 */
@property(nonatomic) int layoutPassCounter;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message;

@end

@implementation MDCAlertController {
  // This is because title is overlapping with view controller title, However Apple alertController
  // redefines title as well.
  NSString *_alertTitle;
  CGSize _previousLayoutSize;
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
    _shouldPlaceAccessoryViewAboveMessage = NO;
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

    _layoutPassCounter = 0;
    _alertTitle = [title copy];
    _titleAlignment = NSTextAlignmentNatural;
    _messageAlignment = NSTextAlignmentNatural;
    _titleIconAlignment = _titleAlignment;
    _alignIconWithTitle = YES;
    _orderVerticalActionsByEmphasis = NO;
    _actionsHorizontalAlignment = MDCContentHorizontalAlignmentTrailing;
    _actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentCenter;
    _actionManager = [[MDCAlertActionManager alloc] init];
    _shadowColor = UIColor.blackColor;
    _mdc_overrideBaseElevation = -1;
    _shouldAutorotateOverride = super.shouldAutorotate;
    _supportedInterfaceOrientationsOverride = super.supportedInterfaceOrientations;
    _preferredInterfaceOrientationForPresentationOverride =
        super.preferredInterfaceOrientationForPresentation;
    _modalTransitionStyleOverride = super.modalTransitionStyle;
    _titlePinsToTop = YES;

    _M3CButtonEnabled = NO;
    [_actionManager setM3CButtonEnabled:_M3CButtonEnabled];

    super.transitioningDelegate = _transitionController;
    super.modalPresentationStyle = UIModalPresentationCustom;
  }
  return self;
}

- (void)setM3CButtonEnabled:(BOOL)enable {
  if (_M3CButtonEnabled == enable) {
    return;
  }
  _M3CButtonEnabled = enable;
  [self.actionManager setM3CButtonEnabled:_M3CButtonEnabled];
  [self.alertView setM3CButtonEnabled:_M3CButtonEnabled];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
  if (![self.traitCollection.preferredContentSizeCategory
          isEqualToString:previousTraitCollection.preferredContentSizeCategory]) {
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
    [self.view setNeedsLayout];
  }
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:
    (__unused __nullable id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCAlertController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCAlertController.modalPresentationStyle cannot be changed.");
  return;
}

- (void)setTitle:(nullable NSString *)title {
  _alertTitle = [title copy];
  if (self.alertView) {
    self.alertView.titleLabel.text = title;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (nullable NSString *)title {
  return _alertTitle;
}

- (void)setTitlePinsToTop:(BOOL)titlePinsToTop {
  _titlePinsToTop = titlePinsToTop;
  if (self.alertView) {
    self.alertView.titlePinsToTop = titlePinsToTop;
  }
}

- (void)setTitleAccessibilityLabel:(nullable NSString *)titleAccessibilityLabel {
  _titleAccessibilityLabel = [titleAccessibilityLabel copy];
  if (self.alertView && titleAccessibilityLabel) {
    self.alertView.titleLabel.accessibilityLabel = titleAccessibilityLabel;
  }
}

- (void)setMessage:(nullable NSString *)message {
  _message = [message copy];
  if (self.alertView) {
    [self messageDidChange];
  }
}

- (void)setAttributedMessage:(nullable NSAttributedString *)attributedMessage {
  _attributedMessage = [attributedMessage copy];
  if (self.alertView) {
    [self messageDidChange];
  }
}

- (void)setAttributedLinkColor:(nullable UIColor *)attributedLinkColor {
  if ([_attributedLinkColor isEqual:attributedLinkColor]) {
    return;
  }
  _attributedLinkColor = attributedLinkColor;
  if (self.alertView) {
    self.alertView.messageTextView.tintColor = attributedLinkColor;
  }
}

- (void)messageDidChange {
  if (self.attributedMessage.length > 0) {
    self.alertView.messageTextView.attributedText = self.attributedMessage;
  } else {
    self.alertView.messageTextView.text = self.message;
  }
  self.preferredContentSize =
      [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
}

- (void)setMessageAccessibilityLabel:(nullable NSString *)messageAccessibilityLabel {
  _messageAccessibilityLabel = [messageAccessibilityLabel copy];
  if (self.alertView && messageAccessibilityLabel) {
    self.alertView.messageTextView.accessibilityLabel = messageAccessibilityLabel;
  }
}

- (void)setImageAccessibilityLabel:(nullable NSString *)imageAccessibilityLabel {
  if ([_imageAccessibilityLabel isEqual:imageAccessibilityLabel]) {
    return;
  }
  _imageAccessibilityLabel = [imageAccessibilityLabel copy];

  if (self.alertView) {
    self.alertView.titleIconImageView.accessibilityLabel = _imageAccessibilityLabel;
    self.alertView.titleIconView.accessibilityLabel = _imageAccessibilityLabel;
  }
}

- (nullable NSString *)imageAccessibilityLabel {
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

- (void)setAccessoryView:(nullable UIView *)accessoryView {
  if (_accessoryView == accessoryView) {
    return;
  }

  _accessoryView = accessoryView;

  if (self.alertView) {
    self.alertView.accessoryView = accessoryView;
    [self setAccessoryViewNeedsLayout];
  }
}

- (void)setShouldPlaceAccessoryViewAboveMessage:(BOOL)shouldPlaceAccessoryViewAboveMessage {
  if (_shouldPlaceAccessoryViewAboveMessage != shouldPlaceAccessoryViewAboveMessage) {
    _shouldPlaceAccessoryViewAboveMessage = shouldPlaceAccessoryViewAboveMessage;
    self.alertView.shouldPlaceAccessoryViewAboveMessage = shouldPlaceAccessoryViewAboveMessage;
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

- (void)setDialogEdgeInsets:(UIEdgeInsets)dialogEdgeInsets {
  [self dialogTransitionController].dialogEdgeInsets = dialogEdgeInsets;
}

- (UIEdgeInsets)dialogEdgeInsets {
  return [self dialogTransitionController].dialogEdgeInsets;
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

- (void)addActions:(NSArray<MDCAlertAction *> *)actions {
  for (MDCAlertAction *action in actions) {
    [self addAction:action];
  }
}

- (nullable MDCButton *)buttonForAction:(nonnull MDCAlertAction *)action {
  UIButton *button = [self.actionManager buttonForAction:action];
  if (!button && [self.actionManager hasAction:action] && !self.isM3CButtonEnabled) {
    button = [self.actionManager createButtonForAction:action
                                                target:self
                                              selector:@selector(actionButtonPressed:forEvent:)];
    [MDCAlertControllerView styleAsTextButton:(MDCButton *)button];
  }
  if ([button isKindOfClass:[MDCButton class]]) {
    return (MDCButton *)button;
  }
  return nil;
}

- (nullable M3CButton *)M3CButtonForAction:(nonnull MDCAlertAction *)action {
  UIButton *button = [self.actionManager buttonForAction:action];
  if (!button && [self.actionManager hasAction:action] && self.isM3CButtonEnabled) {
    button = [self.actionManager createButtonForAction:action
                                                target:self
                                              selector:@selector(actionButtonPressed:forEvent:)];
  }
  if ([button isKindOfClass:[M3CButton class]]) {
    return (M3CButton *)button;
  }
  return nil;
}

- (void)addButtonToAlertViewForAction:(MDCAlertAction *)action {
  if (self.alertView) {
    UIButton *button;
    if (!self.isM3CButtonEnabled) {
      button = [self buttonForAction:action];
    } else {
      button = [self M3CButtonForAction:action];
    }
    [self.alertView addActionButton:button];
    [button setAccessibilityIdentifier:action.accessibilityIdentifier];
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

- (void)setTitleFont:(nullable UIFont *)titleFont {
  _titleFont = titleFont;
  if (self.alertView) {
    self.alertView.titleFont = titleFont;
  }
}

- (void)setMessageFont:(nullable UIFont *)messageFont {
  _messageFont = messageFont;
  if (self.alertView) {
    self.alertView.messageFont = messageFont;
  }
}

- (void)setTitleColor:(nullable UIColor *)titleColor {
  _titleColor = titleColor;
  if (self.alertView) {
    self.alertView.titleColor = titleColor;
  }
}

- (void)setMessageColor:(nullable UIColor *)messageColor {
  _messageColor = messageColor;
  if (self.alertView) {
    self.alertView.messageColor = messageColor;
  }
}

// b/117717380: Will be deprecated
- (void)setButtonTitleColor:(nullable UIColor *)buttonColor {
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

- (void)setTitleIcon:(nullable UIImage *)titleIcon {
  _titleIcon = titleIcon;
  if (self.alertView) {
    self.alertView.titleIcon = titleIcon;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (void)setTitleIconView:(nullable UIView *)titleIconView {
  _titleIconView = titleIconView;
  if (self.alertView) {
    self.alertView.titleIconView = titleIconView;
    self.preferredContentSize =
        [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
  }
}

- (void)setTitleIconTintColor:(nullable UIColor *)titleIconTintColor {
  _titleIconTintColor = titleIconTintColor;
  if (self.alertView) {
    self.alertView.titleIconTintColor = titleIconTintColor;
  }
}

- (nullable UIImageView *)titleIconImageView {
  return self.alertView.titleIconImageView;
}

- (void)setTitleIconAlignment:(NSTextAlignment)titleIconAlignment {
  _alignIconWithTitle = NO;
  _titleIconAlignment = titleIconAlignment;
  if (self.alertView) {
    self.alertView.titleIconAlignment = titleIconAlignment;
  }
}

- (void)setScrimColor:(nullable UIColor *)scrimColor {
  _scrimColor = scrimColor;
  self.mdc_dialogPresentationController.scrimColor = scrimColor;
}

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor {
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
  if (self.viewLoaded) {
    self.alertView.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
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

- (void)actionButtonPressed:(id)button forEvent:(UIEvent *)event {
  MDCAlertAction *action = [self.actionManager actionForButton:button];
  if ([self.delegate respondsToSelector:@selector(alertController:didTapAction:withEvent:)]) {
    [self.delegate alertController:self didTapAction:action withEvent:event];
  }

  if (action.dismissOnAction) {
    // We call our action.tapHandler after we dismiss the existing alert in case the handler
    // also presents a view controller. Otherwise we get a warning about presenting on a controller
    // which is already presenting.
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:^(void) {
                                                        if (action.tapHandler) {
                                                          action.tapHandler(action);
                                                        }
                                                      }];
  } else {
    if (action.tapHandler) {
      action.tapHandler(action);
    }
  }
}

#pragma mark - Text View Delegate

- (BOOL)textView:(UITextView *)textView
    shouldInteractWithURL:(NSURL *)URL
                  inRange:(NSRange)characterRange
              interaction:(UITextItemInteraction)interaction {
  if (self.attributedMessageAction != nil) {
    return self.attributedMessageAction(URL, characterRange, interaction);
  }
  return YES;
}

#pragma mark - UIViewController

- (void)loadView {
  self.view = [[MDCAlertControllerView alloc] initWithFrame:CGRectZero];
  self.alertView = (MDCAlertControllerView *)self.view;
  [self.alertView setM3CButtonEnabled:self.isM3CButtonEnabled];
  [self.alertView
      setShouldPlaceAccessoryViewAboveMessage:self.shouldPlaceAccessoryViewAboveMessage];
  // sharing MDCActionManager with with the alert view
  self.alertView.actionManager = self.actionManager;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupAlertView];

  _previousLayoutSize = CGSizeZero;

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
  [super viewDidLayoutSubviews];
  // Increments the counter to account for an additional layout pass.
  self.layoutPassCounter += 1;
  // Abort if the layout pass counter is too high.
  if (self.layoutPassCounter > MAX_LAYOUT_PASSES) {
    return;
  }
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
  // Resets counter as this function is called at the beginning of a new layout cycle.
  self.layoutPassCounter = 0;

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
        [self.alertView setNeedsLayout];
        // Reset preferredContentSize on viewWillTransition to take advantage of additional width.
        self.preferredContentSize =
            [self.alertView calculatePreferredContentSizeForBounds:CGRectInfinite.size];
      }
                      completion:nil];
}

- (BOOL)shouldAutorotate {
  return _shouldAutorotateOverride;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return _supportedInterfaceOrientationsOverride;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  return _preferredInterfaceOrientationForPresentationOverride;
}

- (UIModalTransitionStyle)modalTransitionStyle {
  return _modalTransitionStyleOverride;
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
  self.alertView.adjustsFontForContentSizeCategory = self.adjustsFontForContentSizeCategory;
  if (self.attributedMessage.length > 0) {
    self.alertView.messageTextView.attributedText = self.attributedMessage;
  } else {
    self.alertView.messageTextView.text = self.message;
  }
  self.alertView.titleLabel.accessibilityLabel = self.titleAccessibilityLabel ?: self.title;
  self.alertView.messageTextView.accessibilityLabel =
      self.messageAccessibilityLabel ?: self.message;
  // Set messageTextView's accessibilityValue to the empty string to resolve b/158732017.
  // For a plain string, the MessageTextView acts as a label and should not have an
  // accessibilityValue. Setting the accessibilityValue to nil causes VoiceOver to use the default
  // value, which is the text of the message, so the value must be set to the empty string instead.
  // This is not the case for attributed strings as disabling the accessibilityValue will not call
  // out attribute traits, e.g (embedded links).
  if ([self shouldUseAttributedStringForMessageA11Y]) {
    self.alertView.messageTextView.accessibilityLabel = self.attributedMessage.accessibilityLabel;
  } else {
    self.alertView.messageTextView.accessibilityValue = @"";
  }

  self.alertView.messageTextView.delegate = self;

  self.alertView.titleIconImageView.accessibilityLabel = self.imageAccessibilityLabel;
  self.alertView.titleIconView.accessibilityLabel = self.imageAccessibilityLabel;

  // TODO(https://github.com/material-components/material-components-ios/issues/8671): Update
  // adjustsFontForContentSizeCategory for messageTextView
  self.alertView.accessoryView = self.accessoryView;
  self.alertView.titleFont = self.titleFont;
  self.alertView.messageFont = self.messageFont;
  self.alertView.titleColor = self.titleColor ?: UIColor.blackColor;
  self.alertView.messageTextView.tintColor = self.attributedLinkColor;
  if (self.attributedMessage.length > 0) {
    // Avoid overriding `messageColor` during initialization, to allow the attributed messages's
    // foregroundColor to take precedence in case `messageColor` was not set.
    if (self.messageColor != nil) {
      self.alertView.messageColor = self.messageColor;
    }
  } else {
    self.alertView.messageColor = self.messageColor ?: UIColor.blackColor;
  }
  if (self.backgroundColor) {
    // Avoid reset background color to transparent when self.backgroundColor is nil.
    self.alertView.backgroundColor = self.backgroundColor;
  }
  if (self.buttonTitleColor) {
    // Avoid reset title color to white when setting it to nil. only set it for an actual UIColor.
    self.alertView.buttonColor = self.buttonTitleColor;  // b/117717380: Will be deprecated
  }
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
  self.alertView.orderVerticalActionsByEmphasis = self.orderVerticalActionsByEmphasis;
  self.alertView.actionsHorizontalAlignment = self.actionsHorizontalAlignment;
  self.alertView.actionsHorizontalAlignmentInVerticalLayout =
      self.actionsHorizontalAlignmentInVerticalLayout;
  self.alertView.titlePinsToTop = self.titlePinsToTop;

  // Create buttons for the actions (if not already created) and apply default styling
  for (MDCAlertAction *action in self.actions) {
    [self addButtonToAlertViewForAction:action];
  }
}

#pragma mark - UIAccessibilityAction

- (BOOL)accessibilityPerformEscape {
  MDCDialogPresentationController *dialogPresentationController =
      self.mdc_dialogPresentationController;
  if (dialogPresentationController.dismissOnBackgroundTap) {
    BOOL shouldDismiss = YES;
    if ([dialogPresentationController.dialogPresentationControllerDelegate
            respondsToSelector:@selector(dialogPresentationControllerShouldDismiss:)]) {
      shouldDismiss = [dialogPresentationController.dialogPresentationControllerDelegate
          dialogPresentationControllerShouldDismiss:dialogPresentationController];
    }
    if (!shouldDismiss) {
      return NO;
    }
    if ([dialogPresentationController.dialogPresentationControllerDelegate
            respondsToSelector:@selector(dialogPresentationControllerWillDismiss:)]) {
      [dialogPresentationController.dialogPresentationControllerDelegate
          dialogPresentationControllerWillDismiss:dialogPresentationController];
    }
    void (^dismissalCompletion)(void) = ^{
      if ([dialogPresentationController.dialogPresentationControllerDelegate
              respondsToSelector:@selector(dialogPresentationControllerDidDismiss:)]) {
        [dialogPresentationController.dialogPresentationControllerDelegate
            dialogPresentationControllerDidDismiss:dialogPresentationController];
      }
    };
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:dismissalCompletion];
    return YES;
  }
  return NO;
}

#pragma mark - Private

/// Returns YES if the attributed message should be used as an accessibility label of the alert
/// message.
/// This happens when the attributed message was explicitly provided without a custom accessibility
/// label.
- (BOOL)shouldUseAttributedStringForMessageA11Y {
  return !(self.messageAccessibilityLabel || self.message) && self.attributedMessage;
}

@end

NS_ASSUME_NONNULL_END
