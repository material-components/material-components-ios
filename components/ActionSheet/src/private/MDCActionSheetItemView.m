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
#import "MaterialTypography.h"

static const CGFloat kTitleLabelAlpha = 0.87f;
static const CGFloat kMessageLabelAlpha = 0.54f;
static const CGFloat kImageAlpha = 0.54f;
static const CGFloat kCellLabelAlpha = 0.87f;

@interface MDCActionSheetItemView ()
@end


@implementation MDCActionSheetItemView {
  MDCActionSheetAction *_itemAction;
  UILabel *_textLabel;
  UIImageView *_imageView;
  MDCInkTouchController *_inkTouchController;
}

- (instancetype)initWithAction:(MDCActionSheetAction *)action
               reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    _itemAction = action;
    [self commonMDCActionSheetItemViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetItemViewInit {
  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.accessibilityTraits = UIAccessibilityTraitButton;
  _textLabel = [[UILabel alloc] init];
  _textLabel.text = _itemAction.title;
  [_textLabel sizeToFit];
  [self.contentView addSubview:_textLabel];
  _textLabel.numberOfLines = 0;
  [_textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  _textLabel.font = [UIFont systemFontOfSize:16.f];
  _textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  _textLabel.alpha = kCellLabelAlpha;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:18.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                              multiplier:1
                                constant:-18.f].active = YES;
  CGFloat leadingConstant;
  if (_itemAction.image == nil) {
    leadingConstant = 16.f;
  } else {
    leadingConstant = 72.f;
  }
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:leadingConstant].active = YES;
  [NSLayoutConstraint constraintWithItem:_textLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:-16.f].active = YES;
  if (!_inkTouchController) {
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];
  }
  if (_itemAction.image == nil) {
    return;
  }
  _imageView = [[UIImageView alloc] init];
  [self.contentView addSubview:_imageView];
  [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  _imageView.image = _itemAction.image;
  _imageView.alpha = kImageAlpha;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:24.f].active = YES;
  [NSLayoutConstraint constraintWithItem:_imageView
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                               attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                                constant:24.f].active = YES;
}

- (void)setAction:(MDCActionSheetAction *)action {
  if (_itemAction != action) {
    _itemAction = [action copy];
    [self setNeedsLayout];
  }
}

- (MDCActionSheetAction *)action {
  return _itemAction;
}

@end

@interface MDCActionSheetHeaderView ()

@property(nonatomic, strong) NSLayoutConstraint *titleTopConstraint;
@property(nonatomic, strong) NSLayoutConstraint *titleBottomConstraint;
@property(nonatomic, strong) NSLayoutConstraint *messageTopConstraint;
@property(nonatomic, strong) NSLayoutConstraint *messageBottomConstraint;

@end

@implementation MDCActionSheetHeaderView {
  UILabel *titleLabel;
  UILabel *messageLabel;
}

- (instancetype)initWithTitle:(NSString *)title {
  return [[MDCActionSheetHeaderView alloc] initWithTitle:title message:nil];
}

- (nonnull instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
  self = [super init];
  if (self) {
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.title = title;
    messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.message = message;
    [self commonMDCActionSheetHeaderViewInit];
  }
  return self;
}

-(void)commonMDCActionSheetHeaderViewInit {
  [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:titleLabel];
  titleLabel.font = [UIFont systemFontOfSize:16];
  titleLabel.numberOfLines = 0;
  if (self.message == nil || [self.message isEqualToString:@""]) {
    titleLabel.alpha = kMessageLabelAlpha;
  } else {
    titleLabel.alpha = kTitleLabelAlpha;
  }
  [NSLayoutConstraint constraintWithItem:titleLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:titleLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:-16.f];
  _titleTopConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0.f];
  _titleBottomConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:0.f];

  [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:messageLabel];
  messageLabel.font = [UIFont systemFontOfSize:14];
  messageLabel.numberOfLines = 0;
  messageLabel.alpha = kMessageLabelAlpha;
  [NSLayoutConstraint constraintWithItem:messageLabel
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:16.f].active = YES;
  [NSLayoutConstraint constraintWithItem:messageLabel
                               attribute:NSLayoutAttributeTrailing
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeTrailing
                              multiplier:1
                                constant:-16.f].active = YES;
  _messageTopConstraint = [NSLayoutConstraint constraintWithItem:messageLabel
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1
                                                        constant:0.f];
  _messageBottomConstraint = [NSLayoutConstraint constraintWithItem:messageLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0.f];

  BOOL addTitle = (titleLabel.text != nil) && (![titleLabel.text  isEqual:@""]);
  BOOL addMessage = (messageLabel.text != nil) && (![messageLabel.text isEqual:@""]);
  if (addTitle && addMessage) {
    [self layoutBoth];
  } else if (addTitle) {
    [self layoutTitle];
  } else if (addMessage) {
    [self layoutMessage];
  }
}

- (void)layoutBoth {
  _titleTopConstraint.constant = 16.f;
  _titleTopConstraint.active = YES;

  _titleBottomConstraint.constant = -60.f;
  _titleBottomConstraint.active = YES;

  _messageTopConstraint.constant = 46.f;
  _messageTopConstraint.active = YES;

  _messageBottomConstraint.constant = -16.f;
  _messageBottomConstraint.active = YES;

}

- (void)layoutTitle {
  _titleTopConstraint.constant = 18.f;
  _titleTopConstraint.active = YES;

  _titleBottomConstraint.constant = -18.f;
  _titleBottomConstraint.active = YES;

  _messageTopConstraint.constant = 0.f;
  _messageTopConstraint.active = YES;

  _messageBottomConstraint.constant = 0.f;
  _messageBottomConstraint.active = YES;
  
}

- (void)layoutMessage {

  _titleTopConstraint.constant = 0.f;
  _titleTopConstraint.active = YES;

  _titleBottomConstraint.constant = 0.f;
  _titleBottomConstraint.active = YES;

  _messageTopConstraint.constant = 23.f;
  _messageTopConstraint.active = YES;
  _messageBottomConstraint.constant = -23.f;
  _messageBottomConstraint.active = YES;
}

- (void)setTitle:(NSString *)title {
  titleLabel.text = title;
  [self setNeedsLayout];
}

- (NSString *)title {
  return titleLabel.text;
}

- (void)setMessage:(NSString *)message {
  messageLabel.text = message;
  [self setNeedsLayout];
}

- (NSString *)message {
  return messageLabel.text;
}

@end
