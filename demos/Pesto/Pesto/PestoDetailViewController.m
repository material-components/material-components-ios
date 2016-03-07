#import "PestoDetailViewController.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialSpritedAnimationView.h"
#import "MaterialTypography.h"

static CGFloat kPestoDetailViewControllerAnimationDelay = 0.1f;
static CGFloat kPestoDetailViewControllerAnimationDuration = 0.33f;
static CGFloat kPestoDetailViewControllerBottomSheetHeight = 320.f;
static NSString *const kPestoDetailViewControllerBackMenu = @"mdc_sprite_menu__arrow_back";
static NSString *const kPestoDetailViewControllerMenuBack = @"mdc_sprite_arrow_back__menu";

@interface PestoRecipeCardView : UIView

@property(nonatomic) NSString *title;

@end

@implementation PestoRecipeCardView

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *contentView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 24.f, 24.f)];
  contentView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:contentView];

  UILabel *title = [[UILabel alloc] init];
  title.text = _title;
  title.font = [MDCTypography headlineFont];
  [title sizeToFit];

  CGRect textViewFrame = CGRectMake(0, 0, contentView.bounds.size.width, 100.f);
  UITextView *desc = [[UITextView alloc] initWithFrame:textViewFrame];
  desc.text = @"This beautiful sprouts receipe is the most glorious side dish on a cold winters\
 night. Construct it with bacon or fake-on, but always make sure the sprouts are deliciously\
 seasonsed and appropriately sautéed.";
  desc.font = [MDCTypography captionFont];
  desc.textColor = [UIColor colorWithWhite:[MDCTypography captionFontOpacity] alpha:1];
  desc.editable = NO;
  [desc setTextContainerInset:UIEdgeInsetsMake(0, -4.f, 0, -4.f)];
  [desc sizeToFit];

  CGFloat lightHeight = 0.5f;
  UIView *lineView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, lightHeight)];
  [lineView.heightAnchor constraintEqualToConstant:lightHeight].active = YES;
  lineView.backgroundColor = [UIColor lightGrayColor];

  UILabel *ingredients = [[UILabel alloc] init];
  ingredients.text = @"Ingredients";
  ingredients.font = [MDCTypography titleFont];
  [ingredients sizeToFit];

  UILabel *ingredient1 = [[UILabel alloc] init];
  ingredient1.text = @"Eggs";
  ingredient1.font = [MDCTypography captionFont];
  ingredient1.textColor = [UIColor colorWithWhite:[MDCTypography captionFontOpacity] alpha:1];
  [ingredient1 sizeToFit];

  UILabel *ingredient2 = [[UILabel alloc] init];
  ingredient2.text = @"Flour";
  ingredient2.font = [MDCTypography captionFont];
  ingredient2.textColor = [UIColor colorWithWhite:[MDCTypography captionFontOpacity] alpha:1];
  [ingredient2 sizeToFit];

  UIStackView *stackView = [[UIStackView alloc] initWithFrame:self.bounds];
  stackView.axis = UILayoutConstraintAxisVertical;
  stackView.spacing = 20.f;
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  [contentView addSubview:stackView];

  [stackView addArrangedSubview:title];
  [stackView addArrangedSubview:desc];
  [stackView addArrangedSubview:lineView];
  [stackView addArrangedSubview:ingredients];
  [stackView addArrangedSubview:ingredient1];
  [stackView addArrangedSubview:ingredient2];

  [stackView.topAnchor constraintEqualToAnchor:contentView.topAnchor].active = YES;
  [stackView.leftAnchor constraintEqualToAnchor:contentView.leftAnchor].active = YES;
  [stackView.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor].active = YES;
  [stackView.rightAnchor constraintEqualToAnchor:contentView.rightAnchor].active = YES;
  [stackView.widthAnchor constraintEqualToAnchor:contentView.widthAnchor].active = YES;
}

@end

@interface PestoDetailViewController ()

@property(nonatomic) UIImageView *imageView;

@end

@implementation PestoDetailViewController {
  BOOL _showMenuIcon;
  MDCSpritedAnimationView *_animationView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *mainView = [[UIView alloc] initWithFrame:self.view.frame];
  mainView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:mainView];

  _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_imageView];

  CGRect bottomFrame = CGRectMake(0,
                                  self.view.frame.size.height,
                                  self.view.frame.size.width,
                                  kPestoDetailViewControllerBottomSheetHeight);
  PestoRecipeCardView *bottomView = [[PestoRecipeCardView alloc] initWithFrame:bottomFrame];
  bottomView.backgroundColor = [UIColor whiteColor];
  bottomView.title = self.title;
  [self.view addSubview:bottomView];

  dispatch_async(dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:kPestoDetailViewControllerAnimationDuration
        delay:kPestoDetailViewControllerAnimationDelay
        options:UIViewAnimationOptionCurveEaseOut
        animations:^{
          CAMediaTimingFunction *quantumEaseInOut = [self quantumEaseInOut];
          [CATransaction setAnimationTimingFunction:quantumEaseInOut];
          CGRect bottomFrameEnd =
              CGRectMake(0,
                         self.view.frame.size.height -
                             kPestoDetailViewControllerBottomSheetHeight,
                         self.view.frame.size.width,
                         kPestoDetailViewControllerBottomSheetHeight);
          bottomView.frame = bottomFrameEnd;
        }
        completion:^(BOOL finished){
        }];
  });

  UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerBackMenu];
  _animationView = [[MDCSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];
  _animationView.frame = CGRectMake(16.f, 16.f, 24.f, 24.f);
  _animationView.tintColor = [UIColor whiteColor];
  [self.view addSubview:_animationView];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                               kPestoDetailViewControllerAnimationDuration * NSEC_PER_SEC),
                 dispatch_get_main_queue(), ^{
                   [_animationView startAnimatingWithCompletion:^{
                     UIImage *spriteImage = [UIImage imageNamed:kPestoDetailViewControllerMenuBack];
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

- (void)loadImage {
  dispatch_async(dispatch_get_main_queue(), ^{
    [_imageView setImage:_image];
  });
}

- (void)tapDetected {
  [_animationView startAnimatingWithCompletion:^{
    _showMenuIcon = !_showMenuIcon;
    NSString *imageName = (_showMenuIcon
                               ? kPestoDetailViewControllerMenuBack
                               : kPestoDetailViewControllerBackMenu);
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
