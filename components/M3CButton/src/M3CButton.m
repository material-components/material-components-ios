#import <Foundation/Foundation.h>
#import <QuartzCore/CALayer.h>
#import <UIKit/UIKit.h>

#import "M3CButton.h"
#import "M3CIconAttributes.h"
#import "M3CVisualBackgroundView.h"
#import "M3CAnimationActions.h"
#import "MDCShadow.h"
#import "MDCShadowsCollection.h"

NS_ASSUME_NONNULL_BEGIN

// Minimum touch size recommended by Apple:
// https://developer.apple.com/design/human-interface-guidelines/accessibility#Mobility
static const CGFloat kMinimumTouchTarget = 44.f;

@interface M3CButton () {
  NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_tintColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  NSMutableDictionary<NSNumber *, MDCShadow *> *_shadows;
  NSMutableDictionary<NSNumber *, UIFont *> *_fonts;
  NSMutableDictionary<NSNumber *, M3CIconAttributes *> *_symbolFonts;
  NSMutableDictionary<NSNumber *, NSNumber *> *_cornerRadius;
  NSMutableDictionary<NSNumber *, NSNumber *> *_pressedCornerRadius;
  NSMutableDictionary<NSNumber *, NSValue *> *_imageEdgeInsetsForSize;
  NSMutableDictionary<NSNumber *, NSValue *> *_edgeInsetsWithImageAndTitleForSize;
  NSMutableDictionary<NSNumber *, NSValue *> *_edgeInsetsWithImageForSize;
  NSMutableDictionary<NSNumber *, NSValue *> *_edgeInsetsWithTitleForSize;
  CGSize _visualContentSize;
  CGFloat _symbolSize;
  BOOL _customInsetAvailable;
  BOOL _buttonSizeSet;
}

@property(nonatomic, assign) M3CButtonSize buttonSize API_AVAILABLE(ios(15.0));

/**
 The visual representation of the background.

 @note Generally has no side effects and is an extra subview hierarchy. But, in instances
 where touch targets are not met, this replaces the background while the background remains the
 touch target size but changes to clear.
 */
@property(nonatomic, strong, nonnull) M3CVisualBackgroundView *visualBackground;

// Used only when layoutTitleWithConstraints is enabled.
@property(nonatomic, strong, nullable) NSLayoutConstraint *titleTopConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *titleBottomConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *titleLeadingConstraint;
@property(nonatomic, strong, nullable) NSLayoutConstraint *titleTrailingConstraint;

@end

@implementation M3CButton

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initCommon];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initCommon];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame primaryAction:(nullable UIAction *)primaryAction {
  self = [super initWithFrame:frame primaryAction:primaryAction];
  if (self) {
    [self initCommon];
  }
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self doesNotRecognizeSelector:_cmd];
  return self;
}

- (void)initCommon {
  self.animationDuration = 0.3f;
  self.minimumHeight = kMinimumTouchTarget;
  self.minimumWidth = kMinimumTouchTarget;
  _borderColors = [NSMutableDictionary dictionary];
  _shadows = [NSMutableDictionary dictionary];
  _fonts = [NSMutableDictionary dictionary];
  _symbolFonts = [NSMutableDictionary dictionary];
  _cornerRadius = [NSMutableDictionary dictionary];
  _pressedCornerRadius = [NSMutableDictionary dictionary];
  _imageEdgeInsetsForSize = [NSMutableDictionary dictionary];
  _edgeInsetsWithImageAndTitleForSize = [NSMutableDictionary dictionary];
  _edgeInsetsWithImageForSize = [NSMutableDictionary dictionary];
  _edgeInsetsWithTitleForSize = [NSMutableDictionary dictionary];
  _customInsetAvailable = NO;
  _visualBackground = [[M3CVisualBackgroundView alloc] init];
  _visualBackground.exclusiveTouch = NO;
  _visualBackground.userInteractionEnabled = NO;
  _visualContentSize = CGSizeZero;

  if (!_backgroundColors) {
    // _backgroundColors may have already been initialized by setting the backgroundColor setter.
    _backgroundColors = [NSMutableDictionary dictionary];
  }

  if (!_tintColors) {
    // _tintColors may have already been initialized by setting the tintColor setter.
    _tintColors = [NSMutableDictionary dictionary];
  }

#if (!defined(TARGET_OS_TV) || TARGET_OS_TV == 0)
  // Block users from activating multiple buttons simultaneously by default.
  self.exclusiveTouch = YES;
#endif
  [self updateColors];
}

