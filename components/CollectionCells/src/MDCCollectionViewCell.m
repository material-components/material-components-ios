/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionViewCell.h"

#import "MaterialCollectionLayoutAttributes.h"
#import "MaterialIcons+ic_check.h"
#import "MaterialIcons+ic_check_circle.h"
#import "MaterialIcons+ic_chevron_right.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialIcons+ic_radio_button_unchecked.h"
#import "MaterialIcons+ic_reorder.h"
#import "MaterialRTL.h"
#import "MaterialPalettes.h"

static CGFloat kEditingControlAppearanceOffset = 16.0f;

// Default accessory insets.
static const UIEdgeInsets kAccessoryInsetDefault = {0, 16.0f, 0, 16.0f};

// Default editing icon colors.
// Color is 0x626262
static inline UIColor *MDCCollectionViewCellGreyColor(void) {
  return MDCPalette.greyPalette.tint700;
}

// Color is 0xF44336
static inline UIColor *MDCCollectionViewCellRedColor(void) {
  return MDCPalette.redPalette.tint500;
}

// File name of the bundle (without the '.bundle' extension) containing resources.
static NSString *const kResourceBundleName = @"MaterialCollectionCells";

// String table name containing localized strings.
static NSString *const kStringTableName = @"MaterialCollectionCells";

NSString *const kSelectedCellAccessibilityHintKey =
    @"MaterialCollectionCellsAccessibilitySelectedHint";

NSString *const kDeselectedCellAccessibilityHintKey =
    @"MaterialCollectionCellsAccessibilityDeselectedHint";

// To be used as accessory view when an accessory type is set. It has no particular functionalities
// other than being a private class defined here, to check if an accessory view was set via an
// accessory type, or if the user of MDCCollectionViewCell set a custom accessory view.
@interface MDCAccessoryTypeImageView : UIImageView
@end
@implementation MDCAccessoryTypeImageView
@end

@implementation MDCCollectionViewCell {
  MDCCollectionViewLayoutAttributes *_attr;
  BOOL _usesCellSeparatorHiddenOverride;
  BOOL _usesCellSeparatorInsetOverride;
  BOOL _shouldAnimateEditingViews;
  UIView *_separatorView;
  UIImageView *_backgroundImageView;
  UIImageView *_editingReorderImageView;
  UIImageView *_editingSelectorImageView;
}

@synthesize inkView = _inkView;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionViewCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCCollectionViewCellInit];
  }
  return self;
}

- (void)commonMDCCollectionViewCellInit {
  // Separator defaults.
  _separatorView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self addSubview:_separatorView];

  // Accessory defaults.
  _accessoryType = MDCCollectionViewCellAccessoryNone;
  _accessoryInset = kAccessoryInsetDefault;
  _editingSelectorColor = MDCCollectionViewCellRedColor();
}

#pragma mark - Layout

