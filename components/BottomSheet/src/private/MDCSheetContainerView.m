/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCSheetContainerView.h"

#import "MaterialKeyboardWatcher.h"
#import "MDCBottomSheetMotionSpec.h"
#import "MDCDraggableView.h"
#import <MotionAnimator/MotionAnimator.h>

// KVO key for monitoring the content size for the content view if it is a scrollview.
static NSString *kContentSizeKey = nil;
static void *kContentSizeContext = &kContentSizeContext;

// We add an extra padding to the sheet height, so that if the user swipes upwards, fast, the
// bounce does not reveal a gap between the sheet and the bottom of the screen.
static const CGFloat kSheetBounceBuffer = 150.0f;

@interface MDCSheetContainerView () <MDCDraggableViewDelegate>

@property(nonatomic, strong) MDCDraggableView *sheet;
@property(nonatomic, strong) UIView *contentView;

@property(nonatomic, strong) MDMMotionAnimator *animator;
@property(nonatomic, assign) BOOL isDragging;
@property(nonatomic, assign) CGFloat originalPreferredSheetHeight;

@end

@implementation MDCSheetContainerView

+ (void)initialize {
  if (self != [MDCSheetContainerView class]) {
    return;
  }
  kContentSizeKey = NSStringFromSelector(@selector(contentSize));
}

- (instancetype)initWithFrame:(CGRect)frame
                  contentView:(UIView *)contentView
                   scrollView:(UIScrollView *)scrollView {
  self = [super initWithFrame:frame];
  if (self) {
    _sheetState = MDCSheetStateClosed;

    // Don't set the frame yet because we're going to change the anchor point.
    _sheet = [[MDCDraggableView alloc] initWithFrame:CGRectZero scrollView:scrollView];
    _sheet.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _sheet.delegate = self;
    _sheet.backgroundColor = contentView.backgroundColor;

    // Adjust the anchor point so all positions relate to the top edge rather than the actual
    // center.
    _sheet.layer.anchorPoint = CGPointMake(0.5f, 0.f);
    _sheet.frame = self.bounds;

    _contentView = contentView;
    _contentView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [_sheet addSubview:_contentView];
    [self addSubview:_sheet];

    [self updateSheetFrame];

    _animator = [[MDMMotionAnimator alloc] init];

    [scrollView addObserver:self
                 forKeyPath:kContentSizeKey
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                    context:kContentSizeContext];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(voiceOverStatusDidChange)
                                                 name:UIAccessibilityVoiceOverStatusChanged
                                               object:nil];

    // Add the keyboard notifications.
    NSArray *notificationNames = @[
      MDCKeyboardWatcherKeyboardWillShowNotification,
      MDCKeyboardWatcherKeyboardWillHideNotification,
      MDCKeyboardWatcherKeyboardWillChangeFrameNotification
    ];

    for (NSString *name in notificationNames) {
      [[NSNotificationCenter defaultCenter]
       addObserver:self
       selector:@selector(keyboardStateChangedWithNotification:)
       name:name
       object:nil];
    }

    // Since we handle the SafeAreaInsets ourselves through the contentInset property, we disable
    // the adjustment behavior to prevent accounting for it twice.
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
    if (@available(iOS 11.0, *)) {
      scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
  }
  return self;
}

- (void)dealloc {
  [self.sheet.scrollView removeObserver:self forKeyPath:kContentSizeKey];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)voiceOverStatusDidChange {
  if (self.window && UIAccessibilityIsVoiceOverRunning()) {
    [self animateToSheetState:self.sheetState];
  }
}

#pragma mark UIView

- (void)didMoveToWindow {
  [super didMoveToWindow];

  if (self.window) {
    [self animateToSheetState:self.sheetState];
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollection.verticalSizeClass == previousTraitCollection.verticalSizeClass) {
    return;
  }

  [self updateSheetFrame];
  // Adjusts the pane to the correct snap point, e.g. after a rotation.
  if (self.window) {
    [self animateToSheetState:self.sheetState];
  }
}

