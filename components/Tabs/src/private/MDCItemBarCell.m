// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCItemBarCell.h"
#import "MDCItemBarCell+Private.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCItemBarStringConstants.h"
#import "MDCItemBarStyle.h"
#import "MaterialAnimationTiming.h"
#import "MaterialInk.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

/// Size of image in points.
static const CGSize kImageSize = {24, 24};

/// Font point size for badges.
static const CGFloat kBadgeFontSize = 12;

/// Padding between top of the cell and the badge.
static const CGFloat kBadgeTopPadding = 6;

/// Maximum width of a badge. This allows for 3 characters before truncation.
static const CGFloat kBadgeMaxWidth = 22;

/// Outer edge padding from spec: https://material.io/go/design-tabs#spec.
static const UIEdgeInsets kEdgeInsets = {.top = 0, .right = 16, .bottom = 0, .left = 16};

/// File name of the bundle (without the '.bundle' extension) containing resources.
static NSString *const kResourceBundleName = @"MaterialTabs";

/// String table name containing localized strings.
static NSString *const kStringTableName = @"MaterialTabs";

/// Scale factor applied to the title of bottom navigation items when selected.
const CGFloat kSelectedNavigationTitleScaleFactor = (16.0f / 14.0f);

/// Vertical translation applied to image components bottom navigation items when selected.
const CGFloat kSelectedNavigationImageYOffset = -2;

/// Duration of selection animations in applicable content styles.
static const NSTimeInterval kSelectionAnimationDuration = 0.3;

@implementation MDCItemBarCell {
  UIImageView *_imageView;
  UILabel *_badgeLabel;
  MDCInkTouchController *_inkTouchController;

  MDCItemBarStyle *_style;

  NSInteger _itemIndex;
  NSInteger _itemCount;
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _style = [[MDCItemBarStyle alloc] init];
    _title = @"";
    _itemIndex = NSNotFound;

    self.isAccessibilityElement = YES;

    // Create initial subviews
    [self updateSubviews];

    // Set up ink controller to splash ink on taps.
    _inkTouchController = [[MDCInkTouchController alloc] initWithView:self];
    [_inkTouchController addInkView];  // Ink should always be on top of other views

    [self updateInk];
    [self updateColors];
    [self updateTransformsAnimated:NO];
  }
  return self;
}

#pragma mark - Public

+ (CGSize)sizeThatFits:(CGSize)size item:(UITabBarItem *)item style:(MDCItemBarStyle *)style {
  NSString *title = [self displayedTitleForTitle:item.title style:style];

  CGRect textBounds = CGRectZero;

  // Only compute text bounding rect if necessary (all except image-only items)
  if (style.shouldDisplayTitle) {
    // Determine size based on the unselected state because the majority of tabs are unselected.
    UIFont *font = style.unselectedTitleFont;
    NSDictionary *titleAttributes = @{NSFontAttributeName : font};
    textBounds = [title boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine
                                  attributes:titleAttributes
                                     context:nil];
  }

  CGRect badgeBounds = CGRectZero;

  // Only compute badge bounding rect if necessary.
  NSString *badge = item.badgeValue;
  if (style.shouldDisplayBadge && badge.length > 0) {
    UIFont *badgeFont = [[MDCTypography fontLoader] regularFontOfSize:kBadgeFontSize];
    NSDictionary *badgeAttributes = @{NSFontAttributeName : badgeFont};
    badgeBounds = [badge boundingRectWithSize:size
                                      options:NSStringDrawingTruncatesLastVisibleLine
                                   attributes:badgeAttributes
                                      context:nil];
  }

  // Determine size based on content style.
  CGRect bounds = CGRectZero;
  if (style.shouldDisplayTitle) {
    if (style.shouldDisplayImage) {
      // Title and image
      bounds.size.width = MAX(textBounds.size.width, kImageSize.width + badgeBounds.size.width * 2);
      bounds.size.height = textBounds.size.height + style.titleImagePadding + kImageSize.height;
    } else {
      // Just title
      bounds = textBounds;
    }
  } else {
    if (style.shouldDisplayImage) {
      // Image only.
      bounds.size = kImageSize;
      bounds.size.width += badgeBounds.size.width * 2;
    } else {
      // No image or title: NOP.
    }
  }

  // Constrain to provided width.
  bounds.size.width = MIN(bounds.size.width, size.width);

  // Add insets.
  UIEdgeInsets insets = kEdgeInsets;
  bounds.size.width += insets.left + insets.right;
  bounds.size.height += insets.top + insets.bottom;

  // Snap to integral coordinates.
  bounds = CGRectIntegral(bounds);
  return bounds.size;
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  [self updateDisplayedTitle];
}

