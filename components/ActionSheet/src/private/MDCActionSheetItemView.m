/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCActionSheetItemView.h"

static const CGFloat TitleLabelAlpha = 0.54f;
static const CGFloat TitleLabelLeadingPadding = 16.f;
static const CGFloat TitleLabelTopPadding = 36.f;

static const CGFloat LabelLeadingPadding = 72.f;
static const CGFloat LabelTrailingPadding = 16.f;
/// This comes from design, a cell should be 56pt tall and the baseline for a single
/// line list item should be centered. Standard font is 20pt tall so that leaves 36pt
/// to support dynamic type we have 36pt / 2 = 18pt.
/// If we change the standard font this will need to be changed.
static const CGFloat LabelVerticalPadding = 18.f;
static const CGFloat LabelAlpha = 0.87f;

static const CGFloat IconLeadingPadding = 16.f;
static const CGFloat IconTopPadding = 16.f;
static const CGFloat IconAlpha = 0.54f;

@interface MDCActionSheetItemView ()

@property(nonatomic, nonnull, strong) UILabel *titleLabel;
@property(nonatomic, nonnull, strong) UIImageView *icon;

@end


@implementation MDCActionSheetItemView {
  NSString *title;
  UIImage *image;
  MDCActionSheetHandler handler;
  MDCInkTouchController *_inkTouchController;
}

+ (instancetype)cellWithAction:(MDCActionSheetAction *)action {
  return [[MDCActionSheetItemView alloc] initWithAction:action];
}

- (instancetype)initWithAction:(MDCActionSheetAction *)action {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  if (self) {
    title = action.title;
    image = action.image;
    handler = action.action;
    [self commonMDCActionSheetItemViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetItemViewInit {
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.accessibilityTraits = UIAccessibilityTraitButton;

  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = title;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _titleLabel.numberOfLines = 0;
  }
  [self addSubview:_titleLabel];
  [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

  [NSLayoutConstraint constraintWithItem:_titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:LabelLeadingPadding].active = YES;

  [NSLayoutConstraint constraintWithItem:_titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:LabelVerticalPadding].active = YES;

  [NSLayoutConstraint constraintWithItem:_titleLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:LabelVerticalPadding].active = YES;
  [NSLayoutConstraint constraintWithItem:_titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:LabelTrailingPadding].active = YES;

  if (!_icon) {
    _icon = [[UIImageView alloc] initWithImage:image];
  }

  if (!_inkTouchController) {
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _titleLabel.alpha = LabelAlpha;
  _titleLabel.font = _font;

  [self.contentView setNeedsLayout];
  [self.contentView layoutIfNeeded];

  _icon.frame = CGRectMake(0, 0, 24, 24);
  _icon.alpha = IconAlpha;
  [self addSubview:_icon];
  [_icon setTranslatesAutoresizingMaskIntoConstraints:NO];
  [NSLayoutConstraint constraintWithItem:_icon
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:IconLeadingPadding].active = YES;
  [NSLayoutConstraint constraintWithItem:_icon
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:IconTopPadding].active = YES;
}

- (NSString *)accessibilityLabel {
  return title;
}

- (void)setFont:(UIFont *)font {
  _font = font;
  [self setNeedsLayout];
}

@end

@implementation MDCACtionSheetHeaderView {
  UILabel *_titleLabel;
}

- (instancetype)initWithTitle:(NSString *)title {
  self = [super init];
  if (self) {
    _title = title;
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetHeaderViewInit {
  self.backgroundColor = [UIColor whiteColor];
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  }
}

- (void)layoutSubviews {
  _titleLabel.text = _title;
  _titleLabel.alpha = TitleLabelAlpha;
  _titleLabel.font = _font;
  [_titleLabel sizeToFit];
  [self addSubview:_titleLabel];
  [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [NSLayoutConstraint constraintWithItem:_titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:TitleLabelLeadingPadding].active = YES;

  CGFloat yPosition = TitleLabelTopPadding - _titleLabel.font.ascender;
  [NSLayoutConstraint constraintWithItem:_titleLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:yPosition].active = YES;
}

- (void)setFont:(UIFont *)font {
  _font = font;
  [self setNeedsLayout];
}

@end
