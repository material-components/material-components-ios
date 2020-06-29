// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

// Credit to the Beacon Tools iOS team for the idea for this implementations
@interface MDCDiscreteDotView : UIView

@property(nonatomic, assign) NSUInteger numDiscreteDots;

/** The color of dots within the @c activeDotsSegment bounds. Defaults to black. */
@property(nonatomic, strong, nonnull) UIColor *activeDotColor;

/** The color of dots outside the @c activeDotsSegment bounds. Defaults to black. */
@property(nonatomic, strong, nonnull) UIColor *inactiveDotColor;

/**
 The segment of the track that uses @c activeDotColor. The horizontal dimension should be bound
 to [0..1]. The vertical dimension is ignored.

 @note Only the @c origin.x and @c size.width are used to determine whether a dot is in the active
 segment.
 */
@property(nonatomic, assign) CGRect activeDotsSegment;

@end
