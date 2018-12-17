// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "private/MDCChipView+Private.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialInk.h"
#import "MaterialMath.h"
#import "MaterialShadowLayer.h"
#import "MaterialShadowElevations.h"
#import "MaterialShapes.h"
#import "MaterialTypography.h"

static const MDCFontTextStyle kTitleTextStyle = MDCFontTextStyleBody2;

static const CGSize kMDCChipMinimumSizeDefault = (CGSize){(CGFloat)0, (CGFloat)32};

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

static inline UIColor *MDCColorDarken(UIColor *color, CGFloat percent) {
  CGFloat hue;
  CGFloat saturation;
  CGFloat brightness;
  CGFloat alpha;
  [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

  brightness = MIN(1, MAX(0, brightness - percent));

  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

static inline UIColor *MDCColorLighten(UIColor *color, CGFloat percent) {
  return MDCColorDarken(color, -percent);
}

// TODO(samnm): Pull background color from MDCPalette
static const uint32_t MDCChipBackgroundColor = 0xEBEBEB;
static const CGFloat MDCChipSelectedDarkenPercent = (CGFloat)0.16;
static const CGFloat MDCChipDisabledLightenPercent = (CGFloat)0.38;
static const CGFloat MDCChipTitleColorWhite = (CGFloat)0.13;
static const CGFloat MDCChipTitleColorDisabledLightenPercent = (CGFloat)0.38;

static const UIEdgeInsets MDCChipContentPadding = {4, 4, 4, 4};
static const UIEdgeInsets MDCChipImagePadding = {0, 0, 0, 0};
static const UIEdgeInsets MDCChipTitlePadding = {3, 8, 4, 8};
static const UIEdgeInsets MDCChipAccessoryPadding = {0, 0, 0, 0};

static CGRect CGRectVerticallyCentered(CGRect rect,
                                       UIEdgeInsets padding,
                                       CGFloat height,
                                       CGFloat pixelScale) {
  CGFloat viewHeight = CGRectGetHeight(rect) + padding.top + padding.bottom;
  CGFloat yValue = (height - viewHeight) / 2;
  yValue = MDCRound(yValue * pixelScale) / pixelScale;
  return CGRectOffset(rect, 0, yValue);
}

static inline CGRect MDCChipBuildFrame(UIEdgeInsets insets,
                                       CGSize size,
                                       CGFloat xOffset,
                                       CGFloat chipHeight,
                                       CGFloat pixelScale) {
  CGRect frame = CGRectMake(xOffset + insets.left, insets.top, size.width, size.height);
  return CGRectVerticallyCentered(frame, insets, chipHeight, pixelScale);
}

static inline CGFloat UIEdgeInsetsHorizontal(UIEdgeInsets insets) {
  return insets.left + insets.right;
}

static inline CGFloat UIEdgeInsetsVertical(UIEdgeInsets insets) {
  return insets.top + insets.bottom;
}

static inline CGSize CGSizeExpandWithInsets(CGSize size, UIEdgeInsets edgeInsets) {
  return CGSizeMake(size.width + UIEdgeInsetsHorizontal(edgeInsets),
                    size.height + UIEdgeInsetsVertical(edgeInsets));
}

static inline CGSize CGSizeShrinkWithInsets(CGSize size, UIEdgeInsets edgeInsets) {
  return CGSizeMake(size.width - UIEdgeInsetsHorizontal(edgeInsets),
                    size.height - UIEdgeInsetsVertical(edgeInsets));
}

@interface MDCChipView ()
@property(nonatomic, readonly) CGRect contentRect;
@property(nonatomic, readonly, strong) MDCShapedShadowLayer *layer;
@property(nonatomic, readonly) BOOL showImageView;
@property(nonatomic, readonly) BOOL showSelectedImageView;
@property(nonatomic, readonly) BOOL showAccessoryView;
@property(nonatomic, strong) MDCInkView *inkView;
@property(nonatomic, readonly) CGFloat pixelScale;
@end

@implementation MDCChipView {
  // For each UIControlState.
  NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, NSNumber *> *_elevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_inkColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_titleColors;

  UIFont *_titleFont;

  BOOL _mdc_adjustsFontForContentSizeCategory;
}

@dynamic layer;

+ (Class)layerClass {
  return [MDCShapedShadowLayer class];
}

- (void)commonMDCChipViewInit {
  _minimumSize = kMDCChipMinimumSizeDefault;
  self.isAccessibilityElement = YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    if (!_backgroundColors) {
      // _backgroundColors may have already been initialized by setting the backgroundColor setter.
      UIColor *normal = MDCColorFromRGB(MDCChipBackgroundColor);
      UIColor *disabled = MDCColorLighten(normal, MDCChipDisabledLightenPercent);
      UIColor *selected = MDCColorDarken(normal, MDCChipSelectedDarkenPercent);

      _backgroundColors = [NSMutableDictionary dictionary];
      _backgroundColors[@(UIControlStateNormal)] = normal;
      _backgroundColors[@(UIControlStateDisabled)] = disabled;
      _backgroundColors[@(UIControlStateSelected)] = selected;
    }
    _borderColors = [NSMutableDictionary dictionary];
    _borderWidths = [NSMutableDictionary dictionary];

    _elevations = [NSMutableDictionary dictionary];
    _elevations[@(UIControlStateNormal)] = @(0);
    _elevations[@(UIControlStateHighlighted)] = @(MDCShadowElevationRaisedButtonPressed);
    _elevations[@(UIControlStateHighlighted | UIControlStateSelected)] =
        @(MDCShadowElevationRaisedButtonPressed);

    _inkColors = [NSMutableDictionary dictionary];

    UIColor *titleColor = [UIColor colorWithWhite:MDCChipTitleColorWhite alpha:1];
    _titleColors = [NSMutableDictionary dictionary];
    _titleColors[@(UIControlStateNormal)] = titleColor;
    _titleColors[@(UIControlStateDisabled)] =
        MDCColorLighten(titleColor, MDCChipTitleColorDisabledLightenPercent);

    _shadowColors = [NSMutableDictionary dictionary];
    _shadowColors[@(UIControlStateNormal)] = [UIColor blackColor];

    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    _inkView.usesLegacyInkRipple = NO;
    _inkView.inkColor = [self inkColorForState:UIControlStateNormal];
    [self addSubview:_inkView];

    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];

    _selectedImageView = [[UIImageView alloc] init];
    [self addSubview:_selectedImageView];

    _titleLabel = [[UILabel alloc] init];
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      _titleLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:kTitleTextStyle];
    } else {
      // There is a custom font loader, retrieve the font from it.
      _titleLabel.font = [MDCTypography buttonFont];
    }
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];

    _contentPadding = MDCChipContentPadding;
    _imagePadding = MDCChipImagePadding;
    _titlePadding = MDCChipTitlePadding;
    _accessoryPadding = MDCChipAccessoryPadding;

    // UIControl has a drag enter/exit boundary that is outside of the frame of the button itself.
    // Because this is not exposed externally, we can't use -touchesMoved: to calculate when to
    // change ink state. So instead we fall back on adding target/actions for these specific events.
    [self addTarget:self
             action:@selector(touchDragEnter:forEvent:)
   forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self
             action:@selector(touchDragExit:forEvent:)
   forControlEvents:UIControlEventTouchDragExit];

    self.layer.elevation = [self elevationForState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;

    [self updateBackgroundColor];

    [self commonMDCChipViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self commonMDCChipViewInit];
  }
  return self;
}

