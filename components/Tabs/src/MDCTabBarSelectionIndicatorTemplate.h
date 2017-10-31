/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

@interface MDCTabBarSelectionIndicatorAttributes : NSObject // <NSCopying>

@property(nonatomic, nullable) UIBezierPath *path;

//@property(nonatomic, nullable) UIImage *image;

@end

@interface MDCTabBarItemAttributes : NSObject

- (nonnull instancetype)initWithItem:(nonnull UITabBarItem *)item
                      bounds:(CGRect)bounds
                contentFrame:(CGRect)contentFrame;

@property(nonatomic, readonly, nonnull) UITabBarItem *item;
@property(nonatomic, readonly) CGRect bounds;
@property(nonatomic, readonly) CGRect contentFrame;

//@property(nonatomic, readonly) CGRect titleFrame;
//@property(nonatomic, readonly) CGRect iconFrame;

@end

@protocol MDCTabBarSelectionIndicatorTemplate <NSObject>

- (nonnull MDCTabBarSelectionIndicatorAttributes *)
    selectionIndicatorAttributesForItemAttributes:(nonnull MDCTabBarItemAttributes *)attributes;

@end

/// Template which produces a fixed-height solid bar underneath the selected tab.
@interface MDCRectangleTabBarSelectionIndicatorTemplate : NSObject<
MDCTabBarSelectionIndicatorTemplate>
@end
