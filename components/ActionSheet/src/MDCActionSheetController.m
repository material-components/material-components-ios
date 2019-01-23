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

#import <MaterialComponents/MaterialMath.h>
#import <MaterialComponents/MaterialTypography.h>
#import "private/MDCActionSheetHeaderView.h"
#import "private/MDCActionSheetItemTableViewCell.h"

static NSString *const kReuseIdentifier = @"BaseCell";
static const CGFloat kActionImageAlpha = (CGFloat)0.6;
static const CGFloat kActionTextAlpha = (CGFloat)0.87;

@interface MDCActionSheetAction ()

@property(nonatomic, nullable, copy) MDCActionSheetHandler completionHandler;

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
  }
  return self;
}

- (id)copyWithZone:(__unused NSZone *)zone {
  MDCActionSheetAction *action = [[self class] actionWithTitle:self.title
                                                         image:self.image
                                                       handler:self.completionHandler];
  action.accessibilityIdentifier = self.accessibilityIdentifier;
  action.accessibilityLabel = self.accessibilityLabel;
  return action;
}

@end

@interface MDCActionSheetController () <MDCBottomSheetPresentationControllerDelegate,
                                        UITableViewDelegate,
                                        UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) MDCActionSheetHeaderView *header;
@end

@implementation MDCActionSheetController {
  NSMutableArray<MDCActionSheetAction *> *_actions;
}

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
  }

  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_actions addObject:action];
  [self updateTable];
}

- (NSArray<MDCActionSheetAction *> *)actions {
  return [_actions copy];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = self.backgroundColor;
  self.tableView.frame = self.view.bounds;
  [self.view addSubview:self.tableView];
  [self.view addSubview:self.header];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  if (self.tableView.contentSize.height > (CGRectGetHeight(self.view.bounds) / 2)) {
    self.mdc_bottomSheetPresentationController.preferredSheetHeight = [self openingSheetHeight];
  } else {
    self.mdc_bottomSheetPresentationController.preferredSheetHeight = 0;
  }
  CGSize size = [self.header sizeThatFits:CGRectStandardize(self.view.bounds).size];
  self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, size.height);
  UIEdgeInsets insets = UIEdgeInsetsMake(self.header.frame.size.height, 0, 0, 0);
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
  return MDCCeil(preferredHeight);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.mdc_bottomSheetPresentationController.delegate = self;
#pragma clang diagnostic pop

  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap =
      self.transitionController.dismissOnBackgroundTap;
  [self.view layoutIfNeeded];
}

- (BOOL)accessibilityPerformEscape {
  if (!self.dismissOnBackgroundTap) {
    return NO;
  }
  [self dismissViewControllerAnimated:YES completion:nil];
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
  cell.inkColor = self.inkColor;
  cell.tintColor = self.actionTintColor;
  cell.imageRenderingMode = self.imageRenderingMode;
  cell.actionTextColor = self.actionTextColor;
  return cell;
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

- (void)setInkColor:(UIColor *)inkColor {
  _inkColor = inkColor;
  [self.tableView reloadData];
}

@end
