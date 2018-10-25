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

#import <Foundation/Foundation.h>

// These enums is only used for debugging right now
typedef NS_ENUM(NSInteger, MDCBannerViewLayoutMode) {
  MDCBannerViewLayoutSingleLineStyle = 0,
  MDCBannerViewLayoutMultiLineStackedButtonStyle = 1,
  MDCBannerViewLayoutMultiLineAlignedButtonStyle = 2
};

@interface MDCBannerViewLayout : NSObject

@property(nonatomic, readonly, strong) NSMutableArray *buttonFrames;
@property(nonatomic, readonly, assign) CGRect iconImageViewFrame;
@property(nonatomic, readonly, assign) CGRect textLabelFrame;

@property(nonatomic, readonly, assign) CGSize frameSize;
@property(nonatomic, readonly, assign) MDCBannerViewLayoutMode style;

- (instancetype)initWithIconImageView:(UIImageView *)iconImageView
                            textLabel:(UILabel *)textLabel
                              buttons:(NSArray<__kindof UIButton *> *)buttons
                            sizeToFit:(CGSize)sizeToFit;

@end
