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
//static const CGFloat TitleLabelLeadingPadding = 16.f;
//static const CGFloat TitleLabelVerticalPadding = 18.f;
//
//static const CGFloat LabelLeadingPadding = 72.f;
//static const CGFloat LabelTrailingPadding = 16.f;
///// This comes from design, a cell should be 56pt tall and the baseline for a single
///// line list item should be centered. Standard font is 20pt tall so that leaves 36pt
///// to support dynamic type we have 36pt / 2 = 18pt.
///// If we change the standard font this will need to be changed.
//static const CGFloat LabelVerticalPadding = 18.f;
//static const CGFloat LabelAlpha = 0.87f;
//
//static const CGFloat ImageLeadingPadding = 16.f;
//static const CGFloat ImageTopPadding = 16.f;
//static const CGFloat ImageAlpha = 0.54f;

@interface MDCActionSheetItemView ()

@property(nonatomic, nullable, strong) UILabel *textLabel;
@property(nonatomic, nullable, strong) UIImageView *imageView;

@end


@implementation MDCActionSheetItemView {
  MDCActionSheetAction *_itemAction;
}

@synthesize textLabel = _textLabel;
@synthesize imageView = _imageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self commonMDCActionSheetItemViewInit];
  }
  return self;
}

- (void)commonMDCActionSheetItemViewInit {

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

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
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
  titleLabel.text = self.title;
  [titleLabel sizeToFit];
  [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:titleLabel];
  titleLabel.numberOfLines = 0;
  titleLabel.alpha = kTitleLabelAlpha;
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
                                constant:16.f];
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

  messageLabel.text = self.message;
  [messageLabel sizeToFit];
  [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addSubview:messageLabel];
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
                                constant:16.f].active = YES;
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
}


- (void)layoutSubviews {
  [super layoutSubviews];
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
  _titleTopConstraint.constant = 12.f;
  _titleTopConstraint.active = YES;

  _titleBottomConstraint.constant = -32.f;
  _titleBottomConstraint.active = YES;

  _messageTopConstraint.constant = 38.f;
  _messageTopConstraint.active = YES;

  _messageBottomConstraint.constant = -12.f;
  _messageBottomConstraint.active = YES;

}

- (void)layoutTitle {
  _titleTopConstraint.constant = 18.f;
  _titleTopConstraint.active = YES;

  _titleBottomConstraint.constant = 18.f;
  _titleBottomConstraint.active = YES;
}

- (void)layoutMessage {
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
