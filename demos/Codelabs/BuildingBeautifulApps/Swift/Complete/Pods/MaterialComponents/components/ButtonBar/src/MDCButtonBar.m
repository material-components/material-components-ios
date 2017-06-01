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

#import "MDCButtonBar.h"
#import "MDCButton.h"

#import "MaterialRTL.h"
#import "private/MDCAppBarButtonBarBuilder.h"

static const CGFloat kDefaultHeight = 56;
static const CGFloat kDefaultPadHeight = 64;

// KVO contexts
static char *const kKVOContextMDCButtonBar = "kKVOContextMDCButtonBar";

// This is required because @selector(enabled) throws a compiler warning of unrecognized selector.
static NSString *const kEnabledSelector = @"enabled";

static NSString *const MDCButtonBarItemsKey = @"MDCButtonBarItemsKey";
static NSString *const MDCButtonBarButtonTitleBaselineKey = @"MDCButtonBarButtonTitleBaselineKey";
static NSString *const MDCButtonBarButtonLayoutPositionKey = @"MDCButtonBarButtonLayoutPositionKey";

@implementation MDCButtonBar {
  id _buttonItemsLock;
  NSArray<__kindof UIView *> *_buttonViews;

  MDCAppBarButtonBarBuilder *_defaultBuilder;
}

- (void)dealloc {
  self.items = nil;
}

