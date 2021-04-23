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

#import "MDCActionSheetController.h"

#import "private/MDCActionSheetHeaderView.h"
#import "private/MDCActionSheetItemTableViewCell.h"
#import "private/MaterialActionSheetStrings.h"
#import "private/MaterialActionSheetStrings_table.h"
#import "MDCActionSheetAction.h"
#import "MDCActionSheetControllerDelegate.h"
#import "MaterialAvailability.h"
#import "MaterialBottomSheet.h"
#import "MaterialElevation.h"
#import "MaterialShadowElevations.h"
#import "MaterialTypography.h"
#import "MaterialMath.h"

static NSString *const kReuseIdentifier = @"BaseCell";
static const CGFloat kActionImageAlpha = (CGFloat)0.6;
static const CGFloat kActionTextAlpha = (CGFloat)0.87;
static const CGFloat kDividerDefaultAlpha = (CGFloat)0.12;

// The Bundle for string resources.
static NSString *const kMaterialActionSheetBundle = @"MaterialActionSheet.bundle";

@interface MDCActionSheetController () <MDCBottomSheetPresentationControllerDelegate,
                                        UITableViewDelegate,
                                        UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) MDCActionSheetHeaderView *header;

/** The view that divides the header from the table. */
@property(nonatomic, strong, nonnull) UIView *headerDividerView;

/**
 Determines if a @c MDCActionSheetItemTableViewCell should add leading padding or not.

 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL addLeadingPaddingToCell;

/**
 Reloads the tables data and does a layout pass.
 */
- (void)updateTable;

@end

@interface MDCActionSheetAction ()

@property(nonatomic, nullable, copy) MDCActionSheetHandler completionHandler;

/**
 The @c MDCActionSheetController responsible for presenting the action.

 @note This is only set when the @c MDCActionSheetController's view is in the heirarchy else it is
 @c nil.
 */
@property(nonatomic, weak, nullable) MDCActionSheetController *actionSheet;

@end

@implementation MDCActionSheetAction

+ (instancetype)actionWithTitle:(NSString *)title
                          image:(UIImage *)image
                        handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
  return [[MDCActionSheetAction alloc] initWithTitle:title image:image handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                      handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
  self = [super init];
  if (self) {
    _title = [title copy];
    _image = [image copy];
    _completionHandler = [handler copy];
    _dividerColor = UIColor.clearColor;
  }
  return self;
}

- (id)copyWithZone:(__unused NSZone *)zone {
  MDCActionSheetAction *action = [[self class] actionWithTitle:self.title
                                                         image:self.image
                                                       handler:self.completionHandler];
  action.accessibilityIdentifier = self.accessibilityIdentifier;
  action.accessibilityLabel = self.accessibilityLabel;
  action.titleColor = self.titleColor;
  action.tintColor = self.tintColor;
  action.dividerColor = self.dividerColor;
  action.showsDivider = self.showsDivider;
  return action;
}

- (void)setImage:(UIImage *)image {
  _image = image;
  if (self.actionSheet) {
    [self.actionSheet updateTable];
  }
}

@end

@implementation MDCActionSheetController {
  NSMutableArray<MDCActionSheetAction *> *_actions;
  UIColor *_inkColor;
}

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;
@synthesize mdc_adjustsFontForContentSizeCategory = _mdc_adjustsFontForContentSizeCategory;

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title message:(NSString *)message {
  return [[MDCActionSheetController alloc] initWithTitle:title message:message];
}

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title {
  return [MDCActionSheetController actionSheetControllerWithTitle:title message:nil];
}

