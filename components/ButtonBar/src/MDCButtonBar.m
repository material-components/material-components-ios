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

#import "MDCButtonBar.h"

static const CGFloat kDefaultHeight = 56;
static const CGFloat kDefaultPadHeight = 64;

// KVO contexts
static char *const kKVOContextMDCButtonBar = "kKVOContextMDCButtonBar";

// This is required because @selector(enabled) throws a compiler warning of unrecognized selector.
static NSString *const kEnabledSelector = @"enabled";

@implementation MDCButtonBar {
  id _buttonItemsLock;
  NSArray *_buttonViews;
}

- (void)dealloc {
  self.buttonItems = nil;
}

- (void)commonInit {
  _buttonItemsLock = [NSObject new];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)alignButtonBaseline:(UIButton *)button {
  CGRect contentRect = [button contentRectForBounds:button.bounds];
  CGRect titleRect = [button titleRectForContentRect:contentRect];
  CGFloat baseline = CGRectGetMaxY(titleRect) + button.titleLabel.font.descender;
  CGFloat buttonBaseline = button.frame.origin.y + baseline;

  UIEdgeInsets insets = button.titleEdgeInsets;
  insets.top += _buttonTitleBaseline - buttonBaseline;
  button.titleEdgeInsets = insets;
}

- (CGSize)sizeThatFits:(CGSize)size shouldLayout:(BOOL)shouldLayout {
  CGFloat totalWidth = 0;

  CGFloat edge;
  switch (_layoutDirection) {
    case UIUserInterfaceLayoutDirectionLeftToRight:
      edge = 0;
      break;
    case UIUserInterfaceLayoutDirectionRightToLeft:
      edge = size.width;
      break;
  }

  BOOL shouldAlignBaselines = _buttonTitleBaseline > 0;

  for (UIView *view in _buttonViews) {
    CGFloat width = view.frame.size.width;
    switch (_layoutDirection) {
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
    switch (_layoutDirection) {
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

#pragma mark - Private

- (NSArray *)viewsForItems:(NSArray *)barButtonItems {
  if (![barButtonItems count]) {
    return nil;
  }
  NSAssert(_delegate,
           @"No delegate provided to %@. Please provide an instance conforming to %@.",
           NSStringFromClass([self class]),
           NSStringFromProtocol(@protocol(MDCButtonBarDelegate)));

  id<MDCButtonBarDelegate> delegate = _delegate;

  NSMutableArray *views = [NSMutableArray array];
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
        NSUInteger itemIndex = [_buttonItems indexOfObject:object];
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

- (void)setButtonItems:(NSArray *)buttonItems {
  @synchronized(_buttonItemsLock) {
    if (_buttonItems == buttonItems || [_buttonItems isEqualToArray:buttonItems]) {
      return;
    }

    NSArray *keyPaths = @[ kEnabledSelector,
                           NSStringFromSelector(@selector(title)),
                           NSStringFromSelector(@selector(image)) ];

    // Remove old observers
    for (UIBarButtonItem *item in _buttonItems) {
      for (NSString *keyPath in keyPaths) {
        [item removeObserver:self forKeyPath:keyPath context:kKVOContextMDCButtonBar];
      }
    }

    _buttonItems = [buttonItems copy];

    // Register new observers
    for (UIBarButtonItem *item in _buttonItems) {
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

- (void)setDelegate:(id<MDCButtonBarDelegate>)delegate {
  if (_delegate == delegate) {
    return;
  }
  _delegate = delegate;

  [self reloadButtonViews];
}

- (void)setLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  if (_layoutDirection == layoutDirection) {
    return;
  }
  _layoutDirection = layoutDirection;

  if (_delegate) {
    [self reloadButtonViews];
  }
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
  _buttonViews = [self viewsForItems:_buttonItems];

  [self setNeedsLayout];
}

@end