- (void)dealloc {
  [self removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];

  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator {
  if (shapeGenerator) {
    self.layer.cornerRadius = 0;
    self.layer.shadowPath = nil;
  } else {
    CGFloat cornerRadius = MIN(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)) / 2;
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowPath =
        [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
  }

  self.layer.shapeGenerator = shapeGenerator;

  [self updateBackgroundColor];
}

- (id)shapeGenerator {
  return self.layer.shapeGenerator;
}

- (void)setInkColor:(UIColor *)inkColor {
  [self setInkColor:inkColor forState:UIControlStateNormal];
}

- (UIColor *)inkColor {
  return [self inkColorForState:UIControlStateNormal];
}

#pragma mark - Dynamic Type Support

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }

  [self updateTitleFont];
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateTitleFont];
}

#pragma mark - Property support

- (void)setAccessoryView:(UIView *)accessoryView {
  [_accessoryView removeFromSuperview];
  _accessoryView = accessoryView;
  if (accessoryView) {
    [self insertSubview:accessoryView aboveSubview:_titleLabel];
  }
}

- (nullable UIColor *)backgroundColorForState:(UIControlState)state {
  UIColor *backgroundColor = _backgroundColors[@(state)];
  if (!backgroundColor && state != UIControlStateNormal) {
    backgroundColor = _backgroundColors[@(UIControlStateNormal)];
  }
  return backgroundColor;
}

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state {
  // Since setBackgroundColor can be called in the initializer we need to optionally build the dict.
  if (!_backgroundColors) {
    _backgroundColors = [NSMutableDictionary dictionary];
  }
  _backgroundColors[@(state)] = backgroundColor;

  [self updateBackgroundColor];
}

