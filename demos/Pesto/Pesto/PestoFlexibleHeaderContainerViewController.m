/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "PestoFlexibleHeaderContainerViewController.h"
#import "PestoCollectionViewController.h"
#import "PestoDetailViewController.h"
#import "PestoSettingsViewController.h"
#import "PestoSideView.h"

#import "MaterialSpritedAnimationView.h"

static CGFloat kPestoAnimationDuration = 0.33f;
static CGFloat kPestoInset = 5.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoFlexibleHeaderContainerViewController () <PestoCollectionViewControllerDelegate,
                                                          PestoSideViewDelegate,
                                                          UIViewControllerAnimatedTransitioning,
                                                          UIViewControllerTransitioningDelegate>

@property(nonatomic) PestoCollectionViewController *collectionViewController;
@property(nonatomic) PestoSideView *sideView;
@property(nonatomic) MDCSpritedAnimationView *animatedMenuArrow;
@property(nonatomic) UIImageView *zoomableView;
@property(nonatomic) UIView *zoomableCardView;

@end

@implementation PestoFlexibleHeaderContainerViewController

- (instancetype)init {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.minimumInteritemSpacing = 0;
  CGFloat sectionInset = kPestoInset * 2.f;
  [layout setSectionInset:UIEdgeInsetsMake(sectionInset,
                                           sectionInset,
                                           sectionInset,
                                           sectionInset)];
  PestoCollectionViewController *collectionVC =
      [[PestoCollectionViewController alloc] initWithCollectionViewLayout:layout];
  self = [super initWithContentViewController:collectionVC];
  if (self) {
    _collectionViewController = collectionVC;
    _collectionViewController.flexHeaderContainerVC = self;
    _collectionViewController.delegate = self;
    [self setNeedsStatusBarAppearanceUpdate];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  self.sideView.hidden = YES;
  self.sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.sideView.delegate = self;
  [self.view addSubview:self.sideView];

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  self.animatedMenuArrow = [[MDCSpritedAnimationView alloc]
      initWithSpriteSheetImage:spriteImage];
  self.animatedMenuArrow.frame = CGRectMake(20.f, 20.f, 24.f, 24.f);
  self.animatedMenuArrow.tintColor = [UIColor whiteColor];
  [self.view addSubview:self.animatedMenuArrow];

  UIButton *button = [[UIButton alloc] initWithFrame:self.animatedMenuArrow.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  self.zoomableCardView = [[UIView alloc] initWithFrame:CGRectZero];
  self.zoomableCardView.backgroundColor = [UIColor whiteColor];
  [self.view insertSubview:self.zoomableCardView belowSubview:self.animatedMenuArrow];

  self.zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  self.zoomableView.backgroundColor = [UIColor lightGrayColor];
  self.zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view insertSubview:self.zoomableView belowSubview:self.animatedMenuArrow];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)showMenu {
  self.sideView.hidden = NO;
  [self.sideView showSideView];
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

#pragma mark - PestoCollectionViewControllerDelegate

- (void)didSelectCell:(PestoCardCollectionViewCell *)cell completion:(void (^)())completionBlock {
  self.zoomableView.frame =
      CGRectMake(cell.frame.origin.x,
                 cell.frame.origin.y - self.collectionViewController.scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height - 50.f);
  self.zoomableCardView.frame =
      CGRectMake(cell.frame.origin.x,
                 cell.frame.origin.y - self.collectionViewController.scrollOffsetY,
                 cell.frame.size.width,
                 cell.frame.size.height);
  dispatch_async(dispatch_get_main_queue(), ^{
    self.zoomableView.image = cell.image;

    [self.animatedMenuArrow startAnimatingWithCompletion:^{
      UIImage *spriteImageArrowToMenu = [UIImage imageNamed:kPestoBackArrowToMenu];
      self.animatedMenuArrow.spriteSheetImage = spriteImageArrowToMenu;
    }];

    [UIView animateWithDuration:kPestoAnimationDuration
        delay:0.0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          CGRect zoomFrame = CGRectMake(0, 0, self.view.bounds.size.width, 320.f);
          self.zoomableView.frame = zoomFrame;
          self.zoomableCardView.frame = self.view.bounds;
        }
        completion:^(BOOL finished) {
          PestoDetailViewController *detailVC =
              [[PestoDetailViewController alloc] init];
          detailVC.image = cell.image;
          detailVC.title = cell.title;
          detailVC.iconImageName = cell.iconImageName;
          detailVC.descText = cell.descText;

          detailVC.modalPresentationStyle = UIModalPresentationCustom;
          detailVC.transitioningDelegate = self;

          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             self.zoomableView.frame = CGRectZero;
                             self.zoomableCardView.frame = CGRectZero;
                             self.animatedMenuArrow.spriteSheetImage =
                                 [UIImage imageNamed:kPestoMenuToBackArrow];
                             completionBlock();
                           }];
        }];
  });
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:
                                                          (UIViewController *)presented
                                                                           presentingController:(UIViewController *)presenting
                                                                               sourceController:(UIViewController *)source {
  return nil;
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
        (UIViewController *)dismissed {
  return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *const fromController = [transitionContext
      viewControllerForKey:UITransitionContextFromViewControllerKey];

  UIViewController *const toController = [transitionContext
      viewControllerForKey:UITransitionContextToViewControllerKey];

  if ([fromController isKindOfClass:[PestoDetailViewController class]] &&
      [toController isKindOfClass:self.class]) {
    // This is our custom dismissal that keeps the arrow button at the top of the controller
    UIImage *spriteImageArrowToMenu = [UIImage imageNamed:kPestoMenuToBackArrow];
    [self.view insertSubview:fromController.view belowSubview:self.animatedMenuArrow];
    ((PestoDetailViewController *)fromController).animationView.hidden = YES;

    [self.animatedMenuArrow startAnimatingWithCompletion:^{
      self.animatedMenuArrow.spriteSheetImage = spriteImageArrowToMenu;
    }];

    CGRect detailFrame = fromController.view.frame;
    detailFrame.origin.y = self.view.frame.size.height;

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
        delay:0.f
        options:UIViewAnimationOptionCurveEaseIn
        animations:^{
          fromController.view.frame = detailFrame;
        }
        completion:^(BOOL finished) {
          [fromController.view removeFromSuperview];
          [transitionContext completeTransition:YES];
        }];
  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.2f;
}

#pragma mark - PestoSideViewDelegate

- (void)sideViewDidSelectSettings:(PestoSideView *)sideView {
  PestoSettingsViewController *settingsVC = [PestoSettingsViewController new];
  settingsVC.title = @"Settings";

  UIColor *white = [UIColor whiteColor];
  UIColor *teal = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1.f];
  UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
      initWithTitle:@"Done"
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(closeViewController)];
  rightBarButton.tintColor = white;
  settingsVC.navigationItem.rightBarButtonItem = rightBarButton;

  UINavigationController *navVC = [[UINavigationController alloc]
      initWithRootViewController:settingsVC];
  navVC.navigationBar.barTintColor = teal;
  navVC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : white};
  navVC.navigationBar.translucent = NO;
  navVC.navigationBarHidden = YES;

  [sideView hideSideView];
  [self presentViewController:navVC animated:YES completion:nil];
}

- (void)closeViewController {
  [self dismissViewControllerAnimated:true completion:nil];
}

@end
