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

#import "MDCAlertController.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCDialogTransitionController.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"
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

  return action;
}

@end

// https://material.io/guidelines/components/dialogs.html#dialogs-specs
static const UIEdgeInsets MDCDialogContentInsets = {24.0, 24.0, 24.0, 24.0};
static const CGFloat MDCDialogContentVerticalPadding = 20.0;

static const UIEdgeInsets MDCDialogActionsInsets = {8.0, 8.0, 8.0, 8.0};
static const CGFloat MDCDialogActionsHorizontalPadding = 8.0;
static const CGFloat MDCDialogActionsVerticalPadding = 8.0;
static const CGFloat MDCDialogActionButtonHeight = 36.0;
static const CGFloat MDCDialogActionButtonMinimumWidth = 48.0;

static const CGFloat MDCDialogMessageOpacity = 0.54f;

@interface MDCAlertController ()

@property(nonatomic, nonnull, strong) NSMutableArray<UIButton *> *actionButtons;

@property(nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic, strong) UIScrollView *actionsScrollView;

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;

@property(nonatomic, strong) MDCDialogTransitionController *transitionController;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message;

@end

@implementation MDCAlertController {
  NSString *_alertTitle;
  NSString *_message;

  NSMutableArray<MDCAlertAction *> *_actions;

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
    _alertTitle = [title copy];
    _message = [message copy];

    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _actionsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];

    _actions = [[NSMutableArray alloc] init];
    _actionButtons = [[NSMutableArray alloc] init];

    _transitionController = [[MDCDialogTransitionController alloc] init];
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

- (NSString *)title {
  return _alertTitle;
}

- (void)setTitle:(NSString *)title {
  _alertTitle = [title copy];
  self.titleLabel.text = _alertTitle;

  self.preferredContentSize = [self calculatePreferredContentSizeForBounds:CGRectInfinite.size];

  [self.view setNeedsLayout];
}

- (NSString *)message {
  return _message;
}

- (void)setMessage:(NSString *)message {
  _message = [message copy];
  self.messageLabel.text = _message;

  self.preferredContentSize = [self calculatePreferredContentSizeForBounds:CGRectInfinite.size];

  [self.view setNeedsLayout];
}

- (NSArray<MDCAlertAction *> *)actions {
  return [_actions copy];
}