- (void)setImage:(nullable UIImage *)image {
  _image = image;
  [self updateDisplayedImage];
}

- (void)setBadgeValue:(nullable NSString *)badgeValue {
  _badgeValue = [badgeValue copy];
  _badgeLabel.text = badgeValue;
  [self setNeedsLayout];
}

- (CGRect)contentFrame {
  if (_style.shouldDisplayTitle) {
    if (_style.shouldDisplayImage) {
      // Title and image.
      CGRect titleFrame = [self convertRect:_titleLabel.bounds fromView:_titleLabel];
      CGRect imageFrame = [self convertRect:_imageView.bounds fromView:_imageView];
      return CGRectUnion(titleFrame, imageFrame);
    } else {
      // Only title.
      return [self convertRect:_titleLabel.bounds fromView:_titleLabel];
    }
  } else {
    // Only image.
    return [self convertRect:_imageView.bounds fromView:_imageView];
  }
}

- (void)applyStyle:(MDCItemBarStyle *)style {
  if (style != _style && ![style isEqual:_style]) {
    _style = style;

    [self updateDisplayedTitle];
    [self updateTitleTextColor];
    [self updateImageTintColor];
    [self updateInk];
    [self updateSubviews];
    [self updateTitleLines];
    [self updateTitleFont];
    [self updateTransformsAnimated:NO];
    [self setNeedsLayout];
  }
}

- (void)updateTitleLines {
  // The presence of an image restricts titles to a single line
  _titleLabel.numberOfLines = _style.shouldDisplayImage ? 1 : _style.textOnlyNumberOfLines;
  // Only permit smaller font sizes for two-line titles
  _titleLabel.adjustsFontSizeToFitWidth = _titleLabel.numberOfLines == 1 ? NO : YES;
}