- (instancetype)init {
  return [MDCActionSheetController actionSheetControllerWithTitle:nil message:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _actions = [[NSMutableArray alloc] init];
    _transitionController = [[MDCBottomSheetTransitionController alloc] init];
    _transitionController.dismissOnBackgroundTap = YES;
    /**
     "We must call super because we've made the setters on this class unavailable and overridden
     their implementations to throw assertions."
     */
    super.transitioningDelegate = _transitionController;
    super.modalPresentationStyle = UIModalPresentationCustom;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _transitionController.trackingScrollView = _tableView;
    _tableView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 56;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MDCActionSheetItemTableViewCell class]
        forCellReuseIdentifier:kReuseIdentifier];

    _header = [[MDCActionSheetHeaderView alloc] initWithFrame:CGRectZero];
    _header.title = [title copy];
    _header.message = [message copy];
    _backgroundColor = UIColor.whiteColor;
    _header.backgroundColor = _backgroundColor;
    _tableView.backgroundColor = _backgroundColor;
    _actionTextColor = [UIColor.blackColor colorWithAlphaComponent:kActionTextAlpha];
    _actionTintColor = [UIColor.blackColor colorWithAlphaComponent:kActionImageAlpha];
    _imageRenderingMode = UIImageRenderingModeAlwaysTemplate;
    _headerDividerView = [[UIView alloc] init];
    _headerDividerView.backgroundColor =
        [UIColor.blackColor colorWithAlphaComponent:kDividerDefaultAlpha];
    _mdc_overrideBaseElevation = -1;
    _elevation = MDCShadowElevationModalBottomSheet;
  }

  return self;
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_actions addObject:action];
  if (self.alwaysAlignTitleLeadingEdges && action.image) {
    self.addLeadingPaddingToCell = YES;
  }
  [self updateTable];
}

- (UIView *)viewForAction:(MDCActionSheetAction *)action {
  if (![self.actions containsObject:action]) {
    return nil;
  }
  [self.view layoutIfNeeded];
  NSUInteger rowIndex = [self.actions indexOfObject:action];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
  return [self.tableView cellForRowAtIndexPath:indexPath];
}

- (NSArray<MDCActionSheetAction *> *)actions {
  return [_actions copy];
}

- (void)loadView {
  [super loadView];

  self.mdc_bottomSheetPresentationController.delegate = self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.backgroundColor;
  self.tableView.frame = self.view.bounds;
  self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
  self.view.preservesSuperviewLayoutMargins = YES;
  if (@available(iOS 11.0, *)) {
    self.view.insetsLayoutMarginsFromSafeArea = NO;
    self.tableView.insetsLayoutMarginsFromSafeArea = NO;
  }
  [self.view addSubview:self.tableView];
  [self.view addSubview:self.header];
  [self.view addSubview:self.headerDividerView];

  NSString *key =
      kMaterialActionSheetStringTable[kStr_MaterialActionSheetPresentedAccessibilityAnnouncement];
  NSString *announcement = NSLocalizedStringFromTableInBundle(
      key, kMaterialActionSheetStringsTableName, [[self class] bundle], @"Alert");
  UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, announcement);
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  if (self.tableView.contentSize.height > (CGRectGetHeight(self.view.bounds) / 2)) {
    self.mdc_bottomSheetPresentationController.preferredSheetHeight = [self openingSheetHeight];
  } else {
    self.mdc_bottomSheetPresentationController.preferredSheetHeight = 0;
  }
  CGSize size = [self.header sizeThatFits:CGRectStandardize(self.view.bounds).size];
  self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, size.height);
  CGFloat dividerHeight = self.showsHeaderDivider ? 1 : 0;
  self.headerDividerView.frame =
      CGRectMake(0, size.height, CGRectGetWidth(self.view.bounds), dividerHeight);
  UIEdgeInsets insets = UIEdgeInsetsMake(size.height + dividerHeight, 0, 0, 0);
  if (@available(iOS 11.0, *)) {
    insets.bottom = self.tableView.adjustedContentInset.bottom;
  }
  self.tableView.contentInset = insets;
  self.tableView.contentOffset = CGPointMake(0, -size.height);
}

- (CGFloat)openingSheetHeight {
  // If there are too many options to fit on half of the screen then show as many options as
  // possible minus half a cell, to allow for bleeding and signal to the user that the sheet is
  // scrollable content.
  CGFloat maxHeight = CGRectGetHeight(self.view.bounds) / 2;
  CGFloat headerHeight = [self.header sizeThatFits:CGRectStandardize(self.view.bounds).size].height;
  CGFloat cellHeight = self.tableView.contentSize.height / (CGFloat)_actions.count;
  CGFloat maxTableHeight = maxHeight - headerHeight;
  NSInteger amountOfCellsToShow = (NSInteger)(maxTableHeight / cellHeight);
  // There is already a partially shown cell that is showing and more than half is visable
  if (fmod(maxTableHeight, cellHeight) > (cellHeight * (CGFloat)0.5)) {
    amountOfCellsToShow += 1;
  }
  CGFloat preferredHeight =
      (((CGFloat)amountOfCellsToShow - (CGFloat)0.5) * cellHeight) + headerHeight;
  // When updating the preferredSheetHeight the presentation controller takes into account the
  // safe area so we have to remove that.
  if (@available(iOS 11.0, *)) {
    preferredHeight = preferredHeight - self.tableView.adjustedContentInset.bottom;
  }
  return ceil(preferredHeight);
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self.transitionController.trackingScrollView flashScrollIndicators];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  for (MDCActionSheetAction *action in self.actions) {
    action.actionSheet = self;
  }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.mdc_bottomSheetPresentationController.delegate = self;
