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

#import "private/MDCActionSheetItemTableViewCell.h"
#import "private/MDCActionSheetHeaderView.h"
#import "MaterialApplication.h"
#import "MaterialTypography.h"

static NSString *const ReuseIdentifier = @"BaseCell";

@interface MDCActionSheetAction ()

@property(nonatomic, nullable, copy) MDCActionSheetHandler completionHandler;

@end

@implementation MDCActionSheetAction

+ (instancetype)actionWithTitle:(NSString *)title
                          image:(UIImage *)image
                        handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
    return [[MDCActionSheetAction alloc] initWithTitle:title
                                                 image:image
                                               handler:handler];
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
  return action;
}

@end

@interface MDCActionSheetController () <MDCBottomSheetPresentationControllerDelegate,
    UITableViewDelegate, UITableViewDataSource>

@end

@implementation MDCActionSheetController {
  MDCActionSheetHeaderView *_header;
  UITableView *_tableView;
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
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                   | UIViewAutoresizingFlexibleHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 56.f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MDCActionSheetItemTableViewCell class]
       forCellReuseIdentifier:ReuseIdentifier];

    _header = [[MDCActionSheetHeaderView alloc] initWithFrame:CGRectZero];
    _header.title = [title copy];
    _header.message = [message copy];
    self.backgroundColor = [UIColor whiteColor];
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

  _tableView.frame = self.view.bounds;
  [self.view addSubview:_tableView];
  [self.view addSubview:_header];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [self correctSheetHeight];
  CGSize size = [_header sizeThatFits:CGRectStandardize(self.view.bounds).size];
  _header.frame = CGRectMake(0, 0, self.view.bounds.size.width, size.height);
  UIEdgeInsets insets = UIEdgeInsetsMake(_header.frame.size.height, 0, 0, 0);
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    insets.bottom = self.view.safeAreaInsets.bottom;
  }
#endif
  _tableView.contentInset = insets;
  _tableView.contentOffset = CGPointMake(0, -size.height);
}

- (void)correctSheetHeight {
  // If there are too many options to fit on half of the screen then show as many options as
  // possible minus half a cell, to allow for bleeding and signal to the user that the sheet is
  // scrollable content.
  if (_tableView.contentSize.height > (CGRectGetHeight(self.view.bounds) / 2)) {
    CGFloat maxHeight = CGRectGetHeight(self.view.bounds) / 2;
    CGFloat headerHeight = [_header sizeThatFits:CGRectStandardize(self.view.bounds).size].height;
    CGFloat cellHeight = _tableView.contentSize.height / (CGFloat)_actions.count;
    NSInteger amountOfCellsToShow = (NSInteger)(maxHeight - headerHeight) / (NSInteger)cellHeight;
    CGFloat preferredHeight = (((CGFloat)amountOfCellsToShow - 0.5f) * cellHeight) + headerHeight;
    // When updating the preferredSheetHeight the presentation controller takes into account the
    // safe area so we have to remove that.
    if (@available(iOS 11.0, *)) {
      preferredHeight = preferredHeight - self.view.safeAreaInsets.bottom;
    }
    self.mdc_bottomSheetPresentationController.preferredSheetHeight = preferredHeight;
  }
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

  [self.presentationController
      preferredContentSizeDidChangeForChildContentContainer:self];
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

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:
    (id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator animateAlongsideTransition:
      ^(__unused id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        CGRect frame = self.view.bounds;
        frame.size = size;
        frame.origin = CGPointZero;
        self.view.frame = frame;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
      }                        completion:nil];
}

#pragma mark - Table view

- (void)updateTable {
  [_tableView reloadData];
  [_tableView setNeedsLayout];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetAction *action = self.actions[indexPath.row];

  [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void){
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
      [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier forIndexPath:indexPath];
  MDCActionSheetAction *action = _actions[indexPath.row];
  cell.action = action;
  cell.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  cell.backgroundColor = self.backgroundColor;
  cell.actionFont = self.actionFont;
  cell.accessibilityIdentifier = action.accessibilityIdentifier;
  return cell;
}

- (void)setTitle:(NSString *)title {
  _header.title = title;
  [self.view setNeedsLayout];
}

- (NSString *)title {
  return _header.title;
}

- (void)setMessage:(NSString *)message {
  _header.message = message;
  [self.view setNeedsLayout];
}

- (NSString *)message {
  return _header.message;
}

- (void)setTitleFont:(UIFont *)titleFont {
  _header.titleFont = titleFont;
}

- (UIFont *)titleFont {
  return _header.titleFont;
}

- (void)setMessageFont:(UIFont *)messageFont {
  _header.messageFont = messageFont;
}

- (UIFont *)messageFont {
  return _header.messageFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  self.view.backgroundColor = backgroundColor;
  _tableView.backgroundColor = backgroundColor;
  _header.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return self.view.backgroundColor;
}

#pragma mark - Dynamic Type

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  _header.mdc_adjustsFontForContentSizeCategory = adjusts;
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
  UIFont *finalActionsFont = _actionFont ?:
      [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    finalActionsFont =
        [finalActionsFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                       scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  }
  _actionFont = finalActionsFont;
  [self updateTable];
}

- (void)updateFontsForDynamicType {
  [self updateTableFonts];
  [self.view setNeedsLayout];
}

@end
