/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

@protocol MDCTypographyScheming

@property(nonatomic, nonnull, readonly) UIFont *headline1;
@property(nonatomic, nonnull, readonly) UIFont *headline2;
@property(nonatomic, nonnull, readonly) UIFont *headline3;
@property(nonatomic, nonnull, readonly) UIFont *headline4;
@property(nonatomic, nonnull, readonly) UIFont *headline5;
@property(nonatomic, nonnull, readonly) UIFont *headline6;
@property(nonatomic, nonnull, readonly) UIFont *subtitle1;
@property(nonatomic, nonnull, readonly) UIFont *subtitle2;
@property(nonatomic, nonnull, readonly) UIFont *body1;
@property(nonatomic, nonnull, readonly) UIFont *body2;
@property(nonatomic, nonnull, readonly) UIFont *caption;
@property(nonatomic, nonnull, readonly) UIFont *button;
@property(nonatomic, nonnull, readonly) UIFont *overline;

@end

@interface MDCTypographyScheme : NSObject <MDCTypographyScheming>

@property(nonatomic, nonnull, readwrite) UIFont *headline1;
@property(nonatomic, nonnull, readwrite) UIFont *headline2;
@property(nonatomic, nonnull, readwrite) UIFont *headline3;
@property(nonatomic, nonnull, readwrite) UIFont *headline4;
@property(nonatomic, nonnull, readwrite) UIFont *headline5;
@property(nonatomic, nonnull, readwrite) UIFont *headline6;
@property(nonatomic, nonnull, readwrite) UIFont *subtitle1;
@property(nonatomic, nonnull, readwrite) UIFont *subtitle2;
@property(nonatomic, nonnull, readwrite) UIFont *body1;
@property(nonatomic, nonnull, readwrite) UIFont *body2;
@property(nonatomic, nonnull, readwrite) UIFont *caption;
@property(nonatomic, nonnull, readwrite) UIFont *button;
@property(nonatomic, nonnull, readwrite) UIFont *overline;

- (nonnull instancetype)init;

- (nonnull instancetype)initWithMaterialDefaults;

@end