- (void)setButtonSize:(M3CButtonSize)buttonSize {
  _buttonSizeSet = YES;
  _buttonSize = buttonSize;

  [self addSubview:self.visualBackground];
  [self sendSubviewToBack:self.visualBackground];
  [self updateInsets];
  [self updateCorners];
  [self updateFont];
  [self updateSymbolFont];
  [self updateShadows];
  [self updateColors];
}

// Colors
- (void)setBackgroundColor:(nullable UIColor *)color forState:(UIControlState)state {
  _backgroundColors[@(state)] = color;
  [self updateColors];
}

- (void)setTintColor:(nullable UIColor *)color forState:(UIControlState)state {
  _tintColors[@(state)] = color;
  [self updateColors];
}

- (void)setBorderColor:(nullable UIColor *)color forState:(UIControlState)state {
  _borderColors[@(state)] = color;
  [self updateColors];
}

- (void)setShadow:(nullable MDCShadow *)shadow forState:(UIControlState)state {
  _shadows[@(state)] = shadow;
  [self updateColors];
  [self updateShadows];
}

- (void)setFont:(UIFont *)font forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _fonts[@(size)] = font;

  [self updateFont];
}

- (void)setSymbolSize:(CGFloat)symbolSize
            textStyle:(UIFontTextStyle)textStyle
              forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _symbolFonts[@(size)] = [[M3CIconAttributes alloc] initWithTextStyle:textStyle
                                                             pointSize:symbolSize];

  [self updateSymbolFont];
}

- (void)setCornerRadius:(CGFloat)cornerRadius forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  NSNumber *cornerRadiusValue = [NSNumber numberWithFloat:cornerRadius];
  _cornerRadius[@(size)] = cornerRadiusValue;

  NSNumber *currentCornerRadius = _cornerRadius[@(self.buttonSize)] ?: cornerRadiusValue;

  if (_buttonSizeSet && !(currentCornerRadius == nil)) {
    [self updateCorners];
  }
}

- (void)setPressedCornerRadius:(CGFloat)cornerRadius
                       forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _pressedCornerRadius[@(size)] = [NSNumber numberWithFloat:cornerRadius];
}

- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                   forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _customInsetAvailable = NO;

  _imageEdgeInsetsForSize[@(size)] = [NSValue valueWithUIEdgeInsets:imageEdgeInsets];
  [self updateInsets];
}

- (void)setMinimumHeight:(CGFloat)minimumHeight {
  _minimumHeight = minimumHeight;
  [self setNeedsLayout];
}

- (void)setMinimumWidth:(CGFloat)minimumWidth {
  _minimumWidth = minimumWidth;
  [self setNeedsLayout];
}

/**
 * A color used as the button's @c backgroundColor for @c state.
 *
 * @param state The state.
 * @return The background color.
 */
- (nullable UIColor *)backgroundColorForState:(UIControlState)state {
  return _backgroundColors[@(state)] ?: _backgroundColors[@(UIControlStateNormal)];
}

/**
 * A color used as the button's @c tintColor for @c state.
 *
 * @param state The state.
 * @return The tint color.
 */
- (nullable UIColor *)tintColorForState:(UIControlState)state {
  return _tintColors[@(state)] ?: _tintColors[@(UIControlStateNormal)];
}

/**
 * A color used as the button's @c borderColor for @c state.
 *
 * @param state The state.
 * @return The border color.
 */
- (nullable UIColor *)borderColorForState:(UIControlState)state {
  return _borderColors[@(state)] ?: _borderColors[@(UIControlStateNormal)];
}

/**
 * A MDCShadow used as the button's @c shadow for @c state.
 *
 * @param state The state.
 * @return The shadow.
 */
- (MDCShadow *)shadowForState:(UIControlState)state {
  return _shadows[@(state)] ?: _shadows[@(UIControlStateNormal)];
}