- (void)addAction:(MDCAlertAction *)action {
  [_actions addObject:[action copy]];

  MDCFlatButton *actionButton = [[MDCFlatButton alloc] initWithFrame:CGRectZero];
  actionButton.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  [actionButton setTitle:action.title forState:UIControlStateNormal];
  // TODO(#1726): Determine default text color values for Normal and Disabled
  CGRect buttonRect = actionButton.bounds;
  buttonRect.size.height = MAX(buttonRect.size.height, MDCDialogActionButtonHeight);
  buttonRect.size.width = MAX(buttonRect.size.width, MDCDialogActionButtonMinimumWidth);
  actionButton.frame = buttonRect;
  [actionButton addTarget:self
                   action:@selector(actionButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
  [self.actionsScrollView addSubview:actionButton];

  [self.actionButtons addObject:actionButton];

  self.preferredContentSize = [self calculatePreferredContentSizeForBounds:CGRectInfinite.size];

  [self.view setNeedsLayout];
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  // Update any action buttons to match the alert controller.
  for (MDCButton *actionButton in self.actionButtons) {
    actionButton.mdc_adjustsFontForContentSizeCategory = adjusts;
  }

  if (_mdc_adjustsFontForContentSizeCategory) {
    [self updateFontsForDynamicType];
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
  self.titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleTitle];
  self.messageLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

  // The action MDCButtons handle their own resizing

  // Our presentation controller reacts to changes to preferredContentSize to determine our
  // frame at the presented controller.
  self.preferredContentSize = [self calculatePreferredContentSizeForBounds:CGRectInfinite.size];
}

- (void)actionButtonPressed:(id)sender {
  NSInteger actionIndex = [self.actionButtons indexOfObject:sender];
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

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  self.view.autoresizesSubviews = NO;
  self.view.clipsToBounds = YES;

  self.contentScrollView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.contentScrollView];

  self.actionsScrollView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.actionsScrollView];

  self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.titleLabel.numberOfLines = 0;
  self.titleLabel.textAlignment = NSTextAlignmentNatural;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    self.titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleTitle];
  } else {
    self.titleLabel.font = [MDCTypography titleFont];
  }
  [self.contentScrollView addSubview:self.titleLabel];

  self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.messageLabel.numberOfLines = 0;
  self.messageLabel.textAlignment = NSTextAlignmentNatural;
  if (self.mdc_adjustsFontForContentSizeCategory) {
    self.messageLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
  } else {
    self.messageLabel.font = [MDCTypography body1Font];
  }
  self.messageLabel.textColor = [UIColor colorWithWhite:0.0f alpha:MDCDialogMessageOpacity];
  [self.contentScrollView addSubview:self.messageLabel];

  self.titleLabel.text = self.title;
  self.messageLabel.text = self.message;

  CGSize idealSize = [self calculatePreferredContentSizeForBounds:CGRectInfinite.size];

  self.preferredContentSize = idealSize;
  _previousLayoutSize = CGSizeZero;

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

  for (UIButton *button in self.actionButtons) {
    [button sizeToFit];
  }

  // Recalculate preferredSize, which is based on width available, if the viewSize has changed.
  if (CGRectGetWidth(self.view.bounds) != _previousLayoutSize.width ||
      CGRectGetHeight(self.view.bounds) != _previousLayoutSize.height) {
    CGSize currentPreferredContentSize = self.preferredContentSize;
    CGSize calculatedPreferredContentSize =
        [self calculatePreferredContentSizeForBounds:CGRectStandardize(self.view.bounds).size];

    if (!CGSizeEqualToSize(currentPreferredContentSize, calculatedPreferredContentSize)) {
      // NOTE: Setting the preferredContentSize can lead to a change to self.view.bounds.
      self.preferredContentSize = calculatedPreferredContentSize;
    }

    _previousLayoutSize = CGRectStandardize(self.view.bounds).size;
  }

  // Used to calculate the height of the scrolling content, so we limit the width.
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = CGRectGetWidth(self.view.bounds);

  // Content
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];

  CGRect contentRect = CGRectZero;
  contentRect.size.width = CGRectGetWidth(self.view.bounds);
  contentRect.size.height = contentSize.height;

  self.contentScrollView.contentSize = contentRect.size;

  // Place Content in contentScrollView
  boundsSize.width = boundsSize.width - MDCDialogContentInsets.left - MDCDialogContentInsets.right;
  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  titleSize.width = boundsSize.width;
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;
  boundsSize.width = boundsSize.width + MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentInternalVerticalPadding = 0.0;
  if (0.0 < titleSize.height && 0.0 < messageSize.height) {
    contentInternalVerticalPadding = MDCDialogContentVerticalPadding;
  }

  CGRect titleFrame = CGRectMake(MDCDialogContentInsets.left, MDCDialogContentInsets.top,
                                 titleSize.width, titleSize.height);
  CGRect messageFrame = CGRectMake(MDCDialogContentInsets.left,
                                   CGRectGetMaxY(titleFrame) + contentInternalVerticalPadding,
                                   messageSize.width, messageSize.height);

  self.titleLabel.frame = titleFrame;
  self.messageLabel.frame = messageFrame;

  // Actions
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];
  const CGFloat horizontalActionHeight =
      MDCDialogActionsInsets.top + MDCDialogActionButtonHeight + MDCDialogActionsInsets.bottom;
  if (horizontalActionHeight < actionSize.height) {
    self.verticalActionsLayout = YES;
  } else {
    self.verticalActionsLayout = NO;
  }

  CGRect actionsFrame = CGRectZero;
  actionsFrame.size.width = CGRectGetWidth(self.view.bounds);
  if (0 < [self.actions count]) {
    actionsFrame.size.height = actionSize.height;
  }
  self.actionsScrollView.contentSize = actionsFrame.size;

  // Place buttons in actionsScrollView
  if (self.isVerticalActionsLayout) {
    CGPoint buttonCenter;
    buttonCenter.x = self.actionsScrollView.contentSize.width * 0.5f;
    buttonCenter.y = self.actionsScrollView.contentSize.height - MDCDialogActionsInsets.bottom;
    for (UIButton *button in self.actionButtons) {
      CGRect buttonRect = button.frame;

      buttonCenter.y -= buttonRect.size.height * 0.5;

      button.center = buttonCenter;

      if (button != [self.actionButtons lastObject]) {
        buttonCenter.y -= buttonRect.size.height * 0.5;
        buttonCenter.y -= MDCDialogActionsVerticalPadding;
      }
    }
  } else {
    CGPoint buttonOrigin = CGPointZero;
    buttonOrigin.x = self.actionsScrollView.contentSize.width - MDCDialogActionsInsets.right;
    buttonOrigin.y = MDCDialogActionsInsets.top;
    for (UIButton *button in self.actionButtons) {
      CGRect buttonRect = button.frame;

      buttonOrigin.x -= buttonRect.size.width;
      buttonRect.origin = buttonOrigin;

      button.frame = buttonRect;

      if (button != [self.actionButtons lastObject]) {
        buttonOrigin.x -= MDCDialogActionsHorizontalPadding;
      }
    }
    // Handle RTL
    if (self.view.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      for (UIButton *button in self.actionButtons) {
        CGRect flippedRect =
          MDFRectFlippedHorizontally(button.frame, CGRectGetWidth(self.view.bounds));
        button.frame = flippedRect;
      }
    }
  }

  // Place scrollviews
  CGRect contentScrollViewRect = CGRectZero;
  contentScrollViewRect.size = self.contentScrollView.contentSize;

  CGRect actionsScrollViewRect = CGRectZero;
  actionsScrollViewRect.size = self.actionsScrollView.contentSize;

  const CGFloat requestedHeight =
      self.contentScrollView.contentSize.height + self.actionsScrollView.contentSize.height;
  if (requestedHeight <= CGRectGetHeight(self.view.bounds)) {
    // Simple layout case : both content and actions fit on the screen at once
    self.contentScrollView.frame = contentScrollViewRect;

    actionsScrollViewRect.origin.y =
        CGRectGetHeight(self.view.bounds) - actionsScrollViewRect.size.height;
    self.actionsScrollView.frame = actionsScrollViewRect;
  } else {
    // Complex layout case : Split the space between the two scrollviews
    if (CGRectGetHeight(contentScrollViewRect) < CGRectGetHeight(self.view.bounds) * 0.5f) {
      actionsScrollViewRect.size.height =
          CGRectGetHeight(self.view.bounds) - contentScrollViewRect.size.height;
    } else {
      CGFloat maxActionsHeight = CGRectGetHeight(self.view.bounds) * 0.5f;
      actionsScrollViewRect.size.height = MIN(maxActionsHeight, actionsScrollViewRect.size.height);
    }
    actionsScrollViewRect.origin.y =
        CGRectGetHeight(self.view.bounds) - actionsScrollViewRect.size.height;
    self.actionsScrollView.frame = actionsScrollViewRect;

    contentScrollViewRect.size.height =
        CGRectGetHeight(self.view.bounds) - actionsScrollViewRect.size.height;
    self.contentScrollView.frame = contentScrollViewRect;
  }
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        // Reset preferredContentSize on viewWIllTransition to take advantage of additional width
        self.preferredContentSize =
            [self calculatePreferredContentSizeForBounds:CGRectInfinite.size];
      }
                               completion:nil];
}

