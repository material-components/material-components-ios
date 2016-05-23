/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MDCNavigationBar.h"

#import "MaterialButtonBar.h"
#import "MaterialTypography.h"

#import <objc/runtime.h>
#import <tgmath.h>

#undef ceil
#define ceil(__x) __tg_ceil(__tg_promote1((__x))(__x))

#undef floor
#define floor(__x) __tg_floor(__tg_promote1((__x))(__x))

static const CGFloat kNavigationBarDefaultHeight = 56;
static const CGFloat kNavigationBarPadDefaultHeight = 64;
static const UIEdgeInsets kTextInsets = {16, 16, 16, 16};
static const UIEdgeInsets kTextPadInsets = {20, 16, 20, 16};

// KVO contexts
static char *const kKVOContextMDCNavigationBar = "kKVOContextMDCNavigationBar";

static NSArray *MDCNavigationBarNavigationItemKVOPaths(void) {
  static dispatch_once_t onceToken;
  static NSArray *forwardingKeyPaths = nil;
  dispatch_once(&onceToken, ^{
    NSMutableArray *keyPaths = [NSMutableArray array];

    Protocol *headerProtocol = @protocol(MDCUINavigationItemObservables);
    unsigned int count = 0;
    objc_property_t *propertyList = protocol_copyPropertyList(headerProtocol, &count);
    if (propertyList) {
      for (unsigned int ix = 0; ix < count; ++ix) {
        [keyPaths addObject:[NSString stringWithFormat:@"%s", property_getName(propertyList[ix])]];
      }
      free(propertyList);
    }

    // Ensure that the plural bar button item key paths are listened to last, otherwise the
    // non-plural variant will cause the extra bar button items to be lost. Fun!
    NSArray *orderedKeyPaths = @[
      NSStringFromSelector(@selector(leftBarButtonItems)),
      NSStringFromSelector(@selector(rightBarButtonItems))
    ];
    [keyPaths removeObjectsInArray:orderedKeyPaths];
    [keyPaths addObjectsFromArray:orderedKeyPaths];

    forwardingKeyPaths = keyPaths;
  });
  return forwardingKeyPaths;
}

/**
 Indiana Jones style placeholder view for UINavigationBar. Ownership of UIBarButtonItem.customView
 and UINavigationItem.titleView are normally transferred to UINavigationController but we plan to
 steal them away. In order to avoid crashing during KVO updates, we steal the view away and
 replace it with a sandbag view.
 */
@interface MDCNavigationBarSandbagView : UIView
@end

@implementation MDCNavigationBarSandbagView
@end

@interface MDCNavigationBar (PrivateAPIs)

- (UILabel *)titleLabel;
- (MDCButtonBar *)leftButtonBar;
- (MDCButtonBar *)rightButtonBar;
- (UIControlContentVerticalAlignment)titleAlignment;

@end

@implementation MDCNavigationBar {
  id _observedNavigationItemLock;
  UINavigationItem *_observedNavigationItem;

  UILabel *_titleLabel;

  MDCButtonBar *_leftButtonBar;
  MDCButtonBar *_rightButtonBar;

  __weak UIViewController *_watchingViewController;
}

@synthesize leftBarButtonItems = _leftBarButtonItems;
@synthesize rightBarButtonItems = _rightBarButtonItems;
@synthesize hidesBackButton = _hidesBackButton;
@synthesize leftItemsSupplementBackButton = _leftItemsSupplementBackButton;
@synthesize titleView = _titleView;

- (void)dealloc {
  [self setObservedNavigationItem:nil];
}

- (void)commonMDCNavigationBarInit {
  _observedNavigationItemLock = [[NSObject alloc] init];

  _titleLabel = [[UILabel alloc] init];
  _titleLabel.font = [MDCTypography titleFont];
  _titleLabel.accessibilityTraits |= UIAccessibilityTraitHeader;

  _leftButtonBar = [[MDCButtonBar alloc] init];
  _leftButtonBar.layoutPosition = MDCButtonBarLayoutPositionLeft;
  _rightButtonBar = [[MDCButtonBar alloc] init];
  _leftButtonBar.layoutPosition = MDCButtonBarLayoutPositionRight;

  [self addSubview:_titleLabel];
  [self addSubview:_leftButtonBar];
  [self addSubview:_rightButtonBar];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCNavigationBarInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCNavigationBarInit];
  }
  return self;
}

#pragma mark - Accessibility

- (NSArray *)accessibilityElements {
  return @[ _leftButtonBar, self.titleView ?: _titleLabel, _rightButtonBar ];
}

- (BOOL)isAccessibilityElement {
  return NO;
}

- (NSInteger)accessibilityElementCount {
  return self.accessibilityElements.count;
}

- (id)accessibilityElementAtIndex:(NSInteger)index {
  return self.accessibilityElements[index];
}

- (NSInteger)indexOfAccessibilityElement:(id)element {
  return [self.accessibilityElements indexOfObject:element];
}

