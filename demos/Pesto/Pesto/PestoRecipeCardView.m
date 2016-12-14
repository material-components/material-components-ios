/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "PestoRecipeCardView.h"

#import "PestoIcons/PestoIconFish.h"
#import "PestoIcons/PestoIconMain.h"
#import "PestoIcons/PestoIconMeat.h"
#import "PestoIcons/PestoIconSpicy.h"
#import "PestoIcons/PestoIconTimer.h"
#import "PestoIcons/PestoIconVeggie.h"

#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

static CGFloat kPestoDetailDescTextHeight = 140;
static CGFloat kPestoDetailPadding = 28;
static CGFloat kPestoDetailSplitWidth = 64;

@interface PestoSplitView : UIView

@property(nonatomic) UIView *leftView;
@property(nonatomic) UIView *rightView;
@property(nonatomic) CGSize originalSize;

@end

@implementation PestoSplitView

- (instancetype)initWithFrame:(CGRect)frame
                     leftView:(UIView *)leftView
                    rightView:(UIView *)rightView {
  self = [super initWithFrame:frame];
  if (self) {
    _originalSize = frame.size;

    CGFloat leftWidth = kPestoDetailSplitWidth;
    CGFloat height = frame.size.height;
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, leftWidth, height)];
    [_leftView addSubview:leftView];
    [self addSubview:_leftView];
    CGRect rightFrame = CGRectMake(leftWidth, 0, self.frame.size.width - leftWidth, height);
    _rightView = [[UIView alloc] initWithFrame:rightFrame];
    [_rightView addSubview:rightView];
    _rightView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_rightView];
  }
  return self;
}

- (CGSize)intrinsicContentSize {
  return self.originalSize;
}

@end

@interface PestoRecipeCardView ()

@property(nonatomic) CGRect contentViewFrame;
@property(nonatomic) UIImageView *iconImageView;
@property(nonatomic) UILabel *amount1;
@property(nonatomic) UILabel *amount2;
@property(nonatomic) UILabel *amount3;
@property(nonatomic) UILabel *amount4;
@property(nonatomic) UILabel *ingredient1;
@property(nonatomic) UILabel *ingredient2;
@property(nonatomic) UILabel *ingredient3;
@property(nonatomic) UILabel *ingredient4;
@property(nonatomic) UILabel *labelDesc;
@property(nonatomic) UIStackView *stackView;

@end