- (void)updateWithItem:(UITabBarItem *)item
               atIndex:(NSInteger)itemIndex
                 count:(NSInteger)itemCount {
  self.title = item.title;
  self.image = item.image;
  self.badgeValue = item.badgeValue;
  self.accessibilityIdentifier = item.accessibilityIdentifier;

  _itemIndex = itemIndex;
  _itemCount = itemCount;
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];

  UIEdgeInsets insets = [[self class] minimumEdgeInsets];
  CGRect contentBounds = UIEdgeInsetsInsetRect(self.contentView.bounds, insets);

  CGPoint imageCenter = CGPointZero;
  CGPoint titleCenter = CGPointZero;
  CGPoint badgeCenter = CGPointZero;
  CGRect imageBounds = CGRectZero;
  CGRect titleBounds = CGRectZero;
  CGRect badgeBounds = CGRectZero;

  // Image has a fixed size and is horizontally centered, regardless of content style.
  imageBounds.size = kImageSize;
  imageCenter.x = CGRectGetMidX(contentBounds);

  CGSize titleSize = [self.titleLabel sizeThatFits:contentBounds.size];
  titleSize.width = MIN(titleSize.width, CGRectGetWidth(contentBounds));

  // Title is a fixed height based on content and is placed full-width, regardless of content style.
  titleCenter.x = CGRectGetMidX(contentBounds);
  titleBounds.size = titleSize;

  // Horizontally align the badge.
  CGSize badgeSize = [_badgeLabel sizeThatFits:contentBounds.size];
  badgeSize.width = MIN(kBadgeMaxWidth, badgeSize.width);
  badgeBounds.size = badgeSize;

  if (_style.shouldDisplayBadge) {
    CGFloat badgeOffset = (imageBounds.size.width / 2) + (badgeSize.width / 2);
    if (self.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      badgeOffset *= -1;
    }

    badgeCenter.x = imageCenter.x + badgeOffset;
    badgeCenter.y = kBadgeTopPadding + (badgeSize.height / 2);
  }

  // Place components vertically
  if (_style.shouldDisplayTitle) {
    if (_style.shouldDisplayImage) {
      // Image and title, center both vertically together.
      const CGFloat padding = _style.titleImagePadding;
      const CGFloat totalHeight = titleSize.height + padding + kImageSize.height;
      const CGFloat yOrigin = CGRectGetMidY(contentBounds) - (totalHeight / 2);
      imageCenter.y = yOrigin + (kImageSize.height / 2);
      titleCenter.y = yOrigin + kImageSize.height + padding + (titleSize.height / 2);
      titleCenter.y = titleCenter.y;

    } else {
      titleCenter.y = CGRectGetMidY(contentBounds);
    }
  } else {
    if (_style.shouldDisplayImage) {
      // Image only, center image vertically
      imageCenter.y = CGRectGetMidY(contentBounds);
    } else {
      // Nothing: NOP
    }
  }

  UIScreen *screen = self.window.screen ?: UIScreen.mainScreen;
  CGFloat scale = screen.scale;
  _imageView.bounds = imageBounds;
  _imageView.center = MDCRoundCenterWithBoundsAndScale(imageCenter, _imageView.bounds, scale);

  _badgeLabel.bounds = MDCRectAlignToScale(badgeBounds, scale);
  _badgeLabel.center = MDCRoundCenterWithBoundsAndScale(badgeCenter, _badgeLabel.bounds, scale);

  self.titleLabel.bounds = MDCRectAlignToScale(titleBounds, scale);
  self.titleLabel.center =
      MDCRoundCenterWithBoundsAndScale(titleCenter, self.titleLabel.bounds, scale);
}

- (void)tintColorDidChange {
  [super tintColorDidChange];

  [self updateTitleTextColor];
  [self updateImageTintColor];
}

- (void)didMoveToWindow {
  [super didMoveToWindow];

  [self updateTransformsAnimated:NO];

  [self setNeedsLayout];
}

#pragma mark - UICollectionReusableView

- (void)prepareForReuse {
  [super prepareForReuse];
  [self updateTitleTextColor];
  [self updateImageTintColor];
  [self updateAccessibilityTraits];
  [_inkTouchController cancelInkTouchProcessing];
}

#pragma mark - UICollectionViewCell

- (void)setSelected:(BOOL)selected {
  // Do not animate if selected is being set before the cell is in the view hierarchy.
  BOOL animate = (self.window != nil);

  [super setSelected:selected];
  [self updateTitleTextColor];
  [self updateImageTintColor];
  [self updateAccessibilityTraits];
  [self updateTransformsAnimated:animate];
  [self updateTitleFont];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self updateTitleTextColor];
  [self updateImageTintColor];
}

#pragma mark - UIAccessibility