- (void)updateImageColorForState:(UIControlState)state {
  UIColor *color = [self tintColorForState:state];
  self.tintColor = color;
  if (self.currentImage != nil && color != nil &&
      self.currentImage.renderingMode == UIImageRenderingModeAlwaysTemplate) {
    [self setImage:[self.currentImage imageWithTintColor:color] forState:state];
  }
}

- (void)updateFont {
  UIFont *currentFont = self.titleLabel.font;

  if (@available(iOS 15.0, *)) {
    currentFont = _fonts[@(self.buttonSize)];
    if (_buttonSizeSet && !(currentFont == nil)) {
      self.titleLabel.font = currentFont;
    }
  }

  self.titleLabel.font = currentFont;
}

- (void)updateSymbolFont {
  M3CIconAttributes *currentAttributes = nil;

  if (@available(iOS 15.0, *)) {
    currentAttributes = _symbolFonts[@(self.buttonSize)];
    if (_buttonSizeSet && currentAttributes != nil) {
      _symbolSize = [[UIFontMetrics metricsForTextStyle:currentAttributes.textStyle]
                    scaledValueForValue:currentAttributes.pointSize
          compatibleWithTraitCollection:self.traitCollection];
      self.imageView.bounds = CGRectMake(0, 0, _symbolSize, _symbolSize);
    }
  }
}

- (void)updateCGColors {
  if (_buttonSizeSet) {
    self.visualBackground.layer.borderColor = [self borderColorForState:self.state].CGColor;
    self.layer.borderColor = UIColor.clearColor.CGColor;
  } else {
    self.layer.borderColor = [self borderColorForState:self.state].CGColor;
  }
}

- (void)updateColors {
  if (_buttonSizeSet) {
    self.visualBackground.backgroundColor = [self backgroundColorForState:self.state];
    self.backgroundColor = UIColor.clearColor;
  } else {
    self.backgroundColor = [self backgroundColorForState:self.state];
  }

  [self updateImageColorForState:self.state];
  [self updateCGColors];
}

- (void)updateShadows {
  MDCShadow *shadow = [self shadowForState:self.state];
  shadow = [[MDCShadowBuilder builderWithColor:shadow.color
                                       opacity:shadow.opacity
                                        radius:shadow.radius
                                        offset:shadow.offset
                                        spread:shadow.spread] build];
  if (_buttonSizeSet) {
    MDCShadow *emptyShadow = [[MDCShadowBuilder builderWithColor:UIColor.clearColor
                                                         opacity:0
                                                          radius:0
                                                          offset:CGSizeZero
                                                          spread:0] build];
    MDCConfigureShadowForView(self, emptyShadow);
    MDCConfigureShadowForView(self.visualBackground, shadow);
  } else {
    MDCConfigureShadowForView(self, shadow);
  }
}

- (void)setImageEdgeInsetsWithImageAndTitle:(UIEdgeInsets)imageEdgeInsetsWithImageAndTitle
                                    forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _customInsetAvailable = NO;

  _imageEdgeInsetsForSize[@(size)] =
      [NSValue valueWithUIEdgeInsets:imageEdgeInsetsWithImageAndTitle];
  [self updateInsets];
}

- (void)setEdgeInsetsWithImageAndTitle:(UIEdgeInsets)edgeInsetsWithImageAndTitle
                               forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _customInsetAvailable = NO;

  _edgeInsetsWithImageAndTitleForSize[@(size)] =
      [NSValue valueWithUIEdgeInsets:edgeInsetsWithImageAndTitle];
  [self updateInsets];
}

- (void)setEdgeInsetsWithImage:(UIEdgeInsets)edgeInsetsWithImage
                       forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _customInsetAvailable = NO;

  _edgeInsetsWithImageForSize[@(size)] = [NSValue valueWithUIEdgeInsets:edgeInsetsWithImage];
  [self updateInsets];
}

- (void)setEdgeInsetsWithTitle:(UIEdgeInsets)edgeInsetsWithTitle
                       forSize:(M3CButtonSize)size API_AVAILABLE(ios(15.0)) {
  _customInsetAvailable = NO;

  _edgeInsetsWithTitleForSize[@(size)] = [NSValue valueWithUIEdgeInsets:edgeInsetsWithTitle];
  [self updateInsets];
}