@implementation PestoRecipeCardView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  _contentViewFrame = CGRectMake(kPestoDetailPadding, kPestoDetailPadding,
                                 self.frame.size.width - kPestoDetailPadding * 2.f,
                                 self.frame.size.height - kPestoDetailPadding * 2.f);
  UIView *contentView = [[UIView alloc] initWithFrame:_contentViewFrame];
  contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:contentView];

  CGRect iconFrame = CGRectMake(0, 0, 32, 32);
  UIImage *image = [PestoIconTimer drawTileImage:iconFrame];
  _iconImageView = [[UIImageView alloc] initWithImage:image];
  _iconImageView.frame =
      CGRectMake(0, 1.f, _iconImageView.frame.size.width, _iconImageView.frame.size.height);
  _titleLabel = [[UILabel alloc] init];
  _titleLabel.font = [MDCTypography headlineFont];
  _titleLabel.alpha = [MDCTypography headlineFontOpacity];
  _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.87f];
  _titleLabel.frame = CGRectMake(0, 0, _contentViewFrame.size.width - kPestoDetailSplitWidth,
                                 [MDCTypography display1Font].pointSize + 4.f);
  _labelDesc = [[UILabel alloc] init];
  _labelDesc.lineBreakMode = NSLineBreakByWordWrapping;
  _labelDesc.numberOfLines = 8;
  _labelDesc.font = [MDCTypography body1Font];
  _labelDesc.alpha = [MDCTypography body1FontOpacity];
  _labelDesc.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  UIFont *bodyFont = [MDCTypography body1Font];
  CGFloat bodyFontOpacity = [MDCTypography body1FontOpacity];
  _ingredient1 = [[UILabel alloc] init];
  _ingredient1.text = @"Mozzarella cheese";
  _ingredient1.font = bodyFont;
  _ingredient1.alpha = bodyFontOpacity;
  [_ingredient1 sizeToFit];

  _ingredient2 = [[UILabel alloc] init];
  _ingredient2.text = @"Toasts";
  _ingredient2.font = bodyFont;
  _ingredient2.alpha = bodyFontOpacity;
  [_ingredient2 sizeToFit];

  _ingredient3 = [[UILabel alloc] init];
  _ingredient3.text = @"Homemade pesto";
  _ingredient3.font = bodyFont;
  _ingredient3.alpha = bodyFontOpacity;
  [_ingredient3 sizeToFit];

  _ingredient4 = [[UILabel alloc] init];
  _ingredient4.text = @"Freshly ground pepper";
  _ingredient4.font = bodyFont;
  _ingredient4.alpha = bodyFontOpacity;
  [_ingredient4 sizeToFit];

  UIColor *teal = [UIColor colorWithRed:0.09f green:0.54f blue:0.44f alpha:1.f];
  UIFont *captionFont = [MDCTypography captionFont];
  CGFloat captionFontOpacity = [MDCTypography captionFontOpacity];

  _amount1 = [[UILabel alloc] init];
  _amount1.text = @"6 pieces";
  _amount1.font = captionFont;
  _amount1.alpha = captionFontOpacity;
  _amount1.textColor = teal;
  [_amount1 sizeToFit];

  _amount2 = [[UILabel alloc] init];
  _amount2.text = @"6 pieces";
  _amount2.font = captionFont;
  _amount2.alpha = captionFontOpacity;
  _amount2.textColor = teal;
  [_amount2 sizeToFit];

  _amount3 = [[UILabel alloc] init];
  _amount3.text = @"2/3 cup";
  _amount3.font = captionFont;
  _amount3.alpha = captionFontOpacity;
  _amount3.textColor = teal;
  [_amount3 sizeToFit];

  _amount4 = [[UILabel alloc] init];
  _amount4.text = @"1 tbsp";
  _amount4.font = captionFont;
  _amount4.alpha = captionFontOpacity;
  _amount4.textColor = teal;
  [_amount4 sizeToFit];

  CGRect splitViewTitleFrame =
      CGRectMake(0, 0, _contentViewFrame.size.width, [MDCTypography display1Font].pointSize + 4.f);
  PestoSplitView *splitViewTitle = [[PestoSplitView alloc] initWithFrame:splitViewTitleFrame
                                                                leftView:_iconImageView
                                                               rightView:_titleLabel];
  CGRect splitViewDescFrame =
      CGRectMake(0, 0, _contentViewFrame.size.width, kPestoDetailDescTextHeight);
  PestoSplitView *splitViewDesc =
      [[PestoSplitView alloc] initWithFrame:splitViewDescFrame leftView:nil rightView:_labelDesc];
  CGRect splitViewRect = CGRectMake(0, 0, _contentViewFrame.size.width, 18.f);
  PestoSplitView *splitView1 =
      [[PestoSplitView alloc] initWithFrame:splitViewRect leftView:_amount1 rightView:_ingredient1];
  PestoSplitView *splitView2 =
      [[PestoSplitView alloc] initWithFrame:splitViewRect leftView:_amount2 rightView:_ingredient2];
  PestoSplitView *splitView3 =
      [[PestoSplitView alloc] initWithFrame:splitViewRect leftView:_amount3 rightView:_ingredient3];
  PestoSplitView *splitView4 =
      [[PestoSplitView alloc] initWithFrame:splitViewRect leftView:_amount4 rightView:_ingredient4];

  CGRect stackFrame =
      CGRectMake(kPestoDetailPadding, 0, self.bounds.size.width - kPestoDetailPadding * 2.f,
                 self.bounds.size.height);
  _stackView = [[UIStackView alloc] initWithFrame:stackFrame];
  _stackView.axis = UILayoutConstraintAxisVertical;
  _stackView.spacing = 12.f;
  _stackView.translatesAutoresizingMaskIntoConstraints = NO;
  [contentView addSubview:_stackView];

  [_stackView addArrangedSubview:splitViewTitle];
  [_stackView addArrangedSubview:splitViewDesc];
  [_stackView addArrangedSubview:splitView1];
  [_stackView addArrangedSubview:splitView2];
  [_stackView addArrangedSubview:splitView3];
  [_stackView addArrangedSubview:splitView4];

  [_stackView.topAnchor constraintEqualToAnchor:contentView.topAnchor].active = YES;
  [_stackView.leftAnchor constraintEqualToAnchor:contentView.leftAnchor].active = YES;
  [_stackView.rightAnchor constraintEqualToAnchor:contentView.rightAnchor].active = YES;
  [_stackView.widthAnchor constraintEqualToAnchor:contentView.widthAnchor].active = YES;
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  self.titleLabel.text = _title;
}

- (void)setIconImageName:(NSString *)iconImageName {
  _iconImageName = [iconImageName copy];
  CGRect iconFrame = CGRectMake(0, 0, 32, 32);
  UIImage *icon = [PestoIconFish drawTileImage:iconFrame];
  if ([_iconImageName isEqualToString:@"Main"]) {
    icon = [PestoIconMain drawTileImage:iconFrame];
  } else if ([_iconImageName isEqualToString:@"Meat"]) {
    icon = [PestoIconMeat drawTileImage:iconFrame];
  } else if ([_iconImageName isEqualToString:@"Spicy"]) {
    icon = [PestoIconSpicy drawTileImage:iconFrame];
  } else if ([_iconImageName isEqualToString:@"Timer"]) {
    icon = [PestoIconTimer drawTileImage:iconFrame];
  } else if ([_iconImageName isEqualToString:@"Veggie"]) {
    icon = [PestoIconVeggie drawTileImage:iconFrame];
  }
  _iconImageView.image = icon;
}

- (void)setDescText:(NSString *)descText {
  _descText = [descText copy];

  NSMutableParagraphStyle *descParagraphStyle = [[NSMutableParagraphStyle alloc] init];
  descParagraphStyle.lineHeightMultiple = 1.2f;
  NSMutableAttributedString *descAttrString =
      [[NSMutableAttributedString alloc] initWithString:_descText];
  [descAttrString addAttribute:NSParagraphStyleAttributeName
                         value:descParagraphStyle
                         range:NSMakeRange(0, descAttrString.length)];
  self.labelDesc.attributedText = descAttrString;
  self.labelDesc.frame = CGRectMake(0, 0, self.contentViewFrame.size.width - kPestoDetailSplitWidth,
                                    kPestoDetailDescTextHeight);
}

@end