- (UIColor *)backgroundColor {
  return self.layer.shapedBackgroundColor;
}

- (void)updateBackgroundColor {
  self.layer.shapedBackgroundColor = [self backgroundColorForState:self.state];
}

- (nullable UIColor *)borderColorForState:(UIControlState)state {
  UIColor *borderColor = _borderColors[@(state)];
  if (!borderColor && state != UIControlStateNormal) {
    borderColor = _borderColors[@(UIControlStateNormal)];
  }
  return borderColor;
}

- (void)setBorderColor:(nullable UIColor *)borderColor forState:(UIControlState)state {
  _borderColors[@(state)] = borderColor;

  [self updateBorderColor];
}

- (void)updateBorderColor {
  self.layer.shapedBorderColor = [self borderColorForState:self.state];
}

- (CGFloat)borderWidthForState:(UIControlState)state {
  NSNumber *borderWidth = _borderWidths[@(state)];
  if (borderWidth == nil && state != UIControlStateNormal) {
    borderWidth = _borderWidths[@(UIControlStateNormal)];
  }
  if (borderWidth != nil) {
    return (CGFloat)borderWidth.doubleValue;
  }
  return 0;
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  self.layer.shapedBorderWidth = [self borderWidthForState:self.state];
}

- (CGFloat)elevationForState:(UIControlState)state {
  NSNumber *elevation = _elevations[@(state)];
  if (elevation == nil && state != UIControlStateNormal) {
    elevation = _elevations[@(UIControlStateNormal)];
  }
  if (elevation != nil) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)setElevation:(CGFloat)elevation forState:(UIControlState)state {
  _elevations[@(state)] = @(elevation);

  [self updateElevation];
}

- (void)updateElevation {
  CGFloat newElevation = [self elevationForState:self.state];
  if (self.layer.elevation != newElevation) {
    self.layer.elevation = newElevation;
  }
}

- (UIColor *)inkColorForState:(UIControlState)state {
  UIColor *inkColor = _inkColors[@(state)];
  if (!inkColor && state != UIControlStateNormal) {
    inkColor = _inkColors[@(UIControlStateNormal)];
  }
  return inkColor;
}

- (void)setInkColor:(UIColor *)inkColor forState:(UIControlState)state {
  _inkColors[@(state)] = inkColor;

  [self updateInkColor];
}

- (void)updateInkColor {
  UIColor *inkColor = [self inkColorForState:self.state];
  self.inkView.inkColor = inkColor ? inkColor : self.inkView.defaultInkColor;
}

- (nullable UIColor *)shadowColorForState:(UIControlState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (!shadowColor && state != UIControlStateNormal) {
    shadowColor = _shadowColors[@(UIControlStateNormal)];
  }
  return shadowColor;
}

- (void)setShadowColor:(nullable UIColor *)shadowColor forState:(UIControlState)state {
  _shadowColors[@(state)] = shadowColor;

  [self updateShadowColor];
}

- (void)updateShadowColor {
  self.layer.shadowColor = [self shadowColorForState:self.state].CGColor;
}

- (nullable UIFont *)titleFont {
  return _titleFont;
}

- (void)setTitleFont:(nullable UIFont *)titleFont {
  _titleFont = titleFont;

  [self updateTitleFont];
}

- (nullable UIColor *)titleColorForState:(UIControlState)state {
  UIColor *titleColor = _titleColors[@(state)];
  if (!titleColor && state != UIControlStateNormal) {
    titleColor = _titleColors[@(UIControlStateNormal)];
  }
  return titleColor;
}

