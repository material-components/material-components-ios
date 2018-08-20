/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCActionSheetController.h"

#import "MDCActionSheetItemTableViewCell.h"
#import "MDCActionSheetDataSource.h"
#import "MDCActionSheetHeaderView.h"
#import "MaterialBottomSheet.h"
#import "MaterialApplication.h"
#import "MaterialTypography.h"

static NSString *const kReuseIdentifer = @"BaseCell";

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
  return action;
}

@end

@interface MDCActionSheetController () <MDCBottomSheetPresentationControllerDelegate, UITableViewDelegate>

@end

@implementation MDCActionSheetController {
  MDCActionSheetHeaderView *_header;
  UITableViewController *_tableViewController;
  MDCActionSheetDataSource *_dataSource;
  NSString *_actionSheetTitle;
  MDCBottomSheetTransitionController *_transitionController;
  BOOL mdc_adjustFontForContentSizeCategory;
  /**
    Used to determine if we need to do a layout within viewWillLayoutSubviews,
    Because we are setting the preferredContentSize we can no longer get the frame to set the sheet
    and headers sizes after a transition. 
   */
  BOOL needsPreferredContentSizeUpdate;
}

@synthesize mdc_adjustsFontForContentSizeCategory;

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
    _actionSheetTitle = [title copy];
    _message = [message copy];
    [self commonMDCActionSheetControllerInit];
  }

  return self;
}

- (void)commonMDCActionSheetControllerInit {
  needsPreferredContentSizeUpdate = false;
  _transitionController = [[MDCBottomSheetTransitionController alloc] init];
  _transitionController.dismissOnBackgroundTap = YES;
  /**
   We have overriden the self implementation so we don't want others to change the values so we
  have to call super
   */
  super.transitioningDelegate = _transitionController;
  super.modalPresentationStyle = UIModalPresentationCustom;
  _dataSource = [[MDCActionSheetDataSource alloc] init];
  _tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
  _tableViewController.tableView.delegate = self;
  _tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  _tableViewController.tableView.estimatedRowHeight = 56.f;
  _tableViewController.tableView.rowHeight = UITableViewAutomaticDimension;
  _tableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _tableViewController.tableView.scrollEnabled = NO;
  _tableViewController.tableView.dataSource = _dataSource;
  [_tableViewController.tableView registerClass:[MDCActionSheetItemTableViewCell class]
                         forCellReuseIdentifier:kReuseIdentifer];
  self.backgroundColor = [UIColor whiteColor];
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_dataSource addAction:action];
  [_tableViewController.tableView reloadData];
  [_tableViewController.tableView setNeedsLayout];
  [self setPreferredContentSizeUpdate];
}

- (NSArray<MDCActionSheetAction *> *)actions {
  return _dataSource.actions;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect headerRect = CGRectZero;
  headerRect.size.width = CGRectGetWidth(self.view.bounds);
  _header = [[MDCActionSheetHeaderView alloc] initWithFrame:headerRect];
  _header.title = _actionSheetTitle;
  _header.message = _message;
  _header.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;

  [self.view addSubview:_tableViewController.tableView];
  [self.view addSubview:_header];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  if (needsPreferredContentSizeUpdate == false) {
    [self layoutViews];
  }
}

- (void)layoutViews {
  CGFloat headerHeight = [_header sizeThatFits:self.view.bounds.size].height;
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGRect tableFrame = _tableViewController.tableView.frame;
  tableFrame.size.width = width;
  _tableViewController.tableView.frame = tableFrame;
  [_tableViewController.tableView reloadData];
  [_tableViewController.tableView setNeedsLayout];

  /// We need this call to `layoutIfNeeded` to get the correct contentSize for the table
  [_tableViewController.tableView layoutIfNeeded];
  CGFloat tableHeight = _tableViewController.tableView.contentSize.height;
  CGFloat height = headerHeight + tableHeight;
  tableFrame = _tableViewController.tableView.frame;
  tableFrame.origin.y = headerHeight;
  _tableViewController.tableView.frame = tableFrame;
  self.preferredContentSize = CGSizeMake(width, height);
  needsPreferredContentSizeUpdate = true;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.mdc_bottomSheetPresentationController.delegate = self;
#pragma clang diagnostic pop

  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap =
      _transitionController.dismissOnBackgroundTap;
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
  return _transitionController.trackingScrollView;
}