- (void)updateCorners {
  // Default to the existing corner radius.
  NSNumber *currentCornerRadius = [NSNumber numberWithFloat:self.layer.cornerRadius];
  if (@available(iOS 15.0, *)) {
    if (self.isHighlighted) {
      currentCornerRadius = _pressedCornerRadius[@(self.buttonSize)];
    } else {
      currentCornerRadius = _cornerRadius[@(self.buttonSize)];
    }
  }

  self.visualBackground.layer.cornerRadius = [currentCornerRadius floatValue];
  self.visualBackground.layer.cornerCurve = kCACornerCurveCircular;
  self.layer.cornerRadius = [currentCornerRadius floatValue];
  self.layer.cornerCurve = kCACornerCurveCircular;
}

- (void)setImageEdgeInsetsWithImageAndTitle:(UIEdgeInsets)imageEdgeInsetsWithImageAndTitle {
  _imageEdgeInsetsWithImageAndTitle = imageEdgeInsetsWithImageAndTitle;
  _customInsetAvailable = NO;
  [self updateInsets];
  [self updateShadows];
}

- (void)setEdgeInsetsWithImageAndTitle:(UIEdgeInsets)edgeInsetsWithImageAndTitle {
  _edgeInsetsWithImageAndTitle = edgeInsetsWithImageAndTitle;
  _customInsetAvailable = NO;
  [self updateInsets];
  [self updateShadows];
}

- (void)setEdgeInsetsWithImageOnly:(UIEdgeInsets)edgeInsetsWithImageOnly {
  _edgeInsetsWithImageOnly = edgeInsetsWithImageOnly;
  _customInsetAvailable = NO;
  [self updateInsets];
  [self updateShadows];
}

- (void)setEdgeInsetsWithTitleOnly:(UIEdgeInsets)edgeInsetsWithTitleOnly {
  _edgeInsetsWithTitleOnly = edgeInsetsWithTitleOnly;
  _customInsetAvailable = NO;
  [self updateInsets];
  [self updateShadows];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)edgeInsets {
  [super setContentEdgeInsets:edgeInsets];
  _customInsetAvailable = YES;

  // Update constraint constants for multiline layout.
  if (self.layoutTitleWithConstraints) {
    [self updateTitleLabelConstraint];
  }
}

- (void)updateInsets {
  if (!_customInsetAvailable) {
    BOOL hasTitle = self.currentTitle.length > 0 || self.currentAttributedTitle.length > 0;
    BOOL hasImage = self.currentImage.size.width > 0;
    if (hasImage && hasTitle) {
      if (@available(iOS 15.0, *)) {
        if (_buttonSizeSet) {
          self.contentEdgeInsets =
              [_edgeInsetsWithImageAndTitleForSize[@(self.buttonSize)] UIEdgeInsetsValue];
          self.imageEdgeInsets = [_imageEdgeInsetsForSize[@(self.buttonSize)] UIEdgeInsetsValue];
        } else {
          self.contentEdgeInsets = self.edgeInsetsWithImageAndTitle;
          self.imageEdgeInsets = self.imageEdgeInsetsWithImageAndTitle;
        }
      } else {
        self.contentEdgeInsets = self.edgeInsetsWithImageAndTitle;
        self.imageEdgeInsets = self.imageEdgeInsetsWithImageAndTitle;
      }
    } else if (hasImage) {
      if (@available(iOS 15.0, *)) {
        if (_buttonSizeSet) {
          self.contentEdgeInsets =
              [_edgeInsetsWithImageForSize[@(self.buttonSize)] UIEdgeInsetsValue];
          // Please add an imageEdgeInsetsWithImageOnly to specify a non zero value.
          self.imageEdgeInsets = UIEdgeInsetsZero;
        } else {
          self.contentEdgeInsets = self.edgeInsetsWithImageOnly;
          // Please add an imageEdgeInsetsWithImageOnly to specify a non zero value.
          self.imageEdgeInsets = UIEdgeInsetsZero;
        }
      } else {
        self.contentEdgeInsets = self.edgeInsetsWithImageOnly;
        // Please add an imageEdgeInsetsWithImageOnly to specify a non zero value.
        self.imageEdgeInsets = UIEdgeInsetsZero;
      }
    } else if (hasTitle) {
      if (@available(iOS 15.0, *)) {
        if (_buttonSizeSet) {
          self.contentEdgeInsets =
              [_edgeInsetsWithTitleForSize[@(self.buttonSize)] UIEdgeInsetsValue];
          // Please add an imageEdgeInsetsWithTitleOnly to specify a non zero value.
          self.imageEdgeInsets = UIEdgeInsetsZero;
        } else {
          self.contentEdgeInsets = self.edgeInsetsWithTitleOnly;
          // Please add an imageEdgeInsetsWithTitleOnly to specify a non zero value.
          self.imageEdgeInsets = UIEdgeInsetsZero;
        }
      } else {
        self.contentEdgeInsets = self.edgeInsetsWithTitleOnly;
        // Please add an imageEdgeInsetsWithTitleOnly to specify a non zero value.
        self.imageEdgeInsets = UIEdgeInsetsZero;
      }
    }
    _customInsetAvailable = NO;
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
  if (_buttonSizeSet) {
    self.visualBackground.layer.borderWidth = borderWidth;
  } else {
    self.layer.borderWidth = borderWidth;
  }
}

- (CGFloat)borderWidth {
  if (_buttonSizeSet) {
    return self.visualBackground.layer.borderWidth;
  }
  return self.layer.borderWidth;
}

- (void)setTextCanWrap:(BOOL)textCanWrap {
  if (_textCanWrap != textCanWrap) {
    self.titleLabel.lineBreakMode =
        textCanWrap ? NSLineBreakByWordWrapping : NSLineBreakByTruncatingMiddle;
    self.titleLabel.numberOfLines = textCanWrap ? 0 : 1;

    _textCanWrap = textCanWrap;
  }
}

#pragma mark - UIButton
- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  [self updateColors];
}