#pragma mark - UIView Overrides

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize leftButtonBarSize = [_leftButtonBar sizeThatFits:self.bounds.size];
  _leftButtonBar.frame = (CGRect){self.bounds.origin, leftButtonBarSize};

  CGSize rightButtonBarSize = [_rightButtonBar sizeThatFits:self.bounds.size];
  _rightButtonBar.frame = (CGRect){.origin = {self.bounds.size.width - rightButtonBarSize.width, 0},
                                   .size = rightButtonBarSize};

  const BOOL isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
  UIEdgeInsets textInsets = isPad ? kTextPadInsets : kTextInsets;

  CGRect textFrame = UIEdgeInsetsInsetRect(self.bounds, textInsets);
  textFrame.origin.x += _leftButtonBar.frame.size.width;
  textFrame.size.width -= _leftButtonBar.frame.size.width + _rightButtonBar.frame.size.width;

  NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
  paraStyle.lineBreakMode = _titleLabel.lineBreakMode;

  NSDictionary *attributes =
      @{NSFontAttributeName : _titleLabel.font, NSParagraphStyleAttributeName : paraStyle};

  CGSize titleSize = [_titleLabel.text boundingRectWithSize:textFrame.size
                                                    options:NSStringDrawingTruncatesLastVisibleLine
                                                 attributes:attributes
                                                    context:NULL]
                         .size;
  titleSize.width = ceil(titleSize.width);
  titleSize.height = ceil(titleSize.height);
  CGRect titleFrame = (CGRect){{textFrame.origin.x, 0}, titleSize};
  UIControlContentVerticalAlignment titleAlignment = [self titleAlignment];
  _titleLabel.frame =
      [self mdc_frameAlignedVertically:titleFrame
                          withinBounds:textFrame
                             alignment:titleAlignment];
  self.titleView.frame = textFrame;

  // Button and title label alignment

  CGFloat titleTextRectHeight =
      [_titleLabel textRectForBounds:_titleLabel.bounds
              limitedToNumberOfLines:0]
          .size.height;

  if (_titleLabel.hidden || titleTextRectHeight <= 0) {
    _leftButtonBar.buttonTitleBaseline = 0;
    _rightButtonBar.buttonTitleBaseline = 0;

  } else {
    // Assumes that the title is center-aligned vertically.
    CGFloat titleTextOriginY = (_titleLabel.frame.size.height - titleTextRectHeight) / 2;
    CGFloat titleTextHeight = titleTextOriginY + titleTextRectHeight + _titleLabel.font.descender;
    CGFloat titleBaseline = _titleLabel.frame.origin.y + titleTextHeight;
    _leftButtonBar.buttonTitleBaseline = titleBaseline;
    _rightButtonBar.buttonTitleBaseline = titleBaseline;
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize intrinsicContentSize = [self intrinsicContentSize];
  return CGSizeMake(size.width, intrinsicContentSize.height);
}

