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

@class MDCBannerViewLayout;

/**
 This protocol supplies the data models used for layout.
 */
@protocol MDCBannerViewLayoutDataSource <NSObject>

- (UILabel *)textLabelForBannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout;

/**
 Provides the number of buttons to the bannerViewLayout.
 1 - 2 would be the suggested value to use for the layout.
 */
- (NSInteger)numberOfButtonsForBannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout;
- (UIButton *)bannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout
                 buttonAtIndex:(NSInteger)index;

@optional

/**
 Provides the image container view object to the bannerViewLayout.
 Default is nil if not implemented

 @param bannerViewLayout The layout where image container is used
 @return The image container view object
 */
- (UIView *)imageContainerForBannerViewLayout:(MDCBannerViewLayout *)bannerViewLayout;

@end

@interface MDCBannerViewLayout : NSObject

@property(nonatomic, readonly, strong) NSArray *buttonFrames;
@property(nonatomic, readonly, assign) CGRect imageContainerFrame;
@property(nonatomic, readonly, assign) CGRect textLabelFrame;

@property(nonatomic, readonly, assign) CGSize frameSize;

@property(nonatomic, weak, nullable) id<MDCBannerViewLayoutDataSource> dataSource;

- (instancetype)initWithSizeToFit:(CGSize)sizeToFit NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Reloads all data from dataSource and refresh the layout.
 */
- (void)reloadData;

@end
