#import "PestoDetailViewController.h"
#import "PestoRecipeCardView.h"

#import "MaterialSpritedAnimationView.h"

static CGFloat kPestoDetailAnimationDelay = 0.1f;
static CGFloat kPestoDetailAnimationDuration = 0.33f;
static CGFloat kPestoDetailBottomSheetBackgroundHeight = 320.f;
static CGFloat kPestoDetailBottomSheetHeightPortrait = 380.f;
static CGFloat kPestoDetailBottomSheetHeightLandscape = 300.f;
static NSString *const kPestoDetailBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoDetailViewController ()

@property(nonatomic) CGFloat bottomSheetHeight;
@property(nonatomic) PestoRecipeCardView *bottomView;
@property(nonatomic) UIImageView *imageView;

@end

@implementation PestoDetailViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightPortrait;
  } else {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightLandscape;
  }

  UIView *mainView = [[UIView alloc] initWithFrame:self.view.frame];
  mainView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:mainView];

  CGRect imageViewFrame = CGRectMake(0,
                                     0,
                                     self.view.frame.size.width,
                                     kPestoDetailBottomSheetBackgroundHeight);
  _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  [self.view addSubview:_imageView];

  CGRect bottomFrame =
      CGRectMake(0,
                 kPestoDetailBottomSheetBackgroundHeight,
                 self.view.frame.size.width,
                 self.view.frame.size.height - kPestoDetailBottomSheetBackgroundHeight);
  UIView *bottomViewBackground = [[UIView alloc] initWithFrame:bottomFrame];
  bottomViewBackground.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:bottomViewBackground];
  _bottomView.frame = bottomFrame;
  _bottomView = [[PestoRecipeCardView alloc] initWithFrame:bottomFrame];
  _bottomView.title = self.title;
  _bottomView.iconImageName = self.iconImageName;
  _bottomView.descText = self.descText;
  _bottomView.alpha = 0;
  [self.view addSubview:_bottomView];

  dispatch_async(dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:kPestoDetailAnimationDuration
        delay:kPestoDetailAnimationDelay
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          _bottomView.alpha = 1;
        }
        completion:^(BOOL finished){
        }];
  });

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(20.f, 20.f, 24.f, 24.f);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                               kPestoDetailAnimationDuration * NSEC_PER_SEC),
                 dispatch_get_main_queue(), ^{
                   [_animationView startAnimatingWithCompletion:^{
                     UIImage *spriteImage = [UIImage imageNamed:kPestoDetailMenuBack];
                     _animationView.spriteSheetImage = spriteImage;
                   }];
                 });

  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(tapDetected)];
  tap.numberOfTapsRequired = 1;
  _animationView.userInteractionEnabled = YES;
  [_animationView addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self loadImage];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightPortrait;
  } else {
    self.bottomSheetHeight = kPestoDetailBottomSheetHeightLandscape;
  }
  CGRect bottomFrame =
      CGRectMake(0,
                 self.view.frame.size.height - self.bottomSheetHeight,
                 self.view.frame.size.width,
                 self.bottomSheetHeight);
  _bottomView.frame = bottomFrame;
}

- (void)loadImage {
  dispatch_async(dispatch_get_main_queue(), ^{
    [_imageView setImage:_image];
  });
}

- (void)tapDetected {
  [_animationView startAnimatingWithCompletion:^{
    _showMenuIcon = !_showMenuIcon;
    NSString *imageName = (_showMenuIcon
                               ? kPestoDetailMenuBack
                               : kPestoDetailBackMenu);
    UIImage *spriteImage = [UIImage imageNamed:imageName];
    _animationView.spriteSheetImage = spriteImage;
    _animationView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
}

/** Use MDCAnimationCurve once available. */
- (CAMediaTimingFunction *)quantumEaseInOut {
  // This curve is slow both at the beginning and end.
  // Visualization of curve  http://cubic-bezier.com/#.4,0,.2,1
  return [[CAMediaTimingFunction alloc] initWithControlPoints:0.4f:0.0f:0.2f:1.0f];
}

@end
