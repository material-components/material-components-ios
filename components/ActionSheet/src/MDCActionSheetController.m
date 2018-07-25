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

static const CGFloat kTitleLeadingPadding = 16.f;
static const CGFloat kTitleBaselinePadding = 36.f;
static const CGFloat kTitleAlpha = 0.54f;
//static const CGFloat kRowHeight = 56.f;

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

-(id)copyWithZone:(NSZone *)zone {
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
  NSMutableArray<MDCActionSheetAction *> *_actions;
  UIViewController *contentViewController;
  MDCBottomSheetTransitionController *_transitionController;
  id<MDCActionSheetControllerDelegate> delegate;
  NSString *_title;
  MDCActionSheetListViewController *_tableView;
}

+ (instancetype)actionSheetControllerWithTitle:(NSString *)title {
  MDCActionSheetController *actionController =
      [[MDCActionSheetController alloc] initWithTitle:title];
  return actionController;
}

- (nonnull instancetype)initWithTitle:(nullable NSString *)title {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _title = title;
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
  contentViewController.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                                          (_actions.count + 1) * 56);
  [self addTitle];
  _tableView = [[MDCActionSheetListViewController alloc] initWithActions:_actions];
  [contentViewController.view addSubview:_tableView.view];
  /*[_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [NSLayoutConstraint constraintWithItem:_tableView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:contentViewController.view
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:kRowHeight].active = YES;
  [NSLayoutConstraint constraintWithItem:_tableView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:56.f * _actions.count].active = YES;
  CGFloat width = CGRectGetWidth(contentViewController.view.frame);
  [NSLayoutConstraint constraintWithItem:_tableView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:width].active = YES;
 [NSLayoutConstraint constraintWithItem:_tableView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:contentViewController.view
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0.f].active = YES;*/
}

- (void)addTitle {
  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.text = _title;
  [titleLabel sizeToFit];
  titleLabel.alpha = kTitleAlpha;
  [contentViewController.view addSubview:titleLabel];
  [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [NSLayoutConstraint constraintWithItem:titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:contentViewController.view
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:kTitleLeadingPadding].active = YES;
  CGFloat yPosition = kTitleBaselinePadding - titleLabel.font.ascender;
  [NSLayoutConstraint constraintWithItem:titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:contentViewController.view
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:yPosition].active = YES;
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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheetPresentationControllerDidDismissAction:
(nonnull __unused MDCBottomSheetPresentationController *)bottomSheet {
#pragma clang diagnostic pop
  [delegate actionSheetControllerDidDismissActionSheet:self];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [_actions[indexPath.row] action];
}

- (NSInteger)tableView:(UITableView *)tableView
     numberOfRowsInSection:(NSInteger)section {
  NSLog(@"We are looking for number of rows in section");
  return _actions.count + 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  MDCActionSheetItemView *cell = [[MDCActionSheetItemView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//      [MDCActionSheetItemView cellWithAction:_actions[indexPath.row]];
  return cell;
}
@end




