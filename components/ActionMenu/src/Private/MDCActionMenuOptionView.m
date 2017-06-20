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

#import "MaterialPalettes.h"

#import "MaterialAnimationTiming.h"
#import "MaterialTypography.h"

#import "MDCActionMenuOption.h"
#import "MDCActionMenuOptionView.h"

const NSTimeInterval kMDCActionMenuFastAnimationDuration = 0.20;
const NSTimeInterval kMDCActionMenuSuperFastAnimationDuration = 0.15;

static const CGFloat kLabelPadding = 8.0f;
static const CGFloat kLabelMargin = 16.0f;
static NSString *const kBackgroundImage = @"mdc_action_menu_label_background";

static const CGFloat kActionMenuOptionPadding = 16.0f;
static const CGFloat kActionMenuOptionCollapseScale = 0.1f;

// static const CGFloat kActionMenuFontSize = 16;
// static const CGFloat kActionMenuIconMargin = 12;
// static const CGFloat kActionMenuIconSize = 24;
// static const CGFloat kActionMenuIconTitleSpace = 32;
// static const CGFloat kActionMenuInkAlpha = 0.06f;
// static const CGFloat kActionMenuTextColorAlpha = 0.54f;

@implementation MDCActionMenuOptionView {
  UILabel *_label;
  UIImageView *_labelBackground;
  UIView *_labelContainer;

  UIImageView *_icon;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _style = kMDCActionMenuStyleDefaultToDefault;
    _labelPosition = kMDCActionMenuLabelPositionLeft;
    _index = 0;

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    UIFont *font = [MDCTypography buttonFont];
    _label.font = font;
    _label.textColor = [UIColor blackColor];  // TODO: Make this configurable

    _labelBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kBackgroundImage]];
    _labelContainer = [[UIView alloc] initWithFrame:CGRectZero];

    [_labelContainer addSubview:_labelBackground];
    [_labelContainer addSubview:_label];

    [self addSubview:_labelContainer];

    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitButton;
  }
  return self;
}

- (void)setOption:(MDCActionMenuOption *)option {
  if (_option == option) {
    return;
  }
  _option = option;

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
      [MDCFloatingButton floatingButtonWithShape:([self isMini] ? MDCFloatingButtonShapeMini
                                                                : MDCFloatingButtonShapeDefault)];
  [_floatingActionButton setBackgroundColor:self.option.palette.tint500
                                   forState:UIControlStateNormal];
  [_floatingActionButton setImage:self.option.image forState:UIControlStateNormal];

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

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect fabFrame = self.floatingActionButton.frame;
  CGFloat primaryFABWidth = [self primaryFloatingButtonWidth];
  CGFloat maxLabelWidth =
      self.bounds.size.width - primaryFABWidth - kLabelMargin - (2 * kLabelPadding);
  CGRect maxLabelRect = CGRectMake(0, 0, maxLabelWidth, fabFrame.size.height);
  CGRect labelRect = [_label textRectForBounds:maxLabelRect limitedToNumberOfLines:1];
  CGSize containerSize = CGSizeMake(labelRect.size.width + (2 * kLabelPadding),
                                    labelRect.size.height + (2 * kLabelPadding));

  CGFloat containerX = 0;
  if (self.labelPosition == kMDCActionMenuLabelPositionRight) {
    if (self.style == kMDCActionMenuStyleDefaultToMini && self.index != 0) {
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
  if (self.labelPosition == kMDCActionMenuLabelPositionLeft) {
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

- (CGSize)sizeThatFits:(CGSize)size {
  CGFloat dimension =
      [self isMini] ? [MDCFloatingButton miniDimension] : [MDCFloatingButton defaultDimension];

  CGFloat primaryFABWidth = [self primaryFloatingButtonWidth];
  CGFloat maxLabelWidth = size.width - primaryFABWidth - kLabelMargin - (2 * kLabelPadding);
  CGRect maxLabelRect = CGRectMake(0, 0, maxLabelWidth, dimension);
  CGRect labelRect = [_label textRectForBounds:maxLabelRect limitedToNumberOfLines:1];
  CGFloat width = labelRect.size.width + (2 * kLabelPadding) + kLabelMargin + primaryFABWidth;
  return CGSizeMake(width, dimension);
}

#pragma mark - Private

- (BOOL)isMini {
  return (self.style == kMDCActionMenuStyleMiniToMini) ||
         (self.style == kMDCActionMenuStyleDefaultToMini && self.index != 0);
}

- (CGFloat)primaryFloatingButtonWidth {
  return self.style == kMDCActionMenuStyleMiniToMini ? [MDCFloatingButton miniDimension]
                                                     : [MDCFloatingButton defaultDimension];
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
  [UIView
      mdc_animateWithTimingFunction:[CAMediaTimingFunction
                                        mdc_functionWithType:MDCAnimationTimingFunctionEaseInOut]
      duration:animated ? kMDCActionMenuSuperFastAnimationDuration : 0
      delay:delay
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

  CAMediaTimingFunction *timingFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionEaseOut];

  [UIView mdc_animateWithTimingFunction:timingFunction
      duration:animated ? kMDCActionMenuFastAnimationDuration : 0
      delay:delay
      options:0
      animations:^{
        self.alpha = 1;
        self.floatingActionButton.transform = CGAffineTransformIdentity;
        _labelContainer.transform = CGAffineTransformIdentity;
      }
      completion:^(BOOL finished) {
        self.floatingActionButton.layer.shouldRasterize = NO;
      }];

  //  [UIView mdc_animateWithTimingFunction:timingFunction
  //                               duration:(kMDCActionMenuFastAnimationDuration * 0.75) : 0
  //                                  delay:delay + (kMDCActionMenuFastAnimationDuration / 4)
  //                                options:0
  //                             animations:^{
  //                               _labelContainer.alpha = 1;
  //                             } completion:^(BOOL finished) {
  //                               // do nothing
  //                             }];
}

- (CGPoint)getTouchPoint:(NSSet *)touches {
  return [[touches anyObject] locationInView:self];
}

@end