#pragma mark - Internal

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateContentSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - MDCDialogContentInsets.left - MDCDialogContentInsets.right;

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];

  CGFloat contentWidth = MAX(titleSize.width, messageSize.width);
  contentWidth += MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentInternalVerticalPadding = 0.0;
  if (0.0 < titleSize.height && 0.0 < messageSize.height) {
    contentInternalVerticalPadding = MDCDialogContentVerticalPadding;
  }
  CGFloat contentHeight = titleSize.height + contentInternalVerticalPadding + messageSize.height;
  contentHeight += MDCDialogContentInsets.top + MDCDialogContentInsets.bottom;

  CGSize contentSize;
  contentSize.width = (CGFloat)ceil(contentWidth);
  contentSize.height = (CGFloat)ceil(contentHeight);

  return contentSize;
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateActionsSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth;

  CGSize horizontalSize = [self actionButtonsSizeInHorizontalLayout];
  CGSize verticalSize = [self actionButtonsSizeInVericalLayout];

  CGSize actionsSize;
  if (boundsSize.width < horizontalSize.width) {
    // Use VerticalLayout
    actionsSize.width = MIN(verticalSize.width, boundsSize.width);
    actionsSize.height = MIN(verticalSize.height, boundsSize.height);
  } else {
    // Use HorizontalLayout
    actionsSize.width = MIN(horizontalSize.width, boundsSize.width);
    actionsSize.height = MIN(horizontalSize.height, boundsSize.height);
  }

  actionsSize.width = (CGFloat)ceil(actionsSize.width);
  actionsSize.height = (CGFloat)ceil(actionsSize.height);

  return actionsSize;
}

// @param boundsSize should not include any internal margins or padding
- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize {
  // Content & Actions
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  // Final Sizing
  CGSize totalSize;
  totalSize.width = MAX(contentSize.width, actionSize.width);
  totalSize.height = contentSize.height + actionSize.height;

  return totalSize;
}

- (CGSize)actionButtonsSizeInHorizontalLayout {
  CGSize size = CGSizeZero;
  if (0 < [self.actions count]) {
    size.height =
        MDCDialogActionsInsets.top + MDCDialogActionButtonHeight + MDCDialogActionsInsets.bottom;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in self.actionButtons) {
      size.width += CGRectGetWidth(button.bounds);
      if (button != [self.actionButtons lastObject]) {
        size.width += MDCDialogActionsHorizontalPadding;
      }
    }
  }

  return size;
}

- (CGSize)actionButtonsSizeInVericalLayout {
  CGSize size = CGSizeZero;
  if (0 < [self.actions count]) {
    size.height = MDCDialogActionsInsets.top + MDCDialogActionsInsets.bottom;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in self.actionButtons) {
      size.height += CGRectGetHeight(button.bounds);
      size.width = MAX(size.width, CGRectGetWidth(button.bounds));
      if (button != [self.actionButtons lastObject]) {
        size.height += MDCDialogActionsVerticalPadding;
      }
    }
  }

  return size;
}

#pragma mark - UIAccessibilityAction

- (BOOL)accessibilityPerformEscape {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
  return YES;
}

@end
