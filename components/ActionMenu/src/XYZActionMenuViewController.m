/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

static const NSTimeInterval kDefaultNormalAnimationDuration = 0.30;
static const NSTimeInterval kCellStaggerDelayDuration = 0.02;

static const CGFloat kIconRotationRadians = (CGFloat)(0.375f * 2.0 * M_PI);
static const CGFloat kPreToggleShrinkScaleX = 0.7f;
static const CGFloat kPreToggleShrinkScaleY = 0.0f;
static const CGFloat kSheetStyleCellHeight = 48.0f;
static const CGFloat kSheetStyleCellWidth = 224.0f;

@interface XYZActionMenuCollectionViewController : UICollectionViewController

@property(nonatomic) UIStatusBarStyle statusBarStyle;

@end

@implementation XYZActionMenuCollectionViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.statusBarStyle;
}

- (BOOL)shouldAutorotate {
  // This is shown modally, so let the presenting view controller determine if it should rotate.
  return self.presentingViewController ? [self.presentingViewController shouldAutorotate] : YES;
}

@end

@interface XYZActionMenuCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout
     actionMenuViewController:(XYZActionMenuViewController *)actionMenuViewController
    NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

@end

@implementation XYZActionMenuCollectionView {
  __weak XYZActionMenuViewController *_actionMenuViewController;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout
     actionMenuViewController:(XYZActionMenuViewController *)actionMenuViewController {
  self = [super initWithFrame:frame collectionViewLayout:layout];
  if (self) {
    _actionMenuViewController = actionMenuViewController;
  }
  return self;
}

- (BOOL)accessibilityPerformEscape {
  [_actionMenuViewController dismiss];
  return YES;
}

@end

@interface XYZActionMenuViewController () <UICollectionViewDataSource,
                                           UICollectionViewDelegate,
                                           UIViewControllerAnimatedTransitioning,
                                           UIViewControllerTransitioningDelegate,
                                           XYZPopoverViewControllerDelegate>

/**
 * Whether there is an animation in progress collapsing the action menu options and dismissing the
 * menu.
 */
@property(nonatomic, getter=isCollapseAnimationInProgress) BOOL collapseAnimationInProgress;

@end

@implementation XYZActionMenuViewController {
  BOOL _activated;
  BOOL _optionSelected;
  UIImage *_image;
  NSMutableArray *_options;
  XYZButton *_floatingActionButton;
  XYZActionMenuCollectionViewController *_collectionVC;
  UIView *_preToggleAnimationContainer;
  UIImageView *_preToggleView;
  UIImageView *_postToggleView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithStyle:(XYZActionMenuStyle)style image:(UIImage *)image {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _style = style;
    _image = image;

    _elevation = MDCShadowElevationFABResting;

    _labelPosition = kXYZActionMenuLabelPositionLeft;
    _autoDismissOnSelection = YES;

    _options = [NSMutableArray array];

    _floatingActionButton =
        [XYZButton floatingButtonMiniSize:(_style == kXYZActionMenuStyleMiniToMini)];
    [_floatingActionButton setElevation:_elevation forState:UIControlStateNormal];

    _backgroundColor = [UIColor clearColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIViewAutoresizing autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  [_floatingActionButton sizeToFit];
  CGSize fabSize = _floatingActionButton.bounds.size;
  self.view.frame = CGRectMake(0, 0, fabSize.width, fabSize.height);
  [self.view addSubview:_floatingActionButton];

  [self updateAccessibilityLabel];
  [_floatingActionButton addTarget:self
                            action:@selector(touchFloatingActionButton)
                  forControlEvents:UIControlEventTouchUpInside];

  XYZActionMenuLayout *layout = [[XYZActionMenuLayout alloc] initWithMenuStyle:self.style];
  _collectionVC =
      [[XYZActionMenuCollectionViewController alloc] initWithCollectionViewLayout:layout];
  _collectionVC.view.autoresizingMask = autoresizingMask;

  // To support iOS 7 and present the collection view controller full screen modally with a
  // transparent background, a UIModalPresentationCustom presentation style is required. This
  // requires a transitioning delegate, which we provide.
  _collectionVC.modalPresentationStyle = UIModalPresentationCustom;
  _collectionVC.transitioningDelegate = self;

  UICollectionView *collectionView = [[XYZActionMenuCollectionView alloc] initWithFrame:CGRectZero
                                                                   collectionViewLayout:layout
                                                               actionMenuViewController:self];
  collectionView.autoresizingMask = autoresizingMask;
  collectionView.backgroundColor = [UIColor clearColor];
  collectionView.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
  collectionView.backgroundView.autoresizingMask = autoresizingMask;
  collectionView.dataSource = self;
  collectionView.delaysContentTouches = NO;
  collectionView.delegate = self;
  collectionView.scrollEnabled = NO;

  Class actionMenuCellClass = [XYZActionMenuCell class];
  [collectionView registerClass:actionMenuCellClass
      forCellWithReuseIdentifier:NSStringFromClass(actionMenuCellClass)];

  if (self.style != kXYZActionMenuStyleSheet) {
    // Create floating action button animation containers.
    _preToggleAnimationContainer = [[UIView alloc] initWithFrame:_floatingActionButton.bounds];
    _preToggleAnimationContainer.autoresizingMask = autoresizingMask;
    _preToggleAnimationContainer.userInteractionEnabled = NO;
    [_floatingActionButton addSubview:_preToggleAnimationContainer];


    _preToggleView = [[UIImageView alloc] initWithFrame:_floatingActionButton.bounds];
    _preToggleView.autoresizingMask = autoresizingMask;
    _preToggleView.image = _image;
    _preToggleView.contentMode = UIViewContentModeCenter;
    [_preToggleAnimationContainer addSubview:_preToggleView];

    _postToggleView = [[UIImageView alloc] initWithFrame:_floatingActionButton.bounds];
    _postToggleView.autoresizingMask = autoresizingMask;
    _postToggleView.contentMode = UIViewContentModeCenter;
    [_floatingActionButton addSubview:_postToggleView];

    // Setup gestures for tap and swipe, used to dismiss the menu.
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.cancelsTouchesInView = NO;
    [collectionView addGestureRecognizer:tapGesture];

    UISwipeGestureRecognizer *horizontalSwipeGesture =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    horizontalSwipeGesture.cancelsTouchesInView = NO;
    horizontalSwipeGesture.direction =
        UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    [collectionView addGestureRecognizer:horizontalSwipeGesture];

    UISwipeGestureRecognizer *verticalSwipeGesture =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    verticalSwipeGesture.cancelsTouchesInView = NO;
    verticalSwipeGesture.direction =
        UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [collectionView addGestureRecognizer:verticalSwipeGesture];

    _collectionVC.collectionView = collectionView;
  } else {
    [_floatingActionButton setImage:_image forState:UIControlStateNormal];
  }

  _collectionVC.collectionView = collectionView;

  [self updateBackgroundColor];
  [self refresh];
}

- (void)setElevation:(CGFloat)elevation {
  _elevation = elevation;
  [_floatingActionButton setElevation:_elevation forState:UIControlStateNormal];
}

- (void)setZIndex:(NSInteger)zIndex {
  _zIndex = zIndex;
  _elevation = (float)pow(2.f, zIndex);
  [_floatingActionButton setElevation:_elevation forState:UIControlStateNormal];
}

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
  _accessibilityLabel = accessibilityLabel;
  [self updateAccessibilityLabel];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  if (_backgroundColor != backgroundColor) {
    _backgroundColor = backgroundColor;
    [self updateBackgroundColor];
  }
}

- (void)updateBackgroundColor {
  if (self.style == kXYZActionMenuStyleSheet) {
    _collectionVC.collectionView.backgroundView.backgroundColor = [UIColor whiteColor];
    return;
  }
  _collectionVC.collectionView.backgroundView.backgroundColor = _backgroundColor;;

  // TODO: Replace with MDFTextAccessibility
  CGFloat r, g, b;
  [_backgroundColor getRed:&r green:&g blue:&b alpha:nil];
  CGFloat brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;

  _collectionVC.statusBarStyle =
      brightness > 0.5 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
  [_collectionVC setNeedsStatusBarAppearanceUpdate];
}

- (void)addOption:(XYZActionMenuOption *)option {
  [_options addObject:option];
  [self updateAccessibilityLabel];
  [self refresh];
}

- (void)clearOptions {
  [_options removeAllObjects];
  [self refresh];
}

- (void)refreshOptions {
  [self refresh];
}

- (void)activateAnimated:(BOOL)animated withCompletion:(void (^)(BOOL didActivate))completion {
  // The menu can only be activated if it has more than one option to display.
  BOOL canActivate = (_options.count > 1);
  BOOL willActivate = (!_activated && canActivate);

  // For consistency, the completion block should be called asynchronously regardless of success.
  void (^asyncCompletion)() = ^{
    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion(willActivate);
      }
    });
  };

  if (willActivate) {
    if (self.style == kXYZActionMenuStyleSheet) {
      [self setSheetStyleActivated:YES animated:YES completion:nil];
    } else {
      [self setSpeeddialActivated:YES animated:YES completion:nil];
    }
  } else {
    asyncCompletion();
  }
}

