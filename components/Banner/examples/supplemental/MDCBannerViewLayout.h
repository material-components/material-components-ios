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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MDCBannerViewLayoutStyle) {
  MDCBannerViewLayoutStyleInvalid = 0,                 // Invalid style
  MDCBannerViewLayoutSingleLineStyle = 1,              // All elements lays on the same line
  MDCBannerViewLayoutMultiLineStackedButtonStyle = 2,  // Multline, stacked button layout
  MDCBannerViewLayoutMultiLineAlignedButtonStyle =
      3  // Multiline style with all buttons on the same line
};

@interface MDCBannerViewLayout : NSObject

@property(nonatomic, readonly, assign) MDCBannerViewLayoutStyle style;
@property(nonatomic, readonly, assign) CGSize size;

- (instancetype)initWithPreferredWidth:(CGFloat)preferredWidth
                             textLabel:(UILabel *)textLabel
                         iconContainer:(UIView *)iconContainer
                               buttons:(NSArray<__kindof UIButton *> *)buttons
    NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
