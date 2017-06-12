/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

const NSTimeInterval kXYZActionMenuFastAnimationDuration = 0.20;
const NSTimeInterval kXYZActionMenuSuperFastAnimationDuration = 0.15;

static const CGFloat kLabelPadding = 8.0f;
static const CGFloat kLabelMargin = 16.0f;
static NSString *const kBackgroundImage = @"xyz_action_menu_label_background";

static const CGFloat kActionMenuOptionPadding = 16.0f;
static const CGFloat kActionMenuOptionCollapseScale = 0.1f;

static const CGFloat kActionMenuFontSize = 16;
static const CGFloat kActionMenuIconMargin = 12;
static const CGFloat kActionMenuIconSize = 24;
static const CGFloat kActionMenuIconTitleSpace = 32;
static const CGFloat kActionMenuInkAlpha = 0.06f;
static const CGFloat kActionMenuTextColorAlpha = 0.54f;

@implementation XYZActionMenuOptionView {
  // Views for speeddial style.
  UILabel *_label;
  UIImageView *_labelBackground;
  UIView *_labelContainer;

  // Views for sheet style.
  BOOL _isTouchDraggingOutsideCell;
  UIImageView *_icon;
  UILabel *_title;
  XYZInkTouchController *_touchController;
  // Use to ensure item action and menu dismissal occur after
  // ink animation has finished for sheet style.
  BOOL _isInkSpreadInFlight;
  BOOL _shouldPerformDelayedAction;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _style = kXYZActionMenuStyleDefaultToDefault;
    _labelPosition = kXYZActionMenuLabelPositionLeft;
    _index = 0;

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *font = [MDCTypography buttonFont];
    _label.font = font;
    _label.textColor = [[XYZColorGroup whiteColors] bodyTextColorOnRegularColorWithFont:font];

    _labelBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kBackgroundImage]];
    _labelContainer = [[UIView alloc] initWithFrame:CGRectZero];

    [_labelContainer addSubview:_labelBackground];
    [_labelContainer addSubview:_label];

    [self addSubview:_labelContainer];

    _isTouchDraggingOutsideCell = NO;

    _icon = [[UIImageView alloc] initWithImage:nil];
    _icon.contentMode = UIViewContentModeCenter;
    [self addSubview:_icon];

    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    _title.font = [[MDCTypography fontLoader] regularFontOfSize:kActionMenuFontSize];
    _title.textColor = [[UIColor blackColor] colorWithAlphaComponent:kActionMenuTextColorAlpha];
    [self addSubview:_title];

    // Set up ink view.
    UIColor *inkColor = [UIColor colorWithWhite:0 alpha:kActionMenuInkAlpha];
    _touchController = [[MDCInkTouchController alloc] initWithView:self];
    _touchController.defaultInkView.inkColor = inkColor;
    _touchController.delegate = self;
    [_touchController addInkView];

    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitButton;
  }
  return self;
}

- (void)setOption:(XYZActionMenuOption *)option {
  if (_option == option) {
    return;
  }
  _option = option;

  if (self.style == kXYZActionMenuStyleSheet) {
    _icon.hidden = NO;
    _title.hidden = NO;
    _floatingActionButton.hidden = YES;
    _labelContainer.hidden = YES;

    _icon.image = self.option.image;
    _title.text = self.option.label;
  } else {
    _icon.hidden = YES;
    _title.hidden = YES;
    _floatingActionButton.hidden = NO;
    _labelContainer.hidden = NO;

    if (self.floatingActionButton) {
      [self.floatingActionButton removeFromSuperview];
    }

    if (!self.option) {
      _floatingActionButton = nil;
      _label.text = nil;
      return;
    }

    _floatingActionButton =
        [XYZButton floatingButtonWithColorGroup:self.option.colorGroup miniSize:[self isMini]];
    [self.floatingActionButton setImage:self.option.image forState:UIControlStateNormal];
    if (!self.option.insetImage) {
      self.floatingActionButton.contentEdgeInsets = UIEdgeInsetsZero;
    }
    [self addSubview:self.floatingActionButton];
    [self.floatingActionButton sizeToFit];

    _label.text = self.option.label;
    _labelContainer.hidden = (self.option.label.length == 0);

    // Rasterize to improve animation performance (toggled on and off before and after animation)
    self.floatingActionButton.layer.shouldRasterize = YES;
    self.floatingActionButton.layer.rasterizationScale = [[UIScreen mainScreen] scale];
  }

  self.accessibilityLabel = self.option.label;
  if (self.option.accessibilityLabel) {
    self.accessibilityLabel = self.option.accessibilityLabel;
  }
  self.accessibilityIdentifier = self.option.accessibilityIdentifier;
}

