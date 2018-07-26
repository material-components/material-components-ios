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

static const CGFloat LabelLeadingPadding = 72.f;
static const CGFloat LabelBaselinePadding = 32.f;
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
  MDCInkView *_inkView;
}

+ (instancetype)cellWithAction:(MDCActionSheetAction *)action {
  return [[MDCActionSheetItemView alloc] initWithAction:action];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.text = @"hello";
  }
  return self;
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

  if (!_inkView) {
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    _inkView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _inkView.usesLegacyInkRipple = NO;
    _inkView.clipsToBounds = NO;
    _inkView.inkColor = [UIColor blackColor];
    [self addSubview:_inkView];
  }

  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = title;
    _titleLabel.alpha = LabelAlpha;
    [_titleLabel sizeToFit];
    [self addSubview:_titleLabel];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1
                                  constant:LabelLeadingPadding].active = YES;

    CGFloat yPosition = LabelBaselinePadding - _titleLabel.font.ascender;
    [NSLayoutConstraint constraintWithItem:_titleLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:yPosition].active = YES;
  }

  if (!_icon) {
    _icon = [[UIImageView alloc] initWithImage:image];
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
}

- (NSString *)accessibilityLabel {
  return [NSString stringWithFormat:@"Button %@", title];
}

@end

/**@implementation MDCACtionSheetHeaderView

- (instancetype)headerWithTitle:(NSString *)title {
  return [self headerWithTitle:title message:nil];
}

- (instancetype)headerWithTitle:(NSString *)title message:(NSString *)message {
  self = [super initWithReuseIdentifier:@"Header"];
  if (self) {
    _title = title;
    _message = message;
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetHeaderViewInit {

}

@end*/
