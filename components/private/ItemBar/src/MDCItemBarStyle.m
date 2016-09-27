#import "MDCItemBarStyle.h"

@implementation MDCItemBarStyle

- (instancetype)init {
  self = [super init];
  if (self) {
    _titleColor = [UIColor whiteColor];
    _inkColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    _displaysUppercaseTitles = YES;
    _shouldDisplayTitle = YES;
    _shouldDisplaySelectionIndicator = YES;
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
