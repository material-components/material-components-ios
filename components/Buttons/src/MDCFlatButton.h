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

#import <Foundation/Foundation.h>

#import "MDCButton.h"

@interface MDCFlatButton : MDCButton

/**
 * Use an opaque background color (default is NO).
 *
 * Flat buttons normally have a transparent background and blend seamlessly with their underlying
 * color, but occasionally a flat button with an opaque background will be required. Consider using
 * a raised button instead if possible.
 */
@property(nonatomic) BOOL hasOpaqueBackground;

@end