- (nullable NSString *)accessibilityLabel {
  NSMutableArray *labelComponents = [NSMutableArray array];

  // Use untransformed title as accessibility label to ensure accurate reading.
  NSString *titleComponent = _title;
  if (titleComponent.length > 0) {
    [labelComponents addObject:titleComponent];
  }

  if (_badgeValue.length > 0 && !_badgeLabel.hidden) {
    [labelComponents addObject:_badgeValue];
  }

  // Describe as "tab, X of Y"
  NSString *tabLabel =
      [[self class] localizedStringWithKey:kMDCItemBarStringKeyAccessibilityTabElementLabel];
  if (tabLabel) {
    [labelComponents addObject:tabLabel];
  }

  NSString *positionFormat =
      [[self class] localizedStringWithKey:kMDCItemBarStringKeyAccessibilityTabPositionFormat];
  if (positionFormat) {
    if (_itemIndex != NSNotFound && _itemCount > 0) {
      int position = (int)(_itemIndex + 1);
      NSString *localizedPosition =
          [NSString localizedStringWithFormat:positionFormat, position, (int)_itemCount];
      [labelComponents addObject:localizedPosition];
    }
  }

  // Speak components with a pause in between.
  return [labelComponents componentsJoinedByString:@", "];
}

#pragma mark - Private

+ (UIEdgeInsets)minimumEdgeInsets {
  const CGFloat outerPadding = 2;
  return UIEdgeInsetsMake(0.0, outerPadding, 0.0, outerPadding);
}

+ (NSString *)localizedStringWithKey:(NSString *)key {
  NSBundle *containingBundle = [NSBundle bundleForClass:self];
  NSURL *resourceBundleURL = [containingBundle URLForResource:kResourceBundleName
                                                withExtension:@"bundle"];
  NSBundle *resourceBundle = [NSBundle bundleWithURL:resourceBundleURL];
  return [resourceBundle localizedStringForKey:key value:nil table:kStringTableName];
}

+ (NSString *)displayedTitleForTitle:(NSString *)title style:(MDCItemBarStyle *)style {
  NSString *displayedTitle = title;
  if (style.displaysUppercaseTitles) {
    displayedTitle = [displayedTitle uppercaseStringWithLocale:nil];
  }
  return displayedTitle;
}

/// Ensures that subviews exist and have the correct visibility for the current content style.
- (void)updateSubviews {
  if (_style.shouldDisplayImage) {
    // Create image view if needed.
    if (!_imageView) {
      _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
      _imageView.contentMode = UIViewContentModeCenter;
      [self.contentView addSubview:_imageView];

      // Display our image in the new image view.
      [self updateDisplayedImage];

      [self updateImageTintColor];
    }

    _imageView.hidden = NO;
  } else {
    _imageView.hidden = YES;
  }

  if (_style.shouldDisplayTitle) {
    // Create title label if needed.
    if (!_titleLabel) {
      CGRect titleFrame = self.contentView.bounds;
      _titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
      _titleLabel.autoresizingMask =
          UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
      // 0.85 is based on 12sp/14sp guidelines for single- or double-line text
      _titleLabel.minimumScaleFactor = (CGFloat)0.85;
      _titleLabel.textAlignment = NSTextAlignmentCenter;

      [self.contentView addSubview:_titleLabel];

      // Display title and update color for the new label.
      [self updateTitleLines];
      [self updateDisplayedTitle];
      [self updateTitleTextColor];
      [self updateTitleFont];
    }

    _titleLabel.hidden = NO;
  } else {
    _titleLabel.hidden = YES;
  }

  if (_style.shouldDisplayBadge) {
    if (!_badgeLabel) {
      _badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
      _badgeLabel.numberOfLines = 1;
      _badgeLabel.font = [[MDCTypography fontLoader] regularFontOfSize:kBadgeFontSize];
      [self.contentView addSubview:_badgeLabel];
      _badgeLabel.text = _badgeValue;
    }
    _badgeLabel.hidden = NO;
  } else {
    _badgeLabel.hidden = YES;
  }
}

- (void)updateColors {
  [self updateTitleTextColor];
  [self updateImageTintColor];
  [self updateInk];
}

- (void)updateTitleTextColor {
  UIColor *textColor = _style.titleColor;
  if (self.isHighlighted || self.isSelected) {
    textColor = _style.selectedTitleColor;
  }
  _titleLabel.textColor = textColor;
  _badgeLabel.textColor = textColor;
}

