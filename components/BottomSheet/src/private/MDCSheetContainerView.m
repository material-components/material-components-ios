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

#import "MDCSheetContainerView.h"

#import "MDCDraggableView.h"
#import "MDCSheetBehavior.h"
#import "MaterialKeyboardWatcher.h"

// KVO key for monitoring the content size for the content view if it is a scrollview.
static NSString *kContentSizeKey = nil;
static void *kContentSizeContext = &kContentSizeContext;

// We add an extra padding to the sheet height, so that if the user swipes upwards, fast, the
// bounce does not reveal a gap between the sheet and the bottom of the screen.
static const CGFloat kSheetBounceBuffer = 150;

@interface MDCSheetContainerView () <MDCDraggableViewDelegate>

@property(nonatomic) MDCSheetState sheetState;
@property(nonatomic) MDCDraggableView *sheet;
@property(nonatomic) UIView *contentView;

@property(nonatomic) UIDynamicAnimator *animator;
@property(nonatomic) MDCSheetBehavior *sheetBehavior;
@property(nonatomic) BOOL isDragging;
@property(nonatomic) CGFloat originalPreferredSheetHeight;
@property(nonatomic) CGRect previousAnimatedBounds;

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
    _sheetState = MDCSheetStatePreferred;

    // Don't set the frame yet because we're going to change the anchor point.
    _sheet = [[MDCDraggableView alloc] initWithFrame:CGRectZero scrollView:scrollView];
    _sheet.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _sheet.delegate = self;
    _sheet.backgroundColor = contentView.backgroundColor;

    // Adjust the anchor point so all positions relate to the top edge rather than the actual
    // center.
    _sheet.layer.anchorPoint = CGPointMake((CGFloat)0.5, 0);
    _sheet.frame = self.bounds;

    _contentView = contentView;
    _contentView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [_sheet addSubview:_contentView];
    [self addSubview:_sheet];

    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];

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
    if (@available(iOS 11.0, *)) {
      scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scrollView.preservesSuperviewLayoutMargins = YES;
  }
  return self;
}

- (void)dealloc {
  [self.sheet.scrollView removeObserver:self forKeyPath:kContentSizeKey];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)voiceOverStatusDidChange {
  if (self.window && UIAccessibilityIsVoiceOverRunning()) {
    // Adjust the sheet height as necessary for VO.
    [self animatePaneWithInitialVelocity:CGPointZero];
  }
}

#pragma mark UIView

- (void)didMoveToWindow {
  [super didMoveToWindow];
  if (self.window) {
    if (!self.sheetBehavior) {
      self.sheetBehavior = [[MDCSheetBehavior alloc] initWithItem:self.sheet];
    }
    [self animatePaneWithInitialVelocity:CGPointZero];
  } else {
    [self.animator removeAllBehaviors];
    self.sheetBehavior = nil;
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
    [self animatePaneWithInitialVelocity:CGPointZero];
  }
}

- (void)safeAreaInsetsDidChange {
  if (@available(iOS 11.0, *)) {
    [super safeAreaInsetsDidChange];

    _preferredSheetHeight = self.originalPreferredSheetHeight + self.safeAreaInsets.bottom;

    UIEdgeInsets contentInset = self.sheet.scrollView.contentInset;
    contentInset.bottom = MAX(contentInset.bottom, self.safeAreaInsets.bottom);
    self.sheet.scrollView.contentInset = contentInset;

    CGRect scrollViewFrame = CGRectStandardize(self.sheet.scrollView.frame);
    scrollViewFrame.size = CGSizeMake(scrollViewFrame.size.width, CGRectGetHeight(self.frame));
    self.sheet.scrollView.frame = scrollViewFrame;
  }
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
      [self animatePaneWithInitialVelocity:CGPointZero];
    }
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

#pragma mark - Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!CGRectEqualToRect(self.bounds, self.previousAnimatedBounds) && self.window) {
    // Adjusts the pane to the correct snap point if we are visible.
    [self animatePaneWithInitialVelocity:CGPointZero];
  }
}

- (void)setPreferredSheetHeight:(CGFloat)preferredSheetHeight {
  self.originalPreferredSheetHeight = preferredSheetHeight;

  CGFloat adjustedPreferredSheetHeight = self.originalPreferredSheetHeight;
  if (@available(iOS 11.0, *)) {
    adjustedPreferredSheetHeight += self.safeAreaInsets.bottom;
  }

  if (_preferredSheetHeight == adjustedPreferredSheetHeight) {
    return;
  }
  _preferredSheetHeight = adjustedPreferredSheetHeight;

  [self updateSheetFrame];

  // Adjusts the pane to the correct snap point if we are visible.
  if (self.window) {
    [self animatePaneWithInitialVelocity:CGPointZero];
  }
}