- (void)setHighlighted:(BOOL)highlighted {
  BOOL animated = highlighted ? NO : YES;
  if (@available(iOS 15.0, *)) {
    if (_buttonSizeSet && _pressedCornerRadius[@(self.buttonSize)] != nil) {
      // If there is a custom value present for the pressed state animate into and out of the new
      // corner radius.
      animated = YES;
    }
  }
  [self setHighlighted:highlighted animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted];
  void (^animations)(void) = ^{
    [self updateColors];
    if (@available(iOS 15.0, *)) {
      if (_buttonSizeSet) {
        [self updateCorners];
        [self updateShadows];
      }
    }
  };

  if (animated) {
    [UIView animateWithDuration:_animationDuration animations:animations];
  } else {
    animations();
  }
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  [self updateColors];
  [self updateInsets];
}

- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state {
  [super setTitle:title forState:state];
  [self updateInsets];

  // If the button size is set, then the visual background is a subview of the button. If a client
  // sets the button size then the title we need to make sure that the title is not obscured by the
  // visual background.
  if (_buttonSizeSet) {
    [self sendSubviewToBack:self.visualBackground];
  }
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state {
  [super setAttributedTitle:title forState:state];
  [self updateInsets];
}

- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state {
  [super setImage:image forState:state];
  [self updateInsets];

  // If the button size is set, then the visual background is a subview of the button. If a client
  // sets the button size then the image we need to make sure that the image is not obscured by the
  // visual background.
  if (_buttonSizeSet) {
    [self sendSubviewToBack:self.visualBackground];
  }
}

- (void)didMoveToSuperview {
  [super didMoveToSuperview];

  // If the image or title are set before the button is part of the heirarchy, then the visual
  // background will be on top of the image or title.
  if (_buttonSizeSet) {
    [self sendSubviewToBack:self.visualBackground];
  }
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self updateCGColors];
  [self updateSymbolFont];

  if (@available(iOS 15.0, *)) {
    _visualContentSize = [self explicitSize];
  }
  [self invalidateIntrinsicContentSize];
  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self setCapsuleCornersBasedOn:self.frame.size];
  [self updateSymbolFont];

  if (_buttonSizeSet) {
    if (_visualContentSize.width < kMinimumTouchTarget ||
        _visualContentSize.height < kMinimumTouchTarget) {
      self.visualBackground.frame =
          CGRectMake(MAX(0, (kMinimumTouchTarget - _visualContentSize.width) / 2),
                     MAX(0, (kMinimumTouchTarget - _visualContentSize.height) / 2),
                     _visualContentSize.width, _visualContentSize.height);
    } else {
      self.visualBackground.frame = self.bounds;
    }
  }
  [self updateShadows];
}