- (void)updateImageTintColor {
  UIColor *imageTintColor = _style.imageTintColor;
  if (self.isHighlighted || self.isSelected) {
    imageTintColor = _style.selectedImageTintColor;
  }
  _imageView.tintColor = imageTintColor;
}

- (void)updateTransformsAnimated:(BOOL)animated {
  CGAffineTransform titleTransform = CGAffineTransformIdentity;
  CGAffineTransform imageTransform = CGAffineTransformIdentity;

  UIScreen *screen = self.window.screen ?: UIScreen.mainScreen;
  const CGFloat screenScale = (screen ? screen.scale : 1);
  CGFloat titleContentsScale = screenScale;

  // Apply transforms to the selected item if appropriate.
  if (_style.shouldGrowOnSelection) {
    const CGFloat titleScaleFactor = self.selected ? kSelectedNavigationTitleScaleFactor : 1;
    const CGFloat imageYTransform = self.selected ? kSelectedNavigationImageYOffset : 0;

    /// Vertical offset in points from the bottom of the label to its baseline.
    const CGFloat titleBaselineOffset = 3.5;

    // Scale title up from the baseline.
    titleTransform = CGAffineTransformMakeTranslation(0, titleBaselineOffset);
    titleTransform = CGAffineTransformScale(titleTransform, titleScaleFactor, titleScaleFactor);
    titleTransform = CGAffineTransformTranslate(titleTransform, 0, -titleBaselineOffset);

    // Shift image up by a small amount.
    imageTransform = CGAffineTransformMakeTranslation(0, imageYTransform);

    // Render the title with a higher contents scale to reduce aliasing after the scale.
    titleContentsScale = ceilf((float)(titleScaleFactor * screenScale));
  }

  void (^performAnimations)(void) = ^{
    // Update the title scale and redraw if it'll be ending at a higher scale
    // to minimize aliasing during animation.
    if (titleContentsScale > self.titleLabel.layer.contentsScale) {
      self.titleLabel.layer.contentsScale = titleContentsScale;
      [self.titleLabel setNeedsDisplay];
    }

    // Set the transforms.
    self.titleLabel.transform = titleTransform;
    self->_badgeLabel.transform = imageTransform;
    self->_imageView.transform = imageTransform;
  };
  void (^completeAnimations)(BOOL) = ^(__unused BOOL finished) {
    if (titleContentsScale != self.titleLabel.layer.contentsScale) {
      // Update the title with the final contents scale and redraw.
      self.titleLabel.layer.contentsScale = titleContentsScale;
      [self.titleLabel setNeedsDisplay];
    }
  };

  if (animated) {
    [CATransaction begin];
    CAMediaTimingFunction *translateTimingFunction =
        [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionTranslate];
    [CATransaction setAnimationTimingFunction:translateTimingFunction];
    [UIView animateWithDuration:kSelectionAnimationDuration
                          delay:0
                        options:0
                     animations:performAnimations
                     completion:completeAnimations];
    [CATransaction commit];
  } else {
    performAnimations();
    completeAnimations(YES);
  }
}

- (void)updateTitleFont {
  _titleLabel.font = self.isSelected ? _style.selectedTitleFont : _style.unselectedTitleFont;
}

- (void)updateInk {
  MDCInkView *inkView = _inkTouchController.defaultInkView;
  inkView.inkColor = _style.inkColor;
  inkView.inkStyle = _style.inkStyle;
  inkView.usesLegacyInkRipple = NO;
  inkView.clipsToBounds = (inkView.inkStyle == MDCInkStyleBounded) ? YES : NO;
}

- (void)updateAccessibilityTraits {
  if (self.isSelected) {
    self.accessibilityTraits |= UIAccessibilityTraitSelected;
  } else {
    self.accessibilityTraits &= ~UIAccessibilityTraitSelected;
  }
}

- (void)updateDisplayedImage {
  _imageView.image = _image;
}

- (void)updateDisplayedTitle {
  _titleLabel.text = [[self class] displayedTitleForTitle:_title style:_style];
}

@end