- (void)dismissAnimated:(BOOL)animated withCompletion:(void (^)(void))completion {
  // For consistency, the completion block should always be called asynchronously.
  void (^asyncCompletion)() = ^{
    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion();
      }
    });
  };

  if (self.style == kXYZActionMenuStyleSheet) {
    [self setSheetStyleActivated:NO animated:YES completion:asyncCompletion];
  } else {
    [self setSpeeddialActivated:NO animated:YES completion:asyncCompletion];
  }
}

- (void)dismiss {
  [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(void (^)(void))completion {
  [self dismissAnimated:YES withCompletion:completion];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _options.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSString *identifier = NSStringFromClass([XYZActionMenuCell class]);
  XYZActionMenuCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

  XYZActionMenuOptionView *optionView = cell.optionView;

  optionView.style = self.style;
  optionView.labelPosition = self.labelPosition;
  optionView.index = indexPath.item;
  optionView.option = _options[indexPath.item];
  [optionView.floatingActionButton setElevation:self.elevation forState:UIControlStateNormal];

  CGSize optionSize = [optionView sizeThatFits:cell.bounds.size];
  optionView.frame = CGRectMake(0, 0, optionSize.width, optionSize.height);
  [optionView setNeedsLayout];

  [optionView setActivatedState:_activated animated:NO withStaggerDelay:0];

  return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self handleSelectionOnOption:_options[indexPath.item]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(collectionView.bounds.size.width, [self heightForOptionAtIndex:indexPath.item]);
}

#pragma mark - UIViewController

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self updateModalViewLayout];
}

