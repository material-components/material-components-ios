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

@class MDCCollectionInfoBarView;

/** The animation duration for the info bar. */
extern const CGFloat MDCCollectionInfoBarAnimationDuration;

/** The available styles that the info bar can be shown within a collectionView. */
typedef NS_ENUM(NSUInteger, MDCInfoBarStyle) {
  MDCInfoBarStyleActionable,
  MDCInfoBarStyleHUD
};

/** The info bar kind depends on if shown in the header or footer location. */
typedef NS_ENUM(NSUInteger, MDCInfoBarKind) {
  MDCInfoBarKindHeader,
  MDCInfoBarKindFooter
};

/** Delegate protocol for the MDCCollectionInfoBarView. */
@protocol MDCCollectionInfoBarViewDelegate <NSObject>
@optional
/**
 Allows the receiver to get notified when a tap gesture has been performed on the info bar.

 @param infoBar The MDCCollectionInfoBarView info bar.
 */
- (void)didTapInfoBar:(nonnull MDCCollectionInfoBarView *)infoBar;

/**
 Whether the info bar should be shown. A call to -showAnimated: will first check this delegate
 method as to whether to show the info bar with/without animation. Defaults to NO.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition will be animated; otherwise, NO.
 @return YES if info bar should show with/without animation. Otherwise NO.
 */
- (BOOL)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar shouldShowAnimated:(BOOL)animated;

/**
 Allows the receiver to get notified when an info bar will show.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition will be animated; otherwise, NO.
 @param willAutoDismiss YES the info bar will be auto-dismissed after the time interval
        set in @c autoDismissAfterDuration.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    willShowAnimated:(BOOL)animated
     willAutoDismiss:(BOOL)willAutoDismiss;

/**
 Allows the receiver to get notified after an info bar did show.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition was animated; otherwise, NO.
 @param willAutoDismiss YES the info bar will be auto-dismissed after the time interval
        set in @c autoDismissAfterDuration.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    didShowAnimated:(BOOL)animated
    willAutoDismiss:(BOOL)willAutoDismiss;

/**
 Allows the receiver to get notified when an info bar will dismiss.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition will be animated; otherwise, NO.
 @param willAutoDismiss YES the info bar will be auto-dismissed after the time interval
        set in @c autoDismissAfterDuration.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    willDismissAnimated:(BOOL)animated
        willAutoDismiss:(BOOL)willAutoDismiss;

/**
 Allows the receiver to get notified after an info bar has been dismissed.

 @param infoBar The MDCCollectionInfoBarView info bar.
 @param animated YES the transition was animated; otherwise, NO.
 @param didAutoDismiss YES the info bar was auto-dismissed.
 */
- (void)infoBar:(nonnull MDCCollectionInfoBarView *)infoBar
    didDismissAnimated:(BOOL)animated
        didAutoDismiss:(BOOL)didAutoDismiss;

@end

/**
 The MDCCollectionInfoBarView class provides a view that can be shown in either the header or
 footer of a collection view. The info bar can be shown and dismissed with/without animation.
 When presented as a MDCInfoBarStyleActionable style, it can be tapped on and pass the event to
 its delegate.
 */
@interface MDCCollectionInfoBarView : UIView



/** Initializes an info bar with the given style and kind for the provided collection view. */
- (nonnull instancetype)initWithStyle:(MDCInfoBarStyle)style
                                 kind:(MDCInfoBarKind)kind
                       collectionView:(nonnull UICollectionView *)
                                          collectionView NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;


/** A delegate through which the MDCCollectionInfoBarView may inform of updates. */
@property(nonatomic, weak, nullable) id<MDCCollectionInfoBarViewDelegate> delegate;

/** The background view containing the message label. This view is animatable on show/dismiss. */
@property(nonatomic, readonly, strong, nullable) UIView *backgroundView;

/**
 The color assigned to the background view.

 Defaults to #448AFF for header, and white for footer.
 */
@property(nonatomic, strong, null_resettable) UIColor *tintColor;

/**
 The color assigned to the info bar message label.

 Defaults to white for header, and #F44336 for footer.
 */
@property(nonatomic, strong, nullable) UIColor *titleColor;

/** The info bar message label. */
@property(nonatomic, readonly, strong, nullable) UILabel *titleLabel;

/** The info bar message text. */
@property(nonatomic, strong, nullable) NSString *message;

/** The horizontal position of bar message. */
@property(nonatomic, assign) NSTextAlignment textAlignment;

/** Whether the background view can receive a tap gesture. */
@property(nonatomic, assign) BOOL allowsTap;

/** The style that the info bar can be shown. */
@property(nonatomic, assign) MDCInfoBarStyle style;

/**
 The kind of info bar (either footer or header). This property is readonly and can only be set
 at time of initialization.
 */
@property(nonatomic, readonly, assign) MDCInfoBarKind kind;

/**
 The desired duration after which the info bar will be automatically dismissed. If set to
 0, autoDismiss will be ignored.
 */
@property(nonatomic, assign) NSTimeInterval autoDismissAfterDuration;

/** Whether the info bar is currently being shown. */
@property(nonatomic, readonly, assign) BOOL isVisible;

/**
 Whether to apply a border on the info bar. If YES, use |borderColor| and |borderWith| to adjust
 the styling.
 */
@property(nonatomic, assign) BOOL shouldApplyBorder;

/** The color of the info bar border (if applicable). */
@property(nonatomic, strong, null_resettable) UIColor *borderColor;

/** The width of the info bar border (if applicable). */
@property(nonatomic, assign) CGFloat borderWidth;

/**
 Shows the info bar with/without animation.

 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)showAnimated:(BOOL)animated;

/**
 Dismisses the info bar with/without animation.

 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)dismissAnimated:(BOOL)animated;

@end