- (void)setTitleColor:(nullable UIColor *)titleColor forState:(UIControlState)state {
  _titleColors[@(state)] = titleColor;

  [self updateTitleColor];
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment {
  [super setContentHorizontalAlignment:alignment];
  [self setNeedsLayout];
}

- (void)updateTitleFont {
  UIFont *customTitleFont = _titleFont;

  // If we have a custom font apply it to the label.
  // If not, fall back to the Material specified font.
  if (customTitleFont) {
    // If we are automatically adjusting for Dynamic Type resize the font based on the text style
    if (_mdc_adjustsFontForContentSizeCategory) {
      self.titleLabel.font =
          [customTitleFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
              scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
    } else {
      self.titleLabel.font = customTitleFont;
    }
  } else {
    // TODO(#2709): Migrate to a single source of truth for fonts
    // There is no custom font, so use the default font.
    if (_mdc_adjustsFontForContentSizeCategory) {
      // If we are using the default (system) font loader, retrieve the
      // font from the UIFont preferredFont API.
      if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
        _titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:kTitleTextStyle];
      } else {
        // There is a custom font loader, retrieve the font and scale it.
        UIFont *customTypographyFont = [MDCTypography buttonFont];
        _titleLabel.font =
            [customTypographyFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
      }
    } else {
      // If we are using the default (system) font loader, retrieve the
      // font from the UIFont standardFont API.
      if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
        _titleLabel.font = [UIFont mdc_standardFontForMaterialTextStyle:kTitleTextStyle];
      } else {
        // There is a custom font loader, retrieve the font from it.
        _titleLabel.font = [MDCTypography buttonFont];
      }
    }
  }

  [self setNeedsLayout];
}

- (void)updateTitleColor {
  self.titleLabel.textColor = [self titleColorForState:self.state];
}

- (void)updateAccessibility {

  // Clearing and then adding the relevant traits based on current the state (while accommodating concurrent states).
  self.accessibilityTraits &= ~(UIAccessibilityTraitSelected | UIAccessibilityTraitNotEnabled);

  if ((self.state & UIControlStateSelected) == UIControlStateSelected) {
    self.accessibilityTraits |= UIAccessibilityTraitSelected;
  }

  if ((self.state & UIControlStateDisabled) == UIControlStateDisabled) {
    self.accessibilityTraits |= UIAccessibilityTraitNotEnabled;
  }
}

- (NSString *)accessibilityLabel {
  NSString *accessibilityLabel = [super accessibilityLabel];
  if (accessibilityLabel.length > 0) {
    return accessibilityLabel;
  }
  accessibilityLabel = self.titleLabel.accessibilityLabel;
  if (accessibilityLabel.length > 0) {
    return accessibilityLabel;
  }
  return self.titleLabel.text;
}

- (void)updateState {
  [self updateBackgroundColor];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateElevation];
  [self updateInkColor];
  [self updateShadowColor];
  [self updateTitleFont];
  [self updateTitleColor];
  [self updateAccessibility];
}

#pragma mark - Custom touch handling

- (BOOL)pointInside:(CGPoint)point withEvent:(__unused UIEvent *)event {
  CGRect hitAreaRect = UIEdgeInsetsInsetRect(CGRectStandardize(self.bounds), self.hitAreaInsets);
  return CGRectContainsPoint(hitAreaRect, point);
}

#pragma mark - Control

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];

  [self updateState];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];

  [self updateState];
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];

  [self updateState];
  [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];

  _inkView.frame = self.bounds;
  _imageView.frame = [self imageViewFrame];
  _selectedImageView.frame = [self selectedImageViewFrame];
  _accessoryView.frame = [self accessoryViewFrame];
  _titleLabel.frame = [self titleLabelFrame];

  _selectedImageView.alpha = self.showSelectedImageView ? 1 : 0;

  if (!self.layer.shapeGenerator) {
    CGFloat cornerRadius = MIN(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)) / 2;
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowPath =
        [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
  }

  // Handle RTL
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    for (UIView *subview in self.subviews) {
      CGRect flippedRect =
        MDFRectFlippedHorizontally(subview.frame, CGRectGetWidth(self.bounds));
      subview.frame = flippedRect;
    }
  }
}