- (CGSize)intrinsicContentSize {
  const BOOL isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
  CGFloat height = (isPad ? kNavigationBarPadDefaultHeight : kNavigationBarDefaultHeight);
  return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

#pragma mark - Private

- (UILabel *)titleLabel {
  return _titleLabel;
}

- (MDCButtonBar *)leftButtonBar {
  return _leftButtonBar;
}

- (MDCButtonBar *)rightButtonBar {
  return _rightButtonBar;
}

- (UIControlContentVerticalAlignment)titleAlignment {
  return UIControlContentVerticalAlignmentTop;
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (context == kKVOContextMDCNavigationBar) {
    void (^mainThreadWork)(void) = ^{
      @synchronized(self->_observedNavigationItemLock) {
        if (object != _observedNavigationItem) {
          return;
        }

        [self setValue:[object valueForKey:keyPath] forKey:keyPath];
      }
    };

    // Ensure that UIKit modifications occur on the main thread.
    if ([NSThread isMainThread]) {
      mainThreadWork();
    } else {
      [[NSOperationQueue mainQueue] addOperationWithBlock:mainThreadWork];
    }

  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark Layout

- (CGRect)mdc_frameAlignedVertically:(CGRect)frame
                        withinBounds:(CGRect)bounds
                           alignment:(UIControlContentVerticalAlignment)alignment {
  switch (alignment) {
    case UIControlContentVerticalAlignmentBottom:
      return (CGRect){{frame.origin.x, CGRectGetMaxY(bounds) - frame.size.height}, frame.size};

    case UIControlContentVerticalAlignmentCenter: {
      CGFloat centeredY = floor((bounds.size.height - frame.size.height) / 2) + bounds.origin.y;
      return (CGRect){{frame.origin.x, centeredY}, frame.size};
    }

    case UIControlContentVerticalAlignmentTop: {
      return (CGRect){{frame.origin.x, bounds.origin.y}, frame.size};
    }

    case UIControlContentVerticalAlignmentFill: {
      return bounds;
    }
  }
}

- (NSArray *)mdc_buttonItemsForLeftBar {
  if (!self.leftItemsSupplementBackButton && self.leftBarButtonItems.count > 0) {
    return self.leftBarButtonItems;
  }

  NSMutableArray *buttonItems = [NSMutableArray array];
  if (self.backItem && !self.hidesBackButton) {
    [buttonItems addObject:self.backItem];
  }
  [buttonItems addObjectsFromArray:self.leftBarButtonItems];
  return buttonItems;
}

#pragma mark Colors

- (void)tintColorDidChange {
  [super tintColorDidChange];

  _titleLabel.textColor = self.tintColor;
  _leftButtonBar.tintColor = self.tintColor;
  _rightButtonBar.tintColor = self.tintColor;
}

#pragma mark - Public

- (void)setTitle:(NSString *)title {
  _titleLabel.text = title;
  [self setNeedsLayout];
}

- (NSString *)title {
  return _titleLabel.text;
}

- (void)setTitleView:(UIView *)titleView {
  if (self.titleView == titleView) {
    return;
  }
  // Ignore sandbag KVO events
  if ([_observedNavigationItem.titleView isKindOfClass:[MDCNavigationBarSandbagView class]]) {
    return;
  }
  [self.titleView removeFromSuperview];
  _titleView = titleView;
  [self addSubview:_titleView];

  _titleLabel.hidden = _titleView != nil;

  [self setNeedsLayout];

  // Swap in the sandbag (so that UINavigationController won't steal our view)
  if (titleView) {
    _observedNavigationItem.titleView = [[MDCNavigationBarSandbagView alloc] init];
  } else if (_observedNavigationItem.titleView) {
    _observedNavigationItem.titleView = nil;
  }
}

- (void)setLeftBarButtonItems:(NSArray *)leftBarButtonItems {
  _leftBarButtonItems = [leftBarButtonItems copy];
  _leftButtonBar.items = [self mdc_buttonItemsForLeftBar];
  [self setNeedsLayout];
}

- (void)setRightBarButtonItems:(NSArray *)rightBarButtonItems {
  _rightBarButtonItems = [rightBarButtonItems copy];
  _rightButtonBar.items = rightBarButtonItems;
  [self setNeedsLayout];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
  self.leftBarButtonItems = leftBarButtonItem ? @[ leftBarButtonItem ] : nil;
}

- (UIBarButtonItem *)leftBarButtonItem {
  return [self.leftBarButtonItems firstObject];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
  self.rightBarButtonItems = rightBarButtonItem ? @[ rightBarButtonItem ] : nil;
}

- (UIBarButtonItem *)rightBarButtonItem {
  return [self.rightBarButtonItems firstObject];
}

- (void)setBackBarButtonItem:(UIBarButtonItem *)backBarButtonItem {
  self.backItem = backBarButtonItem;
}

- (UIBarButtonItem *)backBarButtonItem {
  return self.backItem;
}

- (void)setBackItem:(UIBarButtonItem *)backItem {
  if (_backItem == backItem) {
    return;
  }
  _backItem = backItem;
  _leftButtonBar.items = [self mdc_buttonItemsForLeftBar];
  [self setNeedsLayout];
}

- (void)setHidesBackButton:(BOOL)hidesBackButton {
  if (_hidesBackButton == hidesBackButton) {
    return;
  }
  _hidesBackButton = hidesBackButton;
  _leftButtonBar.items = [self mdc_buttonItemsForLeftBar];
  [self setNeedsLayout];
}

- (void)setLeftItemsSupplementBackButton:(BOOL)leftItemsSupplementBackButton {
  if (_leftItemsSupplementBackButton == leftItemsSupplementBackButton) {
    return;
  }
  _leftItemsSupplementBackButton = leftItemsSupplementBackButton;
  _leftButtonBar.items = [self mdc_buttonItemsForLeftBar];
  [self setNeedsLayout];
}

- (void)setObservedNavigationItem:(UINavigationItem *)navigationItem {
  @synchronized(_observedNavigationItemLock) {
    if (navigationItem == _observedNavigationItem) {
      return;
    }

    NSArray *keyPaths = MDCNavigationBarNavigationItemKVOPaths();
    for (NSString *keyPath in keyPaths) {
      [_observedNavigationItem removeObserver:self
                                   forKeyPath:keyPath
                                      context:kKVOContextMDCNavigationBar];
    }

    _observedNavigationItem = navigationItem;

    NSKeyValueObservingOptions options =
        (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial);
    for (NSString *keyPath in keyPaths) {
      [_observedNavigationItem addObserver:self
                                forKeyPath:keyPath
                                   options:options
                                   context:kKVOContextMDCNavigationBar];
    }
  }
}

- (void)observeNavigationItem:(UINavigationItem *)navigationItem {
  [self setObservedNavigationItem:navigationItem];
}

- (void)unobserveNavigationItem {
  [self setObservedNavigationItem:nil];
}

@end