- (void)setActivatedState:(BOOL)activated
                 animated:(BOOL)animated
         withStaggerDelay:(NSTimeInterval)delay {
  if (activated) {
    [self expand:animated delay:delay];
  } else {
    [self collapse:animated delay:delay];
  }
}

#pragma mark - UIView

- (void)layoutSheetStyle {
  CGRect contentBounds = self.bounds;
  CGRect contentRect = CGRectInset(contentBounds, kActionMenuOptionPadding, 0);
  CGRect iconFrame;
  CGRect titleFrame;

  CGRectDivide(contentRect, &iconFrame, &contentRect, kActionMenuIconSize, CGRectMinXEdge);
  CGRectDivide(contentRect, &(CGRect){}, &titleFrame, kActionMenuIconTitleSpace, CGRectMinXEdge);

  _icon.frame = iconFrame;
  _title.frame = titleFrame;
}

- (void)layoutSpeeddial {
  CGRect fabFrame = self.floatingActionButton.frame;
  CGFloat primaryFABWidth = [self primaryFloatingButtonWidth];
  CGFloat maxLabelWidth =
  self.bounds.size.width - primaryFABWidth - kLabelMargin - (2 * kLabelPadding);
  CGRect maxLabelRect = CGRectMake(0, 0, maxLabelWidth, fabFrame.size.height);
  CGRect labelRect = [_label textRectForBounds:maxLabelRect limitedToNumberOfLines:1];
  CGSize containerSize = CGSizeMake(labelRect.size.width + (2 * kLabelPadding),
                                    labelRect.size.height + (2 * kLabelPadding));

  CGFloat containerX = 0;
  if (self.labelPosition == kXYZActionMenuLabelPositionRight) {
    if (self.style == kXYZActionMenuStyleDefaultToMini && self.index != 0) {
      containerX = primaryFABWidth + kLabelMargin / 2;
    } else {
      containerX = primaryFABWidth + kLabelMargin;
    }
  }
  CGFloat containerY = (fabFrame.size.height - containerSize.height) / 2;
  _labelContainer.frame =
  CGRectMake(containerX, containerY, containerSize.width, containerSize.height);
  _labelBackground.frame = _labelContainer.bounds;
  _label.frame =
  CGRectMake(kLabelPadding, kLabelPadding, labelRect.size.width, labelRect.size.height);

  // If the position is left, the button needs to be moved.
  if (self.labelPosition == kXYZActionMenuLabelPositionLeft) {
    CGFloat fabX =
    containerSize.width + kLabelMargin + ((primaryFABWidth - fabFrame.size.width) / 2);
    self.floatingActionButton.frame =
    CGRectMake(fabX, 0, fabFrame.size.width, fabFrame.size.height);
  }

  if (self.index == 0) {
    // We rely on the controllers floating action button for the first item in order to not
    // overlay two buttons (and shadows) on top of each other.
    self.floatingActionButton.hidden = YES;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.style == kXYZActionMenuStyleSheet ? [self layoutSheetStyle] : [self layoutSpeeddial];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (self.style == kXYZActionMenuStyleSheet) {
    CGFloat height = kActionMenuIconSize + 2 * kActionMenuIconMargin;
    return CGSizeMake(size.width, height);
  }

  CGFloat dimension = [self isMini] ? [XYZButton floatingButtonMiniDimension]
                                    : [XYZButton floatingButtonDefaultDimension];

  CGFloat primaryFABWidth = [self primaryFloatingButtonWidth];
  CGFloat maxLabelWidth = size.width - primaryFABWidth - kLabelMargin - (2 * kLabelPadding);
  CGRect maxLabelRect = CGRectMake(0, 0, maxLabelWidth, dimension);
  CGRect labelRect = [_label textRectForBounds:maxLabelRect limitedToNumberOfLines:1];
  CGFloat width = labelRect.size.width + (2 * kLabelPadding) + kLabelMargin + primaryFABWidth;
  return CGSizeMake(width, dimension);
}

#pragma mark - XYZInkTouchControllerDelegate

- (BOOL)inkTouchController:(MDCInkTouchController *)inkTouchController
    shouldProcessInkTouchesAtTouchLocation:(CGPoint)location {
  return self.style == kXYZActionMenuStyleSheet;
}

#pragma mark - Private

- (BOOL)isMini {
  return (self.style == kXYZActionMenuStyleMiniToMini) ||
         (self.style == kXYZActionMenuStyleDefaultToMini && self.index != 0);
}

- (CGFloat)primaryFloatingButtonWidth {
  return self.style == kXYZActionMenuStyleMiniToMini ? [XYZButton floatingButtonMiniDimension]
                                                     : [XYZButton floatingButtonDefaultDimension];
}

- (void)resetCollapsed {
  self.alpha = 0;
  self.floatingActionButton.transform = CGAffineTransformConcat(
      CGAffineTransformMakeTranslation(0,
                                       (kActionMenuOptionPadding / kActionMenuOptionCollapseScale)),
      CGAffineTransformMakeScale(kActionMenuOptionCollapseScale, kActionMenuOptionCollapseScale));

  _labelContainer.alpha = 0;
  // If the first item has a label, it should not transform.
  if (self.index > 0) {
    _labelContainer.transform = CGAffineTransformMakeTranslation(0, kLabelMargin);
  }
}

- (void)collapse:(BOOL)animated delay:(NSTimeInterval)delay {
  if (!animated) {
    [self resetCollapsed];
    return;
  }
  [UIView qtm_animateWithDuration:animated ? kXYZActionMenuSuperFastAnimationDuration : 0
      delay:delay
      curve:kXYZAnimationTimingCurveQuantumEaseIn
      options:0
      animations:^{
        self.alpha = 0;
      }
      completion:^(BOOL finished) {
        [self resetCollapsed];
      }];
}

- (void)expand:(BOOL)animated delay:(NSTimeInterval)delay {
  self.floatingActionButton.layer.shouldRasterize = YES;
  [UIView qtm_animateWithDuration:animated ? kXYZActionMenuFastAnimationDuration : 0
      delay:delay
      curve:kXYZAnimationTimingCurveQuantumEaseOut
      options:0
      animations:^{
        self.alpha = 1;
        self.floatingActionButton.transform = CGAffineTransformIdentity;
        _labelContainer.transform = CGAffineTransformIdentity;
      }
      completion:^(BOOL finished) {
        self.floatingActionButton.layer.shouldRasterize = NO;
      }];

  [UIView qtm_animateWithDuration:animated ? (kXYZActionMenuFastAnimationDuration * 0.75) : 0
                            delay:delay + (kXYZActionMenuFastAnimationDuration / 4)
                            curve:kXYZAnimationTimingCurveQuantumEaseOut
                          options:0
                       animations:^{
                         _labelContainer.alpha = 1;
                       }
                       completion:nil];
}

- (CGPoint)getTouchPoint:(NSSet *)touches {
  return [[touches anyObject] locationInView:self];
}

@end