/**
 * This VC is not automatically re-laid out during rotation when the collectionVC is
 * modally presented.
 */
#if !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self.view setNeedsLayout];
}
#else
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
  [self.view setNeedsLayout];
}
#endif  // !defined(__IPHONE_8_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0)

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  [[transitionContext containerView] addSubview:_collectionVC.view];

  CGRect screenRect = [[UIScreen mainScreen] bounds];
  _collectionVC.view.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);

  [transitionContext completeTransition:YES];

  [self updateModalViewLayout];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  return self;
}

#pragma mark - XYZPopoverViewControllerDelegate

- (void)popoverViewControllerDidCancel:(XYZPopoverViewController *)controller {
  _floatingActionButton.hidden = NO;
  [self dismissViewControllerAnimated:YES completion:^{
    _activated = NO;
  }];
}

#pragma mark - Private

- (void)updateAccessibilityLabel {
  NSString *accessibilityLabel = self.accessibilityLabel;
  if (_options.count == 1) {
    XYZActionMenuOption *option = (XYZActionMenuOption *)_options[0];
    if (option.accessibilityLabel) {
      accessibilityLabel = option.accessibilityLabel;
    }
  }
  _floatingActionButton.accessibilityLabel = accessibilityLabel;
}

- (CGFloat)heightForOptionAtIndex:(NSUInteger)index {
  if (self.style == kXYZActionMenuStyleSheet) {
    return kSheetStyleCellHeight;
  }
  BOOL isMini = (self.style == kXYZActionMenuStyleMiniToMini) ||
                (self.style == kXYZActionMenuStyleDefaultToMini && index != 0);
  return isMini ? [XYZButton floatingButtonMiniDimension]
                : [XYZButton floatingButtonDefaultDimension];
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
  BOOL hitCell = NO;
  UICollectionView *collectionView = _collectionVC.collectionView;
  for (UICollectionViewCell *cell in collectionView.visibleCells) {
    CGPoint p = [tapGesture locationInView:cell];
    UIView *hitView = [cell hitTest:p withEvent:nil];
    hitCell = hitView != nil;
    if (hitCell)
      break;
  }
  if (!hitCell) {
    [self dismiss];
  }
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
  [self dismiss];
}

