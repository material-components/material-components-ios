#import "PestoCardCollectionViewCell.h"
#import "PestoRemoteImageService.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static const CGFloat kPestoCardPadding = 10.f;
static const CGFloat kPestoCardIconSize = 50.f;

@interface PestoCardCollectionViewCell ()

@property(nonatomic) UIImageView *iconImageView;
@property(nonatomic) UIImageView *thumbnailImageView;
@property(nonatomic) UILabel *authorLabel;
@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UIView *cellView;
@property(nonatomic) PestoRemoteImageService *imageService;

@end

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.imageService = [PestoRemoteImageService sharedService];
    [self commonInit];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self addSubview:_cellView];
}

- (void)commonInit {
  self.cellView = [[UIView alloc] initWithFrame:self.bounds];
  self.cellView.backgroundColor = [UIColor whiteColor];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0,
                                    0,
                                    self.frame.size.width,
                                    self.frame.size.height - kPestoCardIconSize);
  self.thumbnailImageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  self.thumbnailImageView.backgroundColor = [UIColor lightGrayColor];
  self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.thumbnailImageView.clipsToBounds = YES;
  [_cellView addSubview:_thumbnailImageView];

  CGRect iconImageViewFrame = CGRectMake(self.frame.size.width - kPestoCardIconSize,
                                         self.frame.size.height - kPestoCardIconSize,
                                         kPestoCardIconSize,
                                         kPestoCardIconSize);
  self.iconImageView = [[UIImageView alloc] initWithFrame:iconImageViewFrame];
  self.iconImageView.contentMode = UIViewContentModeCenter;
  [_cellView addSubview:_iconImageView];

  self.authorLabel = [[UILabel alloc] init];
  self.authorLabel.font = [MDCTypography captionFont];
  self.authorLabel.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  self.authorLabel.frame =
      CGRectMake(kPestoCardPadding,
                 self.frame.size.width - self.authorLabel.font.pointSize - kPestoCardPadding - 1.f,
                 self.frame.size.width - iconImageViewFrame.size.width,
                 self.authorLabel.font.pointSize + 2.f);
  [_cellView addSubview:_authorLabel];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.font = [MDCTypography body1Font];
  self.titleLabel.frame =
      CGRectMake(kPestoCardPadding,
                 self.authorLabel.frame.origin.y - self.titleLabel.font.pointSize -
                     kPestoCardPadding / 2.f,
                 self.frame.size.width - iconImageViewFrame.size.width,
                 self.titleLabel.font.pointSize + 2.f);
  [_cellView addSubview:_titleLabel];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];
}

- (void)populateContentWithTitle:(NSString *)title
                          author:(NSString *)author
                        imageURL:(NSURL *)imageURL
                        iconName:(NSString *)iconName {
  _title = title;
  _titleLabel.text = title;
  _authorLabel.text = author;

  UIImage *icon = [UIImage imageNamed:iconName];
  _iconImageView.image = icon;
  __weak __typeof__(self) weakSelf = self;
  [_imageService fetchImageAndThumbnailFromURL:imageURL
                                    completion:^(UIImage *image, UIImage *thumbnailImage) {
                                      [weakSelf setImage:image];
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                        [weakSelf.thumbnailImageView setImage:thumbnailImage];
                                      });
                                    }];
}

- (void)prepareForReuse {
  [super prepareForReuse];
  _title = nil;
  _image = nil;
  [_thumbnailImageView setImage:nil];
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
