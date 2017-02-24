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

/**
 * A view that uses two CATextLayer objects to draw title text for an instance of GOOTextField.
 *
 * @ingroup GOOInputs
 */
@interface MDCTextInputTitleView : UIView
@property(nonatomic, assign) CGColorRef frontLayerColor;
@property(nonatomic, assign) CGColorRef backLayerColor;
@property(nonatomic, assign) NSObject *string;
@property(nonatomic, strong) UIFont *font;
@property(nonatomic, strong) CATextLayer *frontLayer;
@property(nonatomic, strong) CATextLayer *backLayer;
@end
