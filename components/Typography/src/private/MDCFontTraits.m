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

#import "MDCFontTraits.h"

static NSDictionary<NSString *, MDCFontTraits *> *_body1Traits;
static NSDictionary<NSString *, MDCFontTraits *> *_body2Traits;
static NSDictionary<NSString *, MDCFontTraits *> *_buttonTraits;
static NSDictionary<NSString *, MDCFontTraits *> *_captionTraits;
static NSDictionary<NSString *, MDCFontTraits *> *_display1Traits;
static NSDictionary<NSString *, MDCFontTraits *> *_display2Traits;
static NSDictionary<NSString *, MDCFontTraits *> *_display3Traits;
static NSDictionary<NSString *, MDCFontTraits *> *_display4Traits;
static NSDictionary<NSString *, MDCFontTraits *> *_headlineTraits;
static NSDictionary<NSString *, MDCFontTraits *> *_subheadlineTraits;
static NSDictionary<NSString *, MDCFontTraits *> *_titleTraits;

static NSDictionary<NSNumber *, NSDictionary *> *_styleTable;

@interface MDCFontTraits (MaterialTypographyPrivate)

+ (instancetype)traitsWithPointSize:(CGFloat)pointSize
                             weight:(CGFloat)weight
                            leading:(CGFloat)leading
                           tracking:(CGFloat)tracking;

- (instancetype)initWithPointSize:(CGFloat)pointSize
                           weight:(CGFloat)weight
                          leading:(CGFloat)leading
                         tracking:(CGFloat)tracking;

@end

