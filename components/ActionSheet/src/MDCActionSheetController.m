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
#import "MDCActionSheetItemView.h"
#import "MDCActionSheetListViewController.h"
#import "MaterialBottomSheet.h"
#import "MaterialTypography.h"

@interface MDCActionSheetAction ()

@property(nonatomic, nullable, copy) MDCActionSheetHandler completionHandler;

@end

@implementation MDCActionSheetAction

+ (instancetype)actionWithTitle:(nonnull NSString *)title
                          image:(nonnull UIImage *)image
                          handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
    return [[MDCActionSheetAction alloc] initWithTitle:title
                                                 image:image
                                               handler:handler];
}

- (instancetype)initWithTitle:(nonnull NSString *)title
                        image:(nonnull UIImage *)image
                      handler:(void (^__nullable)(MDCActionSheetAction *action))handler {
  self = [super init];
  if (self) {
    _title = [title copy];
    _image = [image copy];
    _completionHandler = [handler copy];
  }
  return self;
}

-(id)copyWithZone:(__unused NSZone *)zone {
  MDCActionSheetAction *action = [[self class] actionWithTitle:self.title
                                                         image:self.image
                                                       handler:self.completionHandler];
  return action;
}

@end

@interface MDCActionSheetController () <MDCBottomSheetPresentationControllerDelegate, UITableViewDelegate>

@property(nonatomic, nonnull) MDCActionSheetHeaderView *header;

@property(nonatomic, nullable) MDCActionSheetListViewController *tableView;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message;

@end

@implementation MDCActionSheetController {
  NSString *_actionSheetTitle;
  NSMutableArray<MDCActionSheetAction *> *_actions;
  MDCBottomSheetTransitionController *_transitionController;
  UIViewController *contentViewController;
}

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title message:(NSString *)message {
  MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] initWithTitle:title
                                                                                  message:message];
  
  return actionSheet;
}

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title {
  return [MDCActionSheetController actionSheetControllerWithTitle:title message:nil];
}

- (instancetype)init {
  return [MDCActionSheetController actionSheetControllerWithTitle:nil message:nil];
}

- (nonnull instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _actionSheetTitle = [title copy];
    _message = message;
    [self commonMDCActionSheetControllerInit];
  }
  return self;
}

- (void)commonMDCActionSheetControllerInit {
  contentViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
  _transitionController = [[MDCBottomSheetTransitionController alloc] init];
  _transitionController.dismissOnBackgroundTap = YES;
  super.transitioningDelegate = _transitionController;
  super.modalPresentationStyle = UIModalPresentationCustom;
  _actions = [[NSMutableArray alloc] init];
  _tableView = [[MDCActionSheetListViewController alloc] initWithTitle:_actionSheetTitle
                                                               message:_message
                                                               actions:_actions];
  
  _tableView.tableView.delegate = self;
  [_tableView.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  _tableView.tableView.estimatedRowHeight = 56.f;
  _tableView.tableView.rowHeight = UITableViewAutomaticDimension;
  _tableView.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
  _tableView.tableView.estimatedSectionHeaderHeight = 56.f;
  CGRect tableFrame = _tableView.view.frame;
  tableFrame.origin.y = 0;
  _tableView.view.frame = tableFrame;
}

- (void)addAction:(MDCActionSheetAction *)action {
  [_actions addObject:[action copy]];
}

- (NSArray<MDCActionSheetAction *> *)actions {
  return [_actions copy];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  contentViewController.view.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  contentViewController.view.frame = self.view.bounds;
  [self addChildViewController:contentViewController];
  [self.view addSubview:contentViewController.view];
  [contentViewController didMoveToParentViewController:self];
  contentViewController.view.backgroundColor = [UIColor whiteColor];
  [contentViewController.view addSubview:_tableView.view];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  CGFloat height = CGRectGetHeight(_header.frame) + (_actions.count * 56);
  contentViewController.preferredContentSize =
      CGSizeMake(CGRectGetWidth(self.view.bounds), height);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.mdc_bottomSheetPresentationController.delegate = self;
#pragma clang diagnostic pop

  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap =
      _transitionController.dismissOnBackgroundTap;
  [contentViewController.view layoutIfNeeded];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return contentViewController.supportedInterfaceOrientations;
}

- (BOOL)accessibilityPerformEscape {
  if (!self.dismissOnBackgroundTap) {
    return NO;
  }
  [self dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

- (CGSize)preferredContentSize {
  return contentViewController.preferredContentSize;
}

- (void)setPreferredContentSize:(CGSize)preferredContentSize {
  contentViewController.preferredContentSize = preferredContentSize;
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

-(void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap {
  _transitionController.dismissOnBackgroundTap = dismissOnBackgroundTap;
  self.mdc_bottomSheetPresentationController.dismissOnBackgroundTap = dismissOnBackgroundTap;
}

-(void)setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)transitioningDelegate {
  NSAssert(NO, @"MDCActionSheetController.transitionDelegate cannot be changed");
  return;
}

-(void)setModalPresentationStyle:(__unused UIModalPresentationStyle)modalPresentationStyle {
  NSAssert(NO, @"MDCActionSheetController.modalPresentationStyle cannot be changed.");
  return;
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  _header = [[MDCActionSheetHeaderView alloc] initWithTitle:self.title message:self.message];
  return _header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MDCActionSheetAction *action = _actions[indexPath.row];

  [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void){
    if (action.completionHandler) {
      action.completionHandler(action);
    }
  }];
}

#pragma mark - Dynamic Type

- (void)setTitle:(NSString *)title {
  if (_actionSheetTitle != title) {
    _actionSheetTitle = title;
  }
}

- (NSString *)title {
  return _actionSheetTitle;
}

@end
