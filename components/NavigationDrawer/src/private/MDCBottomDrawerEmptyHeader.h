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

#import <UIKit/UIKit.h>

@protocol MDCBottomDrawerHeader;

/**
 Empty header for the MDCBottomDrawerViewController, to be used to prevent bottom drawer content
 from conflicting with status bar when a header has not been provided by the client (see Github
 issue #6434).
 */
@interface MDCBottomDrawerEmptyHeader : UIViewController <MDCBottomDrawerHeader>

/**
 The color applied to the background of the header, this likely should match the background of the
 drawer content.
 */
@property(nonatomic, nullable) UIColor *backgroundColor;

/**
 The height of the header, this should match the collapsed bottom drawer corner radius, if any.
 */
@property(nonatomic) CGFloat headerHeight;

@end