// Slides the sheet position downwards, so the right amount peeks above the bottom of the superview.
- (void)updateSheetFrame {
  [self.animator removeAllBehaviors];

  CGRect sheetRect = self.bounds;
  sheetRect.origin.y = CGRectGetMaxY(self.bounds) - [self truncatedPreferredSheetHeight];
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

- (void)updateSheetState {
  CGFloat currentSheetHeight = CGRectGetMaxY(self.bounds) - CGRectGetMinY(self.sheet.frame);
  self.sheetState = (currentSheetHeight >= [self maximumSheetHeight] ? MDCSheetStateExtended
                                                                     : MDCSheetStatePreferred);
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
  if (@available(iOS 11.0, *)) {
    boundsHeight -= self.safeAreaInsets.top;
  }
  CGFloat scrollViewContentHeight = self.sheet.scrollView.contentInset.top +
                                    self.sheet.scrollView.contentSize.height +
                                    self.sheet.scrollView.contentInset.bottom;

  // If we have a scrollview, the sheet should never get taller than its content height.
  if (scrollViewContentHeight > 0) {
    return MIN(boundsHeight, scrollViewContentHeight);
  } else {
    return MIN(boundsHeight, self.preferredSheetHeight);
  }
}

#pragma mark - Gesture-driven animation

- (void)animatePaneWithInitialVelocity:(CGPoint)initialVelocity {
  self.previousAnimatedBounds = self.bounds;
  self.sheetBehavior.targetPoint = [self targetPoint];
  self.sheetBehavior.velocity = initialVelocity;
  __weak MDCSheetContainerView *weakSelf = self;
  self.sheetBehavior.action = ^{
    [weakSelf sheetBehaviorDidUpdate];
  };
  [self.animator addBehavior:self.sheetBehavior];
}

// Calculates the snap-point for the view to spring to.
- (CGPoint)targetPoint {
  CGRect bounds = self.bounds;
  CGFloat keyboardOffset = [MDCKeyboardWatcher sharedKeyboardWatcher].visibleKeyboardHeight;
  CGFloat midX = CGRectGetMidX(bounds);
  CGFloat bottomY = CGRectGetMaxY(bounds) - keyboardOffset;

  switch (self.sheetState) {
    case MDCSheetStatePreferred:
      return CGPointMake(midX, bottomY - [self truncatedPreferredSheetHeight]);
    case MDCSheetStateExtended:
      return CGPointMake(midX, bottomY - [self maximumSheetHeight]);
    case MDCSheetStateClosed:
      return CGPointMake(midX, bottomY);
  }
}

- (void)sheetBehaviorDidUpdate {
  // If sheet has been dragged off the bottom, we can trigger a dismiss.
  if (self.sheetState == MDCSheetStateClosed &&
      CGRectGetMinY(self.sheet.frame) > CGRectGetMaxY(self.bounds)) {
    [self.delegate sheetContainerViewDidHide:self];

    [self.animator removeAllBehaviors];

    // Reset the state to preferred once we are dismissed.
    self.sheetState = MDCSheetStatePreferred;
  }
}

#pragma mark - Notifications

- (void)keyboardStateChangedWithNotification:(__unused NSNotification *)notification {
  if (self.window) {
    [self animatePaneWithInitialVelocity:CGPointZero];
  }
}

#pragma mark - MDCDraggableViewDelegate

- (CGFloat)maximumHeightForDraggableView:(__unused MDCDraggableView *)view {
  return [self maximumSheetHeight];
}

- (BOOL)draggableView:(__unused MDCDraggableView *)view
    shouldBeginDraggingWithVelocity:(CGPoint)velocity {
  [self updateSheetState];

  switch (self.sheetState) {
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

- (void)draggableView:(__unused MDCDraggableView *)view
    draggingEndedWithVelocity:(CGPoint)velocity {
  MDCSheetState targetState;
  if (self.preferredSheetHeight == [self maximumSheetHeight]) {
    // Cannot be extended, only closed.
    targetState = (velocity.y >= 0 ? MDCSheetStateClosed : MDCSheetStatePreferred);
  } else {
    CGFloat currentSheetHeight = CGRectGetMaxY(self.bounds) - CGRectGetMinY(self.sheet.frame);
    if (currentSheetHeight >= self.preferredSheetHeight) {
      targetState = (velocity.y >= 0 ? MDCSheetStatePreferred : MDCSheetStateExtended);
    } else {
      targetState = (velocity.y >= 0 ? MDCSheetStateClosed : MDCSheetStatePreferred);
    }
  }
  self.isDragging = NO;
  self.sheetState = targetState;
  [self animatePaneWithInitialVelocity:velocity];
}

- (void)draggableViewBeganDragging:(__unused MDCDraggableView *)view {
  [self.animator removeAllBehaviors];
  self.isDragging = YES;
}

- (void)setSheetState:(MDCSheetState)sheetState {
  if (sheetState != _sheetState) {
    _sheetState = sheetState;
    [self.delegate sheetContainerViewWillChangeState:self sheetState:sheetState];
  }
}

@end
