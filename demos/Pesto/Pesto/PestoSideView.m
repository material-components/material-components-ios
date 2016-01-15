#import "PestoSideView.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"

static CGFloat kPestoSideViewAnimationDuration = 0.2f;
static CGFloat kPestoSideViewWidth = 240.f;

@interface PestoSideContentView : UIView

@end

@implementation PestoSideContentView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end

@interface PestoSideView ()

@property (nonatomic) PestoSideContentView *contentView;
@property (nonatomic) UIButton *dismissButton;

@end

@implementation PestoSideView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGRect contentViewFrame =
        CGRectMake(-kPestoSideViewWidth, 0, kPestoSideViewWidth, self.frame.size.height);
    _contentView = [[PestoSideContentView alloc] initWithFrame:contentViewFrame];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];

    UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(hideSideView)];
    [self addGestureRecognizer:tap];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)_contentView.layer;
  [shadowLayer setElevation:MDCShadowElevationNavDrawer];
}

- (void)showSideView {
  [UIView animateWithDuration:kPestoSideViewAnimationDuration
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^ {
                     _contentView.transform = [PestoSideView showTransform];
                   } completion:^(BOOL finished) {
                     
                   }];
}

- (void)hideSideView {
  [UIView animateWithDuration:kPestoSideViewAnimationDuration
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^ {
                     _contentView.transform = [PestoSideView hideTransform];
                   } completion:^(BOOL finished) {
                     self.hidden = YES;
                   }];
}

+ (CGAffineTransform)showTransform {
  return CGAffineTransformMakeTranslation(kPestoSideViewWidth, 0);
}

+ (CGAffineTransform)hideTransform {
  return CGAffineTransformIdentity;
}

@end
