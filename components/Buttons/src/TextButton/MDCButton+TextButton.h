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

#import "MDCButton.h"
#import "MDCButtonColorThemer.h"
#import "MDCButtonTypographyThemer.h"

@interface MDCButton (TextButton)

- (nonnull instancetype)initTextButton;

@end

@protocol MDCButtonScheming
@property(nonnull, readonly, nonatomic) MDCSemanticColorScheme *colorScheme;
@property(nonnull, readonly, nonatomic) MDCTypographyScheme *typographyScheme;
@property(readonly, nonatomic) CGFloat cornerRadius;
@property(readonly, nonatomic) CGFloat minimumHeight;
@end

@interface MDCButtonScheme : NSObject <MDCButtonScheming>
@property(nonnull, readwrite, nonatomic) MDCSemanticColorScheme *colorScheme;
@property(nonnull, readwrite, nonatomic) MDCTypographyScheme *typographyScheme;
@property(readwrite, nonatomic) CGFloat cornerRadius;
@property(readwrite, nonatomic) CGFloat minimumHeight;
@end

@interface MDCButtonThemer : NSObject
+ (void)applyScheme:(nonnull id<MDCButtonScheming>)scheme
       toTextButton:(nonnull MDCButton *)button;
@end