- (void)prepareForReuse {
  [super prepareForReuse];

  // Accessory defaults.
  _accessoryType = MDCCollectionViewCellAccessoryNone;
  _accessoryInset = kAccessoryInsetDefault;
  [_accessoryView removeFromSuperview];
  _accessoryView = nil;

  // Reset properties.
  _shouldAnimateEditingViews = NO;
  _usesCellSeparatorHiddenOverride = NO;
  _usesCellSeparatorInsetOverride = NO;
  _separatorView.hidden = YES;

  [self drawSeparatorIfNeeded];
  [self updateInterfaceForEditing];

  // Reset cells hidden during swipe deletion.
  self.hidden = NO;

  [self.inkView cancelAllAnimationsAnimated:NO];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Layout the accessory view and the content view.
  [self updateInterfaceForEditing];
  [self layoutForegroundSubviews];

  void (^editingViewLayout)(void) = ^() {
    CGFloat txReorderTransform;
    CGFloat txSelectorTransform;
    switch (self.mdc_effectiveUserInterfaceLayoutDirection) {
      case UIUserInterfaceLayoutDirectionLeftToRight:
        txReorderTransform = kEditingControlAppearanceOffset;
        txSelectorTransform = -kEditingControlAppearanceOffset;
        break;
      case UIUserInterfaceLayoutDirectionRightToLeft:
        txReorderTransform = -kEditingControlAppearanceOffset;
        txSelectorTransform = kEditingControlAppearanceOffset;
        break;
    }
    _editingReorderImageView.alpha = _attr.shouldShowReorderStateMask ? 1.0f : 0.0f;
    _editingReorderImageView.transform =
        _attr.shouldShowReorderStateMask ? CGAffineTransformMakeTranslation(txReorderTransform, 0)
                                         : CGAffineTransformIdentity;

    _editingSelectorImageView.alpha = _attr.shouldShowSelectorStateMask ? 1.0f : 0.0f;
    _editingSelectorImageView.transform =
        _attr.shouldShowSelectorStateMask ? CGAffineTransformMakeTranslation(txSelectorTransform, 0)
                                          : CGAffineTransformIdentity;

    _accessoryView.alpha = _attr.shouldShowSelectorStateMask ? 0.0f : 1.0f;
    _accessoryInset.right = _attr.shouldShowSelectorStateMask
                                ? kAccessoryInsetDefault.right + kEditingControlAppearanceOffset
                                : kAccessoryInsetDefault.right;
  };

  // Animate editing controls.
  if (_shouldAnimateEditingViews) {
    [UIView animateWithDuration:0.3 animations:editingViewLayout];
    _shouldAnimateEditingViews = NO;
  } else {
    [UIView performWithoutAnimation:editingViewLayout];
  }
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes:layoutAttributes];
  if ([layoutAttributes isKindOfClass:[MDCCollectionViewLayoutAttributes class]]) {
    _attr = (MDCCollectionViewLayoutAttributes *)layoutAttributes;

    if (_attr.representedElementCategory == UICollectionElementCategoryCell) {
      // Cells are often set to editing via layout attributes so we default to animating.
      // This can be overridden by ensuring layoutSubviews is called inside a non-animation block.
      [self setEditing:_attr.editing animated:YES];
    }

    // Create image view to hold cell background image with shadowing.
    if (!_backgroundImageView) {
      _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
      self.backgroundView = _backgroundImageView;
    }
    _backgroundImageView.image = _attr.backgroundImage;

    // Draw separator if needed.
    [self drawSeparatorIfNeeded];

    // Layout the accessory view and the content view.
    [self layoutForegroundSubviews];

    // Animate cell on appearance settings.
    [self updateAppearanceAnimation];
  }
}

- (void)layoutForegroundSubviews {
  // First lay out the accessory view.
  _accessoryView.frame = [self accessoryFrame];
  // Then lay out the content view, inset by the accessory view's width.
  self.contentView.frame = [self contentViewFrame];

  // If necessary flip subviews for RTL.
  _accessoryView.frame = MDCRectFlippedForRTL(_accessoryView.frame, CGRectGetWidth(self.bounds),
                                              self.mdc_effectiveUserInterfaceLayoutDirection);
  self.contentView.frame = MDCRectFlippedForRTL(self.contentView.frame, CGRectGetWidth(self.bounds),
                                                self.mdc_effectiveUserInterfaceLayoutDirection);
}

#pragma mark - Accessory Views

- (void)setAccessoryType:(MDCCollectionViewCellAccessoryType)accessoryType {
  _accessoryType = accessoryType;

  UIImageView *accessoryImageView = nil;
  if (!_accessoryView && accessoryType != MDCCollectionViewCellAccessoryNone) {
    // Add accessory view.
    accessoryImageView = [[MDCAccessoryTypeImageView alloc] initWithFrame:CGRectZero];
    _accessoryView = accessoryImageView;
    _accessoryView.userInteractionEnabled = NO;
    [self addSubview:_accessoryView];
  }

  switch (_accessoryType) {
    case MDCCollectionViewCellAccessoryDisclosureIndicator: {
      UIImage *image = [MDCIcons imageFor_ic_chevron_right];
      if (self.mdc_effectiveUserInterfaceLayoutDirection ==
          UIUserInterfaceLayoutDirectionRightToLeft) {
        image = [image mdc_imageFlippedForRightToLeftLayoutDirection];
      }
      accessoryImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      break;
    }
    case MDCCollectionViewCellAccessoryCheckmark: {
      UIImage *image = [MDCIcons imageFor_ic_check];
      accessoryImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      break;
    }
    case MDCCollectionViewCellAccessoryDetailButton: {
      UIImage *image = [MDCIcons imageFor_ic_info];
      accessoryImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      break;
    }
    case MDCCollectionViewCellAccessoryNone: {
      [_accessoryView removeFromSuperview];
      _accessoryView = nil;
      break;
    }
  }
  [_accessoryView sizeToFit];
}

