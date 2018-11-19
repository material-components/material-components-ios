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

@interface MDCBannerViewLayout : NSObject

@property(nonatomic, readonly, strong) NSArray *buttonFrames;
@property(nonatomic, readonly, assign) CGRect imageContainerFrame;
@property(nonatomic, readonly, assign) CGRect textLabelFrame;

@property(nonatomic, readonly, assign) CGSize frameSize;

- (instancetype)initWithSizeToFit:(CGSize)sizeToFit
                        textLabel:(UILabel *)textLabel
                   imageContainer:(UIView *)imageContainer
                          buttons:(NSArray<__kindof UIButton *> *)buttons NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