- (void)setCapsuleCornersBasedOn:(CGSize)size {
  if (self.isCapsuleShape) {
    if (@available(iOS 15.0, *)) {
      if (_buttonSizeSet) {
        if (self.isHighlighted && _pressedCornerRadius[@(self.buttonSize)] != nil) {
          self.visualBackground.layer.cornerRadius =
              [_pressedCornerRadius[@(self.buttonSize)] floatValue];
          self.visualBackground.layer.cornerCurve = kCACornerCurveCircular;
          self.layer.cornerRadius = self.visualBackground.layer.cornerRadius;
          self.layer.cornerCurve = self.visualBackground.layer.cornerCurve;
        } else {
          CGFloat height = MIN(size.height, _visualContentSize.height);
          CGFloat width = MIN(size.width, _visualContentSize.width);
          self.visualBackground.layer.cornerRadius = MIN(height, width) / 2;
          self.visualBackground.layer.cornerCurve = kCACornerCurveCircular;
          self.layer.cornerRadius = self.visualBackground.layer.cornerRadius;
          self.layer.cornerCurve = self.visualBackground.layer.cornerCurve;
        }
      } else {
        self.layer.cornerRadius = size.height / 2;
        self.layer.cornerCurve = kCACornerCurveCircular;
      }
    } else {
      self.layer.cornerRadius = size.height / 2;
      self.layer.cornerCurve = kCACornerCurveCircular;
    }
  }
}

- (CGSize)clampToMinimumSize:(CGSize)size {
  size.height = MAX(size.height, _minimumHeight);

  if (_buttonSizeSet) {
    size.width = MAX(size.width, _minimumWidth);
  } else {
    size.width = MAX(MAX(size.height, size.width), _minimumWidth);
  }
  return size;
}
#pragma mark - Enabling multi-line layout

- (void)setLayoutTitleWithConstraints:(BOOL)layoutTitleWithConstraints {
  if (_layoutTitleWithConstraints == layoutTitleWithConstraints) {
    return;
  }

  _layoutTitleWithConstraints = layoutTitleWithConstraints;

  if (_layoutTitleWithConstraints) {
    self.titleTopConstraint = [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor];
    self.titleBottomConstraint =
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    self.titleLeadingConstraint =
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    self.titleTrailingConstraint =
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    self.titleTopConstraint.active = YES;
    self.titleBottomConstraint.active = YES;
    self.titleLeadingConstraint.active = YES;
    self.titleTrailingConstraint.active = YES;

    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                       forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                       forAxis:UILayoutConstraintAxisVertical];

    [self updateTitleLabelConstraint];
  } else {
    self.titleTopConstraint.active = NO;
    self.titleBottomConstraint.active = NO;
    self.titleLeadingConstraint.active = NO;
    self.titleTrailingConstraint.active = NO;
    self.titleTopConstraint = nil;
    self.titleBottomConstraint = nil;
    self.titleLeadingConstraint = nil;
    self.titleTrailingConstraint = nil;
  }
}

- (void)updateTitleLabelConstraint {
  self.titleTopConstraint.constant = self.contentEdgeInsets.top;
  self.titleBottomConstraint.constant = -self.contentEdgeInsets.bottom;
  self.titleLeadingConstraint.constant = self.contentEdgeInsets.left;
  self.titleTrailingConstraint.constant = -self.contentEdgeInsets.right;
}

- (CGSize)sizeBasedOnLabel {
  CGFloat textWidth = self.titleLabel.preferredMaxLayoutWidth;
  if (textWidth <= 0) {
    self.titleLabel.preferredMaxLayoutWidth = self.frame.size.width - self.contentEdgeInsets.left -
                                              self.contentEdgeInsets.right -
                                              self.imageView.frame.size.width;
  }
  CGSize titleLabelSize = self.titleLabel.intrinsicContentSize;
  self.titleLabel.preferredMaxLayoutWidth = textWidth;
  return CGSizeMake(
      ceil(titleLabelSize.width) + self.contentEdgeInsets.left + self.contentEdgeInsets.right +
          self.imageView.frame.size.width,
      titleLabelSize.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom);
}

#pragma mark - Overrides

