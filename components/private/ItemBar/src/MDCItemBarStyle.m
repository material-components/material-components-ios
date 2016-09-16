#import "MDCItemBarStyle.h"

/** Describes the visual style of individual items in an item bar. */
@implementation MDCItemBarStyle

- (instancetype)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCItemBarStyle *newStyle = [[[self class] alloc] init];

  newStyle.defaultHeight = _defaultHeight;
  newStyle.shouldDisplaySelectionIndicator = _shouldDisplaySelectionIndicator;
  newStyle.selectionIndicatorColor = _selectionIndicatorColor;
  newStyle.maximumItemWidth = _maximumItemWidth;
  newStyle.shouldDisplayTitle = _shouldDisplayTitle;
  newStyle.shouldDisplayImage = _shouldDisplayImage;
  newStyle.shouldDisplayBadge = _shouldDisplayBadge;
  newStyle.shouldGrowOnSelection = _shouldGrowOnSelection;
  newStyle.titleColor = _titleColor;
  newStyle.selectedTitleColor = _selectedTitleColor;
  newStyle.titleFont = _titleFont;
  newStyle.inkStyle = _inkStyle;
  newStyle.inkColor = _inkColor;
  newStyle.titleImagePadding = _titleImagePadding;
  newStyle.displaysUppercaseTitles = _displaysUppercaseTitles;

  return newStyle;
}

@end