#pragma clang diagnostic pop

  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap =
      self.transitionController.dismissOnBackgroundTap;
  [self.view layoutIfNeeded];
}

- (void)viewDidDisappear:(BOOL)animated {
  for (MDCActionSheetAction *action in self.actions) {
    action.actionSheet = nil;
  }
}

- (BOOL)accessibilityPerformEscape {
  if (!self.dismissOnBackgroundTap) {
    return NO;
  }
  [self
      dismissViewControllerAnimated:YES
                         completion:^{
                           if ([self.delegate
                                   respondsToSelector:@selector
                                   (actionSheetControllerDismissalAnimationCompleted:)]) {
                             [self.delegate actionSheetControllerDismissalAnimationCompleted:self];
                           }
                         }];
  return YES;
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
  [super preferredContentSizeDidChangeForChildContentContainer:container];

  [self.presentationController preferredContentSizeDidChangeForChildContentContainer:self];
}

- (UIScrollView *)trackingScrollView {
  return self.transitionController.trackingScrollView;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  self.transitionController.trackingScrollView = trackingScrollView;
}

- (BOOL)dismissOnBackgroundTap {
  return self.transitionController.dismissOnBackgroundTap;
}

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _transitionController.dismissOnBackgroundTap = dismissOnBackgroundTap;
  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap = dismissOnBackgroundTap;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.presentingViewController.supportedInterfaceOrientations;
}

/* Disable setter. Always use internal transition controller */
- (void)setTransitioningDelegate:
    (__unused id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCActionSheetController.transitioningDelegate cannot be changed.");
  return;
}

/* Disable setter. Always use custom presentation style */
- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCActionSheetController.modalPresentationStyle cannot be changed.");
  return;
}

#pragma mark - Table view

- (void)updateTable {
  [self.tableView reloadData];
  [self.tableView setNeedsLayout];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetAction *action = self.actions[indexPath.row];

  [self.presentingViewController dismissViewControllerAnimated:YES
                                                    completion:^(void) {
                                                      if (action.completionHandler) {
                                                        action.completionHandler(action);
                                                      }
                                                    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetItemTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
  MDCActionSheetAction *action = _actions[indexPath.row];
  cell.action = action;
  cell.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  cell.backgroundColor = self.backgroundColor;
  cell.actionFont = self.actionFont;
  cell.accessibilityIdentifier = action.accessibilityIdentifier;
  cell.rippleColor = self.rippleColor;
  cell.tintColor = action.tintColor ?: self.actionTintColor;
  cell.imageRenderingMode = self.imageRenderingMode;
  cell.addLeadingPadding = self.addLeadingPaddingToCell;
  cell.actionTextColor = action.titleColor ?: self.actionTextColor;
  cell.contentEdgeInsets = self.contentEdgeInsets;
  cell.dividerColor = action.dividerColor;
  cell.showsDivider = action.showsDivider;
  return cell;
}

- (void)tableView:(UITableView *)tableView
      willDisplayCell:(nonnull UITableViewCell *)cell
    forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  if ([self.delegate respondsToSelector:@selector(actionSheetController:
                                                        willDisplayView:forRowAtIndexPath:)]) {
    [self.delegate actionSheetController:self willDisplayView:cell forRowAtIndexPath:indexPath];
  }
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
  if (UIEdgeInsetsEqualToEdgeInsets(_contentEdgeInsets, contentEdgeInsets)) {
    return;
  }
  _contentEdgeInsets = contentEdgeInsets;
  [self.tableView reloadData];
}

- (void)setTitle:(NSString *)title {
  self.header.title = title;
  [self.view setNeedsLayout];
}

- (NSString *)title {
  return self.header.title;
}

- (void)setMessage:(NSString *)message {
  self.header.message = message;
  [self.view setNeedsLayout];
}

- (NSString *)message {
  return self.header.message;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    if ([self.traitCollection
            hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
      [self.tableView reloadData];
    }
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (void)setTitleFont:(UIFont *)titleFont {
  self.header.titleFont = titleFont;
}

- (UIFont *)titleFont {
  return self.header.titleFont;
}

- (void)setMessageFont:(UIFont *)messageFont {
  self.header.messageFont = messageFont;
}

- (UIFont *)messageFont {
  return self.header.messageFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  _backgroundColor = backgroundColor;
  self.view.backgroundColor = backgroundColor;
  self.tableView.backgroundColor = backgroundColor;
  self.header.backgroundColor = backgroundColor;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
  self.header.titleTextColor = titleTextColor;
}

- (UIColor *)titleTextColor {
  return self.header.titleTextColor;
}

- (void)setMessageTextColor:(UIColor *)messageTextColor {
  self.header.messageTextColor = messageTextColor;
}

- (UIColor *)messageTextColor {
  return self.header.messageTextColor;
}

- (void)setHeaderDividerColor:(UIColor *)headerDividerColor {
  self.headerDividerView.backgroundColor = headerDividerColor;
}

- (UIColor *)headerDividerColor {
  return self.headerDividerView.backgroundColor;
}

- (void)setShowsHeaderDivider:(BOOL)showsHeaderDivider {
  _showsHeaderDivider = showsHeaderDivider;
  self.headerDividerView.hidden = !showsHeaderDivider;
}

#pragma mark - Dynamic Type

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  self.header.mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateFontsForDynamicType];
  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateFontsForDynamicType)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }
  [self.view setNeedsLayout];
}

