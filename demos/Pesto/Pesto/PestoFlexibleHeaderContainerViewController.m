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
                                                          PestoSideViewDelegate>

@property(nonatomic) PestoCollectionViewController *collectionViewController;
@property(nonatomic) PestoSideView *sideView;
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

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  MDCSpritedAnimationView *animationView = [[MDCSpritedAnimationView alloc]
      initWithSpriteSheetImage:spriteImage];
  animationView.frame = CGRectMake(20.f, 20.f, 24.f, 24.f);
  animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:animationView];

  UIButton *button = [[UIButton alloc] initWithFrame:animationView.frame];
  [self.view addSubview:button];
  [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

  self.sideView = [[PestoSideView alloc] initWithFrame:self.view.bounds];
  self.sideView.hidden = YES;
  self.sideView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.sideView.delegate = self;
  [self.view addSubview:self.sideView];

  self.zoomableCardView = [[UIView alloc] initWithFrame:CGRectZero];
  self.zoomableCardView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.zoomableCardView];

  self.zoomableView = [[UIImageView alloc] initWithFrame:CGRectZero];
  self.zoomableView.backgroundColor = [UIColor lightGrayColor];
  self.zoomableView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:self.zoomableView];
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
    [self.zoomableView setImage:cell.image];
    [UIView animateWithDuration:kPestoAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          CGRect zoomFrame = CGRectMake(0, 0, self.view.bounds.size.width, 320);
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
          [self presentViewController:detailVC
                             animated:NO
                           completion:^() {
                             self.zoomableView.frame = CGRectZero;
                             self.zoomableCardView.frame = CGRectZero;
                             completionBlock();
                           }];
        }];
  });
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

  [sideView hideSideView];
  [self presentViewController:navVC animated:YES completion:nil];
}

- (void)closeViewController {
  [self dismissViewControllerAnimated:true completion:nil];
}

@end