- (void)refresh {
  if (_options.count > 0) {
    // The first item is always what the floating action button "morphs" into.
    XYZActionMenuOption *firstOption = _options[0];
    _floatingActionButton.colorGroup = firstOption.colorGroup;
    _postToggleView.image = firstOption.image;
  }

  if (self.style != kXYZActionMenuStyleSheet) {
    [_collectionVC.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [self updateModalViewLayout];
    [self setSpeeddialActivated:_activated animated:NO completion:nil];
  }
}

- (void)setSheetStyleActivated:(BOOL)activated animated:(BOOL)animated
                    completion:(void (^)(void))completion {
  BOOL isPresentingViewController = self.presentedViewController &&
      !self.presentedViewController.isBeingDismissed;
  if (!isPresentingViewController && activated && _options.count > 0) {
    _activated = YES;

    _collectionVC.preferredContentSize =
    CGSizeMake(kSheetStyleCellWidth, kSheetStyleCellHeight * _options.count);

    XYZPopoverViewController *popVC =
    [[XYZPopoverViewController alloc] initWithContentViewController:_collectionVC];
    popVC.delegate = self;
    popVC.menuAnchor = XYZPopoverMenuAnchorAny;
    popVC.sourceView = _floatingActionButton;
    [self presentViewController:popVC animated:YES completion:^{
      _floatingActionButton.hidden = YES;
    }];
  } else {
    _activated = NO;
    if (self.presentedViewController) {
      _floatingActionButton.hidden = NO;
      [self dismissViewControllerAnimated:YES completion:^{
        completion();
      }];
    }
  }
}

- (void)setSpeeddialActivated:(BOOL)activated animated:(BOOL)animated
                   completion:(void (^)(void))completion {
  void (^innerCompletion)(void) = ^{
    [self updateFinalStateWithCompletion:completion];
  };

  _activated = activated;
  if (_activated) {
    BOOL isPresentingViewController = self.presentedViewController &&
        !self.presentedViewController.isBeingDismissed;
    if (!isPresentingViewController) {
      [self presentViewController:_collectionVC
                         animated:YES
                       completion:^{
                         CGPoint fabCenter =
                             [_floatingActionButton convertPoint:_floatingActionButton.center
                                                          toView:_collectionVC.view];
                         [_collectionVC.view addSubview:_floatingActionButton];
                         _floatingActionButton.isAccessibilityElement = NO;
                         _floatingActionButton.center = fabCenter;
                         [self updateAnimated:animated completion:innerCompletion];
                       }];
    } else {
      // The collection view controller is already present, so no additional presentation
      // is needed.
      [self updateAnimated:animated completion:innerCompletion];
    }
  } else {
    [self updateAnimated:animated completion:innerCompletion];
  }
}

- (void)updateModalViewLayout {
  // Update the layout only if not sheet style and the menu is activated.
  if (self.style == kXYZActionMenuStyleSheet || !_activated) {
    return;
  }
  // Determine the origin of the view in the collection view that is displayed modally.
  CGPoint viewOriginInModalView = [self.view convertPoint:CGPointZero toView:_collectionVC.view];

  // Reposition floating action button
  CGSize fabSize = _floatingActionButton.bounds.size;
  _floatingActionButton.frame =
      CGRectMake(viewOriginInModalView.x, viewOriginInModalView.y, fabSize.width, fabSize.height);

  // Cells only care about the size and x offset.
  CGRect cellFABFrame = CGRectMake(viewOriginInModalView.x, 0, fabSize.width, fabSize.height);

  UIEdgeInsets insets = UIEdgeInsetsZero;
  XYZActionMenuLayout *layout = (XYZActionMenuLayout *)_collectionVC.collectionViewLayout;
  CGFloat contentHeight = -layout.minimumLineSpacing;

  for (NSUInteger index = 0; index < _options.count; index++) {
    XYZActionMenuCell *cell = (XYZActionMenuCell *)[_collectionVC.collectionView
        cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    // Update the cell based on the relative position of the floating action button.
    [cell positionRelativeToFrame:cellFABFrame];

    contentHeight += [self heightForOptionAtIndex:index] + layout.minimumLineSpacing;
  }

  insets.top = viewOriginInModalView.y + fabSize.height - contentHeight;
  _collectionVC.collectionView.contentInset = insets;
}

- (void)handleSelectionOnOption:(XYZActionMenuOption *)option {
  if (_optionSelected) {
    return;
  }
  _optionSelected = YES;
  if (self.autoDismissOnSelection) {
    __weak XYZActionMenuViewController *weakSelf = self;
    [self dismissWithCompletion:^{
      [weakSelf performActionOnTargetForOption:option];
    }];
  } else {
    [self performActionOnTargetForOption:option];
  }
}

- (void)performActionOnTargetForOption:(XYZActionMenuOption *)option {
  if (option && option.target && option.action &&
      [option.target respondsToSelector:option.action]) {
    IMP imp = [option.target methodForSelector:option.action];
    void (*func)(id, SEL, XYZActionMenuOption *) = (void *)imp;
    func(option.target, option.action, option);
  }
  _optionSelected = NO;
}

/**
 * Toggle the state of the floating action button, which when displayed in an animation appears to
 * more the preToggle image to the postToggle image.
 */
- (void)toggleFloatingActionButton {
  _preToggleAnimationContainer.transform =
      _activated ? CGAffineTransformMakeRotation(kIconRotationRadians) : CGAffineTransformIdentity;
  _preToggleView.transform =
      _activated ? CGAffineTransformMakeScale(kPreToggleShrinkScaleX, kPreToggleShrinkScaleY)
                 : CGAffineTransformIdentity;

  _postToggleView.alpha = _activated ? 1 : 0;
  _postToggleView.transform =
      _activated ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(-kIconRotationRadians);
}

- (void)touchFloatingActionButton {
  // Ignore touches during a collapse animation.
  if (_collapseAnimationInProgress) {
    return;
  }

  if (_activated) {
    // User touched the floating action button before it was hidden
    [self handleSelectionOnOption:_options[0]];
  } else {
    // There is only one option, instead of displaying the menu, shortcut to performing the action.
    if (_options.count == 1) {
      [self performActionOnTargetForOption:_options[0]];
    } else {
      [self activateAnimated:YES withCompletion:nil];
    }
  }
}

- (void)updateFinalStateWithCompletion:(void (^)(void))completion {
  // Quick taps by the user might result in an activate followed by a quick deactivate. Base the
  // completion logic on the state at the end of the animation.
  if (!_activated && _collectionVC.presentingViewController) {
    // If the menu is not activated and the collection view controller is currently present,
    // the collection view controller must be dismissed before calling the completion block.
    [_collectionVC dismissViewControllerAnimated:NO
                                      completion:^{
                                        [self.view addSubview:_floatingActionButton];
                                        _floatingActionButton.isAccessibilityElement = YES;
                                        CGSize fabSize = _floatingActionButton.bounds.size;
                                        _floatingActionButton.frame =
                                            CGRectMake(0, 0, fabSize.width, fabSize.height);
                                        if (completion) {
                                          completion();
                                        }
                                      }];
  } else {
    if (completion) {
      completion();
    }
  }
}

- (void)updateAnimated:(BOOL)animated completion:(void (^)(void))completion {
  if (animated) {
    // Signal that the collapse animation is in progress.
    // This will prevent spurious touches on the floating action button to present the view again
    // until the animation is completed.
    _collapseAnimationInProgress = YES;

    // CATransaction to facilitate single, final completion callback.
    [CATransaction begin];
    {
      __weak XYZActionMenuViewController *weakSelf = self;
      [CATransaction setCompletionBlock:^{
        weakSelf.collapseAnimationInProgress = NO;
        if (completion) {
          completion();
        }
      }];
      [UIView qtm_animateWithDuration:kDefaultNormalAnimationDuration
                                curve:kXYZAnimationTimingCurveQuantumEaseInOut
                           animations:^{
                             [self toggleFloatingActionButton];
                           }];
      [self updateLayoutAnimated:YES];
    }
    [CATransaction commit];
  } else {
    [self toggleFloatingActionButton];
    [self updateLayoutAnimated:NO];
    if (completion) {
      completion();
    }
  }

  NSTimeInterval duration =
      _activated ? kXYZActionMenuFastAnimationDuration : kXYZActionMenuSuperFastAnimationDuration;
  NSUInteger curve =
      _activated ? kXYZAnimationTimingCurveQuantumEaseOut : kXYZAnimationTimingCurveQuantumEaseIn;
  [UIView qtm_animateWithDuration:animated ? duration : 0
                            curve:curve
                       animations:^{
                         _collectionVC.collectionView.backgroundView.alpha = _activated ? 1 : 0;
                       }];
}

- (void)updateLayoutAnimated:(BOOL)animated {
  // Stagger each of the cells to give an expansion effect.
  for (NSUInteger index = 0; index < _options.count; index++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    XYZActionMenuCell *cell =
        (XYZActionMenuCell *)[_collectionVC.collectionView cellForItemAtIndexPath:indexPath];
    NSTimeInterval staggerDelay = (animated && _activated) ? index * kCellStaggerDelayDuration : 0;
    [cell.optionView setActivatedState:_activated animated:animated withStaggerDelay:staggerDelay];
  }
}

@end