- (void)updateTableFonts {
  UIFont *finalActionsFont =
      _actionFont ?: [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    finalActionsFont = [finalActionsFont
        mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                     scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  }
  _actionFont = finalActionsFont;
  [self updateTable];
}

- (void)updateFontsForDynamicType {
  [self updateTableFonts];
  [self.view setNeedsLayout];
}

#pragma mark - Table customization

- (void)setActionFont:(UIFont *)actionFont {
  _actionFont = actionFont;
  [self.tableView reloadData];
}

- (void)setActionTextColor:(UIColor *)actionTextColor {
  _actionTextColor = actionTextColor;
  [self.tableView reloadData];
}

- (void)setActionTintColor:(UIColor *)actionTintColor {
  _actionTintColor = actionTintColor;
  [self.tableView reloadData];
}

- (void)setImageRenderingMode:(UIImageRenderingMode)imageRenderingMode {
  _imageRenderingMode = imageRenderingMode;
  [self.tableView reloadData];
}

- (void)setAlwaysAlignTitleLeadingEdges:(BOOL)alignTitles {
  _alwaysAlignTitleLeadingEdges = alignTitles;
  if (alignTitles) {
    // Check to make sure at least one action has an image. If not then all actions will align
    // already and we don't need to add padding.
    self.addLeadingPaddingToCell = [self anyActionHasAnImage];
  } else {
    self.addLeadingPaddingToCell = NO;
  }
  [self.tableView reloadData];
}

- (BOOL)anyActionHasAnImage {
  for (MDCActionSheetAction *action in self.actions) {
    if (action.image) {
      return YES;
    }
  }
  return NO;
}

- (void)setRippleColor:(UIColor *)rippleColor {
  _rippleColor = rippleColor;
  [self.tableView reloadData];
}

- (void)setElevation:(MDCShadowElevation)elevation {
  if (MDCCGFloatEqual(elevation, _elevation)) {
    return;
  }
  _elevation = elevation;
  [self.view mdc_elevationDidChange];
}

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

#pragma mark - MDCBottomSheetPresentationControllerDelegate

- (void)bottomSheetPresentationControllerDidDismissBottomSheet:
    (nonnull MDCBottomSheetController *)controller {
  if ([self.delegate respondsToSelector:@selector(actionSheetControllerDidDismiss:)]) {
    [self.delegate actionSheetControllerDidDismiss:self];
  }
}

- (void)bottomSheetPresentationControllerDismissalAnimationCompleted:
    (MDCBottomSheetPresentationController *)bottomSheet {
  if ([self.delegate
          respondsToSelector:@selector(actionSheetControllerDismissalAnimationCompleted:)]) {
    [self.delegate actionSheetControllerDismissalAnimationCompleted:self];
  }
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialActionSheetBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCActionSheetController class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

@end
