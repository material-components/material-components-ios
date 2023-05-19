#import <Foundation/Foundation.h>
#import <QuartzCore/CALayer.h>
#import <UIKit/UIKit.h>

#import "M3CButton.h"
#import "M3CAnimationActions.h"
#import "MDCShadow.h"
#import "MDCShadowsCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface M3CButton () {
  NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_tintColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  NSMutableDictionary<NSNumber *, MDCShadow *> *_shadows;
  BOOL _customInsetAvailable;
}

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
  self.minimumHeight = 44.0f;
  _borderColors = [NSMutableDictionary dictionary];
  _shadows = [NSMutableDictionary dictionary];
  _customInsetAvailable = NO;

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

- (void)setMinimumHeight:(CGFloat)minimumHeight {
  _minimumHeight = minimumHeight;
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

- (void)updateCGColors {
  self.layer.borderColor = [[self borderColorForState:self.state] CGColor];
}

- (void)updateColors {
  self.backgroundColor = [self backgroundColorForState:self.state];
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
  MDCConfigureShadowForView(self, shadow);
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
}

- (void)updateInsets {
  if (!_customInsetAvailable) {
    BOOL hasTitle = self.currentTitle.length > 0 || self.currentAttributedTitle.length > 0;
    BOOL hasImage = self.currentImage.size.width > 0;
    if (hasImage && hasTitle) {
      self.contentEdgeInsets = self.edgeInsetsWithImageAndTitle;
      self.imageEdgeInsets = self.imageEdgeInsetsWithImageAndTitle;
    } else if (hasImage) {
      self.contentEdgeInsets = self.edgeInsetsWithImageOnly;
      // Please add an imageEdgeInsetsWithImageOnly to specify a non zero value.
      self.imageEdgeInsets = UIEdgeInsetsZero;
    } else if (hasTitle) {
      self.contentEdgeInsets = self.edgeInsetsWithTitleOnly;
      // Please add an imageEdgeInsetsWithTitleOnly to specify a non zero value.
      self.imageEdgeInsets = UIEdgeInsetsZero;
    }
    _customInsetAvailable = NO;
  }
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
  [self setHighlighted:highlighted animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted];
  void (^animations)(void) = ^{
    [self updateColors];
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
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state {
  [super setAttributedTitle:title forState:state];
  [self updateInsets];
}

- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state {
  [super setImage:image forState:state];
  [self updateInsets];
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self updateCGColors];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self setCapsuleCornersBasedOn:self.frame.size];
  [self updateShadows];
}

- (void)setCapsuleCornersBasedOn:(CGSize)size {
  if (self.isCapsuleShape) {
    self.layer.cornerRadius = size.height / 2;
    self.layer.cornerCurve = kCACornerCurveCircular;
  }
}

- (CGSize)clampToMinimumSize:(CGSize)size {
  if (size.height < _minimumHeight) {
    size.height = _minimumHeight;
  }
  if (size.height > size.width) {
    size.width = size.height;
  }
  return size;
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
      titleLabelSize.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right +
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
  [self setCapsuleCornersBasedOn:clampToMinimumSize];
  return clampToMinimumSize;
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
  return clampToMinimumSize;
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