- (CGRect)contentRect {
  CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, self.contentPadding);
  UIControlContentHorizontalAlignment alignment = self.contentHorizontalAlignment;
  if (alignment != UIControlContentHorizontalAlignmentCenter) {
    return contentRect;
  }

  // Calculate the minimum width needed for all the content. If it's less than contentSize.width,
  // then inset to center. If not, just return contentRect.
  CGFloat neededContentWidth = 0;
  CGSize maxContentSize = contentRect.size;

  // If there's an imageView, add it and its padding.
  if (self.showImageView || self.showSelectedImageView) {
    CGFloat maxImageWidth = 0;
    if (self.showImageView) {
      maxImageWidth = [self sizeForImageView:self.imageView maxSize:maxContentSize].width;
    }
    if (self.showSelectedImageView) {
      maxImageWidth = MAX(
          maxImageWidth, [self sizeForImageView:self.selectedImageView maxSize:maxContentSize].width);
    }
    neededContentWidth += maxImageWidth + UIEdgeInsetsHorizontal(self.imagePadding);
  }

  // Always add the title and its padding.
  neededContentWidth += [_titleLabel sizeThatFits:maxContentSize].width;
  neededContentWidth += UIEdgeInsetsHorizontal(_titlePadding);

  // If there's an accessoryView, add it and its padding.
  if (self.showAccessoryView) {
    neededContentWidth += [self sizeForAccessoryViewWithMaxSize:maxContentSize].width;
    neededContentWidth += UIEdgeInsetsHorizontal(self.accessoryPadding);
  }

  CGFloat difference = maxContentSize.width - neededContentWidth;
  if (difference > 0) {
    CGFloat padding = difference / 2;
    contentRect.size.width -= difference;
    contentRect.origin.x += padding;
  }
  return contentRect;
}

- (CGRect)imageViewFrame {
  return [self frameForImageView:self.imageView visible:self.showImageView];
}

- (CGRect)selectedImageViewFrame {
  return [self frameForImageView:self.selectedImageView visible:self.showSelectedImageView];
}

- (CGRect)frameForImageView:(UIImageView *)imageView visible:(BOOL)visible {
  CGRect frame = CGRectMake(CGRectGetMinX(self.contentRect), CGRectGetMidY(self.contentRect), 0, 0);
  if (visible) {
    CGSize selectedSize = [self sizeForImageView:imageView maxSize:self.contentRect.size];
    frame = MDCChipBuildFrame(_imagePadding,
                              selectedSize,
                              CGRectGetMinX(self.contentRect),
                              CGRectGetHeight(self.frame),
                              self.pixelScale);
  }
  return frame;
}

- (CGSize)sizeForImageView:(UIImageView *)imageView maxSize:(CGSize)maxSize {
  CGSize availableSize = CGSizeShrinkWithInsets(maxSize, self.imagePadding);
  return [imageView sizeThatFits:availableSize];
}

- (CGRect)accessoryViewFrame {
  CGSize size = CGSizeZero;
  if (self.showAccessoryView) {
    size = [self sizeForAccessoryViewWithMaxSize:self.contentRect.size];
  }
  CGFloat xOffset = CGRectGetMaxX(self.contentRect) - size.width - _accessoryPadding.right;
  return MDCChipBuildFrame(_accessoryPadding,
                           size,
                           xOffset,
                           CGRectGetHeight(self.frame),
                           self.pixelScale);
}

- (CGSize)sizeForAccessoryViewWithMaxSize:(CGSize)maxSize {
  CGSize availableSize = CGSizeShrinkWithInsets(maxSize, self.accessoryPadding);
  return [_accessoryView sizeThatFits:availableSize];
}

