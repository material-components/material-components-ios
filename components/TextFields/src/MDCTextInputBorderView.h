/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

@interface MDCTextInputBorderView : UIView <NSCopying>

/**
 The color of the area inside the border.

 Default is clear.
 */
@property(nonatomic, nullable, strong) UIColor *borderFillColor UI_APPEARANCE_SELECTOR;

/**
 The path of the area to be highlighted with a border. This could either be with a drawn line or a
 drawn fill.

 Note: The settable properties of the UIBezierPath are respected (.lineWidth, etc).

 Default is a rectangle of the same width as the input with rounded top corners. That means the
 underline labels are not included inside the border. Settable properties of UIBezierPath are left
 at
 system defaults.
 */
@property(nonatomic, nullable, strong) UIBezierPath *borderPath UI_APPEARANCE_SELECTOR;

/**
 The color of the border itself.

 Default is clear.
 */
@property(nonatomic, nullable, strong) UIColor *borderStrokeColor UI_APPEARANCE_SELECTOR;

@end