- (void)safeAreaInsetsDidChange {
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    [super safeAreaInsetsDidChange];

    _preferredSheetHeight = self.originalPreferredSheetHeight + self.safeAreaInsets.bottom;

    UIEdgeInsets contentInset = self.sheet.scrollView.contentInset;
    contentInset.bottom = MAX(contentInset.bottom, self.safeAreaInsets.bottom);
    self.sheet.scrollView.contentInset = contentInset;

    CGRect scrollViewFrame = CGRectStandardize(self.sheet.scrollView.frame);
    scrollViewFrame.size = CGSizeMake(CGRectGetWidth(scrollViewFrame),
                                      CGRectGetHeight(self.frame) - self.safeAreaInsets.top);
    self.sheet.scrollView.frame = scrollViewFrame;
  }
#endif
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if ([keyPath isEqualToString:kContentSizeKey] && context == kContentSizeContext) {
    NSValue *oldValue = change[NSKeyValueChangeOldKey];
    NSValue *newValue = change[NSKeyValueChangeNewKey];
    if (self.window && !self.isDragging && ![oldValue isEqual:newValue]) {
      [self animateToSheetState:self.sheetState];
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark - Layout

- (void)setPreferredSheetHeight:(CGFloat)preferredSheetHeight {
  self.originalPreferredSheetHeight = preferredSheetHeight;

  CGFloat adjustedPreferredSheetHeight = self.originalPreferredSheetHeight;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    adjustedPreferredSheetHeight += self.safeAreaInsets.bottom;
  }
#endif

  if (_preferredSheetHeight == adjustedPreferredSheetHeight) {
    return;
  }
  _preferredSheetHeight = adjustedPreferredSheetHeight;

  [self updateSheetFrame];

  // Adjusts the pane to the correct snap point if we are visible.
  if (self.window) {
    [self animateToSheetState:self.sheetState];
  }
}

- (void)updateSheetFrame {
  CGRect sheetRect = self.bounds;
  CGPoint targetPoint = [self targetPointForState:self.sheetState];
  sheetRect.origin.x = targetPoint.x - CGRectGetWidth(sheetRect) * self.sheet.layer.anchorPoint.x;
  sheetRect.origin.y = (targetPoint.y
                        - [self truncatedPreferredSheetHeight] * self.sheet.layer.anchorPoint.y);
  sheetRect.size.height += kSheetBounceBuffer;

  self.sheet.frame = sheetRect;

  CGRect contentFrame = self.sheet.bounds;
  contentFrame.size.height -= kSheetBounceBuffer;
  if (!self.sheet.scrollView) {
    // If the content doesn't scroll then we have to set its frame to the size we are making
    // visible. This ensures content using autolayout lays out correctly.
    contentFrame.size.height = [self truncatedPreferredSheetHeight];
  }
  self.contentView.frame = contentFrame;
}

- (void)setSheetState:(MDCSheetState)sheetState {
  _sheetState = sheetState;

  [self updateSheetFrame];
}

- (void)animateToSheetState:(MDCSheetState)sheetState {
  [self animateToSheetState:sheetState withInitialVelocity:CGPointZero];
}

- (void)animateToSheetState:(MDCSheetState)sheetState withInitialVelocity:(CGPoint)initialVelocity {
  _sheetState = sheetState;

  if (self.window) {
    MDMMotionTiming spec = MDCBottomSheetMotionSpec.onDragRelease;
    if (spec.curve.type == MDMMotionCurveTypeSpring) {
      spec.curve.data[MDMSpringMotionCurveDataIndexInitialVelocity] = initialVelocity.y;
    }
    [self.animator animateWithTiming:spec animations:^{
      self.sheet.layer.position = [self targetPointForState:sheetState];
    }];
  }
}

// Returns |preferredSheetHeight|, truncated as necessary, so that it never exceeds the height of
// the view.
- (CGFloat)truncatedPreferredSheetHeight {
  // Always return the full height when VO is running, so that the entire content is on-screen
  // and accessibile.
  if (UIAccessibilityIsVoiceOverRunning()) {
    return [self maximumSheetHeight];
  }
  return MIN(self.preferredSheetHeight, [self maximumSheetHeight]);
}

// Returns the maximum allowable height that the sheet can be dragged to.
- (CGFloat)maximumSheetHeight {
  CGFloat boundsHeight = CGRectGetHeight(self.bounds);
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    boundsHeight -= self.safeAreaInsets.top;
  }
#endif
  CGFloat scrollViewContentHeight = self.sheet.scrollView.contentInset.top +
      self.sheet.scrollView.contentSize.height + self.sheet.scrollView.contentInset.bottom;

  // If we have a scrollview, the sheet should never get taller than its content height.
  if (scrollViewContentHeight > 0) {
    return MIN(boundsHeight, scrollViewContentHeight);
  } else {
    return MIN(boundsHeight, self.preferredSheetHeight);
  }
}

