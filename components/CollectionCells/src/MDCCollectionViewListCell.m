//
//  MDCCollectionViewListCell.m
//  MaterialComponents
//
//  Created by yar on 4/9/18.
//

#import "MDCCollectionViewListCell.h"
#import <MDFInternationalization/MDFInternationalization.h>

@implementation MDCCollectionViewListCell {
  CGPoint _lastTouch;
  UIView *_contentWrapper;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}


- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionViewListCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCCollectionViewListCellInit];
  }
  return self;
}

//- (void)resetMDCCollectionViewTextCellLabelProperties {
//  _textLabel.font = CellDefaultTextFont();
//  _textLabel.textColor = [UIColor colorWithWhite:0 alpha:CellDefaultTextOpacity()];
//  _textLabel.shadowColor = nil;
//  _textLabel.shadowOffset = CGSizeZero;
//  _textLabel.textAlignment = NSTextAlignmentNatural;
//  _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//  _textLabel.numberOfLines = 1;
//
//  _detailTextLabel.font = CellDefaultDetailTextFont();
//  _detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:CellDefaultDetailTextFontOpacity()];
//  _detailTextLabel.shadowColor = nil;
//  _detailTextLabel.shadowOffset = CGSizeZero;
//  _detailTextLabel.textAlignment = NSTextAlignmentNatural;
//  _detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//  _detailTextLabel.numberOfLines = 1;
//}

- (void)commonMDCCollectionViewListCellInit {
  _contentWrapper = [[UIView alloc] initWithFrame:self.contentView.bounds];
  _contentWrapper.autoresizingMask =
  UIViewAutoresizingFlexibleWidth | MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);
  _contentWrapper.clipsToBounds = YES;
  [self.contentView addSubview:_contentWrapper];

  // Text label.
  _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _textLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);

  // Detail text label.
  _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _detailTextLabel.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);

//  [self resetMDCCollectionViewTextCellLabelProperties];

  [_contentWrapper addSubview:_textLabel];
  [_contentWrapper addSubview:_detailTextLabel];

  // Image view.
  _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  _imageView.autoresizingMask = MDFTrailingMarginAutoresizingMaskForLayoutDirection(self.mdf_effectiveUserInterfaceLayoutDirection);
  [self.contentView addSubview:_imageView];


  [

}





- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;

  [super touchesBegan:touches withEvent:event];
}


@end
