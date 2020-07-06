// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFlexibleHeaderMinMaxHeight.h"

#import "MDCFlexibleHeaderMinMaxHeightDelegate.h"
#import "MDCFlexibleHeaderTopSafeArea.h"

// The default maximum height for the header. Does not include the status bar height.
static const CGFloat kFlexibleHeaderDefaultHeight = 56;

@interface MDCFlexibleHeaderMinMaxHeight ()

@property(nonatomic, strong) MDCFlexibleHeaderTopSafeArea *topSafeArea;

@property(nonatomic) BOOL hasExplicitlySetMinHeight;
@property(nonatomic) BOOL hasExplicitlySetMaxHeight;
@property(nonatomic) BOOL minMaxHeightIncludesSafeArea;

@end

@implementation MDCFlexibleHeaderMinMaxHeight

- (instancetype)initWithTopSafeArea:(MDCFlexibleHeaderTopSafeArea *)topSafeArea {
  self = [super init];
  if (self) {
    self.topSafeArea = topSafeArea;

    const CGFloat topSafeAreaInset = [self.topSafeArea topSafeAreaInset];

    _minMaxHeightIncludesSafeArea = YES;
    _minimumHeight = kFlexibleHeaderDefaultHeight + topSafeAreaInset;
    _maximumHeight = _minimumHeight;
  }
  return self;
}

#pragma mark - Public

- (void)setMinimumHeight:(CGFloat)minimumHeight {
  _hasExplicitlySetMinHeight = YES;
  if (_minimumHeight == minimumHeight) {
    return;
  }

  _minimumHeight = minimumHeight;

  if (_minimumHeight > self.maximumHeight) {
    [self setMaximumHeight:_minimumHeight];
  } else {
    [self.delegate flexibleHeaderMinMaxHeightDidChange:self];
  }
}

- (void)setMaximumHeight:(CGFloat)maximumHeight {
  _hasExplicitlySetMaxHeight = YES;
  if (_maximumHeight == maximumHeight) {
    return;
  }

  _maximumHeight = maximumHeight;

  [self.delegate flexibleHeaderMaximumHeightDidChange:self];

  if (self.maximumHeight < _minimumHeight) {
    [self setMinimumHeight:self.maximumHeight];
  } else {
    [self.delegate flexibleHeaderMinMaxHeightDidChange:self];
  }
}

- (void)setMinMaxHeightIncludesSafeArea:(BOOL)minMaxHeightIncludesSafeArea {
  if (_minMaxHeightIncludesSafeArea == minMaxHeightIncludesSafeArea) {
    return;
  }
  _minMaxHeightIncludesSafeArea = minMaxHeightIncludesSafeArea;

  // Update default values accordingly.
  // Note that we intentionally set the ivars because we do not want to invoke the setter delegates.
  if (!_hasExplicitlySetMinHeight) {
    if (_minMaxHeightIncludesSafeArea) {
      _minimumHeight = kFlexibleHeaderDefaultHeight + [self.topSafeArea topSafeAreaInset];
    } else {
      _minimumHeight = kFlexibleHeaderDefaultHeight;
    }
  }
  if (!_hasExplicitlySetMaxHeight) {
    if (_minMaxHeightIncludesSafeArea) {
      _maximumHeight = kFlexibleHeaderDefaultHeight + [self.topSafeArea topSafeAreaInset];
    } else {
      _maximumHeight = kFlexibleHeaderDefaultHeight;
    }
  }
}

- (void)recalculateMinMaxHeight {
  // If the min or max height have been explicitly set, don't adjust anything if the values
  // already include a Safe Area inset.
  BOOL hasSetMinOrMaxHeight = self.hasExplicitlySetMinHeight || self.hasExplicitlySetMaxHeight;
  if (!hasSetMinOrMaxHeight && self.minMaxHeightIncludesSafeArea) {
    // If we're using the defaults we need to update them to account for the new Safe Area inset.
    // Note that we intentionally set the ivars because we do not want to invoke the setter
    // delegates.
    _minimumHeight = kFlexibleHeaderDefaultHeight + self.topSafeArea.topSafeAreaInset;
    _maximumHeight = self.minimumHeight;
  }
}

- (CGFloat)minimumHeightWithTopSafeArea {
  if (self.minMaxHeightIncludesSafeArea) {
    return self.minimumHeight;
  } else {
    return self.minimumHeight + [self.topSafeArea topSafeAreaInset];
  }
}

- (CGFloat)maximumHeightWithTopSafeArea {
  if (_minMaxHeightIncludesSafeArea) {
    return self.maximumHeight;
  } else {
    return self.maximumHeight + [self.topSafeArea topSafeAreaInset];
  }
}

- (CGFloat)maximumHeightWithoutTopSafeArea {
  if (_minMaxHeightIncludesSafeArea) {
    return self.maximumHeight - [self.topSafeArea topSafeAreaInset];
  } else {
    return self.maximumHeight;
  };
}

@end