- (void)setAccessoryView:(UIView *)accessoryView {
  if (_accessoryView) {
    [_accessoryView removeFromSuperview];
  }
  _accessoryView = accessoryView;
  if (_accessoryView) {
    [self addSubview:_accessoryView];
  }
}

- (CGRect)accessoryFrame {
  CGSize size = _accessoryView.frame.size;
  CGFloat originX = CGRectGetWidth(self.bounds) - size.width - _accessoryInset.right;
  CGFloat originY = (CGRectGetHeight(self.bounds) - size.height) / 2;
  return CGRectMake(originX, originY, size.width, size.height);
}

- (MDCInkView *)inkView {
  if (!_inkView) {
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    [self addSubview:_inkView];
  }
  return _inkView;
}

- (void)setInkView:(MDCInkView *)inkView {
  if (inkView == _inkView) {
    return;
  }
  if (_inkView) {
    [_inkView removeFromSuperview];
  }
  if (inkView) {
    [self addSubview:inkView];
  }
  _inkView = inkView;
}

#pragma mark - Separator

- (void)setShouldHideSeparator:(BOOL)shouldHideSeparator {
  _usesCellSeparatorHiddenOverride = YES;
  _shouldHideSeparator = shouldHideSeparator;
  [self drawSeparatorIfNeeded];
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
  _usesCellSeparatorInsetOverride = YES;
  _separatorInset = separatorInset;
  [self drawSeparatorIfNeeded];
}

- (void)drawSeparatorIfNeeded {
  // Determine separator spec from attributes and cell overrides. Don't draw separator for bottom
  // cell or in grid layout cells. Separators are added here as cell subviews instead of decoration
  // views registered with the layout to overcome inability to animate decoration views in
  // coordination with cell animations.
  BOOL isHidden =
      _usesCellSeparatorHiddenOverride ? _shouldHideSeparator : _attr.shouldHideSeparators;
  UIEdgeInsets separatorInset =
      _usesCellSeparatorInsetOverride ? _separatorInset : _attr.separatorInset;
  BOOL isBottom = _attr.sectionOrdinalPosition & MDCCollectionViewOrdinalPositionVerticalBottom;
  BOOL isGrid = _attr.isGridLayout;

  BOOL hideSeparator = isBottom || isHidden || isGrid;
  if (hideSeparator != _separatorView.hidden) {
    _separatorView.hidden = hideSeparator;
  }

  if (!hideSeparator) {
    UIEdgeInsets insets = _attr.backgroundImageViewInsets;
    // Compute the frame in LTR.
    CGRect separatorFrame = CGRectMake(
        insets.left, CGRectGetHeight(self.bounds) - _attr.separatorLineHeight,
        CGRectGetWidth(self.bounds) - insets.left - insets.right, _attr.separatorLineHeight);
    separatorFrame = UIEdgeInsetsInsetRect(separatorFrame, separatorInset);
    _separatorView.frame = MDCRectFlippedForRTL(separatorFrame, CGRectGetWidth(self.bounds),
                                                self.mdc_effectiveUserInterfaceLayoutDirection);
    _separatorView.backgroundColor = _attr.separatorColor;
  }
}

#pragma mark - Editing

