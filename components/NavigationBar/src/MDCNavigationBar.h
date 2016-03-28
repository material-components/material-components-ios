/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

@protocol MDCButtonBarDelegate;

/**
 This protocol defines all of the KVO properties on UINavigationItem that can be listened to by
 MDCNavigationBar.
 */
@protocol MDCUINavigationItemKVO <NSObject>
@required

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSArray *leftBarButtonItems;
@property(nonatomic, copy) NSArray *rightBarButtonItems;
@property(nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property(nonatomic) BOOL hidesBackButton;
@property(nonatomic) BOOL leftItemsSupplementBackButton;
@property(nonatomic, strong) UIView *titleView;

@end

/**
 The MDCNavigationBar class is a view consisting of a left and right button bar,
 title label, and an optional title view.

 This view is not designed to have subviews added to it except via through its declared
 properties (e.g. titleView).
 */
@interface MDCNavigationBar : UIView <MDCUINavigationItemKVO>

#pragma mark Behavior

/**
 The title view layout differs from the traditional behavior of UINavigationBar.

 Due to MDCNavigationBar being able to expand vertically, the titleView's height is updated to
 match any changes in the MDCNavigationBar's height.

 You may wish to create a container view that is able to manage subview layout if your
 situation requires it.
 */
@property(nonatomic, strong) UIView *titleView;

/** The delegate to be provided to the left button bar instance. */
@property(nonatomic, weak) id<MDCButtonBarDelegate> leftButtonBarDelegate;

/** The delegate to be provided to the right button bar instance. */
@property(nonatomic, weak) id<MDCButtonBarDelegate> rightButtonBarDelegate;

/** The back button to be displayed, if any. */
@property(nonatomic, strong) UIBarButtonItem *backItem;

#pragma mark Observing UINavigationItem instances

/**
 Begin observing changes to the provided navigation item.

 Only one navigation item instance can be observed at a time. Observing a second navigation item
 will stop observation of the first navigation item.

 The observed navigation item is strongly held.
 */
- (void)observeNavigationItem:(UINavigationItem *)navigationItem;

/**
 Stop observing changes to the previously-observed navigation item.

 Does nothing if no navigation item is being observed.
 */
- (void)unobserveNavigationItem;

@end
