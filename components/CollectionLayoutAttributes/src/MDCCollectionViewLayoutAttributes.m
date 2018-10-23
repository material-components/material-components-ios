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

#import "MDCCollectionViewLayoutAttributes.h"

@implementation MDCCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
  MDCCollectionViewLayoutAttributes *attributes =
      (MDCCollectionViewLayoutAttributes *)[super copyWithZone:zone];
  attributes->_editing = _editing;
  attributes->_shouldShowReorderStateMask = _shouldShowReorderStateMask;
  attributes->_shouldShowSelectorStateMask = _shouldShowSelectorStateMask;
  attributes->_shouldShowGridBackground = _shouldShowGridBackground;
  attributes->_sectionOrdinalPosition = _sectionOrdinalPosition;
  attributes->_backgroundImage = _backgroundImage;
  attributes->_backgroundImageViewInsets = _backgroundImageViewInsets;
  attributes->_isGridLayout = _isGridLayout;
  attributes->_separatorColor = _separatorColor;
  attributes->_separatorInset = _separatorInset;
  attributes->_separatorLineHeight = _separatorLineHeight;
  attributes->_shouldHideSeparators = _shouldHideSeparators;
  attributes->_willAnimateCellsOnAppearance = _willAnimateCellsOnAppearance;
  attributes->_animateCellsOnAppearanceDuration = _animateCellsOnAppearanceDuration;
  attributes->_animateCellsOnAppearanceDelay = _animateCellsOnAppearanceDelay;
  return attributes;
}

- (BOOL)isEqual:(id)object {
  if (object == self) {
    return YES;
  }
  if (!object || ![[object class] isEqual:[self class]]) {
    return NO;
  }

  // Compare custom properties that affect layout.
  MDCCollectionViewLayoutAttributes *otherAttrs = (MDCCollectionViewLayoutAttributes *)object;
  BOOL backgroundImageIdentity = NO;
  if (self.backgroundImage && otherAttrs.backgroundImage) {
    backgroundImageIdentity = [self.backgroundImage isEqual:otherAttrs.backgroundImage];
  } else if (!self.backgroundImage && !otherAttrs.backgroundImage) {
    backgroundImageIdentity = YES;
  }

  BOOL separatorColorIdentity = NO;
  if (self.separatorColor && otherAttrs.separatorColor) {
    separatorColorIdentity = [self.separatorColor isEqual:otherAttrs.separatorColor];
  } else if (!self.separatorColor && !otherAttrs.separatorColor) {
    separatorColorIdentity = YES;
  }

  if ((otherAttrs.editing != self.editing) ||
      (otherAttrs.shouldShowReorderStateMask != self.shouldShowReorderStateMask) ||
      (otherAttrs.shouldShowSelectorStateMask != self.shouldShowSelectorStateMask) ||
      (otherAttrs.shouldShowGridBackground != self.shouldShowGridBackground) ||
      (otherAttrs.sectionOrdinalPosition != self.sectionOrdinalPosition) ||
      !backgroundImageIdentity ||
      (!UIEdgeInsetsEqualToEdgeInsets(otherAttrs.backgroundImageViewInsets,
                                      self.backgroundImageViewInsets)) ||
      (otherAttrs.isGridLayout != self.isGridLayout) || !separatorColorIdentity ||
      (!UIEdgeInsetsEqualToEdgeInsets(otherAttrs.separatorInset, self.separatorInset)) ||
      (otherAttrs.separatorLineHeight != self.separatorLineHeight) ||
      (otherAttrs.shouldHideSeparators != self.shouldHideSeparators) ||
      (!CGRectEqualToRect(otherAttrs.frame, self.frame))) {
    return NO;
  }

  return [super isEqual:object];
}

- (NSUInteger)hash {
  return (NSUInteger)self.editing ^ (NSUInteger)self.shouldShowReorderStateMask ^
         (NSUInteger)self.shouldShowSelectorStateMask ^ (NSUInteger)self.shouldShowGridBackground ^
         (NSUInteger)self.sectionOrdinalPosition ^ (NSUInteger)self.backgroundImage ^
         (NSUInteger)self.isGridLayout ^ (NSUInteger)self.separatorColor ^
         (NSUInteger)self.separatorLineHeight ^ (NSUInteger)self.shouldHideSeparators;
}

@end