#pragma mark - Gesture-driven animation

// Calculates the snap-point for the view to spring to.
- (CGPoint)targetPointForState:(MDCSheetState)state {
  CGRect bounds = self.bounds;
  CGFloat keyboardOffset = [MDCKeyboardWatcher sharedKeyboardWatcher].visibleKeyboardHeight;
  CGFloat midX = CGRectGetMidX(bounds);
  CGFloat bottomY = CGRectGetMaxY(bounds) - keyboardOffset;

  switch(state) {
    case MDCSheetStatePreferred:
      return CGPointMake(midX, bottomY - [self truncatedPreferredSheetHeight]);
    case MDCSheetStateExtended:
      return CGPointMake(midX, bottomY - [self maximumSheetHeight]);
    case MDCSheetStateClosed:
      return CGPointMake(midX, bottomY);
  }
}

#pragma mark - Notifications

- (void)keyboardStateChangedWithNotification:(__unused NSNotification *)notification {
  if (self.window) {
    [self animateToSheetState:self.sheetState];
  }
}

#pragma mark - MDCDraggableViewDelegate

- (CGFloat)maximumHeightForDraggableView:(__unused MDCDraggableView *)view {
  return [self maximumSheetHeight];
}

- (BOOL)draggableView:(__unused MDCDraggableView *)view
    shouldBeginDraggingWithVelocity:(CGPoint)velocity {
  CGFloat currentSheetHeight = CGRectGetMaxY(self.bounds) - CGRectGetMinY(self.sheet.frame);
  MDCSheetState state = (currentSheetHeight >= [self maximumSheetHeight] ?
                         MDCSheetStateExtended : MDCSheetStatePreferred);

  switch (state) {
    case MDCSheetStatePreferred:
      return YES;
    case MDCSheetStateExtended: {
      UIScrollView *scrollView = self.sheet.scrollView;
      if (scrollView) {
        BOOL draggingDown = (velocity.y >= 0);
        // Only allow dragging down if we are scrolled to the top.
        if (scrollView.contentOffset.y <= -scrollView.contentInset.top && draggingDown) {
          return YES;
        } else {
          // Allow dragging in any direction if the content is not scrollable.
          CGFloat contentHeight = scrollView.contentInset.top + scrollView.contentSize.height +
              scrollView.contentInset.bottom;
          return (CGRectGetHeight(scrollView.bounds) >= contentHeight);
        }
      }
      return YES;
    }
    case MDCSheetStateClosed:
      return NO;
  }
}

// @return YES if the sheet can be extended beyond its preferredHeight, else NO
- (BOOL)canExtend {
  return self.preferredSheetHeight != [self maximumSheetHeight];
}

- (void)draggableView:(__unused MDCDraggableView *)view
    draggingEndedWithVelocity:(CGPoint)velocity {
  MDCSheetState targetState;
  if ([self canExtend]) {
    CGFloat currentSheetHeight = CGRectGetMaxY(self.bounds) - CGRectGetMinY(self.sheet.frame);
    if (currentSheetHeight >= self.preferredSheetHeight) {
      targetState = (velocity.y >= 0 ? MDCSheetStatePreferred : MDCSheetStateExtended);
    } else {
      targetState = (velocity.y >= 0 ? MDCSheetStateClosed : MDCSheetStatePreferred);
    }

  } else {
    targetState = (velocity.y >= 0 ? MDCSheetStateClosed : MDCSheetStatePreferred);
  }
  self.isDragging = NO;
  if (targetState == MDCSheetStateClosed) {
    [self.delegate sheetContainerViewWillHide:self];
  }
  [self animateToSheetState:targetState withInitialVelocity:velocity];
}

- (void)draggableViewBeganDragging:(__unused MDCDraggableView *)view {
  self.isDragging = YES;

  [_animator stopAllAnimations];
}

@end
