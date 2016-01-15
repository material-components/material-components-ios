#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
#import "PestoCardCollectionViewCell.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

@implementation PestoCardCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.title = @"Title";
    self.author = @"Author";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIView *cellView = [[UIView alloc] initWithFrame:self.bounds];
  cellView.backgroundColor = [UIColor whiteColor];
  [self addSubview:cellView];

  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)self.layer;
  shadowLayer.shadowMaskEnabled = NO;
  [shadowLayer setElevation:MDCShadowElevationCardResting];

  CGRect imageViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width - 50.f);
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
  }
  _imageView.frame = imageViewRect;
  _imageView.backgroundColor = [UIColor lightGrayColor];
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _imageView.clipsToBounds = YES;
  [self addSubview:_imageView];

  UILabel *label = [[UILabel alloc] init];
  label.text = _title;
  label.font = [MDCTypography body1Font];
  label.textColor = [UIColor colorWithWhite:0.2f alpha:1];
  [label sizeToFit];
  label.frame = CGRectMake(10.f,
                           self.frame.size.height - label.frame.size.height - 24.f,
                           label.frame.size.width,
                           label.frame.size.height);
  [cellView addSubview:label];

  UILabel *labelAuthor = [[UILabel alloc] init];
  labelAuthor.text = _author;
  labelAuthor.font = [MDCTypography captionFont];
  labelAuthor.textColor = [UIColor colorWithWhite:0.5f alpha:1];
  [labelAuthor sizeToFit];
  labelAuthor.frame = CGRectMake(10.f,
                                 self.frame.size.height - labelAuthor.frame.size.height - 8.f,
                                 labelAuthor.frame.size.width,
                                 labelAuthor.frame.size.height);
  [cellView addSubview:labelAuthor];

  UIView *inkView = [[UIView alloc] initWithFrame:self.bounds];
  inkView.backgroundColor = [UIColor clearColor];
  [self addSubview:inkView];

  _inkTouchController = [[MDCInkTouchController alloc] initWithView:inkView];
  _inkTouchController.delegate = self;
  [_inkTouchController addInkView];

  UIImage *icon = [UIImage imageNamed:_icon];
  UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
  iconImageView.frame =
      CGRectMake(cellView.frame.size.width - iconImageView.frame.size.width - 6.f,
                 cellView.frame.size.height - iconImageView.frame.size.height - 12.f,
                 iconImageView.frame.size.width,
                 iconImageView.frame.size.height);
  [cellView addSubview:iconImageView];
}

- (void)prepareForReuse {
  [super prepareForReuse];

  for (UIView *subview in [self.contentView subviews]) {
    [subview removeFromSuperview];
  }

  _author = nil;
  _icon = nil;
  _imageURL = nil;
  _title = nil;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