- (void)commonMDCButtonBarInit {
  _buttonItemsLock = [[NSObject alloc] init];
  _layoutPosition = MDCButtonBarLayoutPositionNone;

  _defaultBuilder = [[MDCAppBarButtonBarBuilder alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCButtonBarInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonMDCButtonBarInit];
    if ([coder containsValueForKey:MDCButtonBarItemsKey]) {
      _items = [coder decodeObjectForKey:MDCButtonBarItemsKey];
    }

    if ([coder containsValueForKey:MDCButtonBarButtonTitleBaselineKey]) {
      _buttonTitleBaseline = (CGFloat)[coder decodeDoubleForKey:MDCButtonBarButtonTitleBaselineKey];
    }

    if ([coder containsValueForKey:MDCButtonBarButtonLayoutPositionKey]) {
      _layoutPosition = [coder decodeIntegerForKey:MDCButtonBarButtonLayoutPositionKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  if (self.items && self.items.count > 0) {
    [aCoder encodeObject:self.items forKey:MDCButtonBarItemsKey];
  }
  [aCoder encodeDouble:self.buttonTitleBaseline forKey:MDCButtonBarButtonTitleBaselineKey];
  [aCoder encodeInteger:self.layoutPosition forKey:MDCButtonBarButtonLayoutPositionKey];
}

- (void)alignButtonBaseline:(UIButton *)button {
  CGRect contentRect = [button contentRectForBounds:button.bounds];
  CGRect titleRect = [button titleRectForContentRect:contentRect];

  // Calculate baseline information based on frame that the title text appears in.
  CGFloat baseline = CGRectGetMaxY(titleRect) + button.titleLabel.font.descender;
  CGFloat buttonBaseline = button.frame.origin.y + baseline;

  // When modifying insets, be sure to add/subtract equal amounts on opposite sides.
  UIEdgeInsets insets = button.titleEdgeInsets;
  CGFloat baselineOffset = _buttonTitleBaseline - buttonBaseline;

  insets.top += baselineOffset;
  insets.bottom -= baselineOffset;
  button.titleEdgeInsets = insets;
}

- (CGSize)sizeThatFits:(CGSize)size shouldLayout:(BOOL)shouldLayout {
  CGFloat totalWidth = 0;

  CGFloat edge;
  switch (self.mdc_effectiveUserInterfaceLayoutDirection) {
    case UIUserInterfaceLayoutDirectionLeftToRight:
      edge = 0;
      break;
    case UIUserInterfaceLayoutDirectionRightToLeft:
      edge = size.width;
      break;
  }

  BOOL shouldAlignBaselines = _buttonTitleBaseline > 0;

  NSEnumerator<__kindof UIView *> *positionedButtonViews =
      self.layoutPosition == MDCButtonBarLayoutPositionTrailing
          ? [_buttonViews reverseObjectEnumerator]
          : [_buttonViews objectEnumerator];

  for (UIView *view in positionedButtonViews) {
    CGFloat width = view.frame.size.width;
    switch (self.mdc_effectiveUserInterfaceLayoutDirection) {
      case UIUserInterfaceLayoutDirectionLeftToRight:
        break;
      case UIUserInterfaceLayoutDirectionRightToLeft:
        edge -= width;
        break;
    }
    if (shouldLayout) {
      view.frame = CGRectMake(edge, 0, width, size.height);

      if (shouldAlignBaselines && [view isKindOfClass:[UIButton class]]) {
        if ([(UIButton *)view titleForState:UIControlStateNormal].length > 0) {
          [self alignButtonBaseline:(UIButton *)view];
        }
      }
    }
    switch (self.mdc_effectiveUserInterfaceLayoutDirection) {
      case UIUserInterfaceLayoutDirectionLeftToRight:
        edge += width;
        break;
      case UIUserInterfaceLayoutDirectionRightToLeft:
        break;
    }
    totalWidth += width;
  }
  // TODO(featherless): Take into account compact/regular sizes rather than the device idiom.
  const BOOL isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
  CGFloat height = isPad ? kDefaultPadHeight : kDefaultHeight;
  return CGSizeMake(totalWidth, height);
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self sizeThatFits:size shouldLayout:NO];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self sizeThatFits:self.bounds.size shouldLayout:YES];
}

- (void)tintColorDidChange {
  [super tintColorDidChange];

  _defaultBuilder.buttonTitleColor = self.tintColor;
  [self updateButtonTitleColors];
}

#pragma mark - Private

- (void)updateButtonTitleColors {
  for (UIView *viewObj in _buttonViews) {
    if ([viewObj isKindOfClass:[MDCButton class]]) {
      MDCButton *buttonView = (MDCButton *)viewObj;
      buttonView.customTitleColor = self.tintColor;
    }
  }
}

- (NSArray<UIView *> *)viewsForItems:(NSArray<UIBarButtonItem *> *)barButtonItems {
  if (![barButtonItems count]) {
    return nil;
  }
  id<MDCButtonBarDelegate> delegate = _defaultBuilder;

  NSMutableArray<UIView *> *views = [NSMutableArray array];
  [barButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *item, NSUInteger idx, BOOL *stop) {
    MDCBarButtonItemLayoutHints hints = MDCBarButtonItemLayoutHintsNone;
    if (idx == 0) {
      hints |= MDCBarButtonItemLayoutHintsIsFirstButton;
    }
    if (idx == [barButtonItems count] - 1) {
      hints |= MDCBarButtonItemLayoutHintsIsLastButton;
    }
    UIView *view = [delegate buttonBar:self viewForItem:item layoutHints:hints];
    if (!view) {
      return;
    }

    [view sizeToFit];
    if (item.width > 0) {
      CGRect frame = view.frame;
      frame.size.width = item.width;
      view.frame = frame;
    }

    [self addSubview:view];
    [views addObject:view];
  }];
  return views;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (context == kKVOContextMDCButtonBar) {
    void (^mainThreadWork)(void) = ^{
      @synchronized(_buttonItemsLock) {
        NSUInteger itemIndex = [_items indexOfObject:object];
        if (itemIndex == NSNotFound || itemIndex > [_buttonViews count]) {
          return;
        }
        UIButton *button = _buttonViews[itemIndex];

        id newValue = [object valueForKey:keyPath];
        if (newValue == [NSNull null]) {
          newValue = nil;
        }

        if ([keyPath isEqualToString:kEnabledSelector]) {
          if ([button respondsToSelector:@selector(setEnabled:)]) {
            [button setValue:newValue forKey:keyPath];
          }

        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]) {
          [button setTitle:newValue forState:UIControlStateNormal];

        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(image))]) {
          [button setImage:newValue forState:UIControlStateNormal];

        } else {
          NSLog(@"Unknown key path notification received by %@ for %@.",
                NSStringFromClass([self class]), keyPath);
        }
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

#pragma mark - Button target selector

- (void)didTapButton:(UIButton *)button event:(UIEvent *)event {
  NSUInteger buttonIndex = [_buttonViews indexOfObject:button];
  if (buttonIndex == NSNotFound || buttonIndex > [self.buttonItems count]) {
    return;
  }

  UIBarButtonItem *item = self.buttonItems[buttonIndex];

  if (item.action == nil) {
    return;
  }

  id target = item.target;

  // As per Apple's documentation on UIBarButtonItem:
  // https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIBarButtonItem_Class/#//apple_ref/occ/instp/UIBarButtonItem/action
  // "If nil, the action message is passed up the responder chain where it may be handled by any
  // object implementing a method corresponding to the selector held by the action property."
  if (target == nil && [self respondsToSelector:@selector(targetForAction:withSender:)]) {
    // iOS 7 and up.
    target = [self targetForAction:item.action withSender:self];
  }

  // If we ultimately couldn't find a target, bail out.
  if (!target) {
    return;
  }

  if (![target respondsToSelector:item.action]) {
    return;
  }

  NSMethodSignature *signature = [target methodSignatureForSelector:item.action];
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
  invocation.selector = item.action;

  if ([invocation.methodSignature numberOfArguments] > 2) {
    [invocation setArgument:&item atIndex:2];
  }
  if ([invocation.methodSignature numberOfArguments] > 3) {
    [invocation setArgument:&event atIndex:3];
  }

  // UIKit methods that present from a UIBarButtonItem will not work with our items because we
  // can't set the necessary private ivars that associate the item with the button. So we pass the
  // button as well so that clients can present from the button's frame instead.
  // This is not part of the standard UIKit method signature.
  if ([invocation.methodSignature numberOfArguments] > 4) {
    [invocation setArgument:&button atIndex:4];
  }

  [invocation invokeWithTarget:target];
}

#pragma mark - Public

- (NSArray<UIBarButtonItem *> *)buttonItems {
  return self.items;
}

- (void)setButtonItems:(NSArray<UIBarButtonItem *> *)buttonItems {
  self.items = buttonItems;
}

- (void)setItems:(NSArray<UIBarButtonItem *> *)items {
  @synchronized(_buttonItemsLock) {
    if (_items == items || [_items isEqualToArray:items]) {
      return;
    }

    NSArray<NSString *> *keyPaths = @[
      kEnabledSelector, NSStringFromSelector(@selector(title)),
      NSStringFromSelector(@selector(image))
    ];

    // Remove old observers
    for (UIBarButtonItem *item in _items) {
      for (NSString *keyPath in keyPaths) {
        [item removeObserver:self forKeyPath:keyPath context:kKVOContextMDCButtonBar];
      }
    }

    _items = [items copy];

    // Register new observers
    for (UIBarButtonItem *item in _items) {
      for (NSString *keyPath in keyPaths) {
        [item addObserver:self
               forKeyPath:keyPath
                  options:NSKeyValueObservingOptionNew
                  context:kKVOContextMDCButtonBar];
      }
    }

    [self reloadButtonViews];
  }
}

- (void)mdc_setSemanticContentAttribute:(UISemanticContentAttribute)semanticContentAttribute {
  [super mdc_setSemanticContentAttribute:semanticContentAttribute];
  [self reloadButtonViews];
}

- (void)setButtonTitleBaseline:(CGFloat)buttonTitleBaseline {
  _buttonTitleBaseline = buttonTitleBaseline;

  [self setNeedsLayout];
}

- (void)reloadButtonViews {
  // TODO(featherless): Recycle buttons.
  for (UIView *view in _buttonViews) {
    [view removeFromSuperview];
  }
  _buttonViews = [self viewsForItems:_items];

  [self setNeedsLayout];
}

@end