- (void)setTrackingScrollView:(UIScrollView *)trackingScrollView {
  _transitionController.trackingScrollView = trackingScrollView;
}

- (BOOL)dismissOnBackgroundTap {
  return _transitionController.dismissOnBackgroundTap;
}

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _transitionController.dismissOnBackgroundTap = dismissOnBackgroundTap;
  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap = dismissOnBackgroundTap;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:
    (id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  
  CGRect frame = self.view.frame;
  frame.size = size;
  self.view.frame = frame;
  CGRect headerFrame = _header.frame;
  headerFrame.size.width = size.width;
  _header.frame = headerFrame;

  CGRect tableFrame = _tableViewController.tableView.frame;
  tableFrame.size.width = size.width;
  _tableViewController.tableView.frame = tableFrame;
  [_tableViewController.tableView reloadData];
  [_tableViewController.tableView setNeedsLayout];
  /// We need this call to `layoutIfNeeded` to get the correct contentSize for the table.
  [_tableViewController.tableView layoutIfNeeded];
  CGFloat tableHeight = _tableViewController.tableView.contentSize.height;
  CGFloat height = CGRectGetHeight(headerFrame) + tableHeight;
  CGSize updatedSize = CGSizeMake(size.width, height);
  self.preferredContentSize = updatedSize;
}

- (void)setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCActionSheetController.transitionDelegate cannot be changed");
  return;
}

- (void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCActionSheetController.modalPresentationStyle cannot be changed.");
  return;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetAction *action = self.actions[indexPath.row];

  [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void){
    if (action.completionHandler) {
      action.completionHandler(action);
    }
  }];
}

- (void)setTitle:(NSString *)title {
  _actionSheetTitle = title;
  _header.title = title;
  [self setPreferredContentSizeUpdate];
}

- (NSString *)title {
  return _actionSheetTitle;
}

- (void)setMessage:(NSString *)message {
  _message = message;
  _header.message = message;
  [self setPreferredContentSizeUpdate];
}

- (void)setTitleFont:(UIFont *)titleFont {
  _titleFont = titleFont;
  _header.titleFont = titleFont;
}

- (void)setMessageFont:(UIFont *)messageFont {
  _messageFont = messageFont;
  _header.messageFont = messageFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  self.view.backgroundColor = backgroundColor;
  _tableViewController.view.backgroundColor = backgroundColor;
  _tableViewController.tableView.backgroundColor = backgroundColor;
  [_tableViewController.view setNeedsLayout];
  _header.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return self.view.backgroundColor;
}

#pragma mark - Dynamic Type

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  mdc_adjustsFontForContentSizeCategory = adjusts;
  [self view];

  _header.mdc_adjustsFontForContentSizeCategory = adjusts;
  [self updateFontsForDynamicType];
  if (self.mdc_adjustsFontForContentSizeCategory) {
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

+ (UIFont *)actionsFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleSubheadline];
  }
  return [MDCTypography subheadFont];
}

- (void)updateTableFonts {
  UIFont *finalActionsFont = _actionsFont ?: [[self class] actionsFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    finalActionsFont =
        [finalActionsFont mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleSubheadline
                                       scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
  }
  _actionsFont = finalActionsFont;
  _dataSource.actionsFont = _actionsFont;
  [_tableViewController.tableView reloadData];
  [_tableViewController.view setNeedsLayout];
}

- (void)updateFontsForDynamicType {
  [_header updateFonts];
  [self updateTableFonts];
  [self setPreferredContentSizeUpdate];
}

- (void)setPreferredContentSizeUpdate {
  needsPreferredContentSizeUpdate = false;
  [self.view setNeedsLayout];
}

@end