- (void)setEditing:(BOOL)editing {
  [self setEditing:editing animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  if (_editing == editing) {
    return;
  }
  _shouldAnimateEditingViews = animated;
  _editing = editing;
  [self setNeedsLayout];
  [self layoutIfNeeded];
}

- (void)updateInterfaceForEditing {
  self.contentView.userInteractionEnabled = [self shouldEnableCellInteractions];

  if (_editing) {
    // Disable implicit animations when setting initial positioning of these subviews.
    [CATransaction begin];
    [CATransaction setDisableActions:YES];

    // Create reorder editing controls.
    if (_attr.shouldShowReorderStateMask) {
      if (!_editingReorderImageView) {
        UIImage *reorderImage = [MDCIcons imageFor_ic_reorder];
        reorderImage = [reorderImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _editingReorderImageView = [[UIImageView alloc] initWithImage:reorderImage];
        _editingReorderImageView.tintColor = MDCCollectionViewCellGreyColor();
        _editingReorderImageView.autoresizingMask =
            MDCAutoresizingFlexibleTrailingMargin(self.mdc_effectiveUserInterfaceLayoutDirection);
        [self addSubview:_editingReorderImageView];
      }
      CGAffineTransform transform = _editingReorderImageView.transform;
      _editingReorderImageView.transform = CGAffineTransformIdentity;
      CGSize size = _editingReorderImageView.image.size;
      CGRect frame =
          CGRectMake(0, (CGRectGetHeight(self.bounds) - size.height) / 2, size.width, size.height);
      _editingReorderImageView.frame = MDCRectFlippedForRTL(
          frame, CGRectGetWidth(self.bounds), self.mdc_effectiveUserInterfaceLayoutDirection);
      _editingReorderImageView.transform = transform;
      _editingReorderImageView.alpha = 1.0f;
    } else {
      _editingReorderImageView.alpha = 0.0f;
    }

    // Create selector editing controls.
    if (_attr.shouldShowSelectorStateMask) {
      if (!_editingSelectorImageView) {
        UIImage *selectorImage = [MDCIcons imageFor_ic_radio_button_unchecked];
        selectorImage = [selectorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _editingSelectorImageView = [[UIImageView alloc] initWithImage:selectorImage];
        _editingSelectorImageView.tintColor = MDCCollectionViewCellGreyColor();
        _editingSelectorImageView.autoresizingMask =
            MDCAutoresizingFlexibleLeadingMargin(self.mdc_effectiveUserInterfaceLayoutDirection);
        [self addSubview:_editingSelectorImageView];
      }
      CGAffineTransform transform = _editingSelectorImageView.transform;
      _editingSelectorImageView.transform = CGAffineTransformIdentity;
      CGSize size = _editingSelectorImageView.image.size;
      CGFloat originX = CGRectGetWidth(self.bounds) - size.width;
      CGFloat originY = (CGRectGetHeight(self.bounds) - size.height) / 2;
      CGRect frame = (CGRect){{originX, originY}, size};
      _editingSelectorImageView.frame = MDCRectFlippedForRTL(
          frame, CGRectGetWidth(self.bounds), self.mdc_effectiveUserInterfaceLayoutDirection);
      _editingSelectorImageView.transform = transform;
      _editingSelectorImageView.alpha = 1.0f;
    } else {
      _editingSelectorImageView.alpha = 0.0f;
    }
    [CATransaction commit];
  } else {
    _editingReorderImageView.alpha = 0.0f;
    _editingSelectorImageView.alpha = 0.0f;
  }

  // Update accessory view.
  _accessoryView.alpha = _attr.shouldShowSelectorStateMask ? 0.0f : 1.0f;
  _accessoryInset.right = _attr.shouldShowSelectorStateMask
                              ? kAccessoryInsetDefault.right + kEditingControlAppearanceOffset
                              : kAccessoryInsetDefault.right;
}

#pragma mark - Selecting

- (void)setSelected:(BOOL)selected {
  BOOL previousSelectedState = self.selected;
  [super setSelected:selected];
  if (selected) {
    if (_editingSelectorImageView && previousSelectedState != selected) {
      _editingSelectorImageView.image = [MDCIcons imageFor_ic_check_circle];
      _editingSelectorImageView.tintColor = self.editingSelectorColor;
      _editingSelectorImageView.image = [_editingSelectorImageView.image
          imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    self.accessibilityTraits |= UIAccessibilityTraitSelected;
  } else {
    if (_editingSelectorImageView && previousSelectedState != selected) {
      _editingSelectorImageView.image = [MDCIcons imageFor_ic_radio_button_unchecked];
      _editingSelectorImageView.tintColor = MDCCollectionViewCellGreyColor();
      _editingSelectorImageView.image = [_editingSelectorImageView.image
          imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    self.accessibilityTraits &= ~UIAccessibilityTraitSelected;
  }
}

- (void)setEditingSelectorColor:(UIColor *)editingSelectorColor {
  if (editingSelectorColor == nil) {
    editingSelectorColor = MDCCollectionViewCellRedColor();
  }
  _editingSelectorColor = editingSelectorColor;
}

#pragma mark - Cell Appearance Animation

- (void)updateAppearanceAnimation {
  if (_attr.animateCellsOnAppearanceDelay > 0) {
    // Intially hide content view and separator.
    self.contentView.alpha = 0;
    _separatorView.alpha = 0;

    // Animate fade-in after delay.
    if (!_attr.willAnimateCellsOnAppearance) {
      [UIView animateWithDuration:_attr.animateCellsOnAppearanceDuration
                            delay:_attr.animateCellsOnAppearanceDelay
                          options:UIViewAnimationOptionCurveEaseOut
                       animations:^{
                         self.contentView.alpha = 1;
                         _separatorView.alpha = 1;
                       }
                       completion:nil];
    }
  }
}

#pragma mark - RTL

- (void)mdc_setSemanticContentAttribute:(UISemanticContentAttribute)mdc_semanticContentAttribute {
  [super mdc_setSemanticContentAttribute:mdc_semanticContentAttribute];
  // Reload the accessory type image if there is one.
  if ([_accessoryView isKindOfClass:[MDCAccessoryTypeImageView class]]) {
    self.accessoryType = self.accessoryType;
  }
}

#pragma mark - Accessibility

- (UIAccessibilityTraits)accessibilityTraits {
  UIAccessibilityTraits accessibilityTraits = [super accessibilityTraits];
  if (self.accessoryType == MDCCollectionViewCellAccessoryCheckmark) {
    accessibilityTraits |= UIAccessibilityTraitSelected;
  }
  return accessibilityTraits;
}

- (NSString *)accessibilityHint {
  if (_attr.shouldShowSelectorStateMask) {
    NSString *localizedHintKey =
        self.selected ? kSelectedCellAccessibilityHintKey : kDeselectedCellAccessibilityHintKey;
    return [[self class] localizedStringWithKey:localizedHintKey];
  }
  return nil;
}

#pragma mark - Private

+ (NSString *)localizedStringWithKey:(NSString *)key {
  NSBundle *containingBundle = [NSBundle bundleForClass:self];
  NSURL *resourceBundleURL =
      [containingBundle URLForResource:kResourceBundleName withExtension:@"bundle"];
  NSBundle *resourceBundle = [NSBundle bundleWithURL:resourceBundleURL];
  return [resourceBundle localizedStringForKey:key value:nil table:kStringTableName];
}

- (CGRect)contentViewFrame {
  CGFloat leadingPadding =
      _attr.shouldShowReorderStateMask
          ? CGRectGetWidth(_editingReorderImageView.bounds) + kEditingControlAppearanceOffset
          : 0.f;

  CGFloat accessoryViewPadding =
      _accessoryView ? CGRectGetWidth(self.bounds) - CGRectGetMinX(_accessoryView.frame) : 0;
  CGFloat trailingPadding =
      _attr.shouldShowSelectorStateMask
          ? CGRectGetWidth(_editingSelectorImageView.bounds) + kEditingControlAppearanceOffset
          : accessoryViewPadding;
  UIEdgeInsets insets = UIEdgeInsetsMake(0, leadingPadding, 0, trailingPadding);
  return UIEdgeInsetsInsetRect(self.bounds, insets);
}

- (BOOL)shouldEnableCellInteractions {
  return !_editing || _allowsCellInteractionsWhileEditing;
}

@end
