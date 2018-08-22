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
#import "MDCActionSheetHeaderView.h"
#import "MaterialBottomSheet.h"
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
  return action;
}

@end

@interface MDCActionSheetController () <MDCBottomSheetPresentationControllerDelegate,
    UITableViewDelegate, UITableViewDataSource>

@end

@implementation MDCActionSheetController {
  MDCActionSheetHeaderView *_header;
  UITableView *_tableView;
  NSString *_actionSheetTitle;
  MDCBottomSheetTransitionController *_transitionController;
  BOOL mdc_adjustFontForContentSizeCategory;
  NSMutableArray<MDCActionSheetAction *> *_actions;
  /**
    Used to determine if we need to do a layout within viewWillLayoutSubviews,
    Because we are setting the preferredContentSize we can no longer get the frame to set the sheet
    and headers sizes after a transition. 
   */
  BOOL _needsPreferredContentSizeUpdate;
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
    _actions = [[NSMutableArray alloc] init];
    _actionSheetTitle = [title copy];
    _message = [message copy];
    _needsPreferredContentSizeUpdate = true;
    _transitionController = [[MDCBottomSheetTransitionController alloc] init];
    _transitionController.dismissOnBackgroundTap = YES;
    /**
     "We must call super because we've made the setters on this class unavailable and overridden
     their implementations to throw assertions."
     */
    super.transitioningDelegate = _transitionController;
    super.modalPresentationStyle = UIModalPresentationCustom;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.estimatedRowHeight = 56.f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    [_tableView registerClass:[MDCActionSheetItemTableViewCell class]
       forCellReuseIdentifier:ReuseIdentifier];
    self.backgroundColor = [UIColor whiteColor];
  }

  return self;
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_actions addObject:action];
  [self updateTable];
  [self setPreferredContentSizeUpdate];
}

- (NSArray<MDCActionSheetAction *> *)actions {
  return [_actions copy];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect headerRect = CGRectZero;
  headerRect.size.width = CGRectGetWidth(self.view.bounds);
  _header = [[MDCActionSheetHeaderView alloc] initWithFrame:headerRect];
  _header.title = _actionSheetTitle;
  _header.message = _message;
  _header.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGRect tableFrame = _tableView.frame;
  tableFrame.size.width = width;
  _tableView.frame = tableFrame;
  
  [self.view addSubview:_tableView];
  [self.view addSubview:_header];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  if (_needsPreferredContentSizeUpdate == true) {
    [self layoutViews];
  }
}

- (void)layoutViews {
  CGFloat headerHeight = [_header sizeThatFits:self.view.bounds.size].height;
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGRect tableFrame = _tableView.frame;
  tableFrame.size.width = width;
  _tableView.frame = tableFrame;
  [self updateTable];

  /// We need this call to `layoutIfNeeded` to get the correct contentSize for the table
  [_tableView layoutIfNeeded];
  CGFloat tableHeight = _tableView.contentSize.height;
  CGFloat height = headerHeight + tableHeight;
  tableFrame = _tableView.frame;
  tableFrame.origin.y = headerHeight;
  _tableView.frame = tableFrame;
  self.preferredContentSize = CGSizeMake(width, height);
  _needsPreferredContentSizeUpdate = false;
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
  
  CGRect frame = self.view.frame;
  frame.size = size;
  self.view.frame = frame;
  CGRect headerFrame = _header.frame;
  headerFrame.size.width = size.width;
  _header.frame = headerFrame;

  CGRect tableFrame = _tableView.frame;
  tableFrame.size.width = size.width;
  _tableView.frame = tableFrame;
  [self updateTable];
  /// We need this call to `layoutIfNeeded` to get the correct contentSize for the table.
  [_tableView layoutIfNeeded];
  CGFloat tableHeight = _tableView.contentSize.height;
  CGFloat height = CGRectGetHeight(headerFrame) + tableHeight;
  CGSize updatedSize = CGSizeMake(size.width, height);
  self.preferredContentSize = updatedSize;
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
  cell.action = _actions[indexPath.row];
  cell.backgroundColor = self.backgroundColor;
  cell.actionsFont = self.actionsFont;
  return cell;
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
  _tableView.backgroundColor = backgroundColor;
  [_tableView setNeedsLayout];
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
  [self updateTable];
}

- (void)updateFontsForDynamicType {
  //[_header updateFonts];
  [self updateTableFonts];
  [self setPreferredContentSizeUpdate];
}

- (void)setPreferredContentSizeUpdate {
  _needsPreferredContentSizeUpdate = true;
  [self.view setNeedsLayout];
}

@end