@implementation MDCFontTraits

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
+ (void)initialize {
  _body1Traits = @{
    UIContentSizeCategoryExtraSmall :
        [MDCFontTraits traitsWithPointSize:11 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategorySmall :
        [MDCFontTraits traitsWithPointSize:12 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryMedium :
        [MDCFontTraits traitsWithPointSize:13 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryLarge :
        [MDCFontTraits traitsWithPointSize:14 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryExtraLarge :
        [MDCFontTraits traitsWithPointSize:16 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [MDCFontTraits traitsWithPointSize:18 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [MDCFontTraits traitsWithPointSize:20 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryAccessibilityMedium :
        [MDCFontTraits traitsWithPointSize:25 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryAccessibilityLarge :
        [MDCFontTraits traitsWithPointSize:30 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryAccessibilityExtraLarge :
        [MDCFontTraits traitsWithPointSize:37 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryAccessibilityExtraExtraLarge :
        [MDCFontTraits traitsWithPointSize:44 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge :
        [MDCFontTraits traitsWithPointSize:52 weight:UIFontWeightRegular leading:0.0 tracking:0.0],
  };

  _body2Traits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:11
                                                                        weight:UIFontWeightMedium
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:12
                                                                   weight:UIFontWeightMedium
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:13
                                                                    weight:UIFontWeightMedium
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:14
                                                                   weight:UIFontWeightMedium
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:16
                                                                        weight:UIFontWeightMedium
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:18
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:20
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryAccessibilityMedium :
        [[MDCFontTraits alloc] initWithPointSize:25
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryAccessibilityLarge :
        [[MDCFontTraits alloc] initWithPointSize:30
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryAccessibilityExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:37
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryAccessibilityExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:44
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:52
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
  };

  _buttonTraits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:11
                                                                        weight:UIFontWeightMedium
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:12
                                                                   weight:UIFontWeightMedium
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:13
                                                                    weight:UIFontWeightMedium
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:14
                                                                   weight:UIFontWeightMedium
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:16
                                                                        weight:UIFontWeightMedium
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:18
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:20
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
  };

  _captionTraits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:11
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:11
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:11
                                                                    weight:UIFontWeightRegular
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:12
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:14
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:16
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:18
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
  };

  _display1Traits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:28
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:30
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:32
                                                                    weight:UIFontWeightRegular
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:34
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:36
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:38
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:40
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
  };

  _display2Traits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:39
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:41
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:43
                                                                    weight:UIFontWeightRegular
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:45
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:47
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:49
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:51
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
  };

  _display3Traits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:50
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:52
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:54
                                                                    weight:UIFontWeightRegular
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:56
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:58
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:60
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:62
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
  };

  _display4Traits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:100
                                                                        weight:UIFontWeightLight
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:104
                                                                   weight:UIFontWeightLight
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:108
                                                                    weight:UIFontWeightLight
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:112
                                                                   weight:UIFontWeightLight
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:116
                                                                        weight:UIFontWeightLight
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:120
                                          weight:UIFontWeightLight
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:124
                                          weight:UIFontWeightLight
                                         leading:0.0
                                        tracking:0.0],
  };

  _headlineTraits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:21
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:22
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:23
                                                                    weight:UIFontWeightRegular
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:24
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:26
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:28
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:30
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
  };

  _subheadlineTraits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:13
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:14
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:15
                                                                    weight:UIFontWeightRegular
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:16
                                                                   weight:UIFontWeightRegular
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:18
                                                                        weight:UIFontWeightRegular
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:20
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:22
                                          weight:UIFontWeightRegular
                                         leading:0.0
                                        tracking:0.0],
  };

  _titleTraits = @{
    UIContentSizeCategoryExtraSmall : [[MDCFontTraits alloc] initWithPointSize:17
                                                                        weight:UIFontWeightMedium
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategorySmall : [[MDCFontTraits alloc] initWithPointSize:18
                                                                   weight:UIFontWeightMedium
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryMedium : [[MDCFontTraits alloc] initWithPointSize:19
                                                                    weight:UIFontWeightMedium
                                                                   leading:0.0
                                                                  tracking:0.0],
    UIContentSizeCategoryLarge : [[MDCFontTraits alloc] initWithPointSize:20
                                                                   weight:UIFontWeightMedium
                                                                  leading:0.0
                                                                 tracking:0.0],
    UIContentSizeCategoryExtraLarge : [[MDCFontTraits alloc] initWithPointSize:22
                                                                        weight:UIFontWeightMedium
                                                                       leading:0.0
                                                                      tracking:0.0],
    UIContentSizeCategoryExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:24
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
    UIContentSizeCategoryExtraExtraExtraLarge :
        [[MDCFontTraits alloc] initWithPointSize:26
                                          weight:UIFontWeightMedium
                                         leading:0.0
                                        tracking:0.0],
  };

  _styleTable = @{
    @(MDCFontTextStyleBody1) : _body1Traits,
    @(MDCFontTextStyleBody2) : _body2Traits,
    @(MDCFontTextStyleButton) : _buttonTraits,
    @(MDCFontTextStyleCaption) : _captionTraits,
    @(MDCFontTextStyleDisplay1) : _display1Traits,
    @(MDCFontTextStyleDisplay2) : _display2Traits,
    @(MDCFontTextStyleDisplay3) : _display3Traits,
    @(MDCFontTextStyleDisplay4) : _display4Traits,
    @(MDCFontTextStyleHeadline) : _headlineTraits,
    @(MDCFontTextStyleSubheadline) : _subheadlineTraits,
    @(MDCFontTextStyleTitle) : _titleTraits
  };
}
#pragma clang diagnostic pop

+ (instancetype)traitsWithPointSize:(CGFloat)pointSize
                             weight:(CGFloat)weight
                            leading:(CGFloat)leading
                           tracking:(CGFloat)tracking {
  return [[MDCFontTraits alloc] initWithPointSize:pointSize
                                           weight:weight
                                          leading:leading
                                         tracking:tracking];
}

- (instancetype)initWithPointSize:(CGFloat)pointSize
                           weight:(CGFloat)weight
                          leading:(CGFloat)leading
                         tracking:(CGFloat)tracking {
  self = [super init];
  if (self) {
    _pointSize = pointSize;
    _weight = weight;
    _leading = leading;
    _tracking = tracking;
  }

  return self;
}

+ (MDCFontTraits *)traitsForTextStyle:(MDCFontTextStyle)style
                         sizeCategory:(NSString *)sizeCategory {
  NSDictionary *traitsTable = _styleTable[@(style)];
  NSCAssert(traitsTable, @"traitsTable cannot be nil. Is style valid?");

  MDCFontTraits *traits;
  if (traitsTable) {
    if (sizeCategory) {
      traits = traitsTable[sizeCategory];
    }

    // If you have queried the table for a sizeCategory that doesn't exist, we will return the
    // traits for XXXL.  This handles the case where the values are requested for one of the
    // accessibility size categories beyond XXXL such as
    // UIContentSizeCategoryAccessibilityExtraLarge.  Accessbility size categories are only
    // defined for the Body Font Style.
    if (traits == nil) {
      traits = traitsTable[UIContentSizeCategoryExtraExtraExtraLarge];
    }
  }

  return traits;
}

@end