- (CGSize)intrinsicContentSize {
  [self updateInsets];
  CGSize size;
  if ([self textCanWrap]) {
    size = [self sizeBasedOnLabel];
  } else {
    size = [super intrinsicContentSize];
  }
  CGSize clampToMinimumSize = [self clampToMinimumSize:size];
  if (_buttonSizeSet) {
    if (@available(iOS 15.0, *)) {
      size = [self explicitSize];
    }
    _visualContentSize = size;

    // The MAX function only takes two inputs but we need the max of clampToMinimumSize, size, and
    // kMinimumTouchTarget.
    CGSize minimumVisualSize = CGSizeMake(MAX(clampToMinimumSize.width, size.width),
                                          MAX(clampToMinimumSize.height, size.height));
    return CGSizeMake(MAX(kMinimumTouchTarget, minimumVisualSize.width),
                      MAX(kMinimumTouchTarget, minimumVisualSize.height));
  } else {
    return clampToMinimumSize;
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize newSize;
  if ([self textCanWrap]) {
    newSize = [self sizeBasedOnLabel];
  } else {
    newSize = [super sizeThatFits:size];
  }
  CGSize clampToMinimumSize = [self clampToMinimumSize:newSize];
  [self setCapsuleCornersBasedOn:clampToMinimumSize];
  if (_buttonSizeSet) {
    if (@available(iOS 15.0, *)) {
      newSize = [self explicitSize];
    }
    _visualContentSize = newSize;

    // The MAX function only takes two inputs but we need the max of clampToMinimumSize, size, and
    // kMinimumTouchTarget.
    CGSize minimumVisualSize = CGSizeMake(MAX(clampToMinimumSize.width, newSize.width),
                                          MAX(clampToMinimumSize.height, newSize.height));
    return CGSizeMake(MAX(kMinimumTouchTarget, minimumVisualSize.width),
                      MAX(kMinimumTouchTarget, minimumVisualSize.height));
  } else {
    return clampToMinimumSize;
  }
}

- (CGSize)explicitSize API_AVAILABLE(ios(15.0)) {
  [self updateInsets];
  BOOL hasTitle = self.currentTitle.length > 0 || self.currentAttributedTitle.length > 0;
  BOOL hasImage = self.currentImage != nil;
  CGSize size = [super intrinsicContentSize];
  CGFloat imageEdgeInsetsWidth = self.imageEdgeInsets.left + self.imageEdgeInsets.right;
  CGFloat contentEdgeInsetsWidth = self.contentEdgeInsets.left + self.contentEdgeInsets.right;
  CGFloat imageEdgeInsetsHeight = self.imageEdgeInsets.top + self.imageEdgeInsets.bottom;
  CGFloat contentEdgeInsetsHeight = self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
  if (hasTitle && hasImage) {
    CGFloat iconWidth = imageEdgeInsetsWidth + _symbolSize;
    CGFloat titleWidth = contentEdgeInsetsWidth + self.titleLabel.intrinsicContentSize.width;
    CGFloat iconHeight = imageEdgeInsetsHeight + _symbolSize;
    CGFloat titleHeight = contentEdgeInsetsHeight + self.titleLabel.intrinsicContentSize.height;
    size = CGSizeMake(iconWidth + titleWidth, MAX(iconHeight, titleHeight));
  } else if (hasImage) {
    // If only using an image we set the contentEdgeInsets rather than imageEdgeInsets.
    CGFloat width = contentEdgeInsetsWidth + _symbolSize;
    CGFloat height = contentEdgeInsetsHeight + _symbolSize;
    size = CGSizeMake(width, height);
  } else if (hasTitle) {
    CGFloat width = contentEdgeInsetsWidth + self.titleLabel.intrinsicContentSize.width;
    CGFloat height = contentEdgeInsetsHeight + self.titleLabel.intrinsicContentSize.height;
    size = CGSizeMake(width, height);
  }

  return size;
}

#pragma mark - CALayerDelegate

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
  if (layer == self.layer && M3CIsMDCShadowPathKey(key)) {
    // Provide a custom action for the view's layer's shadow path only.
    return M3CShadowPathActionForLayer(layer);
  }

  return [super actionForLayer:layer forKey:key];
}

@end

NS_ASSUME_NONNULL_END