- (CGRect)titleLabelFrame {
  CGRect imageFrame = CGRectUnion(_imageView.frame, _selectedImageView.frame);
  CGFloat maximumTitleWidth = CGRectGetWidth(self.contentRect) - CGRectGetWidth(imageFrame)
      - UIEdgeInsetsHorizontal(_titlePadding) + UIEdgeInsetsHorizontal(_imagePadding);
  if (self.showAccessoryView) {
    maximumTitleWidth -= CGRectGetWidth(_accessoryView.frame) +
        UIEdgeInsetsHorizontal(_accessoryPadding);
  }
  CGFloat maximumTitleHeight =
      CGRectGetHeight(self.contentRect) - UIEdgeInsetsVertical(_titlePadding);
  CGSize maximumSize = CGSizeMake(maximumTitleWidth, maximumTitleHeight);
  CGSize titleSize = [_titleLabel sizeThatFits:maximumSize];
  titleSize.width = MAX(0, maximumTitleWidth);

  CGFloat imageRightEdge = CGRectGetMaxX(imageFrame) + _imagePadding.right;
  return MDCChipBuildFrame(_titlePadding,
                           titleSize,
                           imageRightEdge,
                           CGRectGetHeight(self.frame),
                           self.pixelScale);
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize contentPaddedSize = CGSizeShrinkWithInsets(size, self.contentPadding);
  CGSize imagePaddedSize = CGSizeShrinkWithInsets(contentPaddedSize, self.imagePadding);
  CGSize titlePaddedSize = CGSizeShrinkWithInsets(contentPaddedSize, self.titlePadding);
  CGSize accessoryPaddedSize = CGSizeShrinkWithInsets(contentPaddedSize, self.accessoryPadding);

  CGSize imageSize = CGSizeZero;
  CGSize selectedSize = CGSizeZero;

  if (self.showImageView) {
    imageSize = CGSizeExpandWithInsets([_imageView sizeThatFits:imagePaddedSize],
                                       self.imagePadding);
  }
  if (self.showSelectedImageView) {
    selectedSize = CGSizeExpandWithInsets([_selectedImageView sizeThatFits:imagePaddedSize],
                                          self.imagePadding);
  }
  imageSize.width = MAX(imageSize.width, selectedSize.width);
  imageSize.height = MAX(imageSize.height, selectedSize.height);

  CGSize originalTitleSize = [_titleLabel sizeThatFits:titlePaddedSize];
  CGSize titleSize = CGSizeExpandWithInsets(originalTitleSize, self.titlePadding);

  CGSize accessorySize = CGSizeZero;
  if (_accessoryView) {
    accessorySize = CGSizeExpandWithInsets([_accessoryView sizeThatFits:accessoryPaddedSize],
                                           self.accessoryPadding);
  }

  CGSize contentSize =
      CGSizeMake(imageSize.width + titleSize.width + accessorySize.width,
                 MAX(imageSize.height, MAX(titleSize.height, accessorySize.height)));
  CGSize chipSize = CGSizeExpandWithInsets(contentSize, self.contentPadding);
  if (self.minimumSize.width > 0) {
    chipSize.width = MAX(self.minimumSize.width, chipSize.width);
  }
  if (self.minimumSize.height > 0) {
    chipSize.height = MAX(self.minimumSize.height, chipSize.height);
  }
  return MDCSizeCeilWithScale(chipSize, self.pixelScale);
}

- (CGSize)intrinsicContentSize {
  return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self.inkView cancelAllAnimationsAnimated:NO];
}

- (BOOL)showImageView {
  return self.imageView.image != nil;
}

- (BOOL)showSelectedImageView {
  return self.selected && self.selectedImageView.image != nil;
}

- (BOOL)showAccessoryView {
  return self.accessoryView && !self.accessoryView.hidden;
}

- (CGFloat)pixelScale {
  return self.window.screen ? self.window.screen.scale : UIScreen.mainScreen.scale;
}

#pragma mark - Ink Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  [self startTouchBeganAnimationAtPoint:[self locationFromTouches:touches]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  [self startTouchEndedAnimationAtPoint:[self locationFromTouches:touches]];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  [self startTouchEndedAnimationAtPoint:[self locationFromTouches:touches]];
}

- (void)touchDragEnter:(__unused MDCChipView *)button forEvent:(UIEvent *)event {
  [self startTouchBeganAnimationAtPoint:[self locationFromTouches:event.allTouches]];
}

- (void)touchDragExit:(__unused MDCChipView *)button forEvent:(UIEvent *)event {
  [self startTouchEndedAnimationAtPoint:[self locationFromTouches:event.allTouches]];
}

- (CGPoint)locationFromTouches:(NSSet *)touches {
  UITouch *touch = [touches anyObject];
  return [touch locationInView:self];
}

@end

@implementation MDCChipView (Private)

- (void)startTouchBeganAnimationAtPoint:(CGPoint)point {
  if (!self.enabled) {
    return;
  }
  CGSize size = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  CGFloat widthDiff = 24;  // Difference between unselected and selected frame widths.
  _inkView.maxRippleRadius =
      (CGFloat)(MDCHypot(size.height, size.width + widthDiff) / 2 + 10 + widthDiff / 2);

  [_inkView startTouchBeganAnimationAtPoint:point completion:nil];
}

- (void)startTouchEndedAnimationAtPoint:(CGPoint)point {
  if (!self.enabled) {
    return;
  }
  [_inkView startTouchEndedAnimationAtPoint:point completion:nil];
}

- (BOOL)willChangeSizeWithSelectedValue:(BOOL)selected {
  if (selected == self.isSelected) {
    return NO;
  }
  BOOL hasImage = self.imageView.image != nil;
  BOOL hasSelectedImage = self.selectedImageView.image != nil;

  return !hasImage && hasSelectedImage;
}

@end
